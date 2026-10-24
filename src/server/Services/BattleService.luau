--!nonstrict
-- Orchestrates X1 only: no note timing math, UI rendering or matchmaking here.
local Players=game:GetService("Players")
local Root=game.ReplicatedStorage.CumbiaParty
local Config=require(Root.Shared.GameConfig)
local Waves=require(script.Parent.WaveGenerator)
local DefaultRhythm=require(script.Parent.RhythmService)
local DefaultCompetitors=require(script.Parent.CompetitorService)
local function clone(t)
 if type(t)~="table" then return t end
 local out={};for k,v in pairs(t) do out[k]=clone(v) end;return out
end
local function create(deps)
 deps=deps or {}
 local C=deps.competitors or DefaultCompetitors
 local rhythm=deps.rhythm or DefaultRhythm
 local now=deps.now or function() return workspace:GetServerTimeNow() end
 local findPlayer=deps.findPlayer or function(id) return C.Find(id) end
 local send=deps.send or function(p,event,data) if C.IsHuman(p) then Root.Remotes[event]:FireClient(p,data) end end
 local makeId=deps.makeId or function() return game.HttpService:GenerateGUID(false) end
 local alive=deps.alive or C.Available
 local c=deps.config or Config.Combat
 local battles,members,lastResults,invitations,outgoing={},{},{},{},{}
 local B={}
 local function meta(b)
  local list={}
  for _,id in ipairs(b.ids) do local view=clone(b.presentation[id]);view.userId=if typeof(id)=="number" then id else nil;view.hp=b.hp[id];view.maxHP=c.InitialHP;table.insert(list,view) end
  return {battleId=b.id,wave=b.wave,activeUserId=b.active,players=list,deadline=b.deadline,
   winnerUserId=if typeof(b.winner)=="number" then b.winner else nil,winnerId=b.winner,tournamentId=b.tournamentId,performance=b.performance,draw=b.draw,reason=b.reason,stage=b.stage,accelerated=b.pair and b.pair[1].accelerated or false,totals=clone(b.totals)}
 end
 local function idle(p,reason)
  return {protocolVersion=Config.ProtocolVersion,minigameId=Config.MinigameId,userId=C.Id(p),mode="Solo",phase="Idle",reason=reason}
 end
 local function state(p,b)
  local out
  if b.stage=="Active" and b.active==C.Id(p) then out=rhythm.GetSnapshot(p)
  else
   out=idle(p)
   out.phase=if b.stage=="Finished" then "Finished" else "Waiting"
   local own=rhythm.GetSnapshot(p)
   out.stats=if own.battleId==b.id then own.stats else {score=0,combo=0,maxCombo=0,Perfect=0,Great=0,Good=0,Miss=0,PerfectHold=0,GoodHold=0,BrokenHold=0}
  end
  out.mode="Combat";out.battleId=b.id;out.combat=meta(b)
  return out
 end
 local function broadcast(b)
  for _,id in ipairs(b.ids) do local p=findPlayer(id);if p then send(p,"BattleState",state(p,b)) end end
 end
 local function clearInvite(inv,reason)
  invitations[inv.target]=nil;outgoing[inv.sender]=nil
  for _,id in ipairs({inv.sender,inv.target}) do
   local p=findPlayer(id);if p then send(p,"BattleState",idle(p,reason)) end
  end
 end
 function B.IsBusy(p) return members[C.Id(p)]~=nil or invitations[C.Id(p)]~=nil or outgoing[C.Id(p)]~=nil end
 function B.GetSnapshot(p)
  local b=battles[members[C.Id(p)]]
  if b then return clone(state(p,b)) end
  local inv=invitations[C.Id(p)] or outgoing[C.Id(p)]
  if inv then
   local out=idle(p);out.mode="Invite";out.phase=if inv.target==C.Id(p) then "Invited" else "Inviting"
   out.invite={id=inv.id,senderUserId=inv.sender,targetUserId=inv.target,senderName=inv.name,expiresAt=inv.expires}
   return out
  end
  local result=lastResults[C.Id(p)]
  if result and now()<result.expires then return clone(result.snapshot) end
  return nil
 end
 function B.SendSnapshot(p)
  local out=B.GetSnapshot(p)
  if out then send(p,"BattleState",out) else rhythm.SendSnapshot(p) end
 end
 function B.ClearResult(p) lastResults[C.Id(p)]=nil end
 function B.Finish(id,winner,reason)
  local b=battles[id]
  if not b or b.stage=="Finished" then return false end
  b.stage="Finished";b.winner=winner;b.draw=winner==nil;b.reason=reason;b.active=nil;b.finishedAt=now()
  for _,uid in ipairs(b.ids) do
   local p=findPlayer(uid)
   if p then rhythm.Cancel(p,nil,reason,true) end
   members[uid]=nil
  end
  for _,uid in ipairs(b.ids) do
   local p=findPlayer(uid)
   if p then
    local out=state(p,b);lastResults[uid]={snapshot=clone(out),expires=now()+c.ResultRetentionSeconds}
    send(p,"BattleState",out)
   end
  end
  if b.onCompleted then b.onCompleted(b.id,clone(meta(b))) end
  return true
 end
 local function limitWinner(b)
  if b.hp[b.ids[1]]==b.hp[b.ids[2]] then return nil end
  return if b.hp[b.ids[1]]>b.hp[b.ids[2]] then b.ids[1] else b.ids[2]
 end
 local function startTurn(b)
  if b.stage=="Finished" then return end
  if b.wave>c.MaxWaves or now()>=b.deadline then B.Finish(b.id,limitWinner(b),"Limit");return end
  for _,id in ipairs(b.ids) do
   local p=findPlayer(id)
   if not p or not alive(p) then
    local other=if b.ids[1]==id then b.ids[2] else b.ids[1]
    B.Finish(b.id,other,"Unavailable");return
   end
  end
  if b.turn==1 then
   local a,d=Waves.GeneratePair(b.seed,b.wave);b.pair={a,d}
  end
  b.stage="Active";b.active=b.ids[b.turn];b.performance=nil
  local p=findPlayer(b.active)
  local activeId=b.active
  b.rhythmId=rhythm.StartChart(p,b.pair[b.turn],{
   mode="Combat",silent=true,
   context=function() return {mode="Combat",battleId=b.id,combat=meta(b)} end,
   onJudged=function(player,result)
    if b.stage~="Active" or b.active~=C.Id(player) then return end
    local opponent=if b.ids[1]==C.Id(player) then b.ids[2] else b.ids[1]
    local total=b.totals[C.Id(player)]
    local quality=({Perfect=1,Great=.7,Good=.4,Miss=0,PerfectHold=1,GoodHold=.4,BrokenHold=0})[result.grade] or 0
    total.notes+=1;total.quality+=quality
    b.performance={id=C.Id(player),name=C.Name(player),grade=result.grade,combo=result.combo}
    local base=c.Damage[result.grade] or 0
    local multiplier=1+math.min(math.max(result.combo-1,0)*c.ComboBonusPerNote,c.MaxComboBonus)
    local holdBonus=if result.duration>0 then (1+result.duration*c.HoldDamageBonusPerSecond)*result.completion else 1
    local damage=math.floor(base*multiplier*holdBonus*100+.5)/100
    b.hp[opponent]=math.max(0,math.floor((b.hp[opponent]-damage)*100+.5)/100)
    if b.hp[opponent]<=0 then B.Finish(b.id,C.Id(player),"KO") else broadcast(b) end
   end,
   onFinished=function(player,sessionId)
    if b.stage~="Active" or b.active~=activeId or b.rhythmId~=sessionId then return end
    b.stage="Intermission";b.active=nil;b.nextAt=now()+c.TurnGapSeconds
    if b.turn==1 then b.turn=2 else b.turn=1;b.wave+=1 end
    broadcast(b)
   end,
  })
  if b.onTurn then b.onTurn(p,b.rhythmId,b.pair[b.turn],rhythm.GetSnapshot(p).startTime,b.wave,b.id) end
  broadcast(b)
 end
 function B.CreateSession(participants,seed,options)
  options=options or {}
  assert(#participants==2,"Two players required")
  local ids={}
  for _,p in ipairs(participants) do
   assert(not ids[C.Id(p)] and not B.IsBusy(p) and not rhythm.IsActive(p) and alive(p) and C.CanUse(p,options.owner),"Player unavailable")
   ids[C.Id(p)]=true
  end
  local b={id=makeId(),seed=seed or Random.new():NextInteger(1,c.SeedMax),ids={},names={},hp={},presentation={},totals={},
   tournamentId=options.tournamentId,onCompleted=options.onCompleted,onTurn=options.onTurn,
   wave=1,turn=1,stage="Preparing",deadline=now()+c.MaxDurationSeconds}
  for _,p in ipairs(participants) do
   table.insert(b.ids,C.Id(p));b.names[C.Id(p)]=C.Name(p)
   b.presentation[C.Id(p)]=C.Presentation(p);b.totals[C.Id(p)]={notes=0,quality=0}
   b.hp[C.Id(p)]=c.InitialHP;members[C.Id(p)]=b.id;lastResults[C.Id(p)]=nil
  end
  battles[b.id]=b
  startTurn(b)
  return b.id
 end
 function B.Invite(p,targetUserId)
  if typeof(targetUserId)~="number" or targetUserId~=targetUserId or targetUserId%1~=0 or targetUserId==C.Id(p) then return false end
  local target=findPlayer(targetUserId)
  if not C.CanUse(p) or (target and not C.CanUse(target)) or not target or not alive(p) or not alive(target) or B.IsBusy(p) or B.IsBusy(target) or rhythm.IsActive(p) or rhythm.IsActive(target) then
   send(p,"BattleState",B.GetSnapshot(p) or rhythm.GetSnapshot(p));return false
  end
  lastResults[C.Id(p)]=nil;lastResults[targetUserId]=nil
  local inv={id=makeId(),sender=C.Id(p),target=targetUserId,name=p.DisplayName or p.Name,expires=now()+c.InviteSeconds}
  invitations[targetUserId]=inv;outgoing[C.Id(p)]=inv
  B.SendSnapshot(p);B.SendSnapshot(target);return true
 end
 function B.Respond(p,inviteId,accept)
  local inv=invitations[C.Id(p)]
  if not inv or inv.id~=inviteId then return false end
  local sender=findPlayer(inv.sender)
  if not accept or now()>=inv.expires or not sender or not alive(p) or not alive(sender) then clearInvite(inv,"InviteClosed");return false end
  invitations[inv.target]=nil;outgoing[inv.sender]=nil
  B.CreateSession({sender,p});return true
 end
 function B.CancelInvite(p)
  local inv=invitations[C.Id(p)] or outgoing[C.Id(p)]
  if inv then clearInvite(inv,"InviteClosed") end
 end
 function B.Forfeit(p,battleId,reason)
  local id=members[C.Id(p)]
  if not id or (battleId and battleId~=id) then return false end
  local b=battles[id]
  local other=if b.ids[1]==C.Id(p) then b.ids[2] else b.ids[1]
  return B.Finish(id,if findPlayer(other) then other else nil,reason or "Forfeit")
 end
 function B.RemovePlayer(p)
  B.CancelInvite(p);B.Forfeit(p,nil,"Disconnected");lastResults[C.Id(p)]=nil
 end
 function B.Update()
  local t=now()
  for _,inv in pairs(invitations) do if t>=inv.expires then clearInvite(inv,"InviteExpired") end end
  for id,b in pairs(battles) do
   if b.stage=="Finished" then
    if t-b.finishedAt>=c.ResultRetentionSeconds then battles[id]=nil end
   elseif t>=b.deadline then B.Finish(id,limitWinner(b),"TimeLimit")
   elseif b.stage=="Intermission" and t>=b.nextAt then startTurn(b) end
  end
  for uid,result in pairs(lastResults) do if t>=result.expires then lastResults[uid]=nil end end
 end
 -- Diagnostics return copies; tests use these same service methods, never mock damage.
 function B.Release(id)
  local b=battles[id]
  if not b or b.stage~="Finished" then return false end
  for _,uid in ipairs(b.ids) do
   local p=findPlayer(uid)
   if p then
    local snapshot=rhythm.GetSnapshot(p)
    if snapshot.battleId==id then rhythm.ReleaseSession(p) end
   end
   local result=lastResults[uid]
   if result and result.snapshot.battleId==id then lastResults[uid]=nil end
  end
  battles[id]=nil;return true
 end
 function B.GetBattle(id) local b=battles[id];return if b then clone(meta(b)) else nil end
 return B
end
local default=create()
default.new=create
return default