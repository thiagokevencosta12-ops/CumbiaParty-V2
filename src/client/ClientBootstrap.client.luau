--!nonstrict
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Root=game.ReplicatedStorage:WaitForChild("CumbiaParty")
local Config=require(Root.Shared.GameConfig)
local UI=require(script.Parent.Controllers.UIController)
local Input=require(script.Parent.Controllers.InputController)
local TournamentController=require(script.Parent.Controllers.TournamentController)
local LobbyController=require(script.Parent.Controllers.LobbyController)
local arena
local player=Players.LocalPlayer
local gui=player:WaitForChild("PlayerGui"):WaitForChild("CumbiaPartyGui")
local latest={phase="Idle",mode="Solo"}
local token=nil
local suppressed={}
local links={}
local pending=false
local targetIndex=1
local selectedId=nil
Input.Init()
local tournament=TournamentController.new(gui,function(action)
 Root.Remotes.TournamentRequest:FireServer({action=action})
end)
local lobby=LobbyController.new(gui,tournament)
table.insert(links,Root.Remotes.TournamentState.OnClientEvent:Connect(function(data)
 if data.protocolVersion==Config.ProtocolVersion then tournament.Render(data) end
end))
local function request(message)
 if pending then return end
 pending=true;Root.Remotes.RhythmControl:FireServer(message)
 task.delay(1.1,function() pending=false end)
end
local function refreshTarget()
 local list={}
 for _,p in ipairs(Players:GetPlayers()) do if p~=player then table.insert(list,p) end end
 table.sort(list,function(a,b) return a.UserId<b.UserId end)
 targetIndex=if #list==0 then 1 else ((targetIndex-1)%#list)+1
 local p=list[targetIndex];selectedId=if p then p.UserId else nil
 gui.Main.TargetButton.Text=if p then "ADVERSÁRIO: "..p.DisplayName.."  •  TOQUE PARA TROCAR" else "X1: abra dois clientes de teste"
end
local function cancel(reason)
 local old=latest
 if token then suppressed[token]=true end
 token=nil;Input.Stop()
 if old.battleId then Root.Remotes.RhythmControl:FireServer({action="Cancel",battleId=old.battleId})
 elseif old.mode=="Invite" then Root.Remotes.RhythmControl:FireServer({action="CancelInvite"})
 elseif old.sessionId then Root.Remotes.RhythmControl:FireServer({action="Cancel",sessionId=old.sessionId}) end
 latest={phase="Cancelled",mode="Solo",reason=reason};UI.Render(latest);tournament.SetBattleActive(false)
end
local buttons=UI.Init(gui,function()
 if token then return end
 if latest.phase=="Invited" then request({action="Accept",inviteId=latest.invite.id})
 else request({action="Start"}) end
end,function() cancel("Cancelled") end,function()
 if latest.phase=="Invited" then request({action="Decline",inviteId=latest.invite.id})
 elseif selectedId then request({action="Invite",targetUserId=selectedId})
 else UI.Feedback("É preciso outro jogador no servidor") end
end,function() targetIndex+=1;refreshTarget() end)
arena=require(script.Parent.Controllers.ArenaController).new(gui,{
 onIntro=function() tournament.SetBattleActive(true) end,
 onReleased=function() tournament.SetBattleActive(false) end,
})
refreshTarget()
table.insert(links,Players.PlayerAdded:Connect(refreshTarget))
table.insert(links,Players.PlayerRemoving:Connect(function() task.defer(refreshTarget) end))
local function lane(index,action)
 local ok,err=pcall(function()
  local message=UI.TryLane(index,workspace:GetServerTimeNow(),action)
  if message then Root.Remotes.SubmitNote:FireServer(message) end
 end)
 if not ok then warn("[CumbiaParty] Input: "..tostring(err));cancel("ClientError") end
end
table.insert(links,Root.Remotes.BattleState.OnClientEvent:Connect(function(snapshot)
 pending=false
 local ok,err=pcall(function()
  if arena.OnBattleSnapshot(snapshot)==false then return end
  local locked=snapshot.phase=="Playing" or snapshot.phase=="Waiting"
  if snapshot.mode=="Invite" then tournament.SetMenuVisible(true) end
  local nextToken=snapshot.battleId or snapshot.sessionId
  if locked and suppressed[nextToken] then return end
  if locked then
   assert(snapshot.protocolVersion==Config.ProtocolVersion and snapshot.userId==player.UserId and snapshot.minigameId==Config.MinigameId,"Invalid state")
   tournament.SetBattleActive(true);UI.Render(snapshot);latest=snapshot
   if token~=nextToken then
    token=nextToken
    local deadline=if snapshot.combat then snapshot.combat.deadline+2 else snapshot.startTime+(snapshot.chart or Config.Charts[snapshot.chartId]).duration+2
    Input.Start(lane,buttons,deadline,cancel,gui)
   end
  else
   token=nil;Input.Stop();latest=snapshot;UI.Render(snapshot);tournament.SetBattleActive(false)
   if snapshot.phase=="Finished" and not (snapshot.combat and snapshot.combat.tournamentId) then tournament.SetMenuVisible(true) end
  end
 end)
 if not ok then warn("[CumbiaParty] State: "..tostring(err));cancel("ClientError") end
end))
table.insert(links,Root.Remotes.NoteResult.OnClientEvent:Connect(function(result)
 local ok,err=pcall(UI.NoteResult,result)
 if not ok then warn("[CumbiaParty] Result: "..tostring(err));cancel("ClientError") end
end))
table.insert(links,RunService.RenderStepped:Connect(function()
 if not token then return end
 local ok,err=pcall(function()
  local t=workspace:GetServerTimeNow()
  for _,message in ipairs(UI.PollHolds(t,Input.IsLaneHeld)) do Root.Remotes.SubmitNote:FireServer(message) end
  UI.Tick(t)
 end)
 if not ok then warn("[CumbiaParty] Render: "..tostring(err));cancel("ClientError") end
end))
table.insert(links,player.CharacterAdded:Connect(function() cancel("Respawn") end))
table.insert(links,gui.Destroying:Connect(function() cancel("GuiRemoved") end))
script.Destroying:Connect(function()
 Input.Stop()
 if token then
  Root.Remotes.RhythmControl:FireServer({action="Cancel",battleId=latest.battleId,sessionId=latest.sessionId})
 end
 for _,c in ipairs(links) do c:Disconnect() end
 arena.Destroy();lobby.Destroy();tournament.Destroy();UI.Destroy()
end)
UI.Render(latest)
local deadline=os.clock()+10
while Root:GetAttribute("ServerReady")~=true and os.clock()<deadline do task.wait(.1) end
Root.Remotes.ClientReady:FireServer()
print("[CumbiaParty] Cliente pronto: solo, convite X1 e Hold Notes.")

