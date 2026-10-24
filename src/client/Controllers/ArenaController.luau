--!nonstrict
-- Sole owner of the physical duel camera. Input and note processing stay unchanged.
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Root=game.ReplicatedStorage.CumbiaParty
local Plan=require(Root.Shared.BattlePresentationConfig)
local View=require(script.Parent.BattlePresentationView)
local A={}
function A.new(gui,options)
 options=options or {}
 local player=Players.LocalPlayer;local current=nil;local links={};local oldCamera=nil;local hiddenPosition=nil
 local controller={}
 local retired,retiredOrder={},{}
 local function restoreMain()
  if hiddenPosition then gui.Main.Position=hiddenPosition;hiddenPosition=nil end
 end
 local function restore()
  if not current then return end
  if current.battleId and not retired[current.battleId] then
   retired[current.battleId]=true;table.insert(retiredOrder,current.battleId)
   if #retiredOrder>32 then retired[table.remove(retiredOrder,1)]=nil end
  end
  current=nil;restoreMain();gui:SetAttribute("BattlePresentationStage",nil)
  if controller.view then controller.view.Hide() end
  local c=workspace.CurrentCamera
  if c then
   c.CameraType=Enum.CameraType.Custom
   local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
   if h then c.CameraSubject=h end
   if oldCamera then c.FieldOfView=oldCamera.fov end
  end
  oldCamera=nil
  if options.onReleased then options.onReleased() end
 end
 controller.view=View.new(gui,function()
  if current and current.intro then Root.Remotes.TournamentRequest:FireServer({action="Withdraw"}) end
 end)
 local function beginGameplay()
  if not current or not current.intro then return end
  current.intro=false;restoreMain();controller.view.Hide();gui:SetAttribute("BattlePresentationStage","Gameplay")
 end
 table.insert(links,Root.Remotes.LobbyState.OnClientEvent:Connect(function(msg)
  if msg.action=="ArenaAssigned" and typeof(msg.matchId)=="string" and typeof(msg.camera)=="CFrame" and typeof(msg.deadline)=="number" then
   local same=current and current.id==msg.matchId
   if not same then
    restore()
    local camera=workspace.CurrentCamera;oldCamera={fov=camera.FieldOfView}
    current={id=msg.matchId,deadline=msg.deadline,received=os.clock(),intro=false}
   end
   current.camera=msg.camera;current.deadline=msg.deadline;current.battleId=msg.battleId or current.battleId
   current.tournamentId=msg.tournamentId;current.presentation=msg.presentation or current.presentation
   if current.presentation and not current.battleId and (not same or current.intro) then
    current.intro=true
    if not hiddenPosition then hiddenPosition=gui.Main.Position;gui.Main.Position=UDim2.fromScale(3,.5) end
    if not same and options.onIntro then options.onIntro() end
   elseif current.battleId then beginGameplay() end
  elseif msg.action=="ArenaReleased" and current and msg.matchId==current.id then restore() end
 end))
 -- Called before UI.Render by bootstrap. Ignore old round results during a new intro.
 function controller.OnBattleSnapshot(snapshot)
  if not current then return end
  local combat=snapshot.combat
  if current.intro and (retired[snapshot.battleId] or not combat or
   combat.tournamentId~=current.tournamentId or (snapshot.phase~="Playing" and snapshot.phase~="Waiting")) then
   return false -- A ClientReady replay from the previous round cannot dismiss this intro.
  end
  if current.battleId and snapshot.battleId and snapshot.battleId~=current.battleId then return false end
  if combat and combat.tournamentId==current.tournamentId and (snapshot.phase=="Playing" or snapshot.phase=="Waiting") then
   current.battleId=snapshot.battleId;beginGameplay()
  elseif snapshot.battleId and snapshot.battleId==current.battleId and snapshot.phase=="Finished" then restore() end
 end
 table.insert(links,player.CharacterRemoving:Connect(restore))
 table.insert(links,gui.Destroying:Connect(restore))
 table.insert(links,RunService.RenderStepped:Connect(function(dt)
  if not current then return end
  local now=workspace:GetServerTimeNow()
  if now>current.deadline or (os.clock()-current.received>1 and player:GetAttribute("CumbiaArenaMatchId")~=current.id) then restore();return end
  local camera=workspace.CurrentCamera;if not camera then return end
  local target=current.camera;local fov=Plan.GameplayFOV
  local p=current.presentation
  if p then
   local stage,progress=Plan.StageAt(p.startAt,now)
   if current.intro then
    if current.stage~=stage then current.stage=stage;current.cameraStarted=false end
    controller.view.Render(stage,progress,p);gui:SetAttribute("BattlePresentationStage",stage)
    target=p.shots[stage] or p.shots.Versus
    if stage=="CompetitorA" or stage=="CompetitorB" then fov=Plan.PortraitFOV end
   else target=p.shots.Gameplay end
  end
  -- Portrait view widens naturally on narrow viewports, retaining both players.
  local aspect=camera.ViewportSize.X/math.max(1,camera.ViewportSize.Y)
  if aspect<1 then
   fov=math.min(74,fov+18)
   -- A narrower horizontal FOV needs extra distance, not just a wider lens.
   if not current.intro or target==p.shots.Versus or target==p.shots.Logo then
    target+=-target.LookVector*math.max(0,(.9/aspect-1)*12)
   end
  end
  camera.CameraType=Enum.CameraType.Scriptable
  local blend=1-math.exp(-dt/Plan.CameraBlendSeconds)
  if not current.cameraStarted then camera.CFrame=target;current.cameraStarted=true else camera.CFrame=camera.CFrame:Lerp(target,blend) end
  camera.FieldOfView+= (fov-camera.FieldOfView)*blend
 end))
 function controller.Destroy()
  restore();for _,c in links do c:Disconnect() end;controller.view.Destroy()
 end
 return controller
end
return A

