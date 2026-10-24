--!nonstrict
-- Local queue adapter and independent elimination brackets.
-- Match completion is consumed once, outside BattleService's callback stack.
local Players=game:GetService("Players")
local Root=game.ReplicatedStorage.CumbiaParty
local Config=require(Root.Shared.GameConfig)
local DefaultC=require(script.Parent.CompetitorService)
local DefaultR=require(script.Parent.RhythmService)
local DefaultB=require(script.Parent.BattleService)
local BotService=require(script.Parent.BotService)
local function copy(value)
 if type(value)~="table" then return value end
 local out={};for k,v in pairs(value) do out[k]=copy(v) end;return out
end
local function create(deps)
 deps=deps or {}
 local C=deps.competitors or DefaultC
 local R=deps.rhythm or DefaultR
 local B=deps.battle or DefaultB
 local cfg=deps.config or Config.Tournament
 local now=deps.now or function() return workspace:GetServerTimeNow() end
 local makeId=deps.makeId or function() return game.HttpService:GenerateGUID(false) end
 local send=deps.send or function(p,data) Root.Remotes.TournamentState:FireClient(p,data) end
 local listHumans=deps.listHumans or function() return Players:GetPlayers() end
 local connected=deps.connected or function(p) return p and p.Parent==Players end
 local available=deps.available or C.Available
 local seedFor=deps.seed or function() return Random.new():NextInteger(1,cfg.SeedMax) end
 local queue,queueSet={},{}
 local queueDeadline=nil
 local tournaments,members,watching,jobs,completions={},{},{},{},{}
 local bots=BotService.new({competitors=C,rhythm=R,now=now})
 local T={}
 local arenas=deps.arenas
 function T.SetArenaAdapter(adapter) assert(next(tournaments)==nil,"Attach physical adapter before tournaments");arenas=adapter end
 local function activeCount()
  local n=0;for _,t in pairs(tournaments) do if t.status=="Running" then n+=1 end end;return n
 end
 local function view(t,p)
  local participants,matches={},{}
  for _,id in ipairs(t.ids) do
   local dto=copy(t.presentation[id]);dto.eliminated=t.eliminated[id]==true
   table.insert(participants,dto)
  end
  for _,m in ipairs(t.matches) do
   table.insert(matches,{round=m.round,slot=m.slot,a=m.a,b=m.b,status=m.status,winner=m.winner,reason=m.reason})
  end
  local uid=C.Id(p)
  return {id=t.id,status=t.status,round=t.round,participants=participants,matches=matches,
   champion=t.champion,myId=uid,eliminated=t.eliminated[uid]==true,
   reason=t.reason,canExit=t.status~="Running" or t.eliminated[uid]==true}
 end
 function T.GetSnapshot(p)
  local id=members[C.Id(p)] or watching[C.Id(p)]
  local t=id and tournaments[id]
  return {protocolVersion=Config.ProtocolVersion,queue={count=#queue,total=cfg.Size,
   deadline=queueDeadline,joined=queueSet[C.Id(p)]==true,capacityAvailable=activeCount()<cfg.MaxConcurrent and (not arenas or arenas.CanStartTournament())},
   tournament=if t then view(t,p) else nil}
 end
 function T.SendSnapshot(p) if connected(p) then send(p,T.GetSnapshot(p)) end end
 local function broadcast()
  for _,p in ipairs(listHumans()) do T.SendSnapshot(p) end
 end
 function T.IsReserved(p) return queueSet[C.Id(p)]==true or members[C.Id(p)]~=nil end
 local function resolve(t,id) return t.actors[id] end
 local function releaseHuman(t,id)
  local p=resolve(t,id)
  if p and C.IsHuman(p) then
   if members[id]==t.id then members[id]=nil end
   C.Release(p,t.owner)
  end
 end
 local function complete(t,reason,champion)
  if t.status~="Running" then return end
  t.status=if champion then "Finished" else "Cancelled"
  t.reason=reason;t.champion=champion;t.finishedAt=now()
  for _,m in ipairs(t.matches) do
   if m.status=="Active" then
    local engine=if jobs[m.id] then jobs[m.id].battle else B
    engine.Finish(m.battleId,nil,"TournamentCancelled")
    engine.Release(m.battleId)
    bots.CancelBattle(m.battleId);jobs[m.id]=nil;m.status="Cancelled"
   elseif m.status=="Presenting" then
    -- No battle exists yet. EndTournament releases its physical reservation.
    m.status="Cancelled"
   end
  end
  if arenas then arenas.EndTournament(t.id) end
  for _,id in ipairs(t.ids) do
   local p=resolve(t,id)
   releaseHuman(t,id)
   if p and not C.IsHuman(p) then C.Remove(p) end
  end
  broadcast()
 end
 local function finishMatch(t,m,winner,reason)
  if t.status~="Running" or m.status=="Finished" or m.status=="Cancelled" then return end
  m.status="Finished";m.winner=winner;m.reason=reason
  if arenas then arenas.ReleaseMatch(m.id) end
  for _,id in ipairs({m.a,m.b}) do
   if id~=winner then t.eliminated[id]=true;releaseHuman(t,id) end
  end
  broadcast()
 end
 local function tieWinner(t,m,result)
  local a=result.totals and result.totals[m.a]
  local b=result.totals and result.totals[m.b]
  local qa=if a and a.notes>0 then a.quality/a.notes else 0
  local qb=if b and b.notes>0 then b.quality/b.notes else 0
  if math.abs(qa-qb)>1e-9 then return if qa>qb then m.a else m.b end
  -- Public rules: only an exact tie uses a precommitted, seeded fair draw.
  return m.tieWinner
 end
 local function enqueueCompletion(t,m,battleId,result)
  table.insert(completions,{t=t,m=m,battleId=battleId,result=result})
 end
 local function startMatch(t,m)
  if t.status~="Running" or (m.status~="Pending" and m.status~="Presenting") then return end
  local pa,pb=resolve(t,m.a),resolve(t,m.b)
  local aa=pa and not t.withdrawn[m.a] and (not C.IsHuman(pa) or (connected(pa) and available(pa)))
  local ab=pb and not t.withdrawn[m.b] and (not C.IsHuman(pb) or (connected(pb) and available(pb)))
  if not aa or not ab then
   if not aa then t.withdrawn[m.a]=true end
   if not ab then t.withdrawn[m.b]=true end
   finishMatch(t,m,if aa then m.a elseif ab then m.b else m.tieWinner,"Walkover")
   return
  end
  local headless=not C.IsHuman(pa) and not C.IsHuman(pb)
  if arenas then
   if m.status~="Presenting" then
    local ok,reason=arenas.Reserve({tournamentId=t.id,matchId=m.id,round=m.round,slot=m.slot,participants={pa,pb},headless=headless})
    if not ok then warn("[CumbiaBattle] Physical reservation failed: "..tostring(reason));complete(t,"ArenaUnavailable");return end
   end
   -- Optional, non-yielding presentation gate. It changes only when the existing
   -- engine is created; musical clocks and rules begin inside CreateSession.
   if arenas.IsPresentationReady then
    local ready,reason=arenas.IsPresentationReady(m.id)
    if reason then complete(t,reason);return end
    if not ready then m.status="Presenting";return end
   end
  end
  local wasPresenting=m.status=="Presenting"
  local engine=B
  local scheduler=bots
  local job
  if headless then
   job={time=0}
   local clock=function() return job.time end
   local rhythm=DefaultR.new({competitors=C,now=clock,findPlayer=C.Find,send=function() end})
   engine=DefaultB.new({competitors=C,rhythm=rhythm,now=clock,findPlayer=C.Find,send=function() end,alive=available})
   scheduler=BotService.new({competitors=C,rhythm=rhythm,now=clock,salt=m.seed})
   job.rhythm=rhythm;job.battle=engine;job.bots=scheduler
  end
  m.status="Active"
  local ok,id=pcall(engine.CreateSession,{pa,pb},m.seed,{
   owner=t.owner,tournamentId=t.id,
   onTurn=scheduler.Schedule,
   onCompleted=function(battleId,result) enqueueCompletion(t,m,battleId,result) end,
  })
  if not ok then
   warn("[CumbiaParty] Tournament match failed: "..tostring(id))
   if arenas then arenas.ReleaseMatch(m.id) end
   complete(t,"MatchError");return
  end
  m.battleId=id
  if arenas then assert(arenas.BindBattle(m.id,id),"Arena battle binding lost") end
  if job then jobs[m.id]=job end
  if wasPresenting then broadcast() end
 end
 local function startRound(t,ids)
  t.round+=1;t.nextRoundAt=nil
  for i=1,#ids,2 do
   local m={id=t.id..":"..t.round..":"..i,round=t.round,slot=(i+1)/2,a=ids[i],b=ids[i+1],
    status="Pending",seed=t.rng:NextInteger(1,cfg.SeedMax)}
   m.tieWinner=if t.rng:NextNumber()<.5 then m.a else m.b
   table.insert(t.matches,m)
  end
  for _,m in ipairs(t.matches) do if t.status=="Running" and m.round==t.round then startMatch(t,m) end end
  broadcast()
 end
 local function launch()
  if #queue==0 or activeCount()>=cfg.MaxConcurrent or (arenas and not arenas.CanStartTournament()) then return end
  local humans={}
  for _,id in ipairs(queue) do
   local p=C.Find(id)
   if p and connected(p) and available(p) then table.insert(humans,p)
   elseif p then C.Release(p,"TournamentQueue") end
  end
  table.clear(queue);table.clear(queueSet);queueDeadline=nil
  if #humans==0 then broadcast();return end
  local t={id=makeId(),status="Running",round=0,ids={},actors={},presentation={},eliminated={},withdrawn={},matches={},seed=seedFor()}
  t.owner="Tournament:"..t.id;t.rng=Random.new(t.seed)
  if arenas and not arenas.BeginTournament(t.id) then error("Physical complex reservation lost") end
  tournaments[t.id]=t
  local slots={}
  -- Spread humans among first-round pairs before placing second humans.
  local humanSlots={1,3,5,7,2,4,6,8}
  for i,p in ipairs(humans) do slots[humanSlots[i]]=p end
  local nameOffset=t.rng:NextInteger(0,#cfg.Names-1)
  for i=1,cfg.Size do
   local p=slots[i]
   if not p then
    local level=cfg.DifficultySlots[i]
    -- First opponents of humans are welcoming; stronger independent entrants
    -- can progress naturally. No profile changes after bracket construction.
    if i%2==0 and slots[i-1] and C.IsHuman(slots[i-1]) then
     level=if i<=4 then "Beginner" else "Intermediate"
    end
    p=C.CreateServer(t.id..":entrant:"..i,cfg.Names[(i+nameOffset-1)%#cfg.Names+1],level,t.rng:NextInteger(1,cfg.SeedMax),i)
    slots[i]=p
   end
   local id=C.Id(p)
   if C.IsHuman(p) then
    C.Release(p,"TournamentQueue");members[id]=t.id;watching[id]=t.id
   end
   assert(C.Reserve(p,t.owner),"Tournament reservation lost")
   table.insert(t.ids,id);t.actors[id]=p;t.presentation[id]=C.Presentation(p)
  end
  startRound(t,t.ids)
 end
 function T.Join(p)
  local id=C.Id(p)
  if not C.IsHuman(p) or not connected(p) or not available(p) then return false,"Unavailable" end
  if queueSet[id] or members[id] then return false,"AlreadyJoined" end
  if not C.CanUse(p) or B.IsBusy(p) or R.IsActive(p) then return false,"Busy" end
  if #queue>=cfg.Size then return false,"QueueFull" end
  watching[id]=nil
  if not C.Reserve(p,"TournamentQueue") then return false,"Busy" end
  table.insert(queue,id);queueSet[id]=true
  if not queueDeadline then queueDeadline=now()+cfg.QueueSeconds end
  if #queue==cfg.Size then launch() end
  broadcast();return true
 end
 function T.LeaveQueue(p)
  local id=C.Id(p)
  if not queueSet[id] then return false end
  queueSet[id]=nil;C.Release(p,"TournamentQueue")
  local index=table.find(queue,id);if index then table.remove(queue,index) end
  if #queue==0 then queueDeadline=nil end
  broadcast();return true
 end
 function T.ExitView(p)
  local id=C.Id(p)
  if members[id] then return false,"StillCompeting" end
  watching[id]=nil;T.SendSnapshot(p);return true
 end
 function T.Withdraw(p,reason)
  T.LeaveQueue(p)
  local id=C.Id(p);local t=tournaments[members[id]]
  if t then
   t.withdrawn[id]=true
   B.Forfeit(p,nil,reason or "Forfeit")
   -- Between rounds, remove eligibility while preserving the bracket slot.
   t.eliminated[id]=true;releaseHuman(t,id)
   broadcast()
  end
 end
 function T.RemovePlayer(p)
  T.Withdraw(p,"Disconnected");watching[C.Id(p)]=nil
 end
 function T.Update()
  bots.Update()
  -- Globally bounded work; fast jobs rotate so concurrent tournaments progress.
  local start=os.clock()
  local keys={};for id in pairs(jobs) do table.insert(keys,id) end
  local steps=0
  while #keys>0 and steps<cfg.SimulationStepsPerUpdate do
   for _,id in ipairs(keys) do
    local job=jobs[id]
    if job then
     job.time+=cfg.SimulationStepSeconds
     job.bots.Update();job.rhythm.Update();job.battle.Update();steps+=1
     if steps>=cfg.SimulationStepsPerUpdate then break end
    end
   end
   if os.clock()-start>=cfg.SimulationBudgetSeconds then break end
  end
  local pending=completions;completions={}
  for _,event in ipairs(pending) do
   local t,m,result=event.t,event.m,event.result
   if m.status=="Active" and m.battleId==event.battleId and t.status=="Running" then
    local winner=result.winnerId or result.winnerUserId
    local reason=result.reason
    if not winner then winner=tieWinner(t,m,result);reason="Tiebreak" end
    local job=jobs[m.id]
    if job then job.bots.Clear();job.battle.Release(m.battleId);jobs[m.id]=nil
    else bots.CancelBattle(m.battleId);B.Release(m.battleId) end
    finishMatch(t,m,winner,reason)
   end
  end
  for id,t in pairs(tournaments) do
   if t.status=="Running" then
    local hasHuman=false
    for _,uid in ipairs(t.ids) do
     local p=resolve(t,uid)
     if C.IsHuman(p) and connected(p) and (members[uid]==id or watching[uid]==id) then hasHuman=true;break end
    end
    if not hasHuman then complete(t,"NoHumans");continue end
    -- Every match reserves during startRound; ready matches resume independently.
    -- startMatch rechecks withdrawal/availability before creating any session.
    for _,m in ipairs(t.matches) do
     if m.round==t.round and m.status=="Presenting" then startMatch(t,m) end
    end
    if t.status~="Running" then continue end
    local done=true;local winners={}
    for _,m in ipairs(t.matches) do
     if m.round==t.round then
      if m.status~="Finished" then done=false else table.insert(winners,m.winner) end
     end
    end
    if done then
     if #winners==1 then complete(t,"Champion",winners[1])
     elseif not t.nextRoundAt then t.nextRoundAt=now()+cfg.BetweenRoundsSeconds;broadcast()
     elseif now()>=t.nextRoundAt then startRound(t,winners) end
    end
   elseif now()-t.finishedAt>=cfg.RetentionSeconds then
    for uid,viewId in pairs(watching) do if viewId==id then watching[uid]=nil end end
    tournaments[id]=nil
   end
  end
  if #queue>0 and queueDeadline and (now()>=queueDeadline or #queue>=cfg.Size) then launch() end
 end
 function T.CancelPhysicalTournament(id,reason)
  local t=tournaments[id];if t and t.status=="Running" then complete(t,reason or "ArenaUnavailable");return true end;return false
 end
 function T.GetTournament(id)
  local t=tournaments[id]
  return if t then {id=t.id,status=t.status,round=t.round,champion=t.champion,matches=copy(t.matches),ids=copy(t.ids)} else nil
 end
 function T.Diagnostics()
  local n,j=0,0;for _ in pairs(tournaments) do n+=1 end;for _ in pairs(jobs) do j+=1 end
  return {tournaments=n,jobs=j,queue=#queue,active=activeCount()}
 end
 return T
end
local default=create();default.new=create
return default

