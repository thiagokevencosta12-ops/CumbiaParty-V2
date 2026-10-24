--!nonstrict
-- Compact navigation and queue status. Never submits competition results.
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local Root=game.ReplicatedStorage.CumbiaParty
local L={}
function L.new(gui,tournament)
 local links={}
 local data={queue={count=0,total=8}}
 local returned={}
 local back=Instance.new("TextButton");back.Name="ClosePractice";back.Text="VOLTAR À PRAÇA";back.Size=UDim2.fromOffset(145,34);back.Position=UDim2.new(1,-150,0,4);back.BackgroundColor3=Color3.fromRGB(29,58,67);back.TextColor3=Color3.new(1,1,1);back.Font=Enum.Font.GothamBold;back.TextSize=13;back.Visible=false;back.ZIndex=20;back.Parent=gui
 table.insert(links,back.Activated:Connect(function() tournament.Minimize() end))
 local hud=Instance.new("Frame");hud.Name="LobbyHUD";hud.AnchorPoint=Vector2.new(.5,1)
 hud.Position=UDim2.new(.5,0,1,-10);hud.Size=UDim2.new(.9,0,0,83);hud.BackgroundColor3=Color3.fromRGB(22,29,43);hud.BackgroundTransparency=.12;hud.Parent=gui
 local limit=Instance.new("UISizeConstraint");limit.MaxSize=Vector2.new(550,83);limit.Parent=hud
 local corner=Instance.new("UICorner");corner.CornerRadius=UDim.new(0,12);corner.Parent=hud
 local status=Instance.new("TextLabel");status.Name="QueueStatus";status.BackgroundTransparency=1;status.Size=UDim2.new(1,-12,0,30);status.Position=UDim2.fromOffset(6,0);status.Font=Enum.Font.GothamMedium;status.TextSize=14;status.TextColor3=Color3.fromRGB(255,219,143);status.TextWrapped=true;status.Parent=hud
 local function button(name,text,x,fn)
  local b=Instance.new("TextButton");b.Name=name;b.Text=text;b.Font=Enum.Font.GothamBold;b.TextSize=14;b.TextColor3=Color3.new(1,1,1);b.BackgroundColor3=Color3.fromRGB(42,72,83);b.Position=UDim2.new(x,4,0,34);b.Size=UDim2.new(1/3,-8,0,44);b.Parent=hud
  b.TextScaled=true;local c=Instance.new("UITextSizeConstraint");c.MinTextSize=10;c.MaxTextSize=14;c.Parent=b
  table.insert(links,b.Activated:Connect(fn));return b
 end
 button("Tournament","TORNEIO",0,function() tournament.Open() end)
 button("Practice","SOLO / X1",1/3,function() tournament.SetMenuVisible(true) end)
 button("Lobby","EXPLORAR",2/3,function() tournament.Minimize() end)
 table.insert(links,Root.Remotes.TournamentState.OnClientEvent:Connect(function(value)
  data=value
  local t=value.tournament
  if t and (t.eliminated or t.status=="Finished" or t.status=="Cancelled") and not returned[t.id] then
   returned[t.id]=true;Root.Remotes.LobbyRequest:FireServer({action="Return",preserveView=true})
  end
 end))
 table.insert(links,Root.Remotes.LobbyState.OnClientEvent:Connect(function(msg)
  if msg.action=="OpenTournament" then tournament.Open()
  elseif msg.action=="Returned" then
   if not msg.preserveView then tournament.Minimize() end
   local p=game.Players.LocalPlayer;local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
   workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
   if h then workspace.CurrentCamera.CameraSubject=h end
  end
 end))
 table.insert(links,RunService.Heartbeat:Connect(function()
  back.Visible=not tournament.IsLocked() and not tournament.IsOpen() and tournament.IsMenuVisible()
  hud.Visible=not tournament.IsLocked() and not tournament.IsOpen() and not tournament.IsMenuVisible()
  if not hud.Visible then return end
  local narrow=workspace.CurrentCamera.ViewportSize.X<600
  hud.Position=UDim2.new(.5,0,1,if UIS.TouchEnabled and narrow then -125 else -10)
  hud.Size=UDim2.new(if UIS.TouchEnabled and not narrow then .52 else .9,0,0,83)
  local q=data.queue
  status.Text=if q.joined then "NA FILA • "..q.count.."/8 • "..math.max(0,math.ceil((q.deadline or workspace:GetServerTimeNow())-workspace:GetServerTimeNow())).." s"
   elseif data.tournament then (if data.tournament.eliminated then "FESTIVAL • Você pode acompanhar o torneio" elseif data.tournament.status=="Finished" then "FESTIVAL • Torneio concluído" else "CUMBIA PARTY • Torneio em andamento")
   else "CUMBIA PARTY • Explore o festival"
 end))
 local controller={}
 local destroyed=false
 function controller.Destroy()
  if destroyed then return end;destroyed=true
  for _,c in ipairs(links) do c:Disconnect() end;table.clear(links);hud:Destroy();back:Destroy()
 end
 table.insert(links,gui.Destroying:Connect(controller.Destroy))
 return controller
end
return L
