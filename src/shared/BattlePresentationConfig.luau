--!strict
-- Presentation clocks only. Never changes musical countdowns, turn clocks or scores.
local P={NetworkLeadSeconds=.4,Duration=7.9,GameplayFOV=54,PortraitFOV=48,CameraBlendSeconds=.22}
local stages={{"Logo",1},{"CompetitorA",1.4},{"CompetitorB",1.4},{"Versus",1.1},{"3",1},{"2",1},{"1",1}}
for _,s in stages do table.freeze(s) end
P.Stages=table.freeze(stages)
function P.StageAt(startAt:number,now:number):(string,number)
 local elapsed=math.max(0,now-startAt)
 for _,s in stages do
  local duration=s[2] :: number
  if elapsed<duration then return s[1] :: string,elapsed/duration end
  elapsed-=duration
 end
 return "Ready",1
end
function P.Shots(a:CFrame,b:CFrame)
 local center=a.Position:Lerp(b.Position,.5)
 local axis=b.Position-a.Position;axis=Vector3.new(axis.X,0,axis.Z)
 assert(axis.Magnitude>.01,"Duel stations must have horizontal separation")
 axis=axis.Unit
 local front=Vector3.new(-axis.Z,0,axis.X)
 local target=center+Vector3.new(0,3.2,0)
 local gameplay=CFrame.lookAt(center+front*18+Vector3.new(0,7,0),target)
 local function portrait(station:CFrame)
  return CFrame.lookAt(station.Position+station.LookVector*8+station.RightVector*2.2+Vector3.new(0,5.4,0),station.Position+Vector3.new(0,4.1,0))
 end
 return {Logo=CFrame.lookAt(center+front*25+Vector3.new(0,12,0),target),CompetitorA=portrait(a),CompetitorB=portrait(b),Versus=gameplay,Gameplay=gameplay}
end
return table.freeze(P)
