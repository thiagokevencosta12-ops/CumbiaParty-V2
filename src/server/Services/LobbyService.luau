--!nonstrict
-- Physical lobby integration. Competition engines retain all participation/state.
-- SetArea is SERVER ONLY: future arenas must opt out before moving a character.
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Root=game.ReplicatedStorage.CumbiaParty
local Config=require(Root.Shared.GameConfig).Lobby
local WorldBindings=require(script.Parent.WorldBindings)
local Battle=require(script.Parent.BattleService)
local Rhythm=require(script.Parent.RhythmService)
local Tournament=require(script.Parent.TournamentService)
local L={}
local last,areas,recoveries,characterLinks,requestTimes={},{},{},{},{}
local safeAnchors={}
local initialized=false
local bindings=nil
function L.GetWorldProfileId() return if bindings then bindings.ProfileId else nil end
local function active(p)
 if Rhythm.IsActive(p) then return true end
 local state=Battle.GetSnapshot(p)
 return state~=nil and (state.phase=="Playing" or state.phase=="Waiting")
end
-- Explicit server-owned area registration; clients have no remote for this API.
function L.SetArea(p,areaId)
 assert(typeof(areaId)=="string" and #areaId>0 and #areaId<=64,"Invalid server area")
 if areas[p.UserId]~=areaId then safeAnchors[p.UserId]=nil end
 areas[p.UserId]=areaId
end
function L.GetArea(p) return areas[p.UserId] end
function L.GetRecoveryCount(p) return recoveries[p.UserId] or 0 end
-- Preserve the public API; the unchanged polygon rule now belongs to the spatial layer.
function L.IsOutside(position) return WorldBindings.IsOutside(position,Config) end
local function nearestAnchor(position)
 if not bindings then return Config.ReturnMarkerName end
 local name,distance=Config.ReturnMarkerName,math.huge
 for _,n in ipairs(Config.RecoveryMarkerNames) do
  local m=WorldBindings.GetMarker(bindings,n)
  if m and m:IsA("BasePart") and (not Config.RequireRegionHeights or (m.Position.Y<=position.Y-1 and position.Y-m.Position.Y<=14)) then
   local delta=m.Position-position
   local d=delta.X^2+delta.Z^2+delta.Y^2
   if d<distance then name,distance=n,d end
  end
 end
 return name
end
local function reposition(p,preserveView,reason)
 local character=p.Character
 local root=character and character:FindFirstChild("HumanoidRootPart")
 local humanoid=character and character:FindFirstChildOfClass("Humanoid")
 if not root or not humanoid or humanoid.Health<=0 then return false end
 if not bindings then return false end
 local markerName=if reason=="FallRecovery" then safeAnchors[p.UserId] or nearestAnchor(root.Position) else Config.ReturnMarkerName
 local marker=WorldBindings.GetMarker(bindings,markerName)
 if not marker or not marker:IsA("BasePart") or L.IsOutside(marker.Position) then return false end
 -- Refuse to place a character over missing support after future map edits.
 local floor=WorldBindings.GetSupport(bindings,marker)
 if not floor or floor.Normal.Y<.6 or floor.Position.Y<Config.MinY then return false end
 character:PivotTo(marker.CFrame+Vector3.new(0,Config.ReturnHeight,0))
 root.AssemblyLinearVelocity=Vector3.zero;root.AssemblyAngularVelocity=Vector3.zero
 last[p.UserId]=os.clock();safeAnchors[p.UserId]=markerName
 Root.Remotes.LobbyState:FireClient(p,{action="Returned",preserveView=preserveView==true,reason=reason})
 return true
end
function L.Return(p,preserveView)
 if Battle.IsBusy(p) or Rhythm.IsActive(p) or Tournament.IsReserved(p) then return false end
 if areas[p.UserId]~="Lobby" then return false end
 return reposition(p,preserveView,"Navigation")
end
-- Queue membership is intentionally NOT a rejection here. Recovery never leaves a queue.
function L.CheckRecovery(p)
 if areas[p.UserId]~="Lobby" then return false end
 local root=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
 if not root or active(p) then return false end
 if not L.IsOutside(root.Position) then
  local humanoid=p.Character:FindFirstChildOfClass("Humanoid")
  if humanoid and humanoid.Health>0 and humanoid.FloorMaterial~=Enum.Material.Air and humanoid.FloorMaterial~=Enum.Material.Water then
   safeAnchors[p.UserId]=nearestAnchor(root.Position)
  end
  return false
 end
 if os.clock()-(last[p.UserId] or -math.huge)<Config.RecoveryCooldownSeconds then return false end
 if not reposition(p,true,"FallRecovery") then return false end
 recoveries[p.UserId]=(recoveries[p.UserId] or 0)+1
 return true
end
function L.Init()
 if initialized then return end
 -- Resolve all required objects before attaching anything; missing bindings fail clearly.
 bindings=WorldBindings.Resolve()
 initialized=true
 for _,terminal in ipairs(bindings.Terminals) do
  terminal.Prompt.Triggered:Connect(function(p)
   if not terminal.ActivationPart:IsDescendantOf(bindings.WorldRoot) then return end
   local h=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
   if not h or (h.Position-terminal.ActivationPart.Position).Magnitude>terminal.MaxServerDistance or Battle.IsBusy(p) or Rhythm.IsActive(p) then return end
   Root.Remotes.LobbyState:FireClient(p,{action=terminal.Action})
  end)
 end
 Root.Remotes.LobbyRequest.OnServerEvent:Connect(function(p,msg)
  if typeof(msg)~="table" or msg.action~="Return" then return end
  local now=os.clock()
  if now-(requestTimes[p.UserId] or -math.huge)<.5 then return end
  requestTimes[p.UserId]=now
  L.Return(p,msg.preserveView==true)
 end)
 local function attach(p)
  p.RespawnLocation=bindings.Spawn
  L.SetArea(p,"Lobby")
  characterLinks[p.UserId]=p.CharacterAdded:Connect(function()
   L.SetArea(p,"Lobby")
   last[p.UserId]=os.clock();safeAnchors[p.UserId]=nil
  end)
 end
 Players.PlayerAdded:Connect(attach)
 for _,p in ipairs(Players:GetPlayers()) do attach(p) end
 Players.PlayerRemoving:Connect(function(p)
  last[p.UserId]=nil;areas[p.UserId]=nil;recoveries[p.UserId]=nil;requestTimes[p.UserId]=nil;safeAnchors[p.UserId]=nil
  local link=characterLinks[p.UserId]
  if link then link:Disconnect();characterLinks[p.UserId]=nil end
 end)
 local elapsed=0
 RunService.Heartbeat:Connect(function(dt)
  elapsed+=dt
  if elapsed<Config.RecoveryIntervalSeconds then return end
  elapsed=0
  for _,p in ipairs(Players:GetPlayers()) do L.CheckRecovery(p) end
 end)
end
return L

