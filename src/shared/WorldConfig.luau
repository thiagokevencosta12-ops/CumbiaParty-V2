--!nonstrict
-- Spatial data only. Edit ActiveProfileId before Play; no live profile switching.
-- GameConfig.Lobby aliases the active profile, so legacy callers keep one source of truth.
local ActiveProfileId="Underground"
local tropicalLobby=table.freeze({
  -- Authored coast regions. Safety follows the irregular land; arenas opt out via SetArea.
  Center=Vector3.zero, MinY=-14.5, MaxY=80,
  SafeRegions=table.freeze({
   table.freeze({id="Sector1",recoveryMarker="RecoverySoutheast",polygon=table.freeze({Vector2.new(0.000,0.000),Vector2.new(197.640,4.226),Vector2.new(205.579,20.606),Vector2.new(206.850,37.430),Vector2.new(201.895,53.515),Vector2.new(192.341,68.103),Vector2.new(180.452,81.164),Vector2.new(168.169,93.230),Vector2.new(156.152,104.745),Vector2.new(143.455,115.284),Vector2.new(128.483,123.361),Vector2.new(110.970,127.794),Vector2.new(93.102,129.774),Vector2.new(77.746,133.024)})}),
   table.freeze({id="Sector2",recoveryMarker="RecoverySouth",polygon=table.freeze({Vector2.new(0.000,0.000),Vector2.new(77.746,133.024),Vector2.new(65.512,140.550),Vector2.new(54.303,151.700),Vector2.new(41.734,163.146),Vector2.new(26.989,171.912),Vector2.new(10.579,176.699),Vector2.new(-6.521,177.300),Vector2.new(-23.384,174.315),Vector2.new(-39.459,169.105),Vector2.new(-54.884,163.520),Vector2.new(-70.398,159.107),Vector2.new(-86.808,156.172),Vector2.new(-104.183,153.512)})}),
   table.freeze({id="Sector3",recoveryMarker="RecoverySouthwest",polygon=table.freeze({Vector2.new(0.000,0.000),Vector2.new(-104.183,153.512),Vector2.new(-121.214,148.784),Vector2.new(-135.536,139.919),Vector2.new(-145.672,127.026),Vector2.new(-153.217,112.861),Vector2.new(-162.170,100.411),Vector2.new(-174.700,89.921),Vector2.new(-188.687,79.194),Vector2.new(-200.053,66.389),Vector2.new(-206.220,51.456),Vector2.new(-206.850,35.401),Vector2.new(-202.999,19.404),Vector2.new(-196.626,4.226)})}),
   table.freeze({id="Sector4",recoveryMarker="RecoveryNorthwest",polygon=table.freeze({Vector2.new(0.000,0.000),Vector2.new(-196.626,4.226),Vector2.new(-190.095,-9.939),Vector2.new(-185.367,-23.601),Vector2.new(-183.072,-37.519),Vector2.new(-182.205,-52.195),Vector2.new(-180.757,-67.472),Vector2.new(-176.788,-82.523),Vector2.new(-169.420,-96.431),Vector2.new(-159.077,-108.734),Vector2.new(-146.962,-119.707),Vector2.new(-134.206,-130.059),Vector2.new(-121.204,-140.313),Vector2.new(-107.611,-150.291)})}),
   table.freeze({id="Sector5",recoveryMarker="RecoveryNorth",polygon=table.freeze({Vector2.new(0.000,0.000),Vector2.new(-107.611,-150.291),Vector2.new(-92.846,-159.137),Vector2.new(-76.643,-165.795),Vector2.new(-59.376,-169.853),Vector2.new(-41.695,-171.814),Vector2.new(-24.083,-172.907),Vector2.new(-6.521,-174.266),Vector2.new(11.357,-176.069),Vector2.new(29.757,-177.300),Vector2.new(48.275,-176.236),Vector2.new(65.916,-171.400),Vector2.new(81.538,-162.427),Vector2.new(94.580,-150.291)})}),
   table.freeze({id="Sector6",recoveryMarker="RecoveryNortheast",polygon=table.freeze({Vector2.new(0.000,0.000),Vector2.new(94.580,-150.291),Vector2.new(105.385,-136.807),Vector2.new(115.068,-123.637),Vector2.new(124.731,-111.591),Vector2.new(134.778,-100.391),Vector2.new(144.519,-89.093),Vector2.new(152.340,-76.712),Vector2.new(156.763,-62.961),Vector2.new(158.605,-48.807),Vector2.new(162.042,-35.627),Vector2.new(171.055,-23.404),Vector2.new(184.648,-10.530),Vector2.new(197.640,4.226)})})
  }),
  RecoveryMarkerNames=table.freeze({"LobbyReturn","RecoveryNorthwest","RecoveryNorth","RecoveryNortheast","RecoverySoutheast","RecoverySouth","RecoverySouthwest","RecoveryWest"}),
  ReturnMarkerName="LobbyReturn", ReturnHeight=3,
  RecoveryIntervalSeconds=.25, RecoveryCooldownSeconds=2,
 })
local markerPaths={}
for _,name in tropicalLobby.RecoveryMarkerNames do markerPaths[name]={"Markers",name} end

-- Greybox-local coordinate system, isolated from the preserved tropical Terrain.
local origin=Vector3.new(3000,0,0)
local function rect(id,marker,x0,z0,x1,z1,minY,maxY)
 return {id=id,recoveryMarker=marker,minY=minY,maxY=maxY,polygon={Vector2.new(x0,z0),Vector2.new(x1,z0),Vector2.new(x1,z1),Vector2.new(x0,z1)}}
end
local undergroundRegions={rect("Hub","HubReturn",-32,-32,32,32,4,24)}
for _,p in ipairs({
 {"Ring1",-62,-126,22,false},{"Ring2",62,-126,22,false},
 {"Ring3",-62,-70,22,false},{"Ring4",62,-70,22,false},
 {"Final",0,-98,28,true},{"Survival",0,104,43,true},{"Chairs",110,8,43,true}
}) do
 local id,x,z,r,oct=table.unpack(p)
 local region=rect(id,id.."Return",x-r-.5,z-r-.5,x+r+.5,z+r+.5,-7.5,14)
 if oct then
  local a=r*(math.sqrt(2)-1)
  region.polygon={Vector2.new(x-a,z-r-.5),Vector2.new(x+a,z-r-.5),Vector2.new(x+r+.5,z-a),Vector2.new(x+r+.5,z+a),Vector2.new(x+a,z+r+.5),Vector2.new(x-a,z+r+.5),Vector2.new(x-r-.5,z+a),Vector2.new(x-r-.5,z-a)}
 end
 table.insert(undergroundRegions,region)
end
-- Genuine ground floor, plus the lower sports bowls above. No gallery/ramp exceptions.
table.insert(undergroundRegions,rect("GroundFloor","HubReturn",-124,-159,169,159,-1.5,18))
local undergroundMarkerNames={"HubReturn","NorthReturn","SouthReturn","EastReturn","WestReturn","GalleryReturn","Ring1Return","Ring2Return","Ring3Return","Ring4Return","FinalReturn","SurvivalReturn","ChairsReturn"}
local undergroundMarkers={}
for _,name in undergroundMarkerNames do undergroundMarkers[name]={"Bindings","Returns",name} end
local undergroundLobby={
 Center=origin,MinY=-8,MaxY=25,RequireRegionHeights=true,SafeRegions=undergroundRegions,
 RecoveryMarkerNames=undergroundMarkerNames,ReturnMarkerName="HubReturn",ReturnHeight=3,
 RecoveryIntervalSeconds=.25,RecoveryCooldownSeconds=2,
}

local profiles={
 Tropical={
  Id="Tropical",Ready=true,WorldRootPath={"CumbiaPartyLobby"},SpawnPath={"SpawnLocation"},
  MarkerPaths=markerPaths,UseTerrainSupport=true,Lobby=tropicalLobby,
  Terminals={{Id="Tournament",PromptPath={"CumbiaTiles","TournamentTerminal","OpenTournament"},Action="OpenTournament",MaxServerDistance=15}},
 },
 Underground={
  Id="Underground",Ready=true,WorldRootPath={"CumbiaBattleWorld"},
  SpawnPath={"CumbiaBattleWorld","Bindings","UndergroundSpawn"},
  UseTerrainSupport=false,RequireSupportedMarkers=true,
  RequiredPaths={{Id="FloorSupport",Path={"FloorSupport"},ClassName="Model"},
{Id="Hub",Path={"Hub"},ClassName="Model"},
{Id="NorthTournament",Path={"NorthTournament"},ClassName="Model"},
{Id="SouthSurvival",Path={"SouthSurvival"},ClassName="Model"},
{Id="EastChairs",Path={"EastChairs"},ClassName="Model"},
{Id="WestScoreAttack",Path={"WestScoreAttack"},ClassName="Model"},
{Id="Gallery",Path={"NorthTournament","ObservationGallery"},ClassName="Model"},
{Id="NorthStairs",Path={"Hub","North"},ClassName="Model"},
{Id="SouthStairs",Path={"Hub","South"},ClassName="Model"},
{Id="EastStairs",Path={"Hub","East"},ClassName="Model"},
{Id="WestStairs",Path={"Hub","West"},ClassName="Model"},
{Id="Ring1",Path={"NorthTournament","Ring1"},ClassName="Model"},
{Id="Ring2",Path={"NorthTournament","Ring2"},ClassName="Model"},
{Id="Ring3",Path={"NorthTournament","Ring3"},ClassName="Model"},
{Id="Ring4",Path={"NorthTournament","Ring4"},ClassName="Model"},
{Id="Final",Path={"NorthTournament","Final"},ClassName="Model"},
{Id="FinalCage",Path={"NorthTournament","Final","OctagonCage"},ClassName="Model"},
{Id="SurvivalArena",Path={"SouthSurvival","Survival"},ClassName="Model"},
{Id="ChairsArena",Path={"EastChairs","Chairs"},ClassName="Model"}},
  ArenaComplex={Id="NorthX1",MaxPhysicalTournaments=1,Arenas={{Id="Ring1",Path={"NorthTournament","Ring1"}},{Id="Ring2",Path={"NorthTournament","Ring2"}},{Id="Ring3",Path={"NorthTournament","Ring3"}},{Id="Ring4",Path={"NorthTournament","Ring4"}},{Id="Final",Path={"NorthTournament","Final"}}}},
  MarkerPaths=undergroundMarkers,Lobby=undergroundLobby,
  Terminals={{Id="Tournament",PromptPath={"Interactions","NorthTournament","Terminal","OpenTournament"},Action="OpenTournament",MaxServerDistance=15}},
 },

}
local function freezeDeep(value)
 if typeof(value)~="table" then return value end
 for _,child in pairs(value) do freezeDeep(child) end
 if not table.isfrozen(value) then table.freeze(value) end
 return value
end
freezeDeep(profiles)
local W={ActiveProfileId=ActiveProfileId,Profiles=profiles}
function W.GetProfile(id)
 local profile=profiles[id]
 assert(profile,"WorldConfig: unknown profile "..tostring(id))
 return profile
end
function W.GetActiveProfile()
 local profile=W.GetProfile(ActiveProfileId)
 assert(profile.Ready==true,"WorldConfig: profile "..profile.Id.." is not ready. "..tostring(profile.PendingReason or "Complete its spatial configuration."))
 return profile
end
return table.freeze(W)



