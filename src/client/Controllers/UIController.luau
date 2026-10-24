--!nonstrict
-- All notes are GUI Frames. Their position is derived from synchronized time.
-- Local feedback is provisional; displayed score/counters always come from server.
local TweenService=game:GetService("TweenService")
local Config=require(game.ReplicatedStorage.CumbiaParty.Shared.GameConfig)
local Portrait=require(script.Parent.CompetitorPortrait)
local BattleHUD=require(script.Parent.BattleHUD)
local UI={}
local gui,root,board,feedback
local session,chart,lastSnapshot
local noteViews,consumed,buttons={},{},{}
local holding={}
local connections={}
local revision=-1
local feedbackTween
local duelHUD,layout
local colors={Perfect=Color3.fromRGB(102,255,207),Great=Color3.fromRGB(110,197,255),
 PerfectHold=Color3.fromRGB(102,255,207),GoodHold=Color3.fromRGB(255,214,117),BrokenHold=Color3.fromRGB(255,116,143),
 Good=Color3.fromRGB(255,214,117),Miss=Color3.fromRGB(255,116,143)}
local function clearNotes()
 for _,view in pairs(noteViews) do view:Destroy() end
 table.clear(noteViews); table.clear(consumed);table.clear(holding)
end
local function stats(s)
 if not s then return end
 root.Score.Text=string.format("%06d  PONTOS",s.score)
 root.Combo.Text=string.format("%d COMBO  •  MÁX %d",s.combo,s.maxCombo)
 root.Counts.Text=string.format("Perfect %d   Great %d   Good %d   Miss %d",s.Perfect,s.Great,s.Good,s.Miss)
end
function UI.Feedback(text,grade)
 if feedbackTween then feedbackTween:Cancel() end
 feedback.Text=text
 feedback.TextColor3=colors[grade] or Color3.fromRGB(230,234,255)
 feedback.TextTransparency=0
 feedbackTween=TweenService:Create(feedback,TweenInfo.new(.65,Enum.EasingStyle.Quad,Enum.EasingDirection.In,0,false,.18),{TextTransparency=1})
 feedbackTween:Play()
end
local displayGrade={PerfectHold="Perfect Hold",GoodHold="Good Hold",BrokenHold="Broken Hold"}
function UI.SetSummary(snapshot)
 local compact=root.AbsoluteSize.Y<460
 if snapshot.mode=="Combat" then
  local c=snapshot.combat
  if snapshot.phase=="Finished" then
   root.Results.Title.Text=if c.draw then "EMPATE" elseif c.winnerUserId==game.Players.LocalPlayer.UserId then "VITÓRIA" else "DERROTA"
   root.Results.Summary.Text="Encerramento: "..tostring(c.reason).."\nOnda "..c.wave.."\n\nConvide para uma nova partida\nou pratique no modo solo."
  elseif snapshot.phase=="Waiting" then
   root.Results.Title.Text=if c.stage=="Intermission" then "PRÓXIMO TURNO" else "TURNO DO ADVERSÁRIO"
   root.Results.Summary.Text="Onda "..c.wave.."\nPrepare-se para a sua sequência."
   if c.performance then root.Results.Summary.Text..="\n\n"..c.performance.name.." • "..c.performance.grade.."\nCombo "..c.performance.combo end
  end
 elseif snapshot.mode=="Invite" then
  root.Results.Title.Text=if snapshot.phase=="Invited" then "CONVITE X1" else "CONVITE ENVIADO"
  root.Results.Summary.Text=if snapshot.phase=="Invited" then snapshot.invite.senderName.." quer jogar.\nAceite para começar." else "Aguardando o adversário...\nO convite expira em 20 segundos."
 elseif snapshot.phase=="Finished" and snapshot.stats then
  local a=snapshot.stats
  root.Results.Title.Text="SEQUÊNCIA CONCLUÍDA"
  root.Results.Summary.Text=string.format("Perfect %d • Great %d\nGood %d • Miss %d\nPontos %d • Maior combo %d\nHolds: %d / %d / %d",a.Perfect,a.Great,a.Good,a.Miss,a.score,a.maxCombo,a.PerfectHold or 0,a.GoodHold or 0,a.BrokenHold or 0)
 else
  root.Results.Title.Text=if snapshot.phase=="Idle" then "CUMBIA TILES" else "TESTE CANCELADO"
  root.Results.Summary.Text=if compact then "Solo: 48 notas • 24 s\nX1: convide outro jogador\nD/F/J/K ou toque • Sem áudio" else "SOLO: 48 notas • 24 segundos\nX1: escolha um jogador e convide\n\nD / F / J / K ou toque nas colunas\nHOLD: mantenha pressionado\nSem áudio • siga o pulso"
 end
end
function UI.Init(screen,onStart,onCancel,onDuel,onTarget)
 gui=screen; root=gui.Main; board=root.Board; feedback=root.Feedback
 duelHUD=BattleHUD.new(gui)
 gui.StatusLabel.Visible=false
 for i=1,4 do buttons[i]=board["Lane"..i].HitButton end
 table.insert(connections,root.StartButton.Activated:Connect(onStart))
 table.insert(connections,root.CancelButton.Activated:Connect(onCancel))
 if onDuel then table.insert(connections,root.DuelButton.Activated:Connect(onDuel)) end
 if onTarget then table.insert(connections,root.TargetButton.Activated:Connect(onTarget)) end
 layout=function()
  if duelHUD and duelHUD.IsActive() then duelHUD.Layout();return end
  local h=root.AbsoluteSize.Y
  local compact=h<460
  root.Footer.Visible=false
  local function place(name,x,y,w,height)
   root[name].Position=UDim2.new(x,0,0,y);root[name].Size=UDim2.new(w,0,0,height)
  end
  place("Title",.03,4,.94,24)
  if compact then
   local area=math.max(125,h-130)
   place("Timing",.02,32,.35,area*.13)
   place("CombatHUD",.02,32+area*.15,.35,area*.25)
   place("Score",.02,32+area*.42,.35,area*.12)
   place("Combo",.02,32+area*.55,.35,area*.12)
   place("Counts",.02,32+area*.68,.35,area*.16)
   place("Feedback",.02,32+area*.85,.35,area*.13)
   place("Board",.4,32,.58,math.max(80,h-98))
   place("Results",.405,32,.57,math.max(80,h-98))
   place("TargetButton",.02,h-90,.35,30)
   root.Counts.TextWrapped=true
  else
   place("Timing",.04,32,.92,22)
   place("CombatHUD",.04,60,.92,38)
   place("Score",.04,104,.43,26);place("Combo",.5,104,.46,26)
   place("Counts",.025,135,.95,20);place("Feedback",.04,158,.92,26)
   place("Board",.045,191,.91,math.max(140,h-297))
   place("Results",.055,191,.89,math.max(140,h-297))
   place("TargetButton",.04,h-90,.92,30)
   root.Counts.TextWrapped=false
  end
  place("StartButton",.04,h-54,.44,44)
  place("DuelButton",.52,h-54,.44,44)
  place("CancelButton",.12,h-54,.76,44)
  for i=1,2 do
   local bar=root.CombatHUD["HP"..i]
   bar.Position=if compact then UDim2.fromScale(0,(i-1)*.52) else UDim2.fromScale((i-1)*.52,0)
   bar.Size=if compact then UDim2.fromScale(1,.48) else UDim2.fromScale(.48,1)
  end
  -- TextWrapped=false disables TextScaled on Roblox; explicitly restore scaling.
  for _,name in ipairs({"Title","Score","Combo","Counts","Timing","Feedback"}) do
   root[name].TextWrapped=true
   root[name].TextScaled=true
  end
  if lastSnapshot then UI.SetSummary(lastSnapshot) end
 end
 table.insert(connections,root:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout))
 layout()
 return buttons
end
function UI.Render(snapshot)
 lastSnapshot=snapshot
 local playing=snapshot.phase=="Playing" and snapshot.minigameId==Config.MinigameId
 local locked=playing or snapshot.phase=="Waiting"
 local invitation=snapshot.mode=="Invite"
 local newSession=playing and (not session or session.sessionId~=snapshot.sessionId)
 if newSession then
  clearNotes()
  session=snapshot;chart=snapshot.chart or Config.Charts[snapshot.chartId];revision=-1
  assert(chart,"Unknown chart")
  for _,note in ipairs(chart.notes) do
   local view=Instance.new("Frame")
   view.Name=note.id;view.Size=UDim2.new(.84,0,0,Config.NoteHeight)
   view.AnchorPoint=Vector2.new(.5,.5);view.BorderSizePixel=0
   view.BackgroundColor3=board["Lane"..note.lane].Accent.BackgroundColor3
   view.ZIndex=4;view.Visible=false
   local corner=Instance.new("UICorner");corner.CornerRadius=UDim.new(0,5);corner.Parent=view
   if (note.duration or 0)>0 then
    local tail=Instance.new("Frame");tail.Name="Tail";tail.AnchorPoint=Vector2.new(.5,1)
    tail.Position=UDim2.fromScale(.5,.5);tail.BorderSizePixel=0;tail.BackgroundColor3=view.BackgroundColor3
    tail.BackgroundTransparency=.3;tail.ZIndex=3;tail.Parent=view
    local label=Instance.new("TextLabel");label.Name="HoldLabel";label.Size=UDim2.fromScale(1,1)
    label.BackgroundTransparency=1;label.Text="HOLD";label.TextSize=12;label.Font=Enum.Font.GothamBold
    label.TextColor3=Color3.fromRGB(16,22,34);label.ZIndex=5;label.Parent=view
   end
   view.Parent=board["Lane"..note.lane];noteViews[note.id]=view
  end
 elseif playing then session=snapshot end
 if snapshot.stats and (snapshot.revision or 0)>=revision then revision=snapshot.revision or 0;stats(snapshot.stats) end
 if playing then
  for id,grade in pairs(snapshot.judged or {}) do consumed[id]=grade end
 else
  session=nil;chart=nil;clearNotes();revision=-1
 end
 root.StartButton.Visible=not locked and snapshot.phase~="Inviting"
 root.DuelButton.Visible=not locked and snapshot.phase~="Inviting"
 root.TargetButton.Visible=not locked and not invitation
 root.CancelButton.Visible=locked or snapshot.phase=="Inviting"
 root.CancelButton.Text=if snapshot.combat and snapshot.combat.tournamentId then "ABANDONAR PARTIDA" elseif snapshot.mode=="Combat" then "ABANDONAR X1" else "CANCELAR"
 root.StartButton.Text=if snapshot.phase=="Invited" then "ACEITAR X1" else "TESTE SOLO"
 root.DuelButton.Text=if snapshot.phase=="Invited" then "RECUSAR" else "CONVIDAR X1"
 board.Visible=playing
 root.Results.Visible=not playing
 if snapshot.combat then
  for i,p in ipairs(snapshot.combat.players) do
   local bar=root.CombatHUD["HP"..i]
   local avatar=bar:FindFirstChild("Avatar")
   if not avatar then
    avatar=Instance.new("Frame");avatar.Name="Avatar";avatar.Size=UDim2.new(0,28,1,0);avatar.Parent=bar
    bar.Label.Position=UDim2.fromOffset(30,0);bar.Label.Size=UDim2.new(1,-30,1,0)
   end
   if avatar:GetAttribute("Competitor")~=tostring(p.id or p.userId) then
    Portrait.Draw(avatar,p.appearance);avatar:SetAttribute("Competitor",tostring(p.id or p.userId))
   end
   bar.Label.Text=p.name.."  "..string.format("%.0f / %d",p.hp,p.maxHP)
   bar.Fill.Size=UDim2.fromScale(math.clamp(p.hp/p.maxHP,0,1),1)
  end
 else
  for i=1,2 do root.CombatHUD["HP"..i].Label.Text=if i==1 then "X1 • 100 HP" else "HOLD • SEGURE ATÉ O FIM";root.CombatHUD["HP"..i].Fill.Size=UDim2.fromScale(1,1) end
 end
 UI.SetSummary(snapshot)
 gui:SetAttribute("RhythmPhase",snapshot.phase)
 gui:SetAttribute("SessionId",if playing then snapshot.sessionId else nil)
 gui:SetAttribute("BattleId",snapshot.battleId)
 if not playing then
  root.Timing.Text=if snapshot.phase=="Waiting" then "ONDA "..snapshot.combat.wave.." • AGUARDE" else "SOLO OU CONVITE X1"
 end
 if duelHUD and duelHUD.Render(snapshot) then layout() end
end
function UI.Tick(now)
 if not session or not chart then return end
 local elapsed=now-session.startTime
 local prefix=if session.mode=="Combat" then "ONDA "..session.combat.wave.." • SEU TURNO" else "ESTUDO SOLO"
 root.Timing.Text=if elapsed<0 then prefix.." • "..math.ceil(-elapsed) else prefix..(if chart.accelerated then " • INTENSIDADE ↑" else "")
 board.HitLine.BackgroundTransparency=.15+.55*((elapsed*chart.bpm/60)%1)
 for _,note in ipairs(chart.notes) do
  local view=noteViews[note.id]
  local remaining=note.time-elapsed
  local heldNote=holding[note.lane]
  local isHolding=heldNote and heldNote.note.id==note.id and not heldNote.ended
  if not consumed[note.id] and remaining< -Config.GoodWindowSeconds then
   local grade=if (note.duration or 0)>0 then "BrokenHold" else "Miss"
   consumed[note.id]=grade;UI.Feedback(displayGrade[grade] or grade,grade)
  end
  view.Visible=(not consumed[note.id] or isHolding) and remaining<=Config.ApproachSeconds
  if view.Visible then
   local y=if isHolding then .84 else .84*(1-remaining/Config.ApproachSeconds)
   view.Position=UDim2.new(.5,0,y,0)
   if view:FindFirstChild("Tail") then
    local endY=.84*(1-(remaining+note.duration)/Config.ApproachSeconds)
    view.Tail.Size=UDim2.new(.45,0,0,math.max(0,(y-endY)*board.AbsoluteSize.Y))
   end
  end
 end
end
local function payload(note,action,now)
 return {protocolVersion=Config.ProtocolVersion,sessionId=session.sessionId,noteId=note.id,lane=note.lane,inputTime=now,action=action}
end
function UI.TryLane(lane,now,action)
 if not session or not chart then return nil end
 if action=="End" then
  local h=holding[lane]
  if not h or h.ended then return nil end
  h.ended=true
  local broken=now<session.startTime+h.note.time+h.note.duration-Config.HoldReleaseToleranceSeconds
  local grade=if broken then "BrokenHold" elseif h.grade=="Perfect" then "PerfectHold" else "GoodHold"
  consumed[h.note.id]=grade;UI.Feedback(displayGrade[grade],grade)
  return payload(h.note,"End",now)
 end
 if holding[lane] and not holding[lane].ended then return nil end
 local best,delta=nil,math.huge
 for _,note in ipairs(chart.notes) do
  local d=math.abs(now-session.startTime-note.time)
  if note.lane==lane and not consumed[note.id] and d<=Config.GoodWindowSeconds and d<delta then best=note;delta=d end
 end
 if not best then UI.Feedback("Fora do tempo");return nil end
 local grade=if delta<=Config.PerfectWindowSeconds then "Perfect" elseif delta<=Config.GreatWindowSeconds then "Great" else "Good"
 if (best.duration or 0)>0 then
  consumed[best.id]="Holding";holding[lane]={note=best,grade=grade,lastPulse=now,ended=false}
  UI.Feedback("SEGURE",grade)
 else
  consumed[best.id]=grade;noteViews[best.id].Visible=false;UI.Feedback(grade,grade)
 end
 return payload(best,"Begin",now)
end
function UI.PollHolds(now,isHeld)
 local messages={}
 if not session then return messages end
 for lane,h in pairs(holding) do
  if h.ended then continue end
  if not isHeld(lane) or now>=session.startTime+h.note.time+h.note.duration then
   local msg=UI.TryLane(lane,now,"End");if msg then table.insert(messages,msg) end
  elseif now-h.lastPulse>=Config.HoldPulseSeconds then
   h.lastPulse=now;table.insert(messages,payload(h.note,"HoldPulse",now))
  end
 end
 return messages
end
function UI.NoteResult(result)
 if not session or result.sessionId~=session.sessionId then return end
 if result.accepted and result.reason=="Holding" then return end
 if result.accepted then
  local previous=consumed[result.noteId];consumed[result.noteId]=result.grade
  for lane,h in pairs(holding) do if h.note.id==result.noteId then holding[lane]=nil end end
  if noteViews[result.noteId] then noteViews[result.noteId].Visible=false end
  if result.revision>revision then revision=result.revision;stats(result.stats) end
  if previous~=result.grade then UI.Feedback(displayGrade[result.grade] or result.grade,result.grade) end
 elseif result.reason~="AlreadyJudged" then
  for lane,h in pairs(holding) do if h.note.id==result.noteId then holding[lane]=nil end end
  UI.Feedback("Entrada não confirmada")
 end
end
function UI.Destroy()
 if duelHUD then duelHUD.Destroy();duelHUD=nil end
 clearNotes()
 for _,c in ipairs(connections) do c:Disconnect() end
 table.clear(connections)
 if feedbackTween then feedbackTween:Cancel() end
end
return UI