--!nonstrict
-- Server-only resolver. No gameplay dependencies, instance creation or indefinite waits.
local WorldConfig=require(game.ReplicatedStorage.CumbiaParty.Shared.WorldConfig)
local W={}
local function finite(n) return typeof(n)=="number" and n==n and math.abs(n)<math.huge end
local function check(value,message) assert(value,"WorldBindings: "..message) end
local function pathValid(path,label)
 check(typeof(path)=="table" and #path>0,label.." must be a nonempty path")
 for _,name in ipairs(path) do check(typeof(name)=="string" and #name>0 and name~="..",label.." contains an invalid name") end
end
local function resolvePath(parent,path,label)
 pathValid(path,label)
 local node=parent
 for _,name in ipairs(path) do
  local found=nil
  for _,child in ipairs(node:GetChildren()) do
   if child.Name==name then check(found==nil,label.." is ambiguous at "..name);found=child end
  end
  check(found~=nil,"missing "..label.." at "..table.concat(path,"."))
  node=found
 end
 return node
end
local function contains(polygon,x,z)
 local inside=false
 for i,a in ipairs(polygon) do
  local b=polygon[i%#polygon+1]
  local dx,dz=b.X-a.X,b.Y-a.Y
  local length=dx*dx+dz*dz
  local t=if length>0 then math.clamp(((x-a.X)*dx+(z-a.Y)*dz)/length,0,1) else 0
  -- Same edge tolerance as the original LobbyService; no seams between sectors.
  if (x-a.X-t*dx)^2+(z-a.Y-t*dz)^2<=1e-6 then return true end
  if (a.Y>z)~=(b.Y>z) and x<(b.X-a.X)*(z-a.Y)/(b.Y-a.Y)+a.X then inside=not inside end
 end
 return inside
end
-- Tropical polygons retain their original rule; Underground also bounds each floor in Y.
function W.IsOutside(position,config)
 if typeof(position)~="Vector3" or not finite(position.X) or not finite(position.Y) or not finite(position.Z) then return true end
 if position.Y<config.MinY or position.Y>config.MaxY then return true end
 local x,z=position.X-config.Center.X,position.Z-config.Center.Z
 for _,region in ipairs(config.SafeRegions) do
  if (region.minY==nil or (position.Y>=region.minY and position.Y<=region.maxY)) and contains(region.polygon,x,z) then return false end
 end
 return true
end
function W.ValidateProfile(profile)
 check(typeof(profile)=="table","profile must be a table")
 check(typeof(profile.Id)=="string" and #profile.Id>0,"profile Id is required")
 check(profile.Ready==true,"profile "..profile.Id.." is not ready. "..tostring(profile.PendingReason or "Complete its configuration."))
 pathValid(profile.WorldRootPath,"WorldRootPath");pathValid(profile.SpawnPath,"SpawnPath")
 check(typeof(profile.UseTerrainSupport)=="boolean","UseTerrainSupport must be boolean")
 local c=profile.Lobby
 check(typeof(c)=="table","Lobby configuration is required")
 check(typeof(c.Center)=="Vector3" and finite(c.Center.X) and finite(c.Center.Y) and finite(c.Center.Z),"invalid Center")
 check(finite(c.MinY) and finite(c.MaxY) and c.MinY<c.MaxY,"invalid vertical bounds")
 check(finite(c.ReturnHeight) and c.ReturnHeight>=0,"invalid ReturnHeight")
 check(finite(c.RecoveryIntervalSeconds) and c.RecoveryIntervalSeconds>0,"invalid recovery interval")
 check(finite(c.RecoveryCooldownSeconds) and c.RecoveryCooldownSeconds>=0,"invalid recovery cooldown")
 check(typeof(profile.MarkerPaths)=="table","MarkerPaths are required")
 check(typeof(c.RecoveryMarkerNames)=="table" and #c.RecoveryMarkerNames>0,"recovery markers are required")
 local markerIds={}
 for _,id in ipairs(c.RecoveryMarkerNames) do
  check(typeof(id)=="string" and #id>0 and not markerIds[id],"duplicate or invalid recovery marker")
  markerIds[id]=true;pathValid(profile.MarkerPaths[id],"marker "..id)
 end
 check(markerIds[c.ReturnMarkerName],"ReturnMarkerName must reference a recovery marker")
 check(typeof(c.SafeRegions)=="table" and #c.SafeRegions>0,"safe regions must be authored before activation")
 local regionIds={}
 for _,region in ipairs(c.SafeRegions) do
  check(typeof(region.id)=="string" and not regionIds[region.id],"duplicate or invalid region id")
  regionIds[region.id]=true
  check(markerIds[region.recoveryMarker],"region references an unknown recovery marker")
  if c.RequireRegionHeights or region.minY~=nil or region.maxY~=nil then
   check(finite(region.minY) and finite(region.maxY) and region.minY<region.maxY,"invalid region height bounds")
   check(region.minY>=c.MinY and region.maxY<=c.MaxY,"region exceeds global height bounds")
  end
  local polygon=region.polygon
  check(typeof(polygon)=="table" and #polygon>=3,"region polygon needs at least three vertices")
  local area=0
  for i,a in ipairs(polygon) do
   local b=polygon[i%#polygon+1]
   check(typeof(a)=="Vector2" and finite(a.X) and finite(a.Y),"polygon has a nonfinite vertex")
   check(typeof(b)=="Vector2" and finite(b.X) and finite(b.Y),"polygon has a nonfinite vertex")
   area+=a.X*b.Y-b.X*a.Y
  end
  check(math.abs(area)>1e-6,"degenerate region polygon")
 end
 check(typeof(profile.Terminals)=="table","Terminals must be a table")
 local terminalIds={}
 for _,spec in ipairs(profile.Terminals) do
  check(typeof(spec.Id)=="string" and #spec.Id>0 and not terminalIds[spec.Id],"duplicate or invalid terminal id")
  terminalIds[spec.Id]=true;pathValid(spec.PromptPath,"terminal "..spec.Id)
  check(spec.Action=="OpenTournament","unsupported terminal action")
  check(finite(spec.MaxServerDistance) and spec.MaxServerDistance>0,"invalid terminal distance")
 end
 if profile.RequiredPaths then
  local ids={}
  for _,spec in ipairs(profile.RequiredPaths) do
   check(typeof(spec.Id)=="string" and not ids[spec.Id],"duplicate required binding");ids[spec.Id]=true
   pathValid(spec.Path,"required "..spec.Id);check(typeof(spec.ClassName)=="string","required class missing")
  end
 end
 return true
end
function W.Resolve(profile,world)
 profile=profile or WorldConfig.GetActiveProfile();world=world or workspace
 W.ValidateProfile(profile)
 local root=resolvePath(world,profile.WorldRootPath,"world root")
 check(root:IsA("Model") or root:IsA("Folder"),"world root must be a Model or Folder")
 local spawn=resolvePath(world,profile.SpawnPath,"spawn")
 check(spawn:IsA("SpawnLocation"),"spawn must be a SpawnLocation")
 check(not W.IsOutside(spawn.Position,profile.Lobby),"spawn is outside the safe regions")
 local markers={}
 for _,id in ipairs(profile.Lobby.RecoveryMarkerNames) do
  local marker=resolvePath(root,profile.MarkerPaths[id],"marker "..id)
  check(marker:IsA("BasePart"),"marker "..id.." must be a BasePart")
  check(not W.IsOutside(marker.Position,profile.Lobby),"marker "..id.." is outside the safe regions")
  markers[id]=marker
 end
 local features={}
 for _,spec in ipairs(profile.RequiredPaths or {}) do
  local instance=resolvePath(root,spec.Path,"required "..spec.Id)
  check(instance:IsA(spec.ClassName),"wrong class for required "..spec.Id);features[spec.Id]=instance
 end
 local support={root}
 if profile.UseTerrainSupport then
  local terrain=world:FindFirstChildOfClass("Terrain")
  check(terrain~=nil,"Terrain support requested but Terrain is missing")
  table.insert(support,terrain)
 end
 local terminals={}
 for _,spec in ipairs(profile.Terminals) do
  local prompt=resolvePath(root,spec.PromptPath,"terminal "..spec.Id)
  check(prompt:IsA("ProximityPrompt"),"terminal "..spec.Id.." must be a ProximityPrompt")
  check(prompt.Parent:IsA("BasePart"),"terminal "..spec.Id.." must be parented to a BasePart")
  table.insert(terminals,table.freeze({Id=spec.Id,Prompt=prompt,ActivationPart=prompt.Parent,Action=spec.Action,MaxServerDistance=spec.MaxServerDistance}))
 end
 local result=table.freeze({ProfileId=profile.Id,WorldRoot=root,Spawn=spawn,Markers=table.freeze(markers),Features=table.freeze(features),
  SupportInstances=table.freeze(support),Terminals=table.freeze(terminals),Config=profile.Lobby,World=world})
 if profile.RequireSupportedMarkers then
  for id,marker in pairs(markers) do
   local hit=W.GetSupport(result,marker)
   check(hit and hit.Normal.Y>=.6 and math.abs(marker.Position.Y-hit.Position.Y)<=1,"missing or wrong-height support below marker "..id)
  end
  local hit=W.GetSupport(result,spawn)
  check(hit and hit.Normal.Y>=.6,"missing spawn support")
 end
 return result
end
function W.GetMarker(bindings,id)
 if not bindings then return nil end
 local marker=bindings.Markers[id]
 return if marker and marker:IsDescendantOf(bindings.WorldRoot) and bindings.WorldRoot:IsDescendantOf(bindings.World) then marker else nil
end
function W.GetSupport(bindings,marker)
 if not bindings or not marker or not bindings.WorldRoot:IsDescendantOf(bindings.World) then return nil end
 local params=RaycastParams.new();params.FilterType=Enum.RaycastFilterType.Include
 params.FilterDescendantsInstances=bindings.SupportInstances;params.IgnoreWater=true;params.RespectCanCollide=true
 return bindings.World:Raycast(marker.Position+Vector3.new(0,8,0),Vector3.new(0,-20,0),params)
end
-- Optional world-specific arena contract. Tropical has no physical complex.
function W.ResolveArenaComplex(profile,world)
 profile=profile or WorldConfig.GetActiveProfile();world=world or workspace
 if not profile.ArenaComplex then return nil end
 local b=W.Resolve(profile,world);local spec=profile.ArenaComplex
 check(spec.MaxPhysicalTournaments==1,"North physical capacity must be explicit")
 local arenas={}
 for _,item in ipairs(spec.Arenas) do
  check(not arenas[item.Id],"duplicate physical arena")
  local model=resolvePath(b.WorldRoot,item.Path,"physical arena "..item.Id);check(model:IsA("Model"),"arena model required")
  local points=resolvePath(model,{"PhysicalBindings"},"arena bindings")
  local a={Model=model,Stations={},Cameras={},Exits={},Keyboards={}}
  for i,suffix in ipairs({"A","B"}) do
   for field,prefix in pairs({Stations="Station",Cameras="Camera",Exits="Exit"}) do
    local point=resolvePath(points,{prefix..suffix},item.Id.." "..prefix..suffix)
    check(point:IsA("BasePart") and point.Anchored and not point.CanCollide,"arena marker must be an inert anchored part")
    if field~="Cameras" then
     check(not W.IsOutside(point.Position,b.Config),"unsafe arena marker")
     local h=W.GetSupport(b,point);check(h and h.Normal.Y>.95 and math.abs(h.Position.Y-point.Position.Y)<=.25,"unsupported arena station/exit")
    end
    a[field][i]=point
   end
   a.Keyboards[i]=resolvePath(model,{"Keyboard"..suffix},"keyboard "..suffix)
   check(a.Keyboards[i]:IsA("Model"),"keyboard model required")
  end
  check((a.Stations[1].Position-a.Stations[2].Position).Magnitude>=6,"stations too close")
  arenas[item.Id]=a
 end
 for _,id in ipairs({"Ring1","Ring2","Ring3","Ring4","Final"}) do check(arenas[id],"missing North arena "..id) end
 return {Id=spec.Id,WorldRoot=b.WorldRoot,WorldBindings=b,Arenas=arenas}
end
return table.freeze(W)

