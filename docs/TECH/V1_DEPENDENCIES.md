# V1 — dependências e fluxo de dados (rascunho)

- [CONFIRMADO NO CÓDIGO] Base: [V1_INVENTORY.md](../OPS/V1_INVENTORY.md) e leitura direta de Source no Studio `CumbiaParty_V1_2026-10-22.rbxl`, instância `005c0210-6f57-4d6d-b0ea-5aab326fbb9d`, DataModel Edit, em 22/10/2026 (America/New_York).
- [CONFIRMADO NO CÓDIGO] Inspeção estática: leitura de scripts, busca de chamadas de rede e enumeração de Remotes; não foram executados módulos do jogo, Play, testes, disparos de Remote ou alterações no DataModel.
- [CONFIRMADO NO CÓDIGO] As únicas escritas desta tarefa são este documento e [NETWORK_CONTRACTS.md](NETWORK_CONTRACTS.md); `CURRENT_STATE.md` permanece intacto por restrição expressa do escopo aprovado.
- [NÃO ENCONTRADO] `CURRENT_STATE.md` e `GAME_DESIGN.md` não contêm conteúdo; não há implementação local em `src` para vincular as evidências a commits de código.
- [CONFIRMADO NO CÓDIGO] As referências `Módulo:linha` abaixo apontam para Source lido no Studio, não para arquivos locais. As linhas podem mudar após edição no Studio.
- [SUPOSIÇÃO] Riscos e propostas são hipóteses de impacto a validar, não confirmação de exploração nem medição de vazamento. A marcação [NÃO ENCONTRADO] limita-se ao escopo declarado.

## Localização das evidências

| Estado | Nome abreviado | Caminho no Studio |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | `ServerScriptService.CumbiaParty.ServerBootstrap` |
| [CONFIRMADO NO CÓDIGO] | RhythmService, BattleService, WaveGenerator, CompetitorService, BotService, TournamentService, LobbyService, WorldBindings, ArenaService | `ServerScriptService.CumbiaParty.Services.<nome>` |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | `ServerScriptService.CumbiaParty.Validation.NoteValidator` |
| [CONFIRMADO NO CÓDIGO] | GameConfig, NetworkTypes, WorldConfig, BattlePresentationConfig | `ReplicatedStorage.CumbiaParty.Shared.<nome>` |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | `StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap` |
| [CONFIRMADO NO CÓDIGO] | UIController, InputController, TournamentController, LobbyController, ArenaController, BattleHUD, BattlePresentationView, CompetitorPortrait | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.<nome>` |

## Quem chama quem no servidor

| Estado | Origem → destino | Chamadas e dados | Evidência |
|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap → LobbyService | `Init()` resolve o mundo e instala handlers próprios de lobby. | ServerBootstrap:11; LobbyService:86 |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap → ArenaService → TournamentService/LobbyService | `Init({setArea=Lobby.SetArea, onParticipantLost=...Withdraw, onTournamentFault=...CancelPhysicalTournament})`; se inicializa, `Tournament.SetArenaAdapter(Arena)`; `BindToClose(Arena.Shutdown)`. | ServerBootstrap:12 |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap → RhythmService/BattleService/CompetitorService | Rotas de SubmitNote e RhythmControl; checa ocupação/reserva antes do solo; passa intenções, nunca pontuação recebida do cliente. | ServerBootstrap:31 |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap → TournamentService → LobbyService | Join/LeaveQueue/ExitView/Withdraw/Snapshot; ExitView bem-sucedido chama `Lobby.Return`. O retorno de `Lobby.Return` não altera o `ok` anterior. | ServerBootstrap:53 |
| [CONFIRMADO NO CÓDIGO] | Heartbeat → Tournament, Rhythm, Battle, Arena | `Update()` nessa ordem. Lobby instala outro Heartbeat, com intervalo de recuperação próprio. | ServerBootstrap, última conexão Heartbeat; LobbyService.Init |
| [CONFIRMADO NO CÓDIGO] | RhythmService → NoteValidator | `ValidateRequest`, `ValidateTime`, `JudgeTiming`: protocolo, IDs, coluna, ação, finitude e janela temporal; Rhythm complementa com propriedade da sessão, nota, duplicação, ordem e holds. | RhythmService:89; NoteValidator |
| [CONFIRMADO NO CÓDIGO] | RhythmService → CompetitorService | `Id`, `Find`, `IsHuman` distinguem jogadores reais de competidores do servidor; o transporte padrão só envia para humanos. | RhythmService:11 |
| [CONFIRMADO NO CÓDIGO] | RhythmService → callbacks de BattleService | `onJudged(player,{grade,combo,duration,completion})` e `onFinished(player,sessionId)` são funções injetadas pelo servidor em `StartChart`. | RhythmService:38,62,150; BattleService:97 |
| [CONFIRMADO NO CÓDIGO] | BattleService → WaveGenerator | `GeneratePair(seed,wave)` produz dois charts com tempos/durações equivalentes e colunas espelhadas; seed/onda pertencem ao servidor. | BattleService.startTurn; WaveGenerator.GeneratePair |
| [CONFIRMADO NO CÓDIGO] | BattleService → RhythmService | `StartChart`, snapshots, `IsActive`, `Cancel`, `ReleaseSession`. O callback de julgamento calcula dano, HP e desempenho acumulado a partir do resultado interno. | BattleService:34,74,97,140,205 |
| [CONFIRMADO NO CÓDIGO] | BattleService → CompetitorService | Disponibilidade, identidade, apresentação, busca e `CanUse(owner)`; `CreateSession` exige dois competidores distintos e disponíveis. | BattleService:140 |
| [CONFIRMADO NO CÓDIGO] | TournamentService → CompetitorService | Fila reserva `TournamentQueue`; lançamento transfere para `Tournament:<id>`, cria bots para completar oito vagas; eliminações/finalização liberam humanos e finalização remove bots. | TournamentService:65,72,180,220 |
| [CONFIRMADO NO CÓDIGO] | TournamentService → BattleService | `CreateSession` injeta `onTurn=scheduler.Schedule` e `onCompleted=enqueueCompletion`; Withdraw usa `Forfeit`; conclusão libera a batalha antes de avançar a chave. | TournamentService:116,246,260 |
| [CONFIRMADO NO CÓDIGO] | TournamentService → BotService → RhythmService | `Schedule` cria Begin/HoldPulse/End; `Update` chama `SubmitServerInput`; plano encerra quando consumido ou por `CancelBattle`/`Clear`. | BotService:12,48,58; TournamentService:31,260 |
| [CONFIRMADO NO CÓDIGO] | TournamentService → ArenaService | `CanStartTournament`, `BeginTournament`, `Reserve`, `IsPresentationReady`, `BindBattle`, `ReleaseMatch`, `EndTournament`; apresentação física precede criação da batalha. | TournamentService:116,180 |
| [CONFIRMADO NO CÓDIGO] | TournamentService → engines isoladas | Bot × bot cria `RhythmService.new`, `BattleService.new`, `BotService.new` com relógio `job.time` e transporte sem envio; atualização acelerada usa a mesma lógica de julgamento/dano. | TournamentService.startMatch/Update |
| [CONFIRMADO NO CÓDIGO] | LobbyService → Battle/Rhythm/Tournament | Consulta atividade, ocupação e reserva para autorizar Return; recuperação de queda não remove inscrição da fila. | LobbyService:18,64,70 |
| [CONFIRMADO NO CÓDIGO] | LobbyService/ArenaService → WorldBindings | Resolve mundo/complexo, marcadores e suporte físico; lobby reposiciona e arena fixa/restaura personagens. | LobbyService:46,86; ArenaService:38,84; WorldBindings:106,156,163 |
| [CONFIRMADO NO CÓDIGO] | ArenaService → callbacks do bootstrap | Perda de participante chama Withdraw; falha física chama cancelamento do torneio; área é registrada por `Lobby.SetArea`, sem Remote de atribuição. | ArenaService:161,167; ServerBootstrap:13 |
| [CONFIRMADO NO CÓDIGO] | Configurações compartilhadas → consumidores | GameConfig fornece protocolo/regras/charts e requer perfil de WorldConfig para o alias Lobby; WorldBindings resolve WorldConfig; Arena e cliente usam BattlePresentationConfig. | requires dos módulos citados |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes → documentação de tipos | Declara tipos e comentários; retorna tabela vazia congelada. | NetworkTypes |
| [NÃO ENCONTRADO] | NetworkTypes → validação executável | Não há require de NetworkTypes nos bootstraps/serviços/controllers inspecionados nem validador gerado por esses tipos. | busca de requires; NetworkTypes |

- [CONFIRMADO NO CÓDIGO] O retorno Arena → Tournament/Lobby é injetado por callbacks; ArenaService não requer TournamentService nem LobbyService. TournamentService armazena o adaptador, evitando um ciclo de require nesse trecho.

## Cliente e apresentação

| Estado | Origem → destino | Responsabilidade / fluxo |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap → InputController | Inicializa controles; inicia por token de sessão/batalha e deadline; Stop em cancelamento, fim ou destruição. Input chama o callback de coluna/ação. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap → UIController → SubmitNote | `TryLane` seleciona nota e prepara payload; `PollHolds` gera pulsos/End no RenderStepped; bootstrap chama FireServer. Feedback local é provisório; `NoteResult`/snapshots fornecem stats autoritativas. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap → TournamentController | Injeta callback que envia TournamentRequest; recebe TournamentState e chama Render após conferir protocolo. |
| [CONFIRMADO NO CÓDIGO] | LobbyController → TournamentController/Remotes | Abre/minimiza interface; escuta TournamentState e LobbyState; pede Return automático uma vez por ID de torneio terminado/cancelado ou com jogador eliminado. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap → ArenaController → BattlePresentationView | ArenaController recebe atribuição/liberação via LobbyState, controla câmera/introdução e filtra BattleState antes de UI.Render; cancelamento da introdução envia Withdraw. |
| [CONFIRMADO NO CÓDIGO] | UIController → BattleHUD/CompetitorPortrait | Adapta HUD de torneio e retratos; TournamentController também usa CompetitorPortrait. |
| [CONFIRMADO NO CÓDIGO] | InputController → controles Roblox | Requer ControlModule/PlayerModule, bloqueia ações de movimento durante ritmo e restaura controles em Stop. |

## Fluxos de dados

1. [CONFIRMADO NO CÓDIGO] **Entrada humana:** Input → callback do ClientBootstrap → UI.TryLane/PollHolds → SubmitNote → limite do bootstrap → Rhythm.Submit → NoteValidator + sessão/nota → `judge`. Payload contém intenção e `inputTime`, não score/grade/HP.
2. [CONFIRMADO NO CÓDIGO] **Resultado:** `judge` marca `judged[noteId]`, incrementa revisão e stats, envia NoteResult e chama onJudged. Battle calcula dano, atualiza HP e envia BattleState; KO chama Finish. Na ausência de entrada, Rhythm.Update gera Miss/BrokenHold.
3. [CONFIRMADO NO CÓDIGO] **X1 direto:** Invite → valida alvo/disponibilidade → snapshot Inviting/Invited → Accept com inviteId do destinatário → CreateSession → ondas/turnos → Finish. Recusa, cancelamento e expiração removem o convite.
4. [CONFIRMADO NO CÓDIGO] **Torneio:** Join → reserva/fila → oito humanos ou prazo de 30 s → completa vagas com bots → reserva complexo/arena → apresentação de 7,9 s após lead de 0,4 s → CreateSession → onCompleted enfileira → Update consome uma vez → Release/finishMatch → próxima rodada ou campeão. Disponibilidade é rechecada após apresentação.
5. [CONFIRMADO NO CÓDIGO] **Desempate:** batalha por limite compara HP; empate entregue ao torneio compara qualidade média dos julgamentos; igualdade usa vencedor sorteado e fixado ao criar a partida (`tieWinner`). Cliente não escolhe vencedor.
6. [CONFIRMADO NO CÓDIGO] **Bot × bot:** job com relógio próprio incrementado em 0,025 s → Bot.Update → Rhythm.Update → Battle.Update → mesma fila de conclusões; não há submissão humana nesse caminho.
7. [CONFIRMADO NO CÓDIGO] **Entrada/ressincronização:** ClientReady → Battle.SendSnapshot (ou Rhythm), Tournament.SendSnapshot e Arena.SendSnapshot; cliente recebe estado existente, sem reiniciar relógio de apresentação.
8. [CONFIRMADO NO CÓDIGO] **Saída/respawn:** bootstrap coordena Arena, Tournament, Battle e Rhythm; PlayerRemoving também apaga limitadores e desconecta CharacterRemoving. Lobby tem limpeza própria por jogador. Arena libera posição, ancoragem, AutoRotate, atributos e visuais em ReleaseMatch.

## Estado, retenção e cleanup

| Estado | Dono / estruturas | Limite ou liberação observada | Lacuna / alcance |
|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | Rhythm: sessions, byId, judged, holding, callbacks | Uma entrada por ID de competidor; nova StartChart substitui; ReleaseSession/RemovePlayer apagam. Cancel limpa holding. | Update pula sessões não Playing; solo encerrado/cancelado permanece até substituição/remoção explícita. |
| [CONFIRMADO NO CÓDIGO] | Battle: battles, members, lastResults, invitations, outgoing | Finish impede repetição, remove members; Update expira convites (20 s), battles/resultados (30 s). Release também limpa sessão associada no Rhythm. | Expiração automática em Update remove battle/resultados, mas não chama ReleaseSession. |
| [CONFIRMADO NO CÓDIGO] | Tournament: queue, queueSet, tournaments, actors, members, watching, jobs, completions | Fila até 8; até 4 torneios Running na configuração; complexo físico aceita um por vez. Finalizados ficam 60 s; Update remove watchers/torneio. Conclusões usam troca de tabela e estados/IDs. | actors e apresentação ficam durante retenção; MaxConcurrent limita Running, não todos os objetos retidos. |
| [CONFIRMADO NO CÓDIGO] | Competitor: bots, reservations | Queue/torneio usam Release por owner; complete remove bots com C.Remove. | RemovePlayer do bootstrap chega às reservas via Tournament.RemovePlayer; não chama C.Remove para humano diretamente. |
| [CONFIRMADO NO CÓDIGO] | Bot: plans/events | Um plano por competidor; elimina ao consumir todos; CancelBattle e Clear em conclusão/cancelamento. | Eventos consumidos continuam no array até o plano terminar; não são removidos individualmente. |
| [CONFIRMADO NO CÓDIGO] | Arena: matches, occupied, humans, battles, participantMatches, lease, visuals | ReleaseMatch retira propriedade antes de restaurar humanos/destruir visuais; EndTournament libera lease; Shutdown destrói runtime. Há prazo de lease e verificação a cada 0,25 s. | RemovePlayer notifica o torneio; liberação física depende de conclusão/cancelamento subsequente, não ocorre diretamente nesse método. |
| [CONFIRMADO NO CÓDIGO] | Lobby e bootstrap: mapas por UserId e conexões por personagem | PlayerRemoving apaga mapas e desconecta conexões individuais; Lobby.Init é protegido contra repetição. | Conexões globais de Heartbeat/Players/Remotes do bootstrap e Lobby não têm Shutdown/Disconnect central. |
| [CONFIRMADO NO CÓDIGO] | Cliente: Input, UI, Tournament, Lobby, Arena | Input.Stop desconecta/unbind; UI limpa notas e conexões; controllers têm Destroy. Arena limita retiredOrder a 32 IDs. | ClientBootstrap.suppressed e LobbyController.returned acumulam IDs sem TTL/cap/poda explícita. |

## Riscos e evidências

### R1 — timestamp do cliente influencia o julgamento

- [CONFIRMADO NO CÓDIGO] `RhythmService.submit` usa `payload.inputTime` em JudgeTiming, ordem, intervalo por coluna e conclusão de hold. Para humanos, received vem de GetServerTimeNow e ping de GetNetworkPing; a tolerância é `clamp(ping + 0,075, 0,075, 0,250)` s de atraso e até 0,035 s no futuro (NoteValidator.ValidateTime; GameConfig).
- [CONFIRMADO NO CÓDIGO] Begin também verifica recebimento entre `expected - 0,140 - 0,035` e `expected + 0,140 + 0,250`. Holds exigem Begin, ordem e pulso recente, mas a decisão sobre tempo de pressionar/soltar continua usando inputTime.
- [SUPOSIÇÃO] Um cliente alterado pode informar o tempo ideal de uma nota se o recebimento ainda couber nas verificações, melhorando a classificação sem provar o instante físico da tecla; pulsos automáticos também não provam sustentação humana. Isso é uma fronteira de confiança residual, apesar do cálculo de pontos no servidor.
- [SUPOSIÇÃO] Prioridade alta de teste: falsificar tempos nos limites de ping/atraso/futuro, replay de Begin/End e pulsos sintéticos; avaliar política de tolerância antes de alterar gameplay.

### R2 — pontuação, double-award e prêmios

- [CONFIRMADO NO CÓDIGO] Pontos/combo/grade são calculados em RhythmService.judge; dano/HP em BattleService.startTurn.onJudged; campeão em TournamentService. Campos extras do payload não entram nesses cálculos.
- [CONFIRMADO NO CÓDIGO] `judge` bloqueia sessão não Playing e noteId já julgado; marca judged antes de enviar/callback. `Battle.Finish` muda stage antes de concluir; Tournament.Update exige status Active, battleId correspondente e torneio Running; finishMatch/complete também guardam estado. Arena.ReleaseMatch remove a entrada antes do cleanup.
- [NÃO ENCONTRADO] Não foi encontrado caminho de prêmio persistente/monetário, BadgeService, ProcessReceipt ou DataStore nos serviços/bootstraps atuais lidos; a busca literal adicional em scripts fora de ServerStorage/CoreGui não encontrou DataStore/award. Isso não audita backups, outros places ou produção.
- [SUPOSIÇÃO] As guardas reduzem double-count de notas/dano e avanço repetido da chave, mas não substituem teste de callbacks duplicados, KO simultâneo a saída/timeout e entrega repetida. Double-award de prêmio persistente não pode ser avaliado sem um caminho de concessão implementado/encontrado.

### R3 — retenção após solo/X1 direto

- [CONFIRMADO NO CÓDIGO] Rhythm.Update ignora Finished/Cancelled; Battle.Update apaga battles expiradas sem liberar a sessão Rhythm. A sessão de combate guarda context/onJudged/onFinished com closures que referenciam a batalha (RhythmService:62,150; BattleService:97,193).
- [SUPOSIÇÃO] Uma sessão de X1 direto encerrada pode manter a batalha e seus dados alcançáveis mesmo após 30 s, até nova sessão, ReleaseSession ou saída do jogador. A entrada é limitada por competidor, portanto isso não demonstra crescimento ilimitado por partida para o mesmo jogador.
- [CONFIRMADO NO CÓDIGO] O caminho normal do torneio chama Battle.Release na conclusão e não depende apenas dessa expiração. Não se deve generalizar a lacuna do X1 direto para todos os modos.
- [SUPOSIÇÃO] Prioridade média: medir retenção após repetidos X1/solo e inatividade; considerar separar o snapshot final dos callbacks/chart apenas em tarefa futura autorizada.

### R4 — históricos sem limite no cliente

- [CONFIRMADO NO CÓDIGO] ClientBootstrap.cancel grava `suppressed[token]=true` e não há remoção dessas chaves; LobbyController grava `returned[t.id]=true` para cada torneio retornado sem poda (ClientBootstrap:15,41; LobbyController:10,26).
- [SUPOSIÇÃO] Sessões longas com muitos cancelamentos/torneios podem acumular strings/tabelas. O impacto em bytes e o tempo para ser perceptível permanecem desconhecidos; ArenaController.retired tem limite 32 e não compartilha essa lacuna.
- [SUPOSIÇÃO] Prioridade média: testar muitos ciclos e comparar tamanho dos mapas/memória; possível tratamento futuro é retenção limitada por necessidade de ignorar mensagens antigas.

### R5 — teardown parcial de GUI e reinicialização

- [CONFIRMADO NO CÓDIGO] gui.Destroying chama cancel no ClientBootstrap e restore no ArenaController; a desconexão completa de links e UI.Destroy/Arena.Destroy fica em script.Destroying. LobbyController/TournamentController também ligam Destroy diretamente à GUI (ClientBootstrap:109; ArenaController:72,104).
- [SUPOSIÇÃO] Se a GUI for destruída mantendo o LocalScript vivo, links de rede/renderização da UI/Arena podem continuar ativos e reter referências a objetos destruídos; novos callbacks podem produzir erros. O caminho normal de destruição conjunta ainda precisa de teste.
- [CONFIRMADO NO CÓDIGO] Não há teardown central das conexões globais de servidor; Lobby.Init impede duplicação pelo mesmo módulo, mas ServerBootstrap não tem guarda global equivalente.
- [SUPOSIÇÃO] Reexecutar bootstrap/recriar módulos sem encerrar o servidor pode duplicar handlers; não há evidência de que isso aconteça na inicialização normal. Prioridade média para testes de ciclo de vida, não confirmação de leak em produção.

### R6 — alocação e amplificação de snapshots

- [CONFIRMADO NO CÓDIGO] Cada julgamento ativo sem KO pode chamar Battle.broadcast; snapshot do jogador ativo clona chart/notas/judged/stats e inclui combat. Tournament.broadcast recalcula snapshots para todos os humanos; TournamentController.renderContent destrói/recria os filhos do conteúdo a cada Render (RhythmService:22; BattleService:46,97; TournamentService:60; TournamentController:50,90).
- [CONFIRMADO NO CÓDIGO] SubmitNote/RhythmControl/TournamentRequest compartilham limite de 80 eventos por jogador por janela fixa de 1 s; Snapshot do torneio tem cooldown 0,35 s e ClientReady 1 s. LobbyRequest possui cooldown separado de 0,5 s. O limite não mede bytes ou quantidade de campos de uma tabela.
- [SUPOSIÇÃO] Charts completos por julgamento e reconstrução de UI podem elevar tráfego, alocações e GC; limites por jogador não limitam o custo agregado de muitos jogadores. A fronteira entre janelas fixas permite rajadas superiores a 80 em um intervalo móvel de 1 s.
- [CONFIRMADO NO CÓDIGO] A simulação headless possui teto de 240 passos por Update e orçamento de 0,004 s, checado após uma passagem pelos jobs; o trabalho comum de bots/Rhythm/Battle e o custo de cada passo não são interrompidos por esse orçamento.
- [SUPOSIÇÃO] O orçamento é cooperativo, não teto rígido de tempo total do frame. Prioridade média: medir tráfego/GC/Heartbeat com concorrência; nenhum valor de MB ou ms real foi medido nesta tarefa.

### R7 — caminhos excepcionais de criação/cleanup

- [CONFIRMADO NO CÓDIGO] Tournament.startMatch envolve CreateSession em pcall, mas `m.battleId` só é atribuído após sucesso. Battle.CreateSession grava members/battles antes de startTurn; Arena.BindBattle é assert fora desse pcall (TournamentService:116; BattleService:140).
- [SUPOSIÇÃO] Erro após alocação parcial pode deixar estado sem o identificador necessário para a liberação imediata; erro de BindBattle pode interromper o processamento daquela atualização. Requer injeção controlada de falhas para confirmar objetos retidos e recuperação por timeout.

## Backups e memória do mapa

- [CONFIRMADO NO CÓDIGO] A enumeração atual confirma nove Remotes em ReplicatedStorage e sete conjuntos preservados de nove em ServerStorage; eles estão discriminados em NETWORK_CONTRACTS.md.
- [CONFIRMADO NO CÓDIGO] O inventário registra 715 MeshParts, 6.911 Parts, 624 WedgeParts e 50 UnionOperations contando preservações e elementos internos; esses totais vêm do inventário e não foram recontados nesta análise de dependências.
- [SUPOSIÇÃO] Cópias preservadas podem contribuir para memória do place/servidor, mas contagem de instâncias não mede memória nem tráfego replicado. Não há base nesta inspeção para atribuir um custo em MB ou afirmar que todas as cópias chegam ao cliente.
- [NÃO ENCONTRADO] Perfil de memória, objetos sem Parent, histórico de GC e medição de instâncias durante partidas não foram coletados.

## Verificação e limites

- [CONFIRMADO NO CÓDIGO] Conferência documental executada: nenhuma linha de conteúdo sem uma das três marcações; links Markdown locais existentes; seções dos nove Remotes presentes; leitura UTF-8 sem caractere de substituição. Comparação SHA-256 dos 12 arquivos preexistentes fora dos dois destinos autorizados confirmou conteúdo inalterado.
- [CONFIRMADO NO CÓDIGO] Executado: leitura direta dos bootstraps, nove serviços, NoteValidator, GameConfig, NetworkTypes, BattlePresentationConfig e oito controllers; leitura de WorldBindings para suas dependências e APIs espaciais; enumeração dos Remotes e busca das chamadas de rede nos scripts fora de ServerStorage/CoreGui.
- [CONFIRMADO NO CÓDIGO] Contratos e dependências descritos são da implementação atual referenciada pelos bootstraps; código de backup não foi tratado como implementação ativa nem auditado integralmente neste rascunho.
- [NÃO ENCONTRADO] Validação dinâmica permanece NÃO TESTADA: multiplayer, exploração por timestamps, replay, double-award, concorrência entre callbacks, respawn/saída, destruição/recriação de GUI, falhas parciais, longas sessões, carga e memória.
- [NÃO ENCONTRADO] Testes unitários inventariados não foram executados. Não há afirmação de aprovação de testes, segurança completa ou equivalência com produção.
