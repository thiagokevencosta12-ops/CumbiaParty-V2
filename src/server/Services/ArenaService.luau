--!nonstrict
-- Physical allocation only. This service never judges notes, deals damage or picks winners.
-- TournamentService is injected by bootstrap through fault callbacks (no circular requires).
local Players=game:GetService("Players")
local Root=game.ReplicatedStorage.CumbiaParty
local CDefault=require(script.Parent.CompetitorService)
local WorldBindings=require(script.Parent.WorldBindings)
local Config=require(Root.Shared.GameConfig)
local Presentation=require(Root.Shared.BattlePresentationConfig)
local function nameplate(part,text,offset)
 local gui=Instance.new("BillboardGui");gui.Name="CompetitorName";gui.Size=UDim2.fromOffset(210,34);gui.StudsOffset=offset or Vector3.new(0,2,0);gui.MaxDistance=100;gui.AlwaysOnTop=false;gui.Parent=part
 local label=Instance.new("TextLabel");label.Size=UDim2.fromScale(1,1);label.BackgroundTransparency=.25;label.BackgroundColor3=Color3.fromRGB(18,22,30);label.TextColor3=Color3.new(1,1,1);label.TextScaled=true;label.Font=Enum.Font.GothamBold;label.Text=text;label.Parent=gui
end
local function representation(parent,actor,C,cf)
 -- Original, native block character; no fabricated Player, UserId or third-party avatar.
 local m=Instance.new("Model");m.Name="CompetitorVisual";m:SetAttribute("CompetitorId",C.Id(actor));m:SetAttribute("ControllerKind","Server");m.Parent=parent
 local palette={Color3.fromRGB(190,94,100),Color3.fromRGB(78,140,185),Color3.fromRGB(150,113,187),Color3.fromRGB(100,170,138),Color3.fromRGB(199,159,84),Color3.fromRGB(90,170,180),Color3.fromRGB(200,120,83),Color3.fromRGB(115,125,175)}
 local color=palette[(actor.appearance and actor.appearance.color or 1)] or palette[1]
 for _,v in ipairs({{"Torso",Vector3.new(2,2,1),Vector3.new(0,0,0),color},{"Head",Vector3.new(1.4,1.4,1.4),Vector3.new(0,1.7,0),Color3.fromRGB(205,164,125)},{"LeftArm",Vector3.new(1,2,1),Vector3.new(-1.5,0,0),color},{"RightArm",Vector3.new(1,2,1),Vector3.new(1.5,0,0),color},{"LeftLeg",Vector3.new(.9,2,1),Vector3.new(-.55,-2,0),Color3.fromRGB(42,49,62)},{"RightLeg",Vector3.new(.9,2,1),Vector3.new(.55,-2,0),Color3.fromRGB(42,49,62)}}) do
  local p=Instance.new("Part");p.Name=v[1];p.Size=v[2];p.CFrame=cf*CFrame.new(v[3]);p.Color=v[4];p.Material=Enum.Material.SmoothPlastic;p.Anchored=true;p.CanCollide=false;p.CanQuery=false;p.CanTouch=false;p.CastShadow=false;p.Parent=m
  if v[1]=="Head" then nameplate(p,C.Name(actor)) end
 end
 return m
end
local function create(deps)
 deps=deps or {};local C=deps.competitors or CDefault
 local now=deps.now or function() return workspace:GetServerTimeNow() end
 local send=deps.send or function(p,msg) if p.Parent==Players then Root.Remotes.LobbyState:FireClient(p,msg) end end
 local setArea=deps.setArea or function() end
 local complex=deps.bindings
 local lease=nil;local matches,occupied,humans,battles,participantMatches={},{},{},{},{}
 local runtime=nil;local initialized=false
 local function assignment(m,slot)
  return {action="ArenaAssigned",matchId=m.matchId,arenaId=m.arenaId,tournamentId=m.tournamentId,battleId=m.battleId,
   camera=m.arena.Cameras[slot].CFrame,deadline=m.expires,presentation=m.presentation}
 end
 local A={}
 function A.Init(options)
  assert(not initialized,"ArenaService already initialized");options=options or {}
  setArea=options.setArea or setArea
  deps.onParticipantLost=options.onParticipantLost or deps.onParticipantLost
  deps.onTournamentFault=options.onTournamentFault or deps.onTournamentFault
  complex=complex or WorldBindings.ResolveArenaComplex()
  if not complex then return false end
  if deps.render~=false then
   assert(not complex.WorldRoot:FindFirstChild("ArenaRuntime"),"Arena runtime already owned")
   runtime=Instance.new("Folder");runtime.Name="ArenaRuntime";runtime.Parent=complex.WorldRoot
  end
  initialized=true;return true
 end
 function A.CanStartTournament() return initialized and lease==nil end
 function A.BeginTournament(id)
  if not A.CanStartTournament() or typeof(id)~="string" then return false end
  lease=id;return true
 end
 local function clearHuman(entry,exit)
  local p=entry.player;local root=entry.root;local h=entry.humanoid
  if root and root.Parent then
   root.Anchored=entry.anchored;root.AssemblyLinearVelocity=Vector3.zero;root.AssemblyAngularVelocity=Vector3.zero
   if p.Character==entry.character and h.Health>0 and exit then entry.character:PivotTo(exit.CFrame+Vector3.new(0,3,0)) end
  end
  if h and h.Parent then h.AutoRotate=entry.autoRotate end
  if humans[C.Id(p)]==entry.matchId then humans[C.Id(p)]=nil end
  if p.Parent==Players then
   p:SetAttribute("CumbiaArenaMatchId",nil);p:SetAttribute("CumbiaArenaId",nil)
   setArea(p,"Lobby");send(p,{action="ArenaReleased",matchId=entry.matchId})
  end
 end
 function A.ReleaseMatch(id)
  local m=matches[id];if not m then return false end
  -- Remove ownership first: duplicate finish/disconnect callbacks become harmless.
  matches[id]=nil;occupied[m.arenaId]=nil;if m.battleId then battles[m.battleId]=nil end
  for _,uid in m.actorIds do if participantMatches[uid]==id then participantMatches[uid]=nil end end
  for i,entry in ipairs(m.humans) do clearHuman(entry,m.arena.Exits[entry.slot]) end
  if m.visuals then m.visuals:Destroy() end
  return true
 end
 function A.EndTournament(id)
  if lease~=id then return false end
  local ids={};for key,m in pairs(matches) do if m.tournamentId==id then table.insert(ids,key) end end
  for _,key in ids do A.ReleaseMatch(key) end
  lease=nil;return true
 end
 function A.Reserve(spec)
  if not initialized or lease~=spec.tournamentId then return false,"ComplexNotOwned" end
  if matches[spec.matchId] then return false,"DuplicateMatch" end
  local arenaId
  if spec.round==1 and spec.slot>=1 and spec.slot<=4 then arenaId="Ring"..spec.slot
  elseif spec.round==2 and spec.slot>=1 and spec.slot<=2 then arenaId="Ring"..spec.slot
  elseif spec.round==3 and spec.slot==1 then arenaId="Final" end
  local arena=arenaId and complex.Arenas[arenaId]
  if not arena or occupied[arenaId] then return false,"ArenaUnavailable" end
  if #spec.participants~=2 then return false,"TwoCompetitorsRequired" end
  local ids={};local seen={}
  for _,p in spec.participants do local uid=C.Id(p);if participantMatches[uid] or seen[uid] then return false,"CompetitorAlreadyPlaced" end;seen[uid]=true;table.insert(ids,uid) end
  if not arena.Model:IsDescendantOf(complex.WorldRoot) then return false,"ArenaDetached" end
  for _,marker in arena.Stations do
   if not marker:IsDescendantOf(complex.WorldRoot) then return false,"StationDetached" end
   local support=WorldBindings.GetSupport(complex.WorldBindings,marker)
   if not support or math.abs(support.Position.Y-marker.Position.Y)>.25 then return false,"StationUnsupported" end
  end
  local m={matchId=spec.matchId,tournamentId=spec.tournamentId,arenaId=arenaId,arena=arena,headless=spec.headless==true,humans={},actorIds=ids,expires=now()+Config.Combat.MaxDurationSeconds+Presentation.NetworkLeadSeconds+Presentation.Duration+15}
  if not m.headless then
   local startAt=now()+Presentation.NetworkLeadSeconds
   m.presentation={startAt=startAt,endsAt=startAt+Presentation.Duration,round=spec.round,arenaId=arenaId,
    players={C.Presentation(spec.participants[1]),C.Presentation(spec.participants[2])},
    shots=Presentation.Shots(arena.Stations[1].CFrame,arena.Stations[2].CFrame)}
  end
  matches[m.matchId]=m;occupied[arenaId]=m.matchId
  for _,uid in ids do participantMatches[uid]=m.matchId end
  local ok,err=pcall(function()
   if runtime then m.visuals=Instance.new("Folder");m.visuals.Name=arenaId;m.visuals:SetAttribute("AcceleratedSimulation",m.headless);m.visuals.Parent=runtime end
   for slot,p in spec.participants do
    local marker=arena.Stations[slot];local cf=marker.CFrame+Vector3.new(0,3,0)
    if C.IsHuman(p) then
     local character=assert(p.Character,"Missing character");local root=assert(character:FindFirstChild("HumanoidRootPart"),"Missing root");local h=assert(character:FindFirstChildOfClass("Humanoid"),"Missing humanoid");assert(h.Health>0,"Dead character")
     local entry={player=p,character=character,root=root,humanoid=h,anchored=root.Anchored,autoRotate=h.AutoRotate,slot=slot,matchId=m.matchId}
     table.insert(m.humans,entry);humans[C.Id(p)]=m.matchId
     setArea(p,"Arena:"..m.matchId);root.AssemblyLinearVelocity=Vector3.zero;root.AssemblyAngularVelocity=Vector3.zero
     character:PivotTo(cf);root.Anchored=true;h.AutoRotate=false
     p:SetAttribute("CumbiaArenaMatchId",m.matchId);p:SetAttribute("CumbiaArenaId",arenaId)
     send(p,assignment(m,slot))
    elseif m.visuals then
     local model=representation(m.visuals,p,C,cf)
     if not m.headless then for _,v in model:GetDescendants() do if v:IsA("BillboardGui") then v.Enabled=false end end end
    end
   end
   if m.headless and m.visuals then
    local tag=Instance.new("Part");tag.Name="SimulationNotice";tag.Size=Vector3.one;tag.Transparency=1;tag.Anchored=true;tag.CanCollide=false;tag.CanTouch=false;tag.CanQuery=false;tag.Position=arena.Stations[1].Position:Lerp(arena.Stations[2].Position,.5)+Vector3.new(0,9,0);tag.Parent=m.visuals
    nameplate(tag,"Simulação acelerada",Vector3.new(0,1,0))
   end
  end)
  if not ok then A.ReleaseMatch(m.matchId);return false,tostring(err) end
  return true,arenaId
 end
 -- Readiness is server-clock owned. No client acknowledgement can start/extend a match.
 function A.IsPresentationReady(matchId)
  local m=matches[matchId]
  if not m then return false,"PresentationReservationLost" end
  if not m.arena.Model:IsDescendantOf(complex.WorldRoot) or now()>m.expires then return false,"PresentationLeaseLost" end
  for _,marker in m.arena.Stations do
   local support=marker:IsDescendantOf(complex.WorldRoot) and WorldBindings.GetSupport(complex.WorldBindings,marker)
   if not support or math.abs(support.Position.Y-marker.Position.Y)>.25 then return false,"PresentationStationLost" end
  end
  return m.headless or not m.presentation or now()>=m.presentation.endsAt
 end
 function A.BindBattle(matchId,battleId)
  local m=matches[matchId];if not m or m.battleId or typeof(battleId)~="string" or battles[battleId] then return false end
  m.battleId=battleId;battles[battleId]=matchId
  for _,entry in m.humans do send(entry.player,assignment(m,entry.slot)) end
  return true
 end
 -- ClientReady may arrive after placement on slow clients or a bootstrap restart.
 function A.SendSnapshot(p)
  local id=humans[C.Id(p)];local m=id and matches[id]
  if not m then return end
  for _,entry in m.humans do if entry.player==p then
   send(p,assignment(m,entry.slot));return
  end end
 end
 function A.RemovePlayer(p,reason)
  local id=humans[C.Id(p)];local m=id and matches[id]
  if not m then return end
  if deps.onParticipantLost then deps.onParticipantLost(p,reason or "Disconnected") end
 end
 local nextCheck=0
 function A.Update()
  if now()<nextCheck then return end;nextCheck=now()+.25
  for _,m in pairs(matches) do
   local fault=now()>m.expires or not m.arena.Model:IsDescendantOf(workspace)
   for _,marker in m.arena.Stations do
    local support=marker:IsDescendantOf(complex.WorldRoot) and WorldBindings.GetSupport(complex.WorldBindings,marker)
    if not support or math.abs(support.Position.Y-marker.Position.Y)>.25 then fault=true end
   end
   for _,entry in m.humans do
    if not entry.faulted and (entry.player.Character~=entry.character or entry.humanoid.Health<=0 or not entry.root:IsDescendantOf(workspace)) then
     entry.faulted=true;if deps.onParticipantLost then deps.onParticipantLost(entry.player,"CharacterLost") end
    end
   end
   if fault and not m.faulted then
    m.faulted=true
    if deps.onTournamentFault then deps.onTournamentFault(m.tournamentId,"ArenaLeaseLost") end
    A.EndTournament(m.tournamentId)
   end
  end
 end
 function A.Diagnostics()
  local out={tournamentId=lease,matches={},occupied=0}
  for id,m in matches do out.occupied+=1;table.insert(out.matches,{matchId=id,battleId=m.battleId,arenaId=m.arenaId,headless=m.headless,tournamentId=m.tournamentId}) end
  return out
 end
 function A.Shutdown() if lease then A.EndTournament(lease) end;if runtime then runtime:Destroy();runtime=nil end end
 return A
end
local default=create();default.new=create;return default

