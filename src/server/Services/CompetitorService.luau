--!nonstrict
-- Server-only identity and occupancy registry. Server competitors are data,
-- never Players, and never carry a fabricated Roblox UserId.
local Players=game:GetService("Players")
local function create(deps)
 deps=deps or {}
 local findHuman=deps.findHuman or function(id) return Players:GetPlayerByUserId(id) end
 local bots,reservations={},{}
 local C={}
 function C.IsHuman(p) return typeof(p)=="Instance" or p.kind~="Server" end
 function C.Id(p) return if C.IsHuman(p) then p.UserId else p.id end
 function C.Name(p) return if C.IsHuman(p) then p.DisplayName or p.Name else p.name end
 function C.Find(id) return if typeof(id)=="number" then findHuman(id) else bots[id] end
 function C.Available(p)
  if not p then return false end
  if not C.IsHuman(p) then return bots[p.id]==p end
  local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
  return p.Parent==Players and h~=nil and h.Health>0
 end
 function C.Presentation(p)
  local id=C.Id(p)
  return {id=id,name=C.Name(p),appearance=if C.IsHuman(p) then {color=math.abs(id)%8+1,style=math.abs(id)%3+1} else table.clone(p.appearance)}
 end
 function C.CreateServer(id,name,difficulty,seed,index)
  assert(typeof(id)=="string" and not bots[id],"Unique server competitor ID required")
  local p={id=id,kind="Server",name=name,difficulty=difficulty,seed=seed,
   appearance={color=(index-1)%8+1,style=(index-1)%3+1}}
  bots[id]=p;return p
 end
 function C.Remove(p)
  local id=C.Id(p);reservations[id]=nil
  if not C.IsHuman(p) then bots[id]=nil end
 end
 function C.Owner(p) return reservations[C.Id(p)] end
 function C.CanUse(p,owner)
  local current=reservations[C.Id(p)]
  return current==nil or (owner~=nil and current==owner)
 end
 function C.Reserve(p,owner)
  if not C.CanUse(p,owner) then return false end
  reservations[C.Id(p)]=owner;return true
 end
 function C.Release(p,owner)
  local id=C.Id(p)
  if reservations[id]==owner then reservations[id]=nil end
 end
 return C
end
local default=create();default.new=create
return default
