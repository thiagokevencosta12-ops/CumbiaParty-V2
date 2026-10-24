--!nonstrict
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Root=game.ReplicatedStorage:WaitForChild("CumbiaParty")
local Config=require(Root.Shared.GameConfig)
local Rhythm=require(script.Parent.Services.RhythmService)
local Battle=require(script.Parent.Services.BattleService)
local Competitors=require(script.Parent.Services.CompetitorService)
local Tournament=require(script.Parent.Services.TournamentService)
local Lobby=require(script.Parent.Services.LobbyService)
Lobby.Init()
local Arena=require(script.Parent.Services.ArenaService)
if Arena.Init({setArea=Lobby.SetArea,
 onParticipantLost=function(p,reason) Tournament.Withdraw(p,reason) end,
 onTournamentFault=function(id,reason) Tournament.CancelPhysicalTournament(id,reason) end}) then
 Tournament.SetArenaAdapter(Arena)
end
game:BindToClose(Arena.Shutdown)
local tournamentTimes={}
local limits,readyTimes,controlTimes,connections={},{},{},{}
local function allow(player)
 local t=os.clock();local b=limits[player.UserId]
 if not b or t-b.time>=1 then b={time=t,count=0};limits[player.UserId]=b end
 b.count+=1;return b.count<=Config.MaxRequestsPerSecond
end
Root.Remotes.ClientReady.OnServerEvent:Connect(function(p)
 local t=os.clock()
 if t-(readyTimes[p.UserId] or -math.huge)<Config.ReadyCooldownSeconds then return end
 readyTimes[p.UserId]=t;Battle.SendSnapshot(p);Tournament.SendSnapshot(p);Arena.SendSnapshot(p)
end)
Root.Remotes.RhythmControl.OnServerEvent:Connect(function(p,msg)
 if not allow(p) or typeof(msg)~="table" then return end
 local action=msg.action
 if action=="Cancel" then
  if typeof(msg.battleId)=="string" then Battle.Forfeit(p,msg.battleId,"Forfeit")
  elseif typeof(msg.sessionId)=="string" and not Battle.IsBusy(p) then Rhythm.Cancel(p,msg.sessionId,"Cancelled") end
  return
 end
 if action=="CancelInvite" then Battle.CancelInvite(p);return end
 local t=os.clock()
 if t-(controlTimes[p.UserId] or -math.huge)<Config.StartCooldownSeconds then return end
 controlTimes[p.UserId]=t
 if action=="Start" then
  if Battle.IsBusy(p) or not Competitors.CanUse(p) then Battle.SendSnapshot(p);Tournament.SendSnapshot(p) else Battle.ClearResult(p);Rhythm.Start(p) end
 elseif action=="Invite" then Battle.Invite(p,msg.targetUserId)
 elseif action=="Accept" or action=="Decline" then
  if typeof(msg.inviteId)=="string" then Battle.Respond(p,msg.inviteId,action=="Accept") end
 end
end)
Root.Remotes.SubmitNote.OnServerEvent:Connect(function(p,payload)
 if allow(p) then Rhythm.Submit(p,payload) end
end)
Root.Remotes.TournamentRequest.OnServerEvent:Connect(function(p,msg)
 if not allow(p) or typeof(msg)~="table" then return end
 local t=os.clock()
 if t-(tournamentTimes[p.UserId] or -math.huge)<Config.Tournament.RequestCooldownSeconds then return end
 tournamentTimes[p.UserId]=t
 local ok,reason=true,nil
 if msg.action=="Join" then ok,reason=Tournament.Join(p)
 elseif msg.action=="LeaveQueue" then Tournament.LeaveQueue(p)
 elseif msg.action=="ExitView" then
  ok,reason=Tournament.ExitView(p)
  if ok then Lobby.Return(p) end
 elseif msg.action=="Withdraw" then Tournament.Withdraw(p,"Forfeit")
 elseif msg.action~="Snapshot" then return end
 if not ok then
  local snapshot=Tournament.GetSnapshot(p);snapshot.error=reason
  Root.Remotes.TournamentState:FireClient(p,snapshot)
 else Tournament.SendSnapshot(p) end
end)
local function attach(p)
 connections[p.UserId]=p.CharacterRemoving:Connect(function()
  Arena.RemovePlayer(p,"Respawn");Tournament.Withdraw(p,"Respawn");Battle.CancelInvite(p);Battle.Forfeit(p,nil,"Respawn");Rhythm.Cancel(p,nil,"Respawn")
 end)
end
Players.PlayerAdded:Connect(attach)
for _,p in ipairs(Players:GetPlayers()) do attach(p) end
Players.PlayerRemoving:Connect(function(p)
 Arena.RemovePlayer(p,"Disconnected");Tournament.RemovePlayer(p);Battle.RemovePlayer(p);Rhythm.RemovePlayer(p)
 tournamentTimes[p.UserId]=nil
 limits[p.UserId]=nil;readyTimes[p.UserId]=nil;controlTimes[p.UserId]=nil
 if connections[p.UserId] then connections[p.UserId]:Disconnect();connections[p.UserId]=nil end
end)
RunService.Heartbeat:Connect(function() Tournament.Update();Rhythm.Update();Battle.Update();Arena.Update() end)
Root:SetAttribute("ServerReady",true)
print("[CumbiaParty] Rhythm solo + Combat X1 + Tournament V1 prontos.")

