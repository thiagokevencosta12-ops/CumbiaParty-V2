# V1 — contratos de rede (rascunho)

- [CONFIRMADO NO CÓDIGO] Fonte inicial: [V1_INVENTORY.md](../OPS/V1_INVENTORY.md); contratos conferidos por leitura direta no Studio `CumbiaParty_V1_2026-10-22.rbxl`, ID `005c0210-6f57-4d6d-b0ea-5aab326fbb9d`, em Edit, em 22/10/2026 (America/New_York).
- [CONFIRMADO NO CÓDIGO] Nove RemoteEvents atuais residem em `ReplicatedStorage.CumbiaParty.Remotes`; existem outras 63 instâncias em sete grupos de backup. O nome sozinho não identifica uma instância entre esses grupos.
- [NÃO ENCONTRADO] Nenhum RemoteFunction ou UnreliableRemoteEvent foi encontrado na enumeração do DataModel acessível.
- [CONFIRMADO NO CÓDIGO] Caminhos completos dos módulos, fluxo entre serviços, riscos e cleanup estão em [V1_DEPENDENCIES.md](V1_DEPENDENCIES.md). Referências `Módulo:linha` são posições do Source do Studio, não arquivos locais.
- [CONFIRMADO NO CÓDIGO] Este documento descreve o comportamento implementado; NetworkTypes é uma declaração parcial de tipos/comentários, não uma validação executável. Payloads abaixo são tabelas Luau; `?` indica campo opcional/condicional, e não garantia de que todos os handlers aceitam nil.
- [CONFIRMADO NO CÓDIGO] C→S significa cliente para servidor; S→C significa servidor para cliente. O argumento Player dos handlers é recebido pelo OnServerEvent; não é um userId escolhido pelo payload.
- [SUPOSIÇÃO] Observações de risco são hipóteses a testar. [NÃO ENCONTRADO] não significa ausência garantida fora do código e DataModel inspecionados.

## Matriz dos nove Remotes atuais

| Estado | Remote / direção | Quem dispara | Quem escuta / destino | O que envia | Servidor valida? |
|---|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | ClientReady C→S | ClientBootstrap ao terminar inicialização/espera por ServerReady | ServerBootstrap → Battle.SendSnapshot, Tournament.SendSnapshot, Arena.SendSnapshot | Sem argumentos no cliente atual | Cooldown 1 s por jogador; ignora argumentos extras; não passa por allow nem verifica protocolo. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote C→S | ClientBootstrap, usando UI.TryLane e UI.PollHolds | ServerBootstrap → Rhythm.Submit → NoteValidator | protocolVersion, sessionId, noteId, lane, inputTime, action? | Sim: rate limit, formato, tempo, dono/estado da sessão, nota/coluna, ordem, duplicação e hold; detalhes abaixo. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl C→S | ClientBootstrap: botões, cancelamentos, encerramento do script | ServerBootstrap → Rhythm/Battle; consulta Competitor | action e IDs/alvo conforme ação | Sim, por ação; tipo table, allow, cooldown seletivo e validações dos serviços. Não exige protocolVersion. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest C→S | ClientBootstrap via callback do TournamentController; ArenaController para Withdraw na introdução | ServerBootstrap → Tournament; ExitView pode chamar Lobby.Return | `{action}` | Sim: table, allow, cooldown 0,35 s, ações conhecidas e regras de participação; não exige protocolo. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest C→S | LobbyController após eliminação/fim/cancelamento do torneio | LobbyService.Init → Return/reposition | `{action="Return", preserveView=true}` no emissor atual | Sim: table/ação, cooldown 0,5 s, reserva/atividade, área, personagem, marcador/suporte; preserveView convertido por `==true`. |
| [CONFIRMADO NO CÓDIGO] | BattleState S→C | RhythmService e BattleService (transportes padrão) | ClientBootstrap → Arena.OnBattleSnapshot → UI.Render/Input/TournamentController | Estado Solo/Invite/Combat, sessão/chart/stats/combat condicionais | Saída construída no servidor; não há OnServerEvent para esse Remote no código atual inspecionado. |
| [CONFIRMADO NO CÓDIGO] | NoteResult S→C | RhythmService | ClientBootstrap → UI.NoteResult | Rejeição, confirmação Holding ou julgamento final/stats | Saída calculada no servidor; não há handler C→S encontrado. |
| [CONFIRMADO NO CÓDIGO] | TournamentState S→C | TournamentService; ServerBootstrap acrescenta error em falha de pedido | ClientBootstrap → TournamentController e LobbyController diretamente | protocolo, queue, tournament?, error? | Estado gerado no servidor; não há handler C→S encontrado. |
| [CONFIRMADO NO CÓDIGO] | LobbyState S→C | LobbyService e ArenaService | LobbyController e ArenaController | OpenTournament, Returned, ArenaAssigned ou ArenaReleased | Dados de navegação/reserva produzidos no servidor; não há handler C→S encontrado. |

## Limites transversais e identidade

- [CONFIRMADO NO CÓDIGO] `ServerBootstrap.allow` usa os.clock e contador por UserId em janela fixa de 1 s; aceita até 80 eventos, compartilhados por SubmitNote, RhythmControl e TournamentRequest. Requisições inválidas nessas rotas também podem consumir contador (ServerBootstrap:20).
- [CONFIRMADO NO CÓDIGO] ClientReady tem mapa/cooldown independente de 1 s; LobbyRequest usa requestTimes independente de 0,5 s. PlayerRemoving limpa esses mapas nos respectivos módulos.
- [CONFIRMADO NO CÓDIGO] Somente SubmitNote exige protocolVersion=3 na entrada. Ações dos demais requests não usam o campo de versão.
- [CONFIRMADO NO CÓDIGO] Validadores não rejeitam todos os campos desconhecidos nem impõem orçamento de bytes/quantidade de chaves de payload; os handlers leem os campos de interesse.
- [SUPOSIÇÃO] Rate limit por evento não representa proteção completa contra custo agregado, tabelas grandes ou automação de entradas. Rajadas na fronteira de janelas fixas e muitos clientes precisam de teste de carga.
- [CONFIRMADO NO CÓDIGO] CompetitorService usa número UserId para humanos e string opaca para bots; a apresentação pública inclui id/name/appearance. SubmitServerInput não é Remote e rejeita humanos ou competidor não registrado.

## ClientReady

- [CONFIRMADO NO CÓDIGO] Cliente chama `FireServer()` sem payload (ClientBootstrap:122); servidor aplica cooldown e envia snapshot de batalha/ritmo, torneio e eventual arena (ServerBootstrap:26).
- [CONFIRMADO NO CÓDIGO] Battle.SendSnapshot usa batalha, convite ou resultado recente; sem isso cai em Rhythm.SendSnapshot. Arena.SendSnapshot só envia se o jogador ainda tiver atribuição registrada.
- [CONFIRMADO NO CÓDIGO] Não há ACK próprio; as respostas chegam nos três Remotes de estado. O cliente espera ServerReady por até dez segundos, mas envia ClientReady mesmo se a espera atingir o prazo.
- [SUPOSIÇÃO] Reenvios permitidos podem reconstruir snapshots completos; o cooldown limita a frequência por jogador, não o tamanho da resposta.

## SubmitNote

| Estado | Campo | Contrato efetivo |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | protocolVersion | Igual a 3. |
| [CONFIRMADO NO CÓDIGO] | sessionId / noteId | Strings não vazias, no máximo 64; sessão deve pertencer ao Player do evento e estar Playing; nota deve existir em byId. |
| [CONFIRMADO NO CÓDIGO] | lane | Número finito inteiro de 1 a 4 e igual à coluna da nota do servidor. |
| [CONFIRMADO NO CÓDIGO] | inputTime | Número finito, segundos do relógio sincronizado no cliente atual (`workspace:GetServerTimeNow()`); servidor compara com recebimento/ping e usa no julgamento. |
| [CONFIRMADO NO CÓDIGO] | action? | Begin, End ou HoldPulse; ausência equivale a Begin. |

- [CONFIRMADO NO CÓDIGO] Emissores: ClientBootstrap:66/100; construção: UIController:217. Validação: NoteValidator.ValidateRequest/ValidateTime e RhythmService:89.
- [CONFIRMADO NO CÓDIGO] Humanos: `inputTime <= received + 0,035` e `received - inputTime <= clamp(ping + 0,075, 0,075, 0,250)`. Begin exige recebimento dentro de `[expected - 0,175, expected + 0,390]`, onde `expected=startTime+note.time`.
- [CONFIRMADO NO CÓDIGO] Begin exige ordem global não decrescente e intervalo mínimo de 0,045 s por coluna. JudgeTiming compara inputTime com expected: Perfect até 0,045 s, Great até 0,090 s, Good até 0,140 s, com epsilon 1e-6. Miss por entrada é rejeitado; ausência/atraso é julgada por Update.
- [CONFIRMADO NO CÓDIGO] Nota já julgada gera AlreadyJudged. Hold já iniciado rejeita Begin repetido. End/HoldPulse exigem hold existente e inputTime não anterior a pressTime/lastInput; pulso deve ter recebido atualização há no máximo 0,40+0,25 s.
- [CONFIRMADO NO CÓDIGO] HoldPulse atualiza lastPulse e completion sem resposta por pulso. End antes de `ending-0,035` gera BrokenHold; caso contrário usa PerfectHold se início Perfect, senão GoodHold. Update quebra hold por pulso vencido ou prazo final excedido.
- [CONFIRMADO NO CÓDIGO] Não entram no cálculo campos de cliente como score, combo, grade, HP, damage, winner ou reward. Adicioná-los à tabela não os torna autoritativos.
- [CONFIRMADO NO CÓDIGO] Rejeições de validação retornam NoteResult com accepted=false; rejeição pelo rate limit é silenciosa. HoldTimeout chama judge com BrokenHold, portanto pode gerar resultado final accepted=true embora submit retorne false internamente.
- [SUPOSIÇÃO] Timestamp validado continua sendo uma alegação do cliente: tempo ideal forjado dentro das tolerâncias pode melhorar a nota, e pulsos sintéticos não comprovam tecla mantida. Ver R1 em V1_DEPENDENCIES.

## RhythmControl

| Estado | action / campos | Validação e efeito |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | Start | Após cooldown 1 s: se Battle.IsBusy ou !Competitors.CanUse, envia snapshots; senão limpa resultado antigo e Rhythm.Start exige Humanoid vivo e nenhuma sessão ativa. |
| [CONFIRMADO NO CÓDIGO] | Cancel + battleId:string | Antes do cooldown de Start: Battle.Forfeit só aceita a batalha em members do próprio jogador e battleId correspondente. |
| [CONFIRMADO NO CÓDIGO] | Cancel + sessionId:string | Só quando battleId não é string e Battle.IsBusy é falso; Rhythm.Cancel exige sessão própria Playing e ID correspondente. |
| [CONFIRMADO NO CÓDIGO] | CancelInvite | Antes do cooldown de Start: cancela convite de entrada/saída do próprio jogador. |
| [CONFIRMADO NO CÓDIGO] | Invite + targetUserId:number | Cooldown 1 s; alvo numérico inteiro, não NaN, diferente de si, encontrado, vivo/disponível; ambos sem reserva incompatível, batalha/convite ou ritmo ativo. |
| [CONFIRMADO NO CÓDIGO] | Accept / Decline + inviteId:string | Cooldown 1 s; exige convite endereçado ao jogador com esse ID; Accept exige não expirado, remetente existente e ambos vivos; CreateSession revalida disponibilidade/reservas. |

- [CONFIRMADO NO CÓDIGO] Todos exigem tabela e allow. Ação desconhecida, exceto retornos prévios, pode consumir o cooldown de Start antes de ser ignorada; IDs de controle são checados por tipo/equivalência, sem o limite de 64 aplicado por NoteValidator (ServerBootstrap:31; BattleService:160,171,183).
- [CONFIRMADO NO CÓDIGO] Não existe ACK padronizado para esse Remote; alguns caminhos enviam BattleState, outros retornam silenciosamente. O pending local do cliente expira após 1,1 s e é limpo por BattleState.

## TournamentRequest

| Estado | action | Validação / resposta |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | Join | Humano conectado/disponível, não inscrito, sem reserva incompatível/batalha/ritmo, fila menor que 8; reserva vaga. Erros: Unavailable, AlreadyJoined, Busy, QueueFull. |
| [CONFIRMADO NO CÓDIGO] | LeaveQueue | Remove somente o próprio ID da fila e libera owner TournamentQueue. Bootstrap ignora o boolean retornado e envia snapshot. |
| [CONFIRMADO NO CÓDIGO] | ExitView | Rejeita com StillCompeting se ainda membro; senão remove watching e envia snapshot; bootstrap tenta Lobby.Return, sem propagar falha desse retorno. |
| [CONFIRMADO NO CÓDIGO] | Withdraw | Remove da fila; se membro marca withdrawn/eliminated, chama Battle.Forfeit e libera reserva humana; motivo vindo do bootstrap é Forfeit. |
| [CONFIRMADO NO CÓDIGO] | Snapshot | Envia snapshot do próprio jogador, sem entrar na fila nem iniciar partida. |

- [CONFIRMADO NO CÓDIGO] Servidor aceita somente table + action reconhecida, allow e cooldown 0,35 s; cooldown é consumido antes da verificação de ação. Não aceita escolha de campeão, seed, adversário, arena, precisão de bot ou resultado (ServerBootstrap:53; TournamentService:220).
- [CONFIRMADO NO CÓDIGO] Em falha de Join/ExitView, bootstrap acrescenta error ao snapshot e envia TournamentState. Em sucesso envia snapshot; métodos como Join também fazem broadcast, podendo haver snapshots redundantes.

## LobbyRequest

- [CONFIRMADO NO CÓDIGO] Payload aceito é `{action="Return", preserveView?: any}`; preserveView chega à reposição apenas como boolean `msg.preserveView==true`. O emissor atual envia true (LobbyController:26; LobbyService:99).
- [CONFIRMADO NO CÓDIGO] Return rejeita Battle.IsBusy, Rhythm.IsActive, Tournament.IsReserved ou área diferente de Lobby. Reposition exige personagem/root/Humanoid vivo, bindings e marcador válido, dentro dos limites e com suporte físico adequado (LobbyService:46,64).
- [CONFIRMADO NO CÓDIGO] Cliente não fornece destino, CFrame, área ou marcador. Sucesso envia LobbyState Returned; recusa não possui erro/ACK próprio. Cooldown de 0,5 s é separado do allow do bootstrap.

## BattleState

| Estado | Variante / campos | Conteúdo e condições |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | Envelope | protocolVersion=3, minigameId="CumbiaTiles", userId, phase, mode. Idle pode ter reason. |
| [CONFIRMADO NO CÓDIGO] | Solo / sessão Rhythm | sessionId, startTime, chartId, chart, stats, revision, judged, reason?; phase Playing/Finished/Cancelled. Idle sem sessão não tem esses campos. |
| [CONFIRMADO NO CÓDIGO] | Invite | mode=Invite, phase=Invited ou Inviting, invite={id,senderUserId,targetUserId,senderName,expiresAt}. |
| [CONFIRMADO NO CÓDIGO] | Combat | mode=Combat, battleId, combat; jogador ativo recebe snapshot Rhythm com chart; demais recebem Waiting ou Finished e stats da sessão correspondente, ou stats zeradas. |
| [CONFIRMADO NO CÓDIGO] | combat | battleId,wave,activeUserId?,players,deadline,winnerUserId?,winnerId?,tournamentId?,performance?,draw?,reason?,stage,accelerated,totals. Campos nil são ausentes. |
| [CONFIRMADO NO CÓDIGO] | combat.players[] | id,name,appearance={color,style},hp,maxHP; userId só para ID numérico. |
| [CONFIRMADO NO CÓDIGO] | combat.performance / totals | performance={id,name,grade,combo} do julgamento recente; totals por competidor contém notes e quality. |
| [CONFIRMADO NO CÓDIGO] | chart / notes | Chart gerado/configurado: id,title,bpm,duration,notes,accelerated?; nota: id,time,lane,duration?. |
| [CONFIRMADO NO CÓDIGO] | stats / judged | stats: score,combo,maxCombo,Perfect,Great,Good,Miss,PerfectHold,GoodHold,BrokenHold; judged mapeia noteId→grade. |

- [CONFIRMADO NO CÓDIGO] Produtores: RhythmService.snapshot/SendSnapshot e BattleService.state/meta/GetSnapshot/broadcast. Transporte padrão usa FireClient; bots não recebem mensagens.
- [CONFIRMADO NO CÓDIGO] Cliente passa por Arena.OnBattleSnapshot; Playing/Waiting exigem protocolo, userId local e minigameId antes de UI.Render/Input.Start. Estados não bloqueados não passam por esse mesmo assert (ClientBootstrap:73).
- [CONFIRMADO NO CÓDIGO] UI.Render aplica stats conforme revision e consome judged; a chart só vai para o participante ativo durante combate, não para o oponente Waiting.
- [CONFIRMADO NO CÓDIGO] `activeUserId` pode ser string de bot; `winnerId` aceita ID opaco e `winnerUserId` só aparece para humano. NetworkTypes descreve menos campos que a implementação atual.
- [CONFIRMADO NO CÓDIGO] WaveGenerator.chart usa `string.format("wave-%d-%d-%s",seed,wave,suffix)`; portanto chart.id de combate inclui a seed da batalha, embora o comentário em NetworkTypes diga que a apresentação não contém seed.
- [SUPOSIÇÃO] O identificador permite inferir essa seed ao participante que recebe o chart; o comentário não deve ser interpretado como sigilo garantido do PRNG. Isso não concede escrita de score/vencedor, mas merece revisão se imprevisibilidade for requisito.

## NoteResult

| Estado | Variante | Payload |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | Rejeição | `{accepted=false,reason,sessionId?,noteId?}`; IDs só são incluídos se ValidateRequest já tiver aprovado o formato. |
| [CONFIRMADO NO CÓDIGO] | Hold iniciado | `{accepted=true,reason="Holding",sessionId,noteId,startGrade}`; sem stats/revision de julgamento final. |
| [CONFIRMADO NO CÓDIGO] | Julgamento final | `{accepted=true,reason="Judged",sessionId,noteId,grade,completion,revision,stats}`; nota normal completion=1; hold pode ter fração/zero. |

- [CONFIRMADO NO CÓDIGO] Motivos de rejeição enviados: InvalidPayload, InvalidProtocol, InvalidId, InvalidLane, InvalidAction, InvalidTime, InvalidSession, InvalidNote, AlreadyJudged, NotHolding, OutOfOrder, AlreadyHolding, TooFast, OutsideWindow; FutureServerInput pertence ao caminho interno de bots, não a uma entrada humana aceita por Remote.
- [CONFIRMADO NO CÓDIGO] HumanOnly/ServerOnly são retornos internos antes do submit; HoldTimeout faz julgamento BrokenHold e retorna motivo internamente, sem enviar uma rejeição de nome HoldTimeout. Rate limit não gera NoteResult.
- [CONFIRMADO NO CÓDIGO] Não há protocolVersion nessa saída. UI.NoteResult ignora sessionId diferente, trata Holding como confirmação sem stats e só atualiza stats se revision aumentar; grades possíveis são Perfect/Great/Good/Miss/PerfectHold/GoodHold/BrokenHold (RhythmService:38,89; UIController:260).
- [CONFIRMADO NO CÓDIGO] Rejeição sem sessionId válido é descartada pelo filtro de sessão da UI atual; não há apresentação garantida do erro ao usuário.
- [SUPOSIÇÃO] Revision e judged ajudam a evitar aplicação repetida, mas replay, mensagens atrasadas e transições entre sessões precisam de teste dinâmico.

## TournamentState

| Estado | Campo | Estrutura |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | protocolVersion | 3. |
| [CONFIRMADO NO CÓDIGO] | queue | `{count,total,deadline?,joined,capacityAvailable}`; count é humanos na fila, total=8. capacityAvailable combina MaxConcurrent com disponibilidade física quando há adaptador. |
| [CONFIRMADO NO CÓDIGO] | tournament? | `{id,status,round,participants,matches,champion?,myId,eliminated,reason?,canExit}`; somente torneio em members ou watching daquele jogador. |
| [CONFIRMADO NO CÓDIGO] | participants[] | `{id,name,appearance,eliminated}`; não inclui difficulty/seed/kind do competidor. |
| [CONFIRMADO NO CÓDIGO] | matches[] | `{round,slot,a,b,status,winner?,reason?}`; não expõe seed/tieWinner antes do resultado nem IDs internos de battle/match nessa lista. |
| [CONFIRMADO NO CÓDIGO] | error? | Adicionado pelo ServerBootstrap quando Join/ExitView falha; enum de motivos descrito em TournamentRequest. |

- [CONFIRMADO NO CÓDIGO] TournamentService.GetSnapshot/view/broadcast produzem esse estado; todos os humanos recebem snapshots em broadcasts, cada um com sua visão de torneio.
- [CONFIRMADO NO CÓDIGO] ClientBootstrap confere protocolVersion antes de TournamentController.Render. LobbyController também escuta diretamente e não faz essa conferência; usa estado para pedir Return uma vez por t.id.
- [CONFIRMADO NO CÓDIGO] Não há revisão monotônica ou requestId nesse envelope. Conclusão/campeão vêm do servidor; campos não têm rota C→S correspondente.

## LobbyState

| Estado | action | Campos / origem / receptor |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | OpenTournament | `{action}` de terminal do LobbyService; LobbyController abre interface. Triggered valida distância ao personagem e ocupação/ritmo; não inscreve na fila. |
| [CONFIRMADO NO CÓDIGO] | Returned | `{action,preserveView:boolean,reason}` de LobbyService.reposition; reason Navigation ou FallRecovery; LobbyController ajusta menu/câmera. |
| [CONFIRMADO NO CÓDIGO] | ArenaAssigned | `{action,matchId,arenaId,tournamentId,battleId?,camera:CFrame,deadline,presentation?}` de Arena.assignment; ArenaController controla câmera/introdução. |
| [CONFIRMADO NO CÓDIGO] | presentation | `{startAt,endsAt,round,arenaId,players,shots}`; players usa CompetitorPresentation; shots contém Logo,CompetitorA,CompetitorB,Versus,Gameplay como CFrames. |
| [CONFIRMADO NO CÓDIGO] | ArenaReleased | `{action,matchId}` de Arena.clearHuman; ArenaController restaura apenas quando coincide com atribuição atual. |

- [CONFIRMADO NO CÓDIGO] Envelope sem protocolVersion/revision. ArenaAssigned exige no cliente matchId string, camera CFrame e deadline number; não há validação estrutural completa de presentation no ponto de entrada (ArenaController:42).
- [CONFIRMADO NO CÓDIGO] Servidor gera startAt/endsAt/deadline, verifica reserva, disponibilidade física/suporte e IsPresentationReady. Não existe ACK do cliente para começar/estender apresentação ou reivindicar arena (ArenaService:84,137,147,154).
- [CONFIRMADO NO CÓDIGO] Após BindBattle, ArenaAssigned é enviado novamente com battleId; ClientReady pode reenviar atribuição existente. Relógio original é preservado.

## Cópias preservadas: cobertura dos outros 63 Remotes

- [CONFIRMADO NO CÓDIGO] Cada prefixo abaixo contém exatamente os nove nomes da matriz principal, todos RemoteEvent; cada instância é identificada por `<prefixo>.<nome>`.

| Estado | Prefixo completo | Nomes encontrados |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes` | ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes` | ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes` | ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes` | ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes` | ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes` | ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes` | ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState |

| Estado | Aplicação a cada uma das 63 instâncias preservadas | Resultado da análise |
|---|---|---|
| [NÃO ENCONTRADO] | Quem dispara / escuta na implementação atual | Não foi encontrada referência a esses caminhos nos bootstraps/serviços/controllers atuais lidos; suas referências de rede usam ReplicatedStorage.CumbiaParty.Remotes. |
| [NÃO ENCONTRADO] | Payload efetivo / validação do servidor da cópia | Não determinado por inspeção histórica integral nesta tarefa; não é correto herdar o contrato atual só pelo nome. |
| [SUPOSIÇÃO] | Finalidade nominal | Mesma intenção nominal do Remote homônimo na matriz principal, conforme inventário; eventual restauração requer nova verificação de scripts, bindings e versão. |

## Riscos e verificações pendentes

- [CONFIRMADO NO CÓDIGO] Conferência documental executada: seções para os nove Remotes, links locais resolvidos e conteúdo marcado com as categorias exigidas. Studio permaneceu em Edit ao final da coleta.
- [CONFIRMADO NO CÓDIGO] Existem guardas contra julgamento repetido por noteId, Finish repetido e consumo repetido de conclusão de torneio; pontuação/dano são internos. Ver R2 em V1_DEPENDENCIES para os pontos exatos de aplicação.
- [SUPOSIÇÃO] Riscos principais: inputTime forjado dentro da tolerância; custo de snapshots completos; falta de limite de tamanho de payload; IDs de seed embutidos em chart.id; versões/revisões não uniformes podem dificultar evolução do protocolo.
- [CONFIRMADO NO CÓDIGO] A implementação atual não depende dos bloqueios da interface para autorizar pontos, reserva ou vencedor; validações relevantes existem no servidor, com as lacunas descritas.
- [NÃO ENCONTRADO] Testes de protocolo/segurança NÃO EXECUTADOS: payloads inválidos/NaN/infinito/IDs longos, replay em outra sessão, spam, mensagens fora de ordem, timestamp ideal forjado, hold sem tecla, Finish duplicado e saída durante apresentação/julgamento.
- [NÃO ENCONTRADO] Não foram medidos bytes por mensagem, tráfego sob carga, tempo de processamento, memória ou comportamento em produção. Apenas análise estática e conferência documental foram realizadas.
