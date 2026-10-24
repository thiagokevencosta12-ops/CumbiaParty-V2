--!nonstrict
-- Presentation only. Reuses the existing board, note Frames, HP bars and hit buttons.
-- No note/hold/input state is owned here; solo and invitation layouts are restored.
local Players=game:GetService("Players")
local BattleHUD={}
local cyan=Color3.fromRGB(70,224,236)
local coral=Color3.fromRGB(255,127,111)
local pale=Color3.fromRGB(235,242,249)
local muted=Color3.fromRGB(137,149,165)
local dark=Color3.fromRGB(13,19,29)
local keys={"D","F","J","K"}
local grades={PerfectHold="Perfect Hold",GoodHold="Good Hold",BrokenHold="Hold interrompido"}

function BattleHUD.Supports(snapshot)
 return snapshot and snapshot.mode=="Combat" and snapshot.combat and snapshot.combat.tournamentId~=nil
  and (snapshot.phase=="Playing" or snapshot.phase=="Waiting")
end
function BattleHUD.ResolveTurn(snapshot,userId)
 local combat=snapshot and snapshot.combat
 if not combat or combat.stage=="Intermission" or combat.activeUserId==nil then return "Intermission" end
 return if snapshot.phase=="Playing" and combat.activeUserId==userId then "Local" else "Opponent"
end

function BattleHUD.new(gui)
 local root=gui.Main;local board=root.Board;local bars=root.CombatHUD
 local active=false;local saved={};local destroyed=false
 local function keep(object,properties)
  local values=saved[object] or {};saved[object]=values
  for _,key in ipairs(properties) do if values[key]==nil then values[key]=object[key] end end
 end
 local geometry={"AnchorPoint","Position","Size"}
 local function preserve(object,properties)
  keep(object,geometry);if properties then keep(object,properties) end
 end
 preserve(root,{"BackgroundTransparency","BackgroundColor3"})
 local sizeLimit=root:FindFirstChild("SizeLimit") or root:FindFirstChildOfClass("UISizeConstraint")
 if sizeLimit and not sizeLimit:IsA("UISizeConstraint") then sizeLimit=nil end
 if sizeLimit then keep(sizeLimit,{"MinSize","MaxSize"}) end
 preserve(board,{"BackgroundTransparency","BackgroundColor3"})
 preserve(bars,{"BackgroundTransparency"})
 for _,name in ipairs({"Title","Timing","Score","Combo","Counts","Feedback","CancelButton"}) do
  local item=root[name]
  preserve(item,{"TextColor3","BackgroundTransparency","TextXAlignment","TextScaled","TextWrapped","ZIndex"})
  if name~="CancelButton" then keep(item,{"Visible"}) else keep(item,{"BackgroundColor3"}) end
  keep(item,{"TextStrokeColor3","TextStrokeTransparency"})
 end
 for i=1,2 do
  local bar=bars["HP"..i]
  preserve(bar,{"BackgroundColor3","BackgroundTransparency"})
  keep(bar.Fill,{"BackgroundColor3","BackgroundTransparency"})
  keep(bar.Label,{"TextColor3","TextScaled","TextWrapped","ZIndex"})
 end
 for i=1,4 do
  local lane=board["Lane"..i]
  keep(lane,{"BackgroundColor3","BackgroundTransparency"})
  keep(lane.Accent,{"BackgroundColor3","BackgroundTransparency"})
  keep(lane.Key,{"Text","TextColor3","TextTransparency"})
 end
 keep(board.HitLine,{"BackgroundColor3","BackgroundTransparency"})

 local overlay=Instance.new("Frame")
 overlay.Name="BattleHUD";overlay.BackgroundTransparency=1;overlay.Size=UDim2.fromScale(1,1)
 overlay.Visible=false;overlay.Active=false;overlay.Parent=root
 local function label(name,text,color)
  local v=Instance.new("TextLabel");v.Name=name;v.BackgroundTransparency=1
  v.Text=text;v.TextColor3=color;v.Font=Enum.Font.GothamBold
  v.TextScaled=true;v.TextWrapped=true;v.ZIndex=10;v.Parent=overlay
  local limit=Instance.new("UITextSizeConstraint");limit.MinTextSize=9;limit.MaxTextSize=22;limit.Parent=v
  return v
 end
 local brand=label("Identity","CUMBIA\nBATTLE",pale)
 brand.Font=Enum.Font.GothamBlack
 local turn=label("TurnBanner","",pale)
 turn.BackgroundTransparency=.08;turn.BackgroundColor3=dark
 local corner=Instance.new("UICorner");corner.CornerRadius=UDim.new(0,7);corner.Parent=turn
 local stripe=Instance.new("Frame");stripe.Name="Accent";stripe.BorderSizePixel=0
 stripe.Size=UDim2.new(0,4,1,-10);stripe.Position=UDim2.fromOffset(4,5);stripe.ZIndex=11;stripe.Parent=turn
 local meta=label("Round","",muted)
 meta.BackgroundColor3=dark;meta.BackgroundTransparency=.2
 local waitFeedback=label("OpponentPerformance","",muted)
 waitFeedback.TextColor3=pale;waitFeedback.TextStrokeColor3=dark;waitFeedback.TextStrokeTransparency=.25
 waitFeedback.TextScaled=true
 local H={}
 function H.IsActive() return active end
 function H.Layout()
  if not active or destroyed then return end
  local w,h=root.AbsoluteSize.X,root.AbsoluteSize.Y
  if w<=0 or h<=0 then return end
  local portrait=w<h*.9
  local short=h<470
  local margin=if w<600 then 10 else 24
  local brandWidth=math.clamp(w*.14,62,138)
  local gap=12
  local barWidth=math.max(70,(w-margin*2-brandWidth-gap*2)/2)
  bars.AnchorPoint=Vector2.zero;bars.Position=UDim2.fromOffset(margin,12)
  bars.Size=UDim2.new(1,-margin*2,0,if short then 37 else 44)
  bars.BackgroundTransparency=1
  for i=1,2 do
   local bar=bars["HP"..i]
   bar.AnchorPoint=Vector2.zero
   bar.Position=if i==1 then UDim2.fromOffset(0,0) else UDim2.new(1,-barWidth,0,0)
   bar.Size=UDim2.fromOffset(barWidth,if short then 37 else 44)
  end
  brand.AnchorPoint=Vector2.new(.5,0);brand.Position=UDim2.new(.5,0,0,9)
  brand.Size=UDim2.fromOffset(brandWidth,if short then 42 else 50)
  local boardWidth=if portrait then math.clamp(w*.5,200,280) else math.clamp(w*.28,200,360)
  local top=if short then 77 else 105
  local boardHeight=math.clamp(h-top-(if portrait then 135 else 92),100,540)
  board.AnchorPoint=Vector2.new(.5,0);board.Position=UDim2.new(.5,0,0,top)
  board.Size=UDim2.fromOffset(boardWidth,boardHeight)
  turn.AnchorPoint=Vector2.new(.5,0);turn.Position=UDim2.new(.5,0,0,top+boardHeight+5)
  turn.Size=UDim2.fromOffset(boardWidth,30)
  meta.AnchorPoint=Vector2.new(.5,0);meta.Position=UDim2.new(.5,0,0,top-24)
  meta.Size=UDim2.fromOffset(boardWidth,20)
  root.Feedback.AnchorPoint=Vector2.new(.5,0);root.Feedback.Position=UDim2.new(.5,0,0,top+boardHeight+38)
  root.Feedback.Size=UDim2.fromOffset(boardWidth,21)
  waitFeedback.AnchorPoint=Vector2.new(.5,0);waitFeedback.Position=root.Feedback.Position
  waitFeedback.Size=root.Feedback.Size
  local statWidth=if portrait then (w-margin*2)/2 else math.min(220,(w-boardWidth)/2-margin*2)
  root.Score.AnchorPoint=Vector2.zero;root.Combo.AnchorPoint=Vector2.zero
  if portrait then
   root.Score.Position=UDim2.fromOffset(margin,65);root.Combo.Position=UDim2.new(.5,0,0,65)
   root.Score.Size=UDim2.fromOffset(statWidth,17);root.Combo.Size=UDim2.fromOffset(statWidth,17)
  else
   root.Score.Position=UDim2.new(0,margin,1,-83);root.Combo.Position=UDim2.new(0,margin,1,-57)
   root.Score.Size=UDim2.fromOffset(statWidth,23);root.Combo.Size=UDim2.fromOffset(statWidth,21)
  end
  root.CancelButton.AnchorPoint=Vector2.new(1,1)
  root.CancelButton.Position=UDim2.new(1,-margin,1,-8)
  root.CancelButton.Size=UDim2.fromOffset(if portrait then 154 else 176,44)
 end
 local function restore()
  active=false;overlay.Visible=false
  for object,properties in pairs(saved) do
   if object.Parent then for key,value in pairs(properties) do object[key]=value end end
  end
 end
 function H.Render(snapshot)
  if destroyed then return false end
  if not BattleHUD.Supports(snapshot) then
   if active then restore();return true end
   return false
  end
  active=true;overlay.Visible=true
  root.AnchorPoint=Vector2.zero;root.Position=UDim2.fromScale(0,0);root.Size=UDim2.fromScale(1,1)
  root.BackgroundTransparency=1
  if sizeLimit then sizeLimit.MinSize=Vector2.zero;sizeLimit.MaxSize=Vector2.new(100000,100000) end
  root.Title.Visible=false;root.Timing.Visible=false;root.Counts.Visible=false
  root.Score.Visible=true;root.Combo.Visible=true
  root.Score.TextXAlignment=Enum.TextXAlignment.Left;root.Combo.TextXAlignment=Enum.TextXAlignment.Left
  root.Score.TextColor3=pale;root.Combo.TextColor3=muted
  root.Combo.TextColor3=pale
  for _,item in {root.Score,root.Combo,root.Feedback} do item.TextStrokeColor3=dark;item.TextStrokeTransparency=.25 end
  root.Feedback.ZIndex=12;root.Feedback.BackgroundTransparency=1
  root.CancelButton.BackgroundTransparency=.12;root.CancelButton.BackgroundColor3=dark;root.CancelButton.TextColor3=pale
  local state=BattleHUD.ResolveTurn(snapshot,Players.LocalPlayer.UserId)
  overlay:SetAttribute("TurnState",state)
  local ownTurn=state=="Local"
  turn.Text=if ownTurn then "SUA VEZ" elseif state=="Opponent" then "VEZ DO OPONENTE" else "PRÓXIMO TURNO"
  turn.TextColor3=if ownTurn then cyan elseif state=="Opponent" then pale else Color3.fromRGB(255,211,126)
  stripe.BackgroundColor3=turn.TextColor3
  turn.BackgroundColor3=if ownTurn then Color3.fromRGB(12,49,57) else dark
  meta.Text="X1  /  ONDA "..tostring(snapshot.combat.wave or 1)
  board.Visible=true;root.Results.Visible=false
  board.BackgroundColor3=dark;board.BackgroundTransparency=if ownTurn then .34 else .63
  for i=1,4 do
   local lane=board["Lane"..i]
   local base=saved[lane.Accent].BackgroundColor3
   lane.BackgroundColor3=if ownTurn then saved[lane].BackgroundColor3 else Color3.fromRGB(35,42,53)
   lane.BackgroundTransparency=if ownTurn then .48 else .73
   -- UIController uses Accent as the source color when creating the next chart.
   -- Keep that palette immutable; transparency and lane/key colors convey Waiting.
   lane.Accent.BackgroundColor3=base
   lane.Accent.BackgroundTransparency=if ownTurn then 0 else .88
   lane.Key.Text=keys[i];lane.Key.TextColor3=if ownTurn then base else muted
   lane.Key.TextTransparency=if ownTurn then 0 else .18
  end
  if not ownTurn then board.HitLine.BackgroundTransparency=.7;board.HitLine.BackgroundColor3=muted
  else board.HitLine.BackgroundColor3=saved[board.HitLine].BackgroundColor3 end
  root.Feedback.Visible=ownTurn;waitFeedback.Visible=not ownTurn
  local performance=snapshot.combat.performance
  waitFeedback.Text=if state=="Opponent" and performance then (grades[performance.grade] or tostring(performance.grade)).."  •  COMBO "..tostring(performance.combo or 0)
   elseif state=="Opponent" then "Acompanhe o adversário" else "Prepare-se para a próxima sequência"
  for i=1,2 do
   local bar=bars["HP"..i]
   bar.BackgroundColor3=dark;bar.BackgroundTransparency=.16
   bar.Fill.BackgroundColor3=if i==1 then cyan else coral;bar.Fill.BackgroundTransparency=.45
   bar.Label.TextColor3=pale;bar.Label.TextScaled=true;bar.Label.TextWrapped=true;bar.Label.ZIndex=9
  end
  H.Layout();return false
 end
 function H.Destroy()
  if destroyed then return end
  if active then restore() end
  destroyed=true;overlay:Destroy()
 end
 return H
end
return BattleHUD

