# V1 — conferência por amostra contra o Studio

## Escopo e conexão

- [CONFIRMADO NO CÓDIGO] Nesta sessão de 23/10/2026 (America/New_York), `list_roblox_studios` retornou o nome `CumbiaParty_V2_Trabalho.rbxl`, ID `08837ee8-8eb5-4476-9b55-7b789169846f`; `get_studio_state` retornou modo `Edit` e DataModel `Edit` disponível. A identificação vem do MCP; o caminho absoluto do arquivo no disco não foi fornecido por essa resposta.
- [SUPOSIÇÃO] A coluna “o que a auditoria afirma” conserva as alegações dos sete itens do relatório anterior como hipóteses de comparação, não como evidência atual.
- [CONFIRMADO NO CÓDIGO] As confirmações abaixo se baseiam exclusivamente na hierarquia e nos Sources lidos do Studio nesta sessão. A consulta da hierarquia usou somente leitura de descendentes, nomes, classes e caminhos; nenhum módulo do jogo foi executado.
- [NÃO ENCONTRADO] Resultado de testes dinâmicos: não consegui verificar; não foi iniciado Play.

## Resultado por item

| item | o que a auditoria afirma | o que você encontrou | bateu / não bateu / não consegui verificar |
|---|---|---|---|
| 1. Scripts de ServerScriptService | [SUPOSIÇÃO] Doze scripts/módulos: RhythmService, BattleService, WaveGenerator, CompetitorService, BotService, TournamentService, LobbyService, WorldBindings, ArenaService, NoteValidator, ServerBootstrap e UnitTestRunner. | [CONFIRMADO NO CÓDIGO] A varredura de todos os descendentes de ServerScriptService encontrou exatamente esses 12 LuaSourceContainers: 2 Scripts e 10 ModuleScripts. Caminhos abaixo. | bateu |
| 2. RemoteEvents em ReplicatedStorage | [SUPOSIÇÃO] Nove em ReplicatedStorage.CumbiaParty.Remotes: ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest e LobbyState. | [CONFIRMADO NO CÓDIGO] A varredura de toda a árvore de ReplicatedStorage encontrou exatamente esses nove RemoteEvents, todos em game.ReplicatedStorage.CumbiaParty.Remotes, e nenhuma RemoteFunction. | bateu |
| 3. Mundo e área do Torneio X1 | [SUPOSIÇÃO] Workspace.CumbiaBattleWorld contém NorthTournament com Ring1–Ring4, Final e ObservationGallery; existe também Interactions.NorthTournament. | [CONFIRMADO NO CÓDIGO] Todos esses caminhos existem como Models. Também existe o Part game.Workspace.CumbiaBattleWorld.Bindings.AreaMarkers.NorthTournament. | bateu |
| 4. Cenários preservados | [SUPOSIÇÃO] Existem os Models ServerStorage.GreyboxPreservation.CumbiaPartyLobby e CumbiaPartyHorizon. | [CONFIRMADO NO CÓDIGO] Ambos existem como Models, filhos de game.ServerStorage.GreyboxPreservation, que é Folder. | bateu |
| 5. Bootstrap e controllers do cliente | [SUPOSIÇÃO] CumbiaParty.ClientBootstrap é LocalScript; Controllers contém UIController, InputController, CompetitorPortrait, TournamentController, LobbyController, ArenaController, BattleHUD e BattlePresentationView como ModuleScripts. | [CONFIRMADO NO CÓDIGO] Os nove objetos conferem em game.StarterPlayer.StarterPlayerScripts.CumbiaParty. Fora dessa pasta existe também o LocalScript game.StarterPlayer.StarterPlayerScripts.CumbiaPartyFestivalFX; sua presença não contradiz a lista específica de CumbiaParty. | bateu |
| 6. Teclas de entrada | [SUPOSIÇÃO] A V1 usa D/F/J/K. | [CONFIRMADO NO CÓDIGO] InputController declara D/F/J/K e vincula cada tecla à respectiva coluna por ContextActionService. Caminho e trechos exatos abaixo. | bateu |
| 7. inputTime e R1 | [SUPOSIÇÃO] RhythmService.submit usa payload.inputTime em JudgeTiming, ordem, intervalo por coluna e conclusão de hold, com validações de tempo/recebimento. | [CONFIRMADO NO CÓDIGO] O fluxo cliente → SubmitNote → Rhythm.Submit → submit preserva inputTime; o servidor o usa nos quatro pontos alegados e aplica validações. Caminhos e trechos exatos abaixo. [NÃO ENCONTRADO] Exploração prática de R1: não consegui verificar. | bateu |

## Caminhos da amostra estrutural

- [CONFIRMADO NO CÓDIGO] Scripts: `game.ServerScriptService.CumbiaParty.ServerBootstrap` e `game.ServerScriptService.UnitTestRunner`.
- [CONFIRMADO NO CÓDIGO] ModuleScripts sob `game.ServerScriptService.CumbiaParty.Services`: ArenaService, BattleService, BotService, CompetitorService, LobbyService, RhythmService, TournamentService, WaveGenerator e WorldBindings.
- [CONFIRMADO NO CÓDIGO] Décimo ModuleScript: `game.ServerScriptService.CumbiaParty.Validation.NoteValidator`.
- [CONFIRMADO NO CÓDIGO] Models: `game.Workspace.CumbiaBattleWorld`, `game.Workspace.CumbiaBattleWorld.NorthTournament` e seus filhos diretos `Ring1`, `Ring2`, `Ring3`, `Ring4`, `Final` e `ObservationGallery`; também `game.Workspace.CumbiaBattleWorld.Interactions.NorthTournament`.
- [CONFIRMADO NO CÓDIGO] Preservados: `game.ServerStorage.GreyboxPreservation.CumbiaPartyLobby` e `game.ServerStorage.GreyboxPreservation.CumbiaPartyHorizon`.
- [CONFIRMADO NO CÓDIGO] LocalScript: `game.StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap`. Os oito controllers do item 5 são ModuleScripts sob `game.StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers`.

## Item 6 — evidência exata

[CONFIRMADO NO CÓDIGO] Mapeamento das quatro teclas: Caminho: `game.StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController`, linhas 17.

```lua
local keys={Enum.KeyCode.D,Enum.KeyCode.F,Enum.KeyCode.J,Enum.KeyCode.K}
```

[CONFIRMADO NO CÓDIGO] Vínculo das teclas às colunas: Caminho: `game.StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController`, linhas 88–98.

```lua
 for lane,key in ipairs(keys) do
  held[lane]=UIS:IsKeyDown(key)
  CAS:BindActionAtPriority("CumbiaTilesLane"..lane,function(_,state)
   if state==Enum.UserInputState.End or state==Enum.UserInputState.Cancel then
    held[lane]=nil;release(lane,"Key")
   elseif state==Enum.UserInputState.Begin and active and not held[lane] then
    held[lane]=true
    if not UIS:GetFocusedTextBox() then press(lane,"Key") end
   end
   return Enum.ContextActionResult.Sink
  end,false,Config.InputPriority,key)
```

## Item 7 — evidência exata

[CONFIRMADO NO CÓDIGO] O cliente fornece o horário sincronizado à UI e envia a mensagem ao RemoteEvent: Caminho: `game.StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap`, linhas 66–72.

```lua
local function lane(index,action)
 local ok,err=pcall(function()
  local message=UI.TryLane(index,workspace:GetServerTimeNow(),action)
  if message then Root.Remotes.SubmitNote:FireServer(message) end
 end)
 if not ok then warn("[CumbiaParty] Input: "..tostring(err));cancel("ClientError") end
end
```

[CONFIRMADO NO CÓDIGO] A construção da mensagem atribui esse horário a inputTime: Caminho: `game.StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController`, linhas 217–219.

```lua
local function payload(note,action,now)
 return {protocolVersion=Config.ProtocolVersion,sessionId=session.sessionId,noteId=note.id,lane=note.lane,inputTime=now,action=action}
end
```

[CONFIRMADO NO CÓDIGO] TryLane retorna o payload de Begin: Caminho: `game.StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController`, linhas 245–246.

```lua
 return payload(best,"Begin",now)
end
```

[CONFIRMADO NO CÓDIGO] O servidor encaminha o payload recebido a Rhythm.Submit após o limitador: Caminho: `game.ServerScriptService.CumbiaParty.ServerBootstrap`, linhas 50–52.

```lua
Root.Remotes.SubmitNote.OnServerEvent:Connect(function(p,payload)
 if allow(p) then Rhythm.Submit(p,payload) end
end)
```

[CONFIRMADO NO CÓDIGO] A entrada humana chama submit com serverInput=false: Caminho: `game.ServerScriptService.CumbiaParty.Services.RhythmService`, linhas 142–145.

```lua
 function R.Submit(p,payload)
  if not C.IsHuman(p) then return false,"HumanOnly" end
  return submit(p,payload,false)
 end
```

[CONFIRMADO NO CÓDIGO] O recebimento humano usa now() e valida o horário informado: Caminho: `game.ServerScriptService.CumbiaParty.Services.RhythmService`, linhas 101–103.

```lua
  local received=if serverInput then payload.inputTime else now()
  if serverInput and payload.inputTime>now()+1e-6 then return reject("FutureServerInput") end
  if not serverInput and not Validator.ValidateTime(payload.inputTime,received,ping(p)) then return reject("InvalidTime") end
```

[CONFIRMADO NO CÓDIGO] A ordem e a conclusão de hold dependem de payload.inputTime; o timeout usa received: Caminho: `game.ServerScriptService.CumbiaParty.Services.RhythmService`, linhas 106–124.

```lua
  if action~="Begin" then
   if not hold then return reject("NotHolding") end
   if payload.inputTime<hold.lastInput or payload.inputTime<hold.pressTime then return reject("OutOfOrder") end
   if received-hold.lastPulse>Config.HoldPulseTimeoutSeconds+Config.MaxBackdateSeconds then
    judge(p,s,note,"BrokenHold",hold.completion);return false,"HoldTimeout"
   end
   local ending=s.startTime+note.time+note.duration
   local completion=math.clamp((payload.inputTime-math.max(hold.pressTime,s.startTime+note.time))/note.duration,0,1)
   hold.lastInput=payload.inputTime
   if action=="HoldPulse" then
    hold.lastPulse=received;hold.completion=completion
    return true,"Holding"
   end
   local grade="BrokenHold"
   if payload.inputTime>=ending-Config.HoldReleaseToleranceSeconds then
    grade=if hold.startGrade=="Perfect" then "PerfectHold" else "GoodHold"
    completion=math.clamp((ending-math.max(hold.pressTime,s.startTime+note.time))/note.duration,0,1)
   end
   judge(p,s,note,grade,completion);return true,grade
```

[CONFIRMADO NO CÓDIGO] Ordem, intervalo por coluna, janela de recebimento e JudgeTiming: Caminho: `game.ServerScriptService.CumbiaParty.Services.RhythmService`, linhas 126–139.

```lua
  if hold then return reject("AlreadyHolding") end
  if payload.inputTime<s.lastInput then return reject("OutOfOrder") end
  if payload.inputTime-(s.laneTimes[payload.lane] or -math.huge)<Config.MinimumLaneIntervalSeconds then return reject("TooFast") end
  local expected=s.startTime+note.time
  if received<expected-Config.GoodWindowSeconds-Config.FutureToleranceSeconds or received>expected+Config.GoodWindowSeconds+Config.MaxBackdateSeconds then return reject("OutsideWindow") end
  local grade=Validator.JudgeTiming(expected,payload.inputTime)
  if grade=="Miss" then return reject("OutsideWindow") end
  s.lastInput=payload.inputTime;s.laneTimes[payload.lane]=payload.inputTime
  if (note.duration or 0)>0 then
   s.holding[note.id]={startGrade=grade,pressTime=payload.inputTime,lastInput=payload.inputTime,lastPulse=received,completion=0}
   send(p,"NoteResult",{accepted=true,reason="Holding",sessionId=s.id,noteId=note.id,startGrade=grade})
   return true,"Holding"
  end
  judge(p,s,note,grade,1);return true,grade
```

[CONFIRMADO NO CÓDIGO] JudgeTiming compara expected com actual; ValidateTime limita futuro e retrodatação conforme ping e configuração: Caminho: `game.ServerScriptService.CumbiaParty.Validation.NoteValidator`, linhas 19–32.

```lua
function Validator.JudgeTiming(expected: number, actual: number): string
 if not finite(expected) or not finite(actual) then return "Miss" end
 local delta=math.abs(expected-actual)
 -- Tiny epsilon only for floating point representation at exact boundaries.
 if delta<=Config.PerfectWindowSeconds+1e-6 then return "Perfect" end
 if delta<=Config.GreatWindowSeconds+1e-6 then return "Great" end
 if delta<=Config.GoodWindowSeconds+1e-6 then return "Good" end
 return "Miss"
end
function Validator.ValidateTime(inputTime: number, received: number, measuredPing: number): boolean
 if not finite(inputTime) or not finite(received) or not finite(measuredPing) then return false end
 local allowance=math.clamp(measuredPing+Config.NetworkJitterSeconds,Config.NetworkJitterSeconds,Config.MaxBackdateSeconds)
 return inputTime<=received+Config.FutureToleranceSeconds and received-inputTime<=allowance
end
```

## Conclusão e limites

- [CONFIRMADO NO CÓDIGO] Os sete itens bateram no alcance da amostra estática; não foi encontrada divergência entre as alegações comparadas e os objetos/trechos consultados.
- [CONFIRMADO NO CÓDIGO] R1 está sustentado como dependência do julgamento em relação ao timestamp enviado pelo cliente, mesmo com validações no servidor. Isso não significa ausência de validação nem decisão direta da nota pelo cliente: RhythmService calcula a classificação e atualiza as estatísticas.
- [SUPOSIÇÃO] A possibilidade de obter vantagem adulterando o timestamp é uma hipótese de risco; sua eficácia e magnitude dependem de investigação dinâmica.
- [NÃO ENCONTRADO] Segurança efetiva contra exploração de timestamps, comportamento em gameplay, multiplayer, mobile, teclado real, respawn, desempenho e memória: não consegui verificar.
- [NÃO ENCONTRADO] Testes unitários e de integração: NÃO TESTADO; nenhum teste do jogo foi executado.
- [SUPOSIÇÃO] Registro operacional desta entrega: somente este relatório foi sobrescrito; CURRENT_STATE.md e os demais arquivos ficaram fora do escopo autorizado. Nenhuma ferramenta de edição, publicação, salvamento ou início de Play foi chamada no Studio.
