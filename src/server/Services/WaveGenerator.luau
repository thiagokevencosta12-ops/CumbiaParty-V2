--!strict
-- Pure deterministic data generator. Equivalent pair = identical rhythm/holds,
-- mirrored lanes (1<->4, 2<->3), preserving simultaneous load and hand symmetry.
local Config=require(game.ReplicatedStorage.CumbiaParty.Shared.GameConfig)
local W={}
function W.GeneratePair(seed:number,wave:number)
 local c=Config.Combat
 assert(wave>=1 and wave%1==0,"Invalid wave")
 local rng=Random.new((seed+wave*7919)%2147483647)
 local count=c.WaveCounts[math.min(wave,#c.WaveCounts)]
 local accelerated=wave>=c.AccelerationFromWave and (wave-c.AccelerationFromWave)%c.AcceleratedWaveEvery==0
 local beat=60/c.BPM
 local notes={}
 local free={0,0,0,0}
 local beatTime=1
 local lastLane=0
 local endTime=0
 for i=1,count do
  local duration=if wave>=c.HoldsFromWave and i%c.HoldEvery==0 then c.HoldBeats*beat else 0
  local candidates={}
  for lane=1,4 do
   if free[lane]<=beatTime*beat and lane~=lastLane then table.insert(candidates,lane) end
  end
  if #candidates==0 then
   -- Keep generation on the quarter-beat lattice until a lane is free.
   repeat
    beatTime+=.25
    for lane=1,4 do if free[lane]<=beatTime*beat then table.insert(candidates,lane) end end
   until #candidates>0
  end
  local lane=candidates[rng:NextInteger(1,#candidates)]
  local t=beatTime*beat
  table.insert(notes,{id=string.format("w%02dn%02d",wave,i),time=t,lane=lane,duration=duration})
  free[lane]=t+duration+Config.GoodWindowSeconds*2
  lastLane=lane
  endTime=math.max(endTime,t+duration)
  local subdivision=1
  if accelerated then
   local section=math.min(#c.Subdivisions,math.floor((i-1)*#c.Subdivisions/count)+1)
   subdivision=c.Subdivisions[section]
  end
  local chord=wave>=c.ChordsFromWave and i%c.ChordEvery==0 and i<count
  if not chord then beatTime+=1/subdivision end
 end
 local first,second={},{}
 for _,n in ipairs(notes) do
  table.insert(first,table.clone(n))
  local other=table.clone(n);other.lane=5-n.lane;table.insert(second,other)
 end
 local function chart(notesForPlayer,suffix)
  return {id=string.format("wave-%d-%d-%s",seed,wave,suffix),title="Cumbia X1",bpm=c.BPM,
   duration=endTime+.5,notes=notesForPlayer,accelerated=accelerated}
 end
 return chart(first,"A"),chart(second,"B")
end
return table.freeze(W)