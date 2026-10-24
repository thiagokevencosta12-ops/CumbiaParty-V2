--!nonstrict
-- Schedules server-owned input intentions. Never writes scores, HP or winners.
local Config=require(game.ReplicatedStorage.CumbiaParty.Shared.GameConfig)
local DefaultCompetitors=require(script.Parent.CompetitorService)
local function create(deps)
 deps=deps or {}
 local C=deps.competitors or DefaultCompetitors
 local rhythm=deps.rhythm or require(script.Parent.RhythmService)
 local now=deps.now or function() return workspace:GetServerTimeNow() end
 local plans={}
 local S={}
 function S.Schedule(p,sessionId,chart,startTime,wave,battleId)
  if C.IsHuman(p) then return end
  local cfg=Config.Tournament
  local profile=assert(cfg.Profiles[p.difficulty],"Unknown difficulty")
  local rng=Random.new((p.seed+wave*7919+(deps.salt or 0))%2147483647)
  local base=Random.new(p.seed):NextNumber(profile.min,profile.max)
  local accuracy=math.clamp(base-(wave-1)*cfg.WavePenalty-(if chart.accelerated then cfg.AccelerationPenalty else 0),.05,.99)
  local plan={events={},index=1,player=p,battleId=battleId}
  local function add(note,t,action)
   table.insert(plan.events,{protocolVersion=Config.ProtocolVersion,sessionId=sessionId,noteId=note.id,lane=note.lane,inputTime=t,action=action})
  end
  for _,note in ipairs(chart.notes) do
   local hold=(note.duration or 0)>0
   local hitChance=if hold then math.min(.995,accuracy/profile.holdReliability) else accuracy
   if rng:NextNumber()>hitChance then continue end -- normal automatic Miss
   local gradeRoll=rng:NextNumber()
   local offset
   if gradeRoll<profile.perfect then offset=rng:NextNumber(-.032,.032)
   elseif rng:NextNumber()<.25 then offset=rng:NextNumber(.052,.082)
   else offset=rng:NextNumber(.102,.131) end
   local press=startTime+note.time+offset
   add(note,press,"Begin")
   if hold then
    local ending=startTime+note.time+note.duration
    if rng:NextNumber()>profile.holdReliability then ending=press+note.duration*rng:NextNumber(.2,.7) end
    local pulse=press+Config.HoldPulseSeconds
    while pulse<ending do add(note,pulse,"HoldPulse");pulse+=Config.HoldPulseSeconds end
    add(note,ending,"End")
   end
  end
  table.sort(plan.events,function(a,b)
   if a.inputTime==b.inputTime then return a.lane<b.lane end
   return a.inputTime<b.inputTime
  end)
  plans[C.Id(p)]=plan
 end
 function S.Update()
  local time=now()
  for id,plan in pairs(plans) do
   while plan.index<=#plan.events and plan.events[plan.index].inputTime<=time do
    rhythm.SubmitServerInput(plan.player,plan.events[plan.index])
    plan.index+=1
   end
   if plan.index>#plan.events then plans[id]=nil end
  end
 end
 function S.CancelBattle(id)
  for key,plan in pairs(plans) do if plan.battleId==id then plans[key]=nil end end
 end
 function S.Clear() table.clear(plans) end
 return S
end
return {new=create}
