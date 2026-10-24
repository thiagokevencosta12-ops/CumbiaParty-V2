--!nonstrict
-- Owns tournament navigation only; rhythm rendering/inputs remain in existing controllers.
local RunService=game:GetService("RunService")
local Portrait=require(script.Parent.CompetitorPortrait)
local Controller={}
local function create(gui,request)
 local opened,locked=false,false
 local menuOpen=false
 local destroyed=false
 local snapshot={queue={count=0,total=8}}
 local links={}
 local screen=Instance.new("Frame");screen.Name="TournamentPanel";screen.AnchorPoint=Vector2.new(.5,.5)
 screen.Position=UDim2.fromScale(.5,.5);screen.Size=UDim2.fromScale(.96,.94)
 screen.BackgroundColor3=Color3.fromRGB(16,21,34);screen.BorderSizePixel=0;screen.Visible=false;screen.Parent=gui
 local function label(parent,name,text,height)
  local v=Instance.new("TextLabel");v.Name=name;v.Size=UDim2.new(1,0,0,height)
  v.BackgroundTransparency=1;v.Text=text;v.Font=Enum.Font.GothamMedium;v.TextSize=16
  v.TextColor3=Color3.fromRGB(234,240,255);v.TextWrapped=true;v.Parent=parent;return v
 end
 local function button(parent,name,text,callback)
  local b=Instance.new("TextButton");b.Name=name;b.Text=text;b.TextSize=14;b.Font=Enum.Font.GothamBold
  b.TextScaled=true;b.TextWrapped=true
  local limit=Instance.new("UITextSizeConstraint");limit.MinTextSize=10;limit.MaxTextSize=14;limit.Parent=b
  b.TextColor3=Color3.fromRGB(240,248,255);b.BackgroundColor3=Color3.fromRGB(50,71,108);b.BorderSizePixel=0;b.Parent=parent
  table.insert(links,b.Activated:Connect(callback));return b
 end
 local title=label(screen,"Title","CUMBIA TILES • TOURNAMENT",30)
 title.Position=UDim2.new(.02,0,0,4);title.Size=UDim2.new(.96,0,0,30)
 local status=label(screen,"Status","",48);status.Position=UDim2.new(.03,0,0,35);status.Size=UDim2.new(.94,0,0,48)
 local actions=Instance.new("Frame");actions.Name="Actions";actions.BackgroundTransparency=1;actions.Position=UDim2.new(.03,0,0,87);actions.Size=UDim2.new(.94,0,0,44);actions.Parent=screen
 local join=button(actions,"Join","JOIN TOURNAMENT",function() request("Join") end)
 local leave=button(actions,"Leave","LEAVE QUEUE",function() request("LeaveQueue") end)
 local exit=button(actions,"Exit","VOLTAR",function()
  if snapshot.tournament then request("ExitView") else opened=false end
 end)
 for i,b in ipairs({join,leave,exit}) do b.Position=UDim2.fromScale((i-1)/3,0);b.Size=UDim2.new(1/3,-5,1,0) end
 local scroll=Instance.new("ScrollingFrame");scroll.Name="Content";scroll.Position=UDim2.new(.03,0,0,140)
 scroll.Size=UDim2.new(.94,0,1,-148);scroll.BackgroundTransparency=1;scroll.BorderSizePixel=0
 scroll.ScrollBarThickness=5;scroll.CanvasSize=UDim2.new();scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y;scroll.Parent=screen
 local layout=Instance.new("UIListLayout");layout.Padding=UDim.new(0,7);layout.SortOrder=Enum.SortOrder.LayoutOrder;layout.Parent=scroll
 local open=button(gui,"OpenTournament","TORNEIO",function() opened=true end)
 open.AnchorPoint=Vector2.new(1,0);open.Position=UDim2.new(1,-8,0,5);open.Size=UDim2.fromOffset(110,36);open.ZIndex=20
 local lastCountdown=nil
 local T={}
 local function visibility()
  screen.Visible=opened and not locked
  gui.Main.Visible=not screen.Visible and (locked or menuOpen)
  open.Visible=false
 end
 local function renderContent()
  for _,v in ipairs(scroll:GetChildren()) do if v~=layout then v:Destroy() end end
  local t=snapshot.tournament
  local order=0
  local function text(name,value,height)
   local l=label(scroll,name,value,height);order+=1;l.LayoutOrder=order;return l
  end
  if not t then
   text("Explanation","8 competidores • Quartas, semifinais e final\nVagas livres são preenchidas por competidores do jogo.",66)
   text("Rules","A inscrição reserva sua vaga. Saia da fila para jogar solo ou aceitar um X1.\nD / F / J / K ou toque nas colunas • Hold: mantenha pressionado.",90)
   text("TieRules","Desempate: HP, precisão acumulada e, em igualdade absoluta, sorteio.",56)
   return
  end
  local byId={}
  for _,p in ipairs(t.participants) do byId[p.id]=p end
  local function name(id) return byId[id] and byId[id].name or "A definir" end
  if t.champion then text("Champion","CAMPEÃO • "..name(t.champion),40) end
  if t.eliminated then text("Spectator","Você foi eliminado. Pode acompanhar ou voltar ao lobby agora.",54) end
  for i,p in ipairs(t.participants) do
   local row=Instance.new("Frame");row.Name="Competitor"..i;row.Size=UDim2.new(1,-8,0,48)
   row.BackgroundColor3=Color3.fromRGB(25,32,49);row.BorderSizePixel=0;order+=1;row.LayoutOrder=order;row.Parent=scroll
   local portrait=Instance.new("Frame");portrait.Name="Avatar";portrait.Size=UDim2.fromOffset(44,44);portrait.Position=UDim2.fromOffset(2,2);portrait.Parent=row
   Portrait.Draw(portrait,p.appearance)
   local titleLabel=label(row,"Name",p.name..(if p.eliminated then " • Eliminado" else ""),44)
   titleLabel.Position=UDim2.fromOffset(54,2);titleLabel.Size=UDim2.new(1,-60,0,44);titleLabel.TextXAlignment=Enum.TextXAlignment.Left
  end
  local rounds={"QUARTAS DE FINAL","SEMIFINAIS","FINAL"}
  for round=1,3 do
   text("Round"..round,rounds[round],28)
   local count=0
   for _,m in ipairs(t.matches) do
    if m.round~=round then continue end
    count+=1
    local line=name(m.a).."  ×  "..name(m.b)
    line..=if m.winner then "\nAvança: "..name(m.winner) elseif m.status=="Active" then "\nEm disputa" else "\nAguardando"
    text("Match"..round.."_"..count,line,60)
   end
   if count==0 then text("Pending"..round,"Aguardando classificados",34) end
  end
 end
 function T.Render(data)
  local previous=snapshot.tournament
  snapshot=data
  if data.tournament and (not previous or previous.status~=data.tournament.status) then opened=true
  elseif previous then opened=false end
  local t=data.tournament
  join.Visible=not t and not data.queue.joined
  leave.Visible=data.queue.joined
  exit.Visible=not data.queue.joined and (not t or t.canExit)
  exit.Text=if t then "VOLTAR AO LOBBY" else "VOLTAR"
  renderContent();lastCountdown=nil;visibility()
 end
 function T.Open() if not locked then opened=true;menuOpen=false;visibility() end end
 function T.Minimize() opened=false;menuOpen=false;visibility() end
 function T.SetMenuVisible(value) if not locked then menuOpen=value;opened=false;visibility() end end
 function T.IsLocked() return locked end
 function T.IsOpen() return opened end
 function T.IsMenuVisible() return menuOpen end
 function T.SetBattleActive(active) locked=active;if active then menuOpen=false end;visibility() end
 local minimize=button(screen,"Explore","EXPLORAR",function() T.Minimize() end)
 minimize.Size=UDim2.fromOffset(85,28);minimize.Position=UDim2.new(1,-90,0,3)
 title.Size=UDim2.new(1,-100,0,30)
 table.insert(links,RunService.Heartbeat:Connect(function()
  visibility()
  if not screen.Visible then return end
  local t=snapshot.tournament
  if t then
   local rounds={"Quartas de final","Semifinais","Final"}
   local opponent
   for _,m in ipairs(t.matches) do
    if m.round==t.round and m.status=="Active" and (m.a==t.myId or m.b==t.myId) then
     local other=if m.a==t.myId then m.b else m.a
     for _,p in ipairs(t.participants) do if p.id==other then opponent=p.name end end
    end
   end
   status.Text=if t.status=="Finished" then "TORNEIO CONCLUÍDO • 8 competidores"
    elseif t.status=="Cancelled" then "TORNEIO ENCERRADO"
    else (rounds[t.round] or "Preparando").." • 8 competidores"..(if opponent then "\nAdversário: "..opponent elseif t.eliminated then "\nAcompanhando o torneio" else "\nAguardando o próximo confronto")
  else
   local q=snapshot.queue
   local seconds=if q.deadline then math.max(0,math.ceil(q.deadline-workspace:GetServerTimeNow())) else nil
   status.Text=string.format("%d / %d jogadores na fila",q.count,q.total)..(if seconds then " • "..seconds.." s" else "\nInscreva-se para iniciar a contagem")
   if seconds==0 and not q.capacityAvailable then status.Text..="\nAguardando vaga para iniciar." end
   if snapshot.error then
    status.Text..="\n"..(({Busy="Termine sua atividade atual.",AlreadyJoined="Você já está inscrito.",Unavailable="Aguarde seu personagem.",QueueFull="A fila está cheia.",StillCompeting="Você ainda está competindo."})[snapshot.error] or "Solicitação indisponível.")
   end
  end
 end))
 function T.Destroy()
  if destroyed then return end
  destroyed=true
  for _,c in ipairs(links) do c:Disconnect() end
  screen:Destroy();open:Destroy()
 end
 table.insert(links,gui.Destroying:Connect(T.Destroy))
 return T
end
Controller.new=create
return Controller
