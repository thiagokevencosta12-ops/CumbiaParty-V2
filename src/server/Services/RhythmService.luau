--!nonstrict
-- Shared authoritative note engine for solo charts AND combat turns.
-- Factory permits deterministic server tests with simulated players/clock/transport.
local Players=game:GetService("Players")
local Root=game.ReplicatedStorage.CumbiaParty
local Config=require(Root.Shared.GameConfig)
local DefaultCompetitors=require(script.Parent.CompetitorService)
local Validator=require(script.Parent.Parent.Validation.NoteValidator)
local function create(deps)
 deps=deps or {}
 local C=deps.competitors or DefaultCompetitors
 local now=deps.now or function() return workspace:GetServerTimeNow() end
 local findPlayer=deps.findPlayer or function(id) return C.Find(id) end
 local ping=deps.ping or function(p) return p:GetNetworkPing() end
 local send=deps.send or function(p,event,payload) if C.IsHuman(p) then Root.Remotes[event]:FireClient(p,payload) end end
 local makeId=deps.makeId or function() return game.HttpService:GenerateGUID(false) end
 local sessions={}
 local R={}
 local function stats()
  return {score=0,combo=0,maxCombo=0,Perfect=0,Great=0,Good=0,Miss=0,PerfectHold=0,GoodHold=0,BrokenHold=0}
 end
 local function snapshot(p,s)
  local out={protocolVersion=Config.ProtocolVersion,minigameId=Config.MinigameId,userId=C.Id(p),phase="Idle",mode="Solo"}
  if s then
   out.phase=s.phase;out.mode=s.mode;out.sessionId=s.id;out.startTime=s.startTime
   out.chartId=s.chart.id;out.chart=table.clone(s.chart);out.chart.notes={}
   for _,note in ipairs(s.chart.notes) do table.insert(out.chart.notes,table.clone(note)) end
   out.stats=table.clone(s.stats);out.revision=s.revision;out.judged=table.clone(s.judged);out.reason=s.reason
   if s.context then for k,v in pairs(s.context()) do out[k]=v end end
  end
  return out
 end
 function R.GetSnapshot(p) return snapshot(p,sessions[C.Id(p)]) end
 function R.SendSnapshot(p) send(p,"BattleState",R.GetSnapshot(p)) end
 function R.IsActive(p)
  local s=sessions[C.Id(p)];return s~=nil and s.phase=="Playing"
 end
 local function judge(p,s,note,grade,completion)
  if s.phase~="Playing" or s.judged[note.id] then return false end
  s.judged[note.id]=grade;s.holding[note.id]=nil;s.revision+=1
  local base=grade
  if grade=="PerfectHold" then base="Perfect"
  elseif grade=="GoodHold" then base="Good"
  elseif grade=="BrokenHold" then base="Miss" end
  s.stats[base]+=1
  if grade~=base then s.stats[grade]+=1 end
  if base=="Miss" then s.stats.combo=0 else s.stats.combo+=1 end
  s.stats.maxCombo=math.max(s.stats.maxCombo,s.stats.combo)
  local value=Config.Scores[base]
  if (note.duration or 0)>0 then
   value=math.floor((if grade=="BrokenHold" then Config.Scores.Good*Config.BrokenHoldScoreFraction else value)
    *(1+note.duration*Config.HoldScoreBonusPerSecond)*(completion or 0))
  end
  s.stats.score+=value
  local result={sessionId=s.id,noteId=note.id,accepted=true,grade=grade,reason="Judged",
   completion=completion or 1,revision=s.revision,stats=table.clone(s.stats)}
  send(p,"NoteResult",result)
  -- Trusted server callback; remote payload never enters damage calculations.
  if s.onJudged then s.onJudged(p,{grade=grade,combo=s.stats.combo,duration=note.duration or 0,completion=completion or 1}) end
  return true
 end
 function R.StartChart(p,chart,options)
  options=options or {}
  assert(not R.IsActive(p),"Player already has active chart")
  local s={id=makeId(),userId=C.Id(p),phase="Playing",mode=options.mode or "Solo",
   startTime=options.startTime or now()+Config.CountdownSeconds,chart=chart,stats=stats(),
   judged={},holding={},byId={},revision=0,lastInput=-math.huge,laneTimes={},
   context=options.context,onJudged=options.onJudged,onFinished=options.onFinished}
  for _,note in ipairs(chart.notes) do
   assert(not s.byId[note.id],"Duplicate chart note ID")
   s.byId[note.id]=note
  end
  sessions[C.Id(p)]=s
  if not options.silent then R.SendSnapshot(p) end
  return s.id
 end
 function R.Start(p)
  if R.IsActive(p) then R.SendSnapshot(p);return false end
  local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
  if not h or h.Health<=0 then R.SendSnapshot(p);return false end
  R.StartChart(p,Config.Charts[Config.DefaultChartId]);return true
 end
 function R.Cancel(p,id,reason,silent)
  local s=sessions[C.Id(p)]
  if not s or s.phase~="Playing" or (id and id~=s.id) then return end
  s.phase="Cancelled";s.reason=reason or "Cancelled";table.clear(s.holding)
  if not silent then R.SendSnapshot(p) end
 end
 local function submit(p,payload,serverInput)
  local valid,reason=Validator.ValidateRequest(payload)
  local s=sessions[C.Id(p)]
  local function reject(why)
   send(p,"NoteResult",{accepted=false,reason=why,sessionId=if valid then payload.sessionId else nil,noteId=if valid then payload.noteId else nil})
   return false,why
  end
  if not valid then return reject(reason) end
  if not s or s.id~=payload.sessionId or s.userId~=C.Id(p) or s.phase~="Playing" then return reject("InvalidSession") end
  local note=s.byId[payload.noteId]
  if not note or note.lane~=payload.lane then return reject("InvalidNote") end
  if s.judged[note.id] then return reject("AlreadyJudged") end
  local received=if serverInput then payload.inputTime else now()
  if serverInput and payload.inputTime>now()+1e-6 then return reject("FutureServerInput") end
  if not serverInput and not Validator.ValidateTime(payload.inputTime,received,ping(p)) then return reject("InvalidTime") end
  local action=payload.action or "Begin"
  local hold=s.holding[note.id]
  if action~="Begin" then
   if not hold then return reject("NotHolding") end
   if payload.inputTime<hold.lastInput or payload.inputTime<hold.pressTime then return reject("OutOfOrder") end
   if received-hold.lastPulse>Config.HoldPulseTimeoutSeconds+Config.MaxBackdateSeconds then
    judge(p,s,note,"BrokenHold",hold.completion);return false,"HoldTimeout"
   end
   local ending=s.startTime+note.time+note.duration
   local completion=math.clamp((payload.inputTime-math.max(hold.pressTime,s.startTime+note.time))/note.duration,0,1)
   hold.lastInput=payload.inputTime
   if action=="HoldPulse" then
    hold.lastPulse=received;hold.completion=completion
    return true,"Holding"
   end
   local grade="BrokenHold"
   if payload.inputTime>=ending-Config.HoldReleaseToleranceSeconds then
    grade=if hold.startGrade=="Perfect" then "PerfectHold" else "GoodHold"
    completion=math.clamp((ending-math.max(hold.pressTime,s.startTime+note.time))/note.duration,0,1)
   end
   judge(p,s,note,grade,completion);return true,grade
  end
  if hold then return reject("AlreadyHolding") end
  if payload.inputTime<s.lastInput then return reject("OutOfOrder") end
  if payload.inputTime-(s.laneTimes[payload.lane] or -math.huge)<Config.MinimumLaneIntervalSeconds then return reject("TooFast") end
  local expected=s.startTime+note.time
  if received<expected-Config.GoodWindowSeconds-Config.FutureToleranceSeconds or received>expected+Config.GoodWindowSeconds+Config.MaxBackdateSeconds then return reject("OutsideWindow") end
  local grade=Validator.JudgeTiming(expected,payload.inputTime)
  if grade=="Miss" then return reject("OutsideWindow") end
  s.lastInput=payload.inputTime;s.laneTimes[payload.lane]=payload.inputTime
  if (note.duration or 0)>0 then
   s.holding[note.id]={startGrade=grade,pressTime=payload.inputTime,lastInput=payload.inputTime,lastPulse=received,completion=0}
   send(p,"NoteResult",{accepted=true,reason="Holding",sessionId=s.id,noteId=note.id,startGrade=grade})
   return true,"Holding"
  end
  judge(p,s,note,grade,1);return true,grade
 end
 -- Both entry points share note ownership, timing, hold and duplicate rules.
 function R.Submit(p,payload)
  if not C.IsHuman(p) then return false,"HumanOnly" end
  return submit(p,payload,false)
 end
 function R.SubmitServerInput(p,payload)
  if C.IsHuman(p) or C.Find(C.Id(p))~=p then return false,"ServerOnly" end
  return submit(p,payload,true)
 end
 function R.Update()
  local t=now()
  for userId,s in pairs(sessions) do
   if s.phase~="Playing" then continue end
   local p=findPlayer(userId)
   if not p then sessions[userId]=nil;continue end
   for _,note in ipairs(s.chart.notes) do
    if s.phase~="Playing" then break end
    if s.judged[note.id] then continue end
    local hold=s.holding[note.id]
    local expected=s.startTime+note.time
    if hold then
     if t-hold.lastPulse>Config.HoldPulseTimeoutSeconds+Config.MaxBackdateSeconds
      or t>expected+note.duration+Config.GoodWindowSeconds+Config.MaxBackdateSeconds then
      judge(p,s,note,"BrokenHold",hold.completion)
     end
    elseif t>expected+Config.GoodWindowSeconds+Config.MaxBackdateSeconds then
     judge(p,s,note,if (note.duration or 0)>0 then "BrokenHold" else "Miss",0)
    end
   end
   if s.phase=="Playing" and t>s.startTime+s.chart.duration+Config.GoodWindowSeconds+Config.MaxBackdateSeconds then
    s.phase="Finished"
    if s.onFinished then s.onFinished(p,s.id) else R.SendSnapshot(p) end
   end
  end
 end
 function R.ReleaseSession(p) sessions[C.Id(p)]=nil end
 function R.RemovePlayer(p) sessions[C.Id(p)]=nil end
 return R
end
local default=create()
default.new=create
return default