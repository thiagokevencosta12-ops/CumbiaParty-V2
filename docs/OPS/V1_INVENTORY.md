# Inventário V1 — Studio e pasta do projeto

## Escopo e critérios

- [CONFIRMADO NO CÓDIGO] Inspeção realizada em 22/10/2026 (America/New_York), no Studio conectado `CumbiaParty_V1_2026-10-22.rbxl`, ID `005c0210-6f57-4d6d-b0ea-5aab326fbb9d`, em modo Edit.
- [CONFIRMADO NO CÓDIGO] Pasta examinada: `C:\Users\Thiago-PC1\CumbiaParty-V2`.
- [CONFIRMADO NO CÓDIGO] A coleta usou listagem recursiva do DataModel, leitura de Source/propriedades e amostragem de Terrain; nenhum módulo do projeto foi requerido ou executado, nenhum Play foi iniciado, nenhum remote foi disparado e nenhum objeto foi criado/alterado.
- [CONFIRMADO NO CÓDIGO] Única escrita autorizada nesta tarefa: este arquivo. CURRENT_STATE.md não foi atualizado, por restrição específica do usuário.
- [SUPOSIÇÃO] “Responsabilidade aparente” descreve a finalidade inferida do código, das funções e dos comentários; não comprova funcionamento em execução.
- [CONFIRMADO NO CÓDIGO] Neste documento, [CONFIRMADO NO CÓDIGO] também identifica evidência direta de instâncias, propriedades e arquivos. [NÃO ENCONTRADO] é restrito ao escopo consultado, não uma afirmação sobre outros lugares ou produção.
- [CONFIRMADO NO CÓDIGO] Contagem no DataModel acessível: 177 LuaSourceContainers (156 ModuleScripts, 11 LocalScripts, 10 Scripts), 72 RemoteEvents e 5 ScreenGuis; inclui backups e interfaces internas do Studio.
- [CONFIRMADO NO CÓDIGO] Todos os 177 Source foram legíveis. A análise estática do inventário concentrou-se nos módulos prioritários, bootstraps e evidências extraídas; não é auditoria integral de todas as versões.
- [CONFIRMADO NO CÓDIGO] Há nomes/caminhos repetidos em algumas árvores preservadas; o caminho textual não garante unicidade de instância.

## Pasta do projeto

| Estado | Arquivo | Conteúdo observado |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `README.md` | Cabeçalho CumbiaParty-V2; 16 bytes. |
| [CONFIRMADO NO CÓDIGO] | `AGENTS.md` | Regras operacionais do projeto; 1076 bytes. |
| [CONFIRMADO NO CÓDIGO] | `.gitignore` | Exclusões para segredos, temporários e locks de Studio; 213 bytes. |
| [CONFIRMADO NO CÓDIGO] | `decisions/ADR-0001.md` | Vazio; 0 bytes. |
| [CONFIRMADO NO CÓDIGO] | `docs/OPS/BACKLOG.md` | Vazio; 0 bytes. |
| [CONFIRMADO NO CÓDIGO] | `docs/OPS/CURRENT_STATE.md` | Vazio; 0 bytes. |
| [CONFIRMADO NO CÓDIGO] | `docs/PRODUCT/GAME_DESIGN.md` | Vazio; 0 bytes. |
| [CONFIRMADO NO CÓDIGO] | `docs/PRODUCT/VISION.md` | Vazio; 0 bytes. |
| [CONFIRMADO NO CÓDIGO] | `docs/TECH/ARCHITECTURE.md` | Vazio; 0 bytes. |
| [CONFIRMADO NO CÓDIGO] | `docs/TECH/NETWORK_CONTRACTS.md` | Vazio; 0 bytes. |
| [CONFIRMADO NO CÓDIGO] | `src/.gitkeep` | Vazio; 0 bytes. |
| [CONFIRMADO NO CÓDIGO] | `tests/.gitkeep` | Vazio; 0 bytes. |

- [NÃO ENCONTRADO] Nenhum arquivo .lua/.luau, .rbxl/.rbxlx, modelo .rbxm/.rbxmx, mídia ou configuração Rojo foi encontrado na pasta de trabalho examinada; src e tests contêm somente .gitkeep.
- [CONFIRMADO NO CÓDIGO] A enumeração local incluiu arquivos ocultos; o conteúdo interno de .git não integra o inventário de assets.
- [CONFIRMADO NO CÓDIGO] O git status inicial já apresentava .gitignore, AGENTS.md, decisions/, docs/, src/ e tests/ como não rastreados.
- [NÃO ENCONTRADO] Não há espelho local dos scripts do Studio que permita comparar implementação local versus Studio.

## Módulos prioritários

| Estado | Módulo / evidência | Responsabilidade constatada |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | RhythmService — StartChart, Submit, SubmitServerInput, Update, judge | Sessões próprias por competidor; verifica sessão, nota, coluna, duplicação, ordem, intervalo e tempo. Calcula pontos/combo e holds no servidor; publica NoteResult/BattleState. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator — ValidateRequest, ValidateTime, JudgeTiming | Exige protocolo válido, IDs limitados, coluna inteira 1–4 e tempo finito; aceita Begin/End/HoldPulse e limita atraso pelo ping e configuração. |
| [CONFIRMADO NO CÓDIGO] | BattleService — CreateSession, startTurn, Finish | Dois competidores, ondas em turnos e HP; dano calculado a partir do callback de julgamento do servidor; encerramento por KO, limite ou indisponibilidade. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator — GeneratePair | PRNG por seed/onda; mesmos tempos e durações para ambos os charts, com coluna espelhada por 5 - lane; introduz holds, acordes e aceleração segundo GameConfig. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService — CreateServer, Find, Reserve, Release | Humanos usam UserId; bots são dados com ID textual, dificuldade, seed e aparência; reservas são controladas no servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService — Schedule, Update | Gera Begin/HoldPulse/End com erros e precisão por perfil; envia SubmitServerInput, sem atribuir diretamente pontos, HP ou vencedor. |
| [CONFIRMADO NO CÓDIGO] | TournamentService — Join, launch, startMatch, Update | Fila local, chave com oito participantes, preenchimento por bots, reservas, desistências e progressão; simulação bot-versus-bot com relógio próprio e orçamento de processamento. |

- [CONFIRMADO NO CÓDIGO] Fluxo observado: ServerBootstrap → RhythmService.Submit → NoteValidator → julgamento do RhythmService → callback de BattleService → conclusão consumida pelo TournamentService.
- [CONFIRMADO NO CÓDIGO] ServerBootstrap aplica limite de solicitações e cooldowns; LobbyRequest tem tratamento em LobbyService. A existência dessas verificações não substitui testes de segurança.
- [CONFIRMADO NO CÓDIGO] GameConfig define ProtocolVersion=3, quatro colunas, 100 HP iniciais e chart solo com 48 notas; torneio Size=8 e QueueSeconds=30.
- [CONFIRMADO NO CÓDIGO] WorldConfig usa ActiveProfileId="Underground"; também mantém o perfil Tropical.
- [CONFIRMADO NO CÓDIGO] TournamentService integra o adaptador ArenaService; partidas podem aguardar a apresentação antes da criação da sessão de batalha.
- [SUPOSIÇÃO] A arquitetura inspecionada busca manter notas, dano e resultados sob autoridade do servidor; não foi comprovada ausência de vulnerabilidades.

## Scripts e ModuleScripts — implementação atual e ferramentas

- [CONFIRMADO NO CÓDIGO] Cada linha abaixo confirma nome, classe, caminho e Disabled quando aplicável. A responsabilidade está separadamente marcada como inferência.
- [CONFIRMADO NO CÓDIGO] ModuleScripts não têm propriedade Disabled; sua presença não significa execução automática.
- [CONFIRMADO NO CÓDIGO] Objetos em ServerStorage estão listados como ferramentas/testes/preservação, não como componentes automaticamente ativos.

| Estado | Nome | Tipo | Local completo | Disabled | Responsabilidade aparente |
|---|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | UIController | ModuleScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController` | — | [SUPOSIÇÃO] Renderiza notas, feedback provisório e snapshots de pontuação; produz intenções de entrada. |
| [CONFIRMADO NO CÓDIGO] | InputController | ModuleScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController` | — | [SUPOSIÇÃO] Gerencia entradas por coluna e bloqueio temporário dos controles durante o ritmo. |
| [CONFIRMADO NO CÓDIGO] | CompetitorPortrait | ModuleScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait` | — | [SUPOSIÇÃO] Desenha retratos provisórios de competidores usando Frames. |
| [CONFIRMADO NO CÓDIGO] | TournamentController | ModuleScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.TournamentController` | — | [SUPOSIÇÃO] Apresenta fila, chave e navegação do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyController | ModuleScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.LobbyController` | — | [SUPOSIÇÃO] Apresenta navegação do lobby e estado da fila. |
| [CONFIRMADO NO CÓDIGO] | ArenaController | ModuleScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController` | — | [SUPOSIÇÃO] Controla câmera e apresentação sincronizada da arena física. |
| [CONFIRMADO NO CÓDIGO] | BattleHUD | ModuleScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD` | — | [SUPOSIÇÃO] Adapta o HUD existente à batalha e ao turno ativo. |
| [CONFIRMADO NO CÓDIGO] | BattlePresentationView | ModuleScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattlePresentationView` | — | [SUPOSIÇÃO] Renderiza a introdução visual dos competidores e contagem regressiva. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap` | false | [SUPOSIÇÃO] Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | CumbiaPartyFestivalFX | LocalScript | `StarterPlayer.StarterPlayerScripts.CumbiaPartyFestivalFX` | true | [SUPOSIÇÃO] Controla efeitos cosméticos locais e cria configurações visuais do festival. |
| [CONFIRMADO NO CÓDIGO] | GameConfig | ModuleScript | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` | — | [SUPOSIÇÃO] Define protocolo, pontuação, janelas de tempo, chart solo, combate e torneio. |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes | ModuleScript | `ReplicatedStorage.CumbiaParty.Shared.NetworkTypes` | — | [SUPOSIÇÃO] Declara tipos e documenta contratos dos eventos de rede. |
| [CONFIRMADO NO CÓDIGO] | WorldConfig | ModuleScript | `ReplicatedStorage.CumbiaParty.Shared.WorldConfig` | — | [SUPOSIÇÃO] Define perfis espaciais, spawn, áreas seguras, marcadores e arenas. |
| [CONFIRMADO NO CÓDIGO] | BattlePresentationConfig | ModuleScript | `ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig` | — | [SUPOSIÇÃO] Define duração, etapas e enquadramentos da apresentação. |
| [CONFIRMADO NO CÓDIGO] | RhythmService | ModuleScript | `ServerScriptService.CumbiaParty.Services.RhythmService` | — | [SUPOSIÇÃO] Mantém sessões, valida entradas e calcula julgamentos, holds, pontos e combos no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleService | ModuleScript | `ServerScriptService.CumbiaParty.Services.BattleService` | — | [SUPOSIÇÃO] Orquestra convites e duelos X1, turnos, HP, dano e encerramento. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator | ModuleScript | `ServerScriptService.CumbiaParty.Services.WaveGenerator` | — | [SUPOSIÇÃO] Gera pares determinísticos de charts com colunas espelhadas, holds e aceleração. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService | ModuleScript | `ServerScriptService.CumbiaParty.Services.CompetitorService` | — | [SUPOSIÇÃO] Mantém identidade, disponibilidade e reservas de humanos e competidores do servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService | ModuleScript | `ServerScriptService.CumbiaParty.Services.BotService` | — | [SUPOSIÇÃO] Agenda intenções de entrada dos bots e as envia ao motor RhythmService. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerScriptService.CumbiaParty.Services.TournamentService` | — | [SUPOSIÇÃO] Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | LobbyService | ModuleScript | `ServerScriptService.CumbiaParty.Services.LobbyService` | — | [SUPOSIÇÃO] Integra terminais, retorno, recuperação de quedas e RespawnLocation. |
| [CONFIRMADO NO CÓDIGO] | WorldBindings | ModuleScript | `ServerScriptService.CumbiaParty.Services.WorldBindings` | — | [SUPOSIÇÃO] Resolve e valida objetos espaciais, suporte, limites e complexo de arenas. |
| [CONFIRMADO NO CÓDIGO] | ArenaService | ModuleScript | `ServerScriptService.CumbiaParty.Services.ArenaService` | — | [SUPOSIÇÃO] Reserva arenas físicas, posiciona participantes e gerencia apresentações e liberação. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | ModuleScript | `ServerScriptService.CumbiaParty.Validation.NoteValidator` | — | [SUPOSIÇÃO] Valida payloads, IDs, colunas, ações e tempos; classifica precisão temporal. |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerScriptService.CumbiaParty.ServerBootstrap` | false | [SUPOSIÇÃO] Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | UnitTestRunner | Script | `ServerScriptService.UnitTestRunner` | true | [SUPOSIÇÃO] Ponto de entrada para o executor de testes; está desabilitado. |
| [CONFIRMADO NO CÓDIGO] | TournamentService_Test | ModuleScript | `ServerStorage.UnitTest.Cases.TournamentService_Test` | — | [SUPOSIÇÃO] Contém testes de TournamentService; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | BotService_Test | ModuleScript | `ServerStorage.UnitTest.Cases.BotService_Test` | — | [SUPOSIÇÃO] Contém testes de BotService; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | LobbyService_Test | ModuleScript | `ServerStorage.UnitTest.Cases.LobbyService_Test` | — | [SUPOSIÇÃO] Contém testes de LobbyService; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | WorldBindings_Test | ModuleScript | `ServerStorage.UnitTest.Cases.WorldBindings_Test` | — | [SUPOSIÇÃO] Contém testes de WorldBindings; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator_Test | ModuleScript | `ServerStorage.UnitTest.Cases.NoteValidator_Test` | — | [SUPOSIÇÃO] Contém testes de NoteValidator; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | UndergroundWorld_Test | ModuleScript | `ServerStorage.UnitTest.Cases.UndergroundWorld_Test` | — | [SUPOSIÇÃO] Contém testes de UndergroundWorld; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | ArenaService_Test | ModuleScript | `ServerStorage.UnitTest.Cases.ArenaService_Test` | — | [SUPOSIÇÃO] Contém testes de ArenaService; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | BattlePresentation_Test | ModuleScript | `ServerStorage.UnitTest.Cases.BattlePresentation_Test` | — | [SUPOSIÇÃO] Contém testes de BattlePresentation; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | RunUnitTest | ModuleScript | `ServerStorage.UnitTest.RunUnitTest` | — | [SUPOSIÇÃO] Descobre e executa manualmente casos de teste com funções de asserção. |
| [CONFIRMADO NO CÓDIGO] | PhaseATerrainPlan | ModuleScript | `ServerStorage.CumbiaPartyBuildTools.PhaseATerrainPlan` | — | [SUPOSIÇÃO] Ferramenta de autoria do relevo, costa, rotas e integração do terreno. |
| [CONFIRMADO NO CÓDIGO] | PhaseBEnvironmentPlan | ModuleScript | `ServerStorage.CumbiaPartyBuildTools.PhaseBEnvironmentPlan` | — | [SUPOSIÇÃO] Ferramenta de autoria da vegetação, arquitetura e acabamento ambiental. |
| [CONFIRMADO NO CÓDIGO] | PhaseCOceanPlan | ModuleScript | `ServerStorage.CumbiaPartyBuildTools.PhaseCOceanPlan` | — | [SUPOSIÇÃO] Ferramenta de autoria do oceano em setores com água nativa e fundo costeiro. |
| [CONFIRMADO NO CÓDIGO] | PhaseCRestore | ModuleScript | `ServerStorage.CumbiaPartyBuildTools.PhaseCRestore` | — | [SUPOSIÇÃO] Ferramenta de restauração manual da fase C. |
| [CONFIRMADO NO CÓDIGO] | PhaseDFestivalPlan | ModuleScript | `ServerStorage.CumbiaPartyBuildTools.PhaseDFestivalPlan` | — | [SUPOSIÇÃO] Ferramenta de autoria de decoração, iluminação e efeitos do festival. |
| [CONFIRMADO NO CÓDIGO] | PhaseDRestore | ModuleScript | `ServerStorage.CumbiaPartyBuildTools.PhaseDRestore` | — | [SUPOSIÇÃO] Ferramenta de restauração manual da fase D. |
| [CONFIRMADO NO CÓDIGO] | GreyboxBuilder | ModuleScript | `ServerStorage.GreyboxTools.GreyboxBuilder` | — | [SUPOSIÇÃO] Ferramenta de construção do greybox, setores, bindings e cercas. |
| [CONFIRMADO NO CÓDIGO] | GreyboxMigration | ModuleScript | `ServerStorage.GreyboxTools.GreyboxMigration` | — | [SUPOSIÇÃO] Ferramenta manual para preservar, ativar o greybox ou restaurar o cenário tropical. |

## Scripts e ModuleScripts — cópias preservadas

- [CONFIRMADO NO CÓDIGO] “Igual” compara literalmente Source com a implementação atual de mesmo nome, quando existente; não compara propriedades, dependências ou estado de execução.
- [SUPOSIÇÃO] A finalidade das versões divergentes é inferida pelo nome e contexto de preservação; não pressupõe equivalência funcional.

| Estado | Nome | Tipo | Local completo | Disabled | Source igual ao atual | Responsabilidade aparente |
|---|---|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.ServerBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | RhythmService | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.Services.RhythmService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém sessões, valida entradas e calcula julgamentos, holds, pontos e combos no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleService | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.Services.BattleService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Orquestra convites e duelos X1, turnos, HP, dano e encerramento. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.Services.WaveGenerator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gera pares determinísticos de charts com colunas espelhadas, holds e aceleração. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.Services.CompetitorService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém identidade, disponibilidade e reservas de humanos e competidores do servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.Services.BotService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Agenda intenções de entrada dos bots e as envia ao motor RhythmService. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.Services.TournamentService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | LobbyService | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.Services.LobbyService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Integra terminais, retorno, recuperação de quedas e RespawnLocation. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Server.Validation.NoteValidator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Valida payloads, IDs, colunas, ações e tempos; classifica precisão temporal. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Client.ClientBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | UIController | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Client.Controllers.UIController` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Renderiza notas, feedback provisório e snapshots de pontuação; produz intenções de entrada. |
| [CONFIRMADO NO CÓDIGO] | InputController | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Client.Controllers.InputController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gerencia entradas por coluna e bloqueio temporário dos controles durante o ritmo. |
| [CONFIRMADO NO CÓDIGO] | CompetitorPortrait | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Client.Controllers.CompetitorPortrait` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Desenha retratos provisórios de competidores usando Frames. |
| [CONFIRMADO NO CÓDIGO] | TournamentController | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Client.Controllers.TournamentController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta fila, chave e navegação do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyController | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.Client.Controllers.LobbyController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta navegação do lobby e estado da fila. |
| [CONFIRMADO NO CÓDIGO] | GameConfig | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Shared.GameConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define protocolo, pontuação, janelas de tempo, chart solo, combate e torneio. |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes | ModuleScript | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Shared.NetworkTypes` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Declara tipos e documenta contratos dos eventos de rede. |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.ServerBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | RhythmService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.Services.RhythmService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém sessões, valida entradas e calcula julgamentos, holds, pontos e combos no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.Services.BattleService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Orquestra convites e duelos X1, turnos, HP, dano e encerramento. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.Services.WaveGenerator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gera pares determinísticos de charts com colunas espelhadas, holds e aceleração. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.Services.CompetitorService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém identidade, disponibilidade e reservas de humanos e competidores do servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.Services.BotService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Agenda intenções de entrada dos bots e as envia ao motor RhythmService. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.Services.TournamentService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | LobbyService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.Services.LobbyService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Integra terminais, retorno, recuperação de quedas e RespawnLocation. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Server.Validation.NoteValidator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Valida payloads, IDs, colunas, ações e tempos; classifica precisão temporal. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Client.ClientBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | UIController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Client.Controllers.UIController` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Renderiza notas, feedback provisório e snapshots de pontuação; produz intenções de entrada. |
| [CONFIRMADO NO CÓDIGO] | InputController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Client.Controllers.InputController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gerencia entradas por coluna e bloqueio temporário dos controles durante o ritmo. |
| [CONFIRMADO NO CÓDIGO] | CompetitorPortrait | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Client.Controllers.CompetitorPortrait` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Desenha retratos provisórios de competidores usando Frames. |
| [CONFIRMADO NO CÓDIGO] | TournamentController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Client.Controllers.TournamentController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta fila, chave e navegação do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Client.Controllers.LobbyController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta navegação do lobby e estado da fila. |
| [CONFIRMADO NO CÓDIGO] | GameConfig | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Shared.GameConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define protocolo, pontuação, janelas de tempo, chart solo, combate e torneio. |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Shared.NetworkTypes` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Declara tipos e documenta contratos dos eventos de rede. |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.ServerBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | RhythmService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.Services.RhythmService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém sessões, valida entradas e calcula julgamentos, holds, pontos e combos no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.Services.BattleService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Orquestra convites e duelos X1, turnos, HP, dano e encerramento. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.Services.WaveGenerator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gera pares determinísticos de charts com colunas espelhadas, holds e aceleração. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.Services.CompetitorService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém identidade, disponibilidade e reservas de humanos e competidores do servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.Services.BotService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Agenda intenções de entrada dos bots e as envia ao motor RhythmService. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.Services.TournamentService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | LobbyService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.Services.LobbyService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Integra terminais, retorno, recuperação de quedas e RespawnLocation. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Server.Validation.NoteValidator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Valida payloads, IDs, colunas, ações e tempos; classifica precisão temporal. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Client.ClientBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | UIController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Client.Controllers.UIController` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Renderiza notas, feedback provisório e snapshots de pontuação; produz intenções de entrada. |
| [CONFIRMADO NO CÓDIGO] | InputController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Client.Controllers.InputController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gerencia entradas por coluna e bloqueio temporário dos controles durante o ritmo. |
| [CONFIRMADO NO CÓDIGO] | CompetitorPortrait | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Client.Controllers.CompetitorPortrait` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Desenha retratos provisórios de competidores usando Frames. |
| [CONFIRMADO NO CÓDIGO] | TournamentController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Client.Controllers.TournamentController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta fila, chave e navegação do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Client.Controllers.LobbyController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta navegação do lobby e estado da fila. |
| [CONFIRMADO NO CÓDIGO] | GameConfig | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Shared.GameConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define protocolo, pontuação, janelas de tempo, chart solo, combate e torneio. |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Shared.NetworkTypes` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Declara tipos e documenta contratos dos eventos de rede. |
| [CONFIRMADO NO CÓDIGO] | LobbyService_Test | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.TestCases.LobbyService_Test` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Contém testes de LobbyService; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | GameConfig | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Shared.GameConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define protocolo, pontuação, janelas de tempo, chart solo, combate e torneio. |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Shared.NetworkTypes` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Declara tipos e documenta contratos dos eventos de rede. |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.ServerBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | RhythmService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.Services.RhythmService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém sessões, valida entradas e calcula julgamentos, holds, pontos e combos no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.Services.BattleService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Orquestra convites e duelos X1, turnos, HP, dano e encerramento. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.Services.WaveGenerator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gera pares determinísticos de charts com colunas espelhadas, holds e aceleração. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.Services.CompetitorService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém identidade, disponibilidade e reservas de humanos e competidores do servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.Services.BotService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Agenda intenções de entrada dos bots e as envia ao motor RhythmService. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.Services.TournamentService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | LobbyService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.Services.LobbyService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Integra terminais, retorno, recuperação de quedas e RespawnLocation. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Server.Validation.NoteValidator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Valida payloads, IDs, colunas, ações e tempos; classifica precisão temporal. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Client.ClientBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | UIController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Client.Controllers.UIController` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Renderiza notas, feedback provisório e snapshots de pontuação; produz intenções de entrada. |
| [CONFIRMADO NO CÓDIGO] | InputController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Client.Controllers.InputController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gerencia entradas por coluna e bloqueio temporário dos controles durante o ritmo. |
| [CONFIRMADO NO CÓDIGO] | CompetitorPortrait | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Client.Controllers.CompetitorPortrait` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Desenha retratos provisórios de competidores usando Frames. |
| [CONFIRMADO NO CÓDIGO] | TournamentController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Client.Controllers.TournamentController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta fila, chave e navegação do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Client.Controllers.LobbyController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta navegação do lobby e estado da fila. |
| [CONFIRMADO NO CÓDIGO] | GameConfig | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Shared.GameConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define protocolo, pontuação, janelas de tempo, chart solo, combate e torneio. |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Shared.NetworkTypes` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Declara tipos e documenta contratos dos eventos de rede. |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.ServerBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | RhythmService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Services.RhythmService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém sessões, valida entradas e calcula julgamentos, holds, pontos e combos no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Services.BattleService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Orquestra convites e duelos X1, turnos, HP, dano e encerramento. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Services.WaveGenerator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gera pares determinísticos de charts com colunas espelhadas, holds e aceleração. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Services.CompetitorService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém identidade, disponibilidade e reservas de humanos e competidores do servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Services.BotService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Agenda intenções de entrada dos bots e as envia ao motor RhythmService. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Services.TournamentService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | LobbyService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Services.LobbyService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Integra terminais, retorno, recuperação de quedas e RespawnLocation. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Validation.NoteValidator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Valida payloads, IDs, colunas, ações e tempos; classifica precisão temporal. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.ClientBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | UIController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Controllers.UIController` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Renderiza notas, feedback provisório e snapshots de pontuação; produz intenções de entrada. |
| [CONFIRMADO NO CÓDIGO] | InputController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Controllers.InputController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gerencia entradas por coluna e bloqueio temporário dos controles durante o ritmo. |
| [CONFIRMADO NO CÓDIGO] | CompetitorPortrait | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Controllers.CompetitorPortrait` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Desenha retratos provisórios de competidores usando Frames. |
| [CONFIRMADO NO CÓDIGO] | TournamentController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Controllers.TournamentController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta fila, chave e navegação do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Controllers.LobbyController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta navegação do lobby e estado da fila. |
| [CONFIRMADO NO CÓDIGO] | GameConfig | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Shared.GameConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define protocolo, pontuação, janelas de tempo, chart solo, combate e torneio. |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Shared.NetworkTypes` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Declara tipos e documenta contratos dos eventos de rede. |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.ServerBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | RhythmService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Services.RhythmService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém sessões, valida entradas e calcula julgamentos, holds, pontos e combos no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Services.BattleService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Orquestra convites e duelos X1, turnos, HP, dano e encerramento. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Services.WaveGenerator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gera pares determinísticos de charts com colunas espelhadas, holds e aceleração. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Services.CompetitorService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém identidade, disponibilidade e reservas de humanos e competidores do servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Services.BotService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Agenda intenções de entrada dos bots e as envia ao motor RhythmService. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Services.TournamentService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | LobbyService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Services.LobbyService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Integra terminais, retorno, recuperação de quedas e RespawnLocation. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Validation.NoteValidator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Valida payloads, IDs, colunas, ações e tempos; classifica precisão temporal. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.ClientBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | UIController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Controllers.UIController` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Renderiza notas, feedback provisório e snapshots de pontuação; produz intenções de entrada. |
| [CONFIRMADO NO CÓDIGO] | InputController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Controllers.InputController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gerencia entradas por coluna e bloqueio temporário dos controles durante o ritmo. |
| [CONFIRMADO NO CÓDIGO] | CompetitorPortrait | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Controllers.CompetitorPortrait` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Desenha retratos provisórios de competidores usando Frames. |
| [CONFIRMADO NO CÓDIGO] | TournamentController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Controllers.TournamentController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta fila, chave e navegação do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Controllers.LobbyController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta navegação do lobby e estado da fila. |
| [CONFIRMADO NO CÓDIGO] | GameConfig | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Shared.GameConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define protocolo, pontuação, janelas de tempo, chart solo, combate e torneio. |
| [CONFIRMADO NO CÓDIGO] | NetworkTypes | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Shared.NetworkTypes` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Declara tipos e documenta contratos dos eventos de rede. |
| [CONFIRMADO NO CÓDIGO] | RhythmService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.Services.RhythmService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém sessões, valida entradas e calcula julgamentos, holds, pontos e combos no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.Services.BattleService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Orquestra convites e duelos X1, turnos, HP, dano e encerramento. |
| [CONFIRMADO NO CÓDIGO] | WaveGenerator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.Services.WaveGenerator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gera pares determinísticos de charts com colunas espelhadas, holds e aceleração. |
| [CONFIRMADO NO CÓDIGO] | CompetitorService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.Services.CompetitorService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Mantém identidade, disponibilidade e reservas de humanos e competidores do servidor. |
| [CONFIRMADO NO CÓDIGO] | BotService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.Services.BotService` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Agenda intenções de entrada dos bots e as envia ao motor RhythmService. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.Services.TournamentService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | LobbyService | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.Services.LobbyService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Integra terminais, retorno, recuperação de quedas e RespawnLocation. |
| [CONFIRMADO NO CÓDIGO] | NoteValidator | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.Validation.NoteValidator` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Valida payloads, IDs, colunas, ações e tempos; classifica precisão temporal. |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Server.ServerBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | UIController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Client.Controllers.UIController` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Renderiza notas, feedback provisório e snapshots de pontuação; produz intenções de entrada. |
| [CONFIRMADO NO CÓDIGO] | InputController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Client.Controllers.InputController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Gerencia entradas por coluna e bloqueio temporário dos controles durante o ritmo. |
| [CONFIRMADO NO CÓDIGO] | CompetitorPortrait | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Client.Controllers.CompetitorPortrait` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Desenha retratos provisórios de competidores usando Frames. |
| [CONFIRMADO NO CÓDIGO] | TournamentController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Client.Controllers.TournamentController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta fila, chave e navegação do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyController | ModuleScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Client.Controllers.LobbyController` | — | Sim | [SUPOSIÇÃO] Cópia preservada: Apresenta navegação do lobby e estado da fila. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.Client.ClientBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | CumbiaPartyFestivalFX | LocalScript | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.CumbiaPartyFestivalFX` | false | Sim | [SUPOSIÇÃO] Cópia preservada: Controla efeitos cosméticos locais e cria configurações visuais do festival. |
| [CONFIRMADO NO CÓDIGO] | WorldConfig | ModuleScript | `ServerStorage.Phase1BPreservation.WorldConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define perfis espaciais, spawn, áreas seguras, marcadores e arenas. |
| [CONFIRMADO NO CÓDIGO] | GreyboxBuilder | ModuleScript | `ServerStorage.Phase1BPreservation.GreyboxBuilder` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Ferramenta de construção do greybox, setores, bindings e cercas. |
| [CONFIRMADO NO CÓDIGO] | UndergroundWorld_Test | ModuleScript | `ServerStorage.Phase1BPreservation.UndergroundWorld_Test` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Contém testes de UndergroundWorld; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | WorldConfig | ModuleScript | `ServerStorage.Phase1BWestPreservation.WorldConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define perfis espaciais, spawn, áreas seguras, marcadores e arenas. |
| [CONFIRMADO NO CÓDIGO] | GreyboxBuilder | ModuleScript | `ServerStorage.Phase1BWestPreservation.GreyboxBuilder` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Ferramenta de construção do greybox, setores, bindings e cercas. |
| [CONFIRMADO NO CÓDIGO] | UndergroundWorld_Test | ModuleScript | `ServerStorage.Phase1BWestPreservation.UndergroundWorld_Test` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Contém testes de UndergroundWorld; não executados neste inventário. |
| [CONFIRMADO NO CÓDIGO] | GreyboxBuilder | ModuleScript | `ServerStorage.Phase1BFencePreservation.GreyboxBuilder` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Ferramenta de construção do greybox, setores, bindings e cercas. |
| [CONFIRMADO NO CÓDIGO] | WorldConfig | ModuleScript | `ServerStorage.Phase2Preservation.WorldConfig` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Define perfis espaciais, spawn, áreas seguras, marcadores e arenas. |
| [CONFIRMADO NO CÓDIGO] | WorldBindings | ModuleScript | `ServerStorage.Phase2Preservation.WorldBindings` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Resolve e valida objetos espaciais, suporte, limites e complexo de arenas. |
| [CONFIRMADO NO CÓDIGO] | TournamentService | ModuleScript | `ServerStorage.Phase2Preservation.TournamentService` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Administra fila, chave eliminatória, preenchimento por bots e progressão das partidas. |
| [CONFIRMADO NO CÓDIGO] | ServerBootstrap | Script | `ServerStorage.Phase2Preservation.ServerBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Inicializa serviços, conecta remotes, aplica limites de requisição e coordena atualizações no servidor. |
| [CONFIRMADO NO CÓDIGO] | ClientBootstrap | LocalScript | `ServerStorage.Phase2Preservation.ClientBootstrap` | false | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Conecta UI, controles e eventos do servidor; encaminha entradas e cancelamentos. |
| [CONFIRMADO NO CÓDIGO] | UndergroundWorld_Test | ModuleScript | `ServerStorage.Phase2Preservation.UndergroundWorld_Test` | — | Não / sem correspondente atual | [SUPOSIÇÃO] Cópia preservada: Contém testes de UndergroundWorld; não executados neste inventário. |

## RemoteEvents e RemoteFunctions

- [CONFIRMADO NO CÓDIGO] Existem 9 RemoteEvents em ReplicatedStorage.CumbiaParty.Remotes e 63 cópias em sete grupos de backup.
- [NÃO ENCONTRADO] Nenhum RemoteFunction ou UnreliableRemoteEvent encontrado no DataModel acessível.
- [CONFIRMADO NO CÓDIGO] Contratos abaixo verificados em NetworkTypes, bootstraps e serviços; para backups, descrevem a finalidade nominal, sem garantir igualdade de protocolo.

| Estado | Nome | Tipo | Local completo | Contrato / finalidade |
|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | ClientReady | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.ClientReady` | C→S: solicita snapshots iniciais. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.SubmitNote` | C→S: intenção de entrada de nota/hold. |
| [CONFIRMADO NO CÓDIGO] | BattleState | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.BattleState` | S→C: snapshot de solo, convite ou combate. |
| [CONFIRMADO NO CÓDIGO] | NoteResult | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.NoteResult` | S→C: reconhecimento de hold ou julgamento e estatísticas. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.RhythmControl` | C→S: iniciar/cancelar solo, convidar, aceitar/recusar ou abandonar X1. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.TournamentRequest` | C→S: Join, LeaveQueue, ExitView, Withdraw e Snapshot. |
| [CONFIRMADO NO CÓDIGO] | TournamentState | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.TournamentState` | S→C: fila e chave do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.LobbyRequest` | C→S: Return. |
| [CONFIRMADO NO CÓDIGO] | LobbyState | RemoteEvent | `ReplicatedStorage.CumbiaParty.Remotes.LobbyState` | S→C: abertura do torneio, retorno e atribuição/liberação de arena. |
| [CONFIRMADO NO CÓDIGO] | ClientReady | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.ClientReady` | [SUPOSIÇÃO] Cópia preservada; C→S: solicita snapshots iniciais. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.SubmitNote` | [SUPOSIÇÃO] Cópia preservada; C→S: intenção de entrada de nota/hold. |
| [CONFIRMADO NO CÓDIGO] | BattleState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.BattleState` | [SUPOSIÇÃO] Cópia preservada; S→C: snapshot de solo, convite ou combate. |
| [CONFIRMADO NO CÓDIGO] | NoteResult | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.NoteResult` | [SUPOSIÇÃO] Cópia preservada; S→C: reconhecimento de hold ou julgamento e estatísticas. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.RhythmControl` | [SUPOSIÇÃO] Cópia preservada; C→S: iniciar/cancelar solo, convidar, aceitar/recusar ou abandonar X1. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.TournamentRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Join, LeaveQueue, ExitView, Withdraw e Snapshot. |
| [CONFIRMADO NO CÓDIGO] | TournamentState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.TournamentState` | [SUPOSIÇÃO] Cópia preservada; S→C: fila e chave do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.LobbyRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Return. |
| [CONFIRMADO NO CÓDIGO] | LobbyState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Scripts.SharedAndRemotes.Remotes.LobbyState` | [SUPOSIÇÃO] Cópia preservada; S→C: abertura do torneio, retorno e atribuição/liberação de arena. |
| [CONFIRMADO NO CÓDIGO] | ClientReady | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.ClientReady` | [SUPOSIÇÃO] Cópia preservada; C→S: solicita snapshots iniciais. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.SubmitNote` | [SUPOSIÇÃO] Cópia preservada; C→S: intenção de entrada de nota/hold. |
| [CONFIRMADO NO CÓDIGO] | BattleState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.BattleState` | [SUPOSIÇÃO] Cópia preservada; S→C: snapshot de solo, convite ou combate. |
| [CONFIRMADO NO CÓDIGO] | NoteResult | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.NoteResult` | [SUPOSIÇÃO] Cópia preservada; S→C: reconhecimento de hold ou julgamento e estatísticas. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.RhythmControl` | [SUPOSIÇÃO] Cópia preservada; C→S: iniciar/cancelar solo, convidar, aceitar/recusar ou abandonar X1. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.TournamentRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Join, LeaveQueue, ExitView, Withdraw e Snapshot. |
| [CONFIRMADO NO CÓDIGO] | TournamentState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.TournamentState` | [SUPOSIÇÃO] Cópia preservada; S→C: fila e chave do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.LobbyRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Return. |
| [CONFIRMADO NO CÓDIGO] | LobbyState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.Sources.Shared.Remotes.LobbyState` | [SUPOSIÇÃO] Cópia preservada; S→C: abertura do torneio, retorno e atribuição/liberação de arena. |
| [CONFIRMADO NO CÓDIGO] | ClientReady | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.ClientReady` | [SUPOSIÇÃO] Cópia preservada; C→S: solicita snapshots iniciais. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.SubmitNote` | [SUPOSIÇÃO] Cópia preservada; C→S: intenção de entrada de nota/hold. |
| [CONFIRMADO NO CÓDIGO] | BattleState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.BattleState` | [SUPOSIÇÃO] Cópia preservada; S→C: snapshot de solo, convite ou combate. |
| [CONFIRMADO NO CÓDIGO] | NoteResult | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.NoteResult` | [SUPOSIÇÃO] Cópia preservada; S→C: reconhecimento de hold ou julgamento e estatísticas. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.RhythmControl` | [SUPOSIÇÃO] Cópia preservada; C→S: iniciar/cancelar solo, convidar, aceitar/recusar ou abandonar X1. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.TournamentRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Join, LeaveQueue, ExitView, Withdraw e Snapshot. |
| [CONFIRMADO NO CÓDIGO] | TournamentState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.TournamentState` | [SUPOSIÇÃO] Cópia preservada; S→C: fila e chave do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.LobbyRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Return. |
| [CONFIRMADO NO CÓDIGO] | LobbyState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Sources.Shared.Remotes.LobbyState` | [SUPOSIÇÃO] Cópia preservada; S→C: abertura do torneio, retorno e atribuição/liberação de arena. |
| [CONFIRMADO NO CÓDIGO] | ClientReady | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.ClientReady` | [SUPOSIÇÃO] Cópia preservada; C→S: solicita snapshots iniciais. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.SubmitNote` | [SUPOSIÇÃO] Cópia preservada; C→S: intenção de entrada de nota/hold. |
| [CONFIRMADO NO CÓDIGO] | BattleState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.BattleState` | [SUPOSIÇÃO] Cópia preservada; S→C: snapshot de solo, convite ou combate. |
| [CONFIRMADO NO CÓDIGO] | NoteResult | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.NoteResult` | [SUPOSIÇÃO] Cópia preservada; S→C: reconhecimento de hold ou julgamento e estatísticas. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.RhythmControl` | [SUPOSIÇÃO] Cópia preservada; C→S: iniciar/cancelar solo, convidar, aceitar/recusar ou abandonar X1. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.TournamentRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Join, LeaveQueue, ExitView, Withdraw e Snapshot. |
| [CONFIRMADO NO CÓDIGO] | TournamentState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.TournamentState` | [SUPOSIÇÃO] Cópia preservada; S→C: fila e chave do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.LobbyRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Return. |
| [CONFIRMADO NO CÓDIGO] | LobbyState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.Sources.Shared.Remotes.LobbyState` | [SUPOSIÇÃO] Cópia preservada; S→C: abertura do torneio, retorno e atribuição/liberação de arena. |
| [CONFIRMADO NO CÓDIGO] | ClientReady | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.ClientReady` | [SUPOSIÇÃO] Cópia preservada; C→S: solicita snapshots iniciais. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.SubmitNote` | [SUPOSIÇÃO] Cópia preservada; C→S: intenção de entrada de nota/hold. |
| [CONFIRMADO NO CÓDIGO] | BattleState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.BattleState` | [SUPOSIÇÃO] Cópia preservada; S→C: snapshot de solo, convite ou combate. |
| [CONFIRMADO NO CÓDIGO] | NoteResult | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.NoteResult` | [SUPOSIÇÃO] Cópia preservada; S→C: reconhecimento de hold ou julgamento e estatísticas. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.RhythmControl` | [SUPOSIÇÃO] Cópia preservada; C→S: iniciar/cancelar solo, convidar, aceitar/recusar ou abandonar X1. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.TournamentRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Join, LeaveQueue, ExitView, Withdraw e Snapshot. |
| [CONFIRMADO NO CÓDIGO] | TournamentState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.TournamentState` | [SUPOSIÇÃO] Cópia preservada; S→C: fila e chave do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.LobbyRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Return. |
| [CONFIRMADO NO CÓDIGO] | LobbyState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.ProductionSources.CumbiaParty.Remotes.LobbyState` | [SUPOSIÇÃO] Cópia preservada; S→C: abertura do torneio, retorno e atribuição/liberação de arena. |
| [CONFIRMADO NO CÓDIGO] | ClientReady | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.ClientReady` | [SUPOSIÇÃO] Cópia preservada; C→S: solicita snapshots iniciais. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.SubmitNote` | [SUPOSIÇÃO] Cópia preservada; C→S: intenção de entrada de nota/hold. |
| [CONFIRMADO NO CÓDIGO] | BattleState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.BattleState` | [SUPOSIÇÃO] Cópia preservada; S→C: snapshot de solo, convite ou combate. |
| [CONFIRMADO NO CÓDIGO] | NoteResult | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.NoteResult` | [SUPOSIÇÃO] Cópia preservada; S→C: reconhecimento de hold ou julgamento e estatísticas. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.RhythmControl` | [SUPOSIÇÃO] Cópia preservada; C→S: iniciar/cancelar solo, convidar, aceitar/recusar ou abandonar X1. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.TournamentRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Join, LeaveQueue, ExitView, Withdraw e Snapshot. |
| [CONFIRMADO NO CÓDIGO] | TournamentState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.TournamentState` | [SUPOSIÇÃO] Cópia preservada; S→C: fila e chave do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.LobbyRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Return. |
| [CONFIRMADO NO CÓDIGO] | LobbyState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.ProductionSources.CumbiaParty.Remotes.LobbyState` | [SUPOSIÇÃO] Cópia preservada; S→C: abertura do torneio, retorno e atribuição/liberação de arena. |
| [CONFIRMADO NO CÓDIGO] | ClientReady | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.ClientReady` | [SUPOSIÇÃO] Cópia preservada; C→S: solicita snapshots iniciais. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.SubmitNote` | [SUPOSIÇÃO] Cópia preservada; C→S: intenção de entrada de nota/hold. |
| [CONFIRMADO NO CÓDIGO] | BattleState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.BattleState` | [SUPOSIÇÃO] Cópia preservada; S→C: snapshot de solo, convite ou combate. |
| [CONFIRMADO NO CÓDIGO] | NoteResult | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.NoteResult` | [SUPOSIÇÃO] Cópia preservada; S→C: reconhecimento de hold ou julgamento e estatísticas. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.RhythmControl` | [SUPOSIÇÃO] Cópia preservada; C→S: iniciar/cancelar solo, convidar, aceitar/recusar ou abandonar X1. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.TournamentRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Join, LeaveQueue, ExitView, Withdraw e Snapshot. |
| [CONFIRMADO NO CÓDIGO] | TournamentState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.TournamentState` | [SUPOSIÇÃO] Cópia preservada; S→C: fila e chave do torneio. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.LobbyRequest` | [SUPOSIÇÃO] Cópia preservada; C→S: Return. |
| [CONFIRMADO NO CÓDIGO] | LobbyState | RemoteEvent | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B.SharedAndRemotes.Remotes.LobbyState` | [SUPOSIÇÃO] Cópia preservada; S→C: abertura do torneio, retorno e atribuição/liberação de arena. |

## UI — ScreenGuis

| Estado | Nome | Tipo | Local | Finalidade aparente |
|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | CumbiaPartyGui | ScreenGui | `StarterGui.CumbiaPartyGui` | [SUPOSIÇÃO] Interface principal do jogo. |
| [CONFIRMADO NO CÓDIGO] | RobloxGui | ScreenGui | `CoreGui.RobloxGui` | [SUPOSIÇÃO] Interface interna do ambiente Studio/CoreGui; não classificada como UI de gameplay. |
| [CONFIRMADO NO CÓDIGO] | ViewSelectorScreenGui | ScreenGui | `CoreGui.ViewSelectorScreenGui` | [SUPOSIÇÃO] Interface interna do ambiente Studio/CoreGui; não classificada como UI de gameplay. |
| [CONFIRMADO NO CÓDIGO] | Gen3dGui | ScreenGui | `CoreGui.Gen3d.Gen3dGui` | [SUPOSIÇÃO] Interface interna do ambiente Studio/CoreGui; não classificada como UI de gameplay. |
| [CONFIRMADO NO CÓDIGO] | ImageLoader | ScreenGui | `CoreGui.ImageLoader` | [SUPOSIÇÃO] Interface interna do ambiente Studio/CoreGui; não classificada como UI de gameplay. |

- [CONFIRMADO NO CÓDIGO] StarterGui.CumbiaPartyGui contém StatusLabel e Main; Main contém `SizeLimit` (UISizeConstraint), `Corner` (UICorner), `Title` (TextLabel), `Timing` (TextLabel), `Score` (TextLabel), `Combo` (TextLabel), `Counts` (TextLabel), `Feedback` (TextLabel), `Board` (Frame), `Results` (Frame), `StartButton` (TextButton), `CancelButton` (TextButton), `Footer` (TextLabel), `DuelButton` (TextButton), `TargetButton` (TextButton), `CombatHUD` (Frame).
- [CONFIRMADO NO CÓDIGO] UIController cria as notas como Frames; TournamentController, LobbyController, BattleHUD e BattlePresentationView criam elementos de UI em execução.
- [CONFIRMADO NO CÓDIGO] CumbiaPartyFestivalFX contém a criação do ScreenGui CumbiaFestivalSettings, mas o LocalScript atual está Disabled=true.
- [NÃO ENCONTRADO] CumbiaFestivalSettings não existe como ScreenGui no snapshot Edit consultado.
- [CONFIRMADO NO CÓDIGO] Foram contados 223 SurfaceGuis no DataModel, incluindo sinalização de mapa e backups; não são ScreenGuis.

## Mapa, lobby, iluminação, oceano e respawn

- [CONFIRMADO NO CÓDIGO] Workspace.CumbiaBattleWorld é o mapa atual presente; inclui Hub, NorthTournament, SouthSurvival, EastChairs, WestScoreAttack, Shell, FloorSupport, Interactions, Bindings e LayoutReservations.
- [CONFIRMADO NO CÓDIGO] NorthTournament contém Ring1–Ring4, Final e ObservationGallery; o terminal OpenTournament existe em Interactions.NorthTournament.Terminal.
- [SUPOSIÇÃO] Hub.A_Roulette, B_Shop, C_Casual e D_Freestyle são áreas/reservas visuais conforme os nomes; a existência física não comprova mecânicas ou monetização implementadas.
- [CONFIRMADO NO CÓDIGO] O lobby tropical e horizonte estão em ServerStorage.GreyboxPreservation.CumbiaPartyLobby e CumbiaPartyHorizon, com MainStage, SocialCourtyard, CumbiaTiles, MusicalChairs, BeatDropSurvival, SeaBackdrop e ilhas/montanhas distantes.
- [CONFIRMADO NO CÓDIGO] Workspace.SpawnLocation está Enabled=false em (0, 1.45, 56). UndergroundSpawn está Enabled=true, Neutral=true em (3000, 6.5, 0).
- [CONFIRMADO NO CÓDIGO] LobbyService.Init atribui p.RespawnLocation=bindings.Spawn; retorno e recuperação usam marcadores, validação de suporte e regras espaciais. ServerBootstrap cancela participação durante CharacterRemoving.
- [CONFIRMADO NO CÓDIGO] Lighting: ClockTime=14, Brightness=2, GlobalShadows=false, Ambient=0.647059, 0.666667, 0.705882, OutdoorAmbient=0.647059, 0.666667, 0.705882.
- [CONFIRMADO NO CÓDIGO] `Lighting.SunRays` (SunRaysEffect): Enabled=false.
- [CONFIRMADO NO CÓDIGO] `Lighting.Atmosphere` (Atmosphere).
- [CONFIRMADO NO CÓDIGO] `Lighting.Bloom` (BloomEffect): Enabled=false.
- [CONFIRMADO NO CÓDIGO] `Lighting.DepthOfField` (DepthOfFieldEffect): Enabled=false.
- [CONFIRMADO NO CÓDIGO] `Lighting.IslandSky` (Sky).
- [CONFIRMADO NO CÓDIGO] `Lighting.CaribbeanGrade` (ColorCorrectionEffect): Enabled=false.
- [CONFIRMADO NO CÓDIGO] Workspace.Terrain possui CaribbeanSunsetClouds. Água: cor 0.0666667, 0.670588, 0.721569, transparência 0.5, refletância aproximadamente 0.025, ondas aproximadamente 0.06 / velocidade 4.
- [CONFIRMADO NO CÓDIGO] Amostra Terrain em (400, -24, 0): Enum.Material.Water, ocupação 1; leitura de voxel com resolução 4.
- [CONFIRMADO NO CÓDIGO] Amostra Terrain em (0, -24, 400): Enum.Material.Water, ocupação 1; leitura de voxel com resolução 4.
- [CONFIRMADO NO CÓDIGO] Amostra Terrain em (-400, -24, 0): Enum.Material.Water, ocupação 1; leitura de voxel com resolução 4.
- [CONFIRMADO NO CÓDIGO] Amostra Terrain em (0, -24, -400): Enum.Material.Water, ocupação 1; leitura de voxel com resolução 4.
- [CONFIRMADO NO CÓDIGO] PhaseCOceanPlan contém autoria de água nativa em setores e fundo costeiro; seu código de escrita não foi executado.
- [SUPOSIÇÃO] As quatro amostras confirmam água nesses pontos, mas não delimitam todo o oceano nem demonstram continuidade ou profundidade total.

### Objetos principais e preservações

| Estado | Local | Tipo | Propriedades observadas |
|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `Workspace.Camera` | Camera | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.Terrain` | Terrain | 1 filhos; posição 0, 0, 0; tamanho 2044, 252, 2044; CanCollide=true |
| [CONFIRMADO NO CÓDIGO] | `Workspace.Terrain.CaribbeanSunsetClouds` | Clouds | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.SpawnLocation` | SpawnLocation | 1 filhos; posição 0, 1.4500000476837158, 56; tamanho 12, 1, 12; CanCollide=false; Enabled=false; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `Workspace.SpawnLocation.Decal` | Decal | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld` | Model | 10 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub` | Model | 10 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions` | Model | 4 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings` | Model | 3 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.UndergroundSpawn` | SpawnLocation | 0 filhos; posição 3000, 6.5, 0; tamanho 8, 1, 8; CanCollide=false; Enabled=true; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.LayoutReservations` | Model | 6 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament` | Model | 6 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.SouthSurvival` | Model | 2 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.EastChairs` | Model | 2 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Shell` | Model | 13 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.FloorSupport` | Model | 36 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.WestScoreAttack` | Model | 4 filhos |
| [CONFIRMADO NO CÓDIGO] | `Workspace.Part` | Part | 0 filhos; posição 2870, 44.5, -86; tamanho 4, 1, 2; CanCollide=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.UnitTest` | Folder | 2 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.UnitTest.Cases` | Folder | 8 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.UnitTest.RunUnitTest` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups` | Folder | 7 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2` | Folder | 8 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.SpawnLocation` | SpawnLocation | 1 filhos; posição 0, 1.4500000476837158, 56; tamanho 12, 1, 12; CanCollide=false; Enabled=true; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement` | Folder | 5 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeHorizonRefinement.SpawnLocation` | SpawnLocation | 1 filhos; posição 0, 1.4500000476837158, 56; tamanho 12, 1, 12; CanCollide=false; Enabled=true; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA` | Folder | 8 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.SpawnLocation` | SpawnLocation | 1 filhos; posição 0, 1.4500000476837158, 56; tamanho 12, 1, 12; CanCollide=false; Enabled=true; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB` | Folder | 7 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseB.SpawnLocation` | SpawnLocation | 1 filhos; posição 0, 1.4500000476837158, 56; tamanho 12, 1, 12; CanCollide=false; Enabled=true; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC` | Folder | 9 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.SpawnLocation` | SpawnLocation | 1 filhos; posição 0, 1.4500000476837158, 56; tamanho 12, 1, 12; CanCollide=false; Enabled=true; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD` | Folder | 6 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseD.SpawnLocation` | SpawnLocation | 1 filhos; posição 0, 1.4500000476837158, 56; tamanho 12, 1, 12; CanCollide=false; Enabled=true; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBackups.BeforeSpatialBindingsPhase0B` | Folder | 4 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools` | Folder | 7 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseATerrainPlan` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets` | Folder | 4 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBEnvironmentPlan` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseCOceanPlan` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseCRestore` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseDFestivalPlan` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseDRestore` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxTools` | Folder | 2 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxTools.GreyboxBuilder` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxTools.GreyboxMigration` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation` | Folder | 3 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.LightingChildren` | Folder | 6 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby` | Model | 14 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyHorizon` | Model | 3 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BPreservation` | Folder | 5 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BPreservation.CumbiaBattleWorld` | Model | 10 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BPreservation.CumbiaBattleWorld.Bindings.UndergroundSpawn` | SpawnLocation | 0 filhos; posição 3000, 8.5, 0; tamanho 8, 1, 8; CanCollide=false; Enabled=false; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BPreservation.WorldConfig` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BPreservation.GreyboxBuilder` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BPreservation.UndergroundWorld_Test` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BPreservation.OriginalGreybox` | Folder | 1 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BPreservation.OriginalGreybox.CumbiaBattleWorld.Bindings.UndergroundSpawn` | SpawnLocation | 0 filhos; posição 3000, 8.5, 0; tamanho 8, 1, 8; CanCollide=false; Enabled=false; Neutral=true |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation` | Folder | 8 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation.WestScoreAttack` | Model | 8 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation.Shell` | Model | 13 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation.FloorSupport` | Model | 36 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation.WestScoreAttack` | Part | 0 filhos; posição 2889, 0, 0; tamanho 1, 1, 1; CanCollide=false |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation.SouthWestReserve` | Part | 0 filhos; posição 2908, -0.4749999940395355, 105; tamanho 64, 1, 70; CanCollide=false |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation.WorldConfig` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation.GreyboxBuilder` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BWestPreservation.UndergroundWorld_Test` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BFencePreservation` | Folder | 4 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BFencePreservation.Final` | Folder | 1 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BFencePreservation.Survival` | Folder | 1 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BFencePreservation.Chairs` | Folder | 1 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase1BFencePreservation.GreyboxBuilder` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase2Preservation` | Folder | 6 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase2Preservation.WorldConfig` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase2Preservation.WorldBindings` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase2Preservation.TournamentService` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase2Preservation.ServerBootstrap` | Script | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase2Preservation.ClientBootstrap` | LocalScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.Phase2Preservation.UndergroundWorld_Test` | ModuleScript | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Lighting.SunRays` | SunRaysEffect | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Lighting.Atmosphere` | Atmosphere | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Lighting.Bloom` | BloomEffect | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Lighting.DepthOfField` | DepthOfFieldEffect | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Lighting.IslandSky` | Sky | 0 filhos |
| [CONFIRMADO NO CÓDIGO] | `Lighting.CaribbeanGrade` | ColorCorrectionEffect | 0 filhos |

### Detalhamento dos setores, marcadores e modelos de arte

- [CONFIRMADO NO CÓDIGO] A tabela agrupa instâncias que possuem o mesmo caminho e classe; quantidades maiores que um sinalizam nomes repetidos.

| Estado | Local | Tipo | Quantidade |
|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.Platform` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.North` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.South` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.East` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.West` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.A_Roulette` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.B_Shop` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.C_Casual` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.D_Freestyle` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.Sign_CUMBIABATTLEGREYBOX1B` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions.NorthTournament` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions.NorthTournament.Terminal.OpenTournament` | ProximityPrompt | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions.SouthEntrance` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions.EastEntrance` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions.WestEntrance` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.GalleryReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.Ring2Return` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.NorthReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.SurvivalReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.ChairsReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.WestReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.FinalReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.Ring4Return` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.Ring3Return` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.HubReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.SouthReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.Ring1Return` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.EastReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.UndergroundSpawn` | SpawnLocation | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.AreaMarkers` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.LayoutReservations` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.LayoutReservations.NorthApproach` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.LayoutReservations.SouthApproach` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.LayoutReservations.EastApproach` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.LayoutReservations.WestApproach` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.LayoutReservations.SouthWestReserve` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.LayoutReservations.SouthEastReserve` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.ObservationGallery` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.SouthSurvival` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.SouthSurvival.Survival` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.SouthSurvival.Sign_SULSOBREVIVENCIA` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.EastChairs` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.EastChairs.Chairs` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.EastChairs.Sign_LESTEDANCADASCADEIRAS` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Shell` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Shell.WestWall` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Shell.EastWall` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Shell.NorthWall` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Shell.SouthWall` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Shell.Roof` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Shell.Column` | Part | 8 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.FloorSupport` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.FloorSupport.FloorStrip` | Part | 24 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.FloorSupport.BowlUpperCorner` | WedgePart | 12 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.WestScoreAttack` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.WestScoreAttack.StationReserve` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.WestScoreAttack.ScoreStage` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.WestScoreAttack.WaitingReserve` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.WestScoreAttack.Sign_RECORDEDEPONTOS` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.LightingChildren` | Folder | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.LightingChildren.SunRays` | SunRaysEffect | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.LightingChildren.Atmosphere` | Atmosphere | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.LightingChildren.Bloom` | BloomEffect | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.LightingChildren.DepthOfField` | DepthOfFieldEffect | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.LightingChildren.IslandSky` | Sky | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.LightingChildren.CaribbeanGrade` | ColorCorrectionEffect | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.EnvironmentArtV3` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.IslandScenery` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.MainStage` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.SocialCourtyard` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.WorldLayoutV3` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.FestivalLighting` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.Paths` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.CumbiaTiles` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.CumbiaTiles.TournamentTerminal.OpenTournament` | ProximityPrompt | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.FestivalDecor` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.FestivalLightingV3` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.Plaza` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.Markers` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.Markers.LobbyReturn` | Part | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.MusicalChairs` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyLobby.BeatDropSurvival` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyHorizon` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyHorizon.SeaBackdrop` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyHorizon.DistantIslands` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.GreyboxPreservation.CumbiaPartyHorizon.FarMountainRanges` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets.CoconutPalm` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets.CoconutPalm.body_geom` | MeshPart | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets.SeaGrape` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets.SeaGrape.body_geom` | MeshPart | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets.TropicalShrub` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets.TropicalShrub.body_geom` | MeshPart | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets.FloweringShrub` | Model | 1 |
| [CONFIRMADO NO CÓDIGO] | `ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets.FloweringShrub.body_geom` | MeshPart | 1 |
| [CONFIRMADO NO CÓDIGO] | `StarterGui.CumbiaPartyGui` | ScreenGui | 1 |
| [CONFIRMADO NO CÓDIGO] | `StarterGui.CumbiaPartyGui.StatusLabel` | TextLabel | 1 |
| [CONFIRMADO NO CÓDIGO] | `StarterGui.CumbiaPartyGui.Main` | Frame | 1 |

## Assets

- [CONFIRMADO NO CÓDIGO] Referências abaixo agrupadas por classe, propriedade e URI; quantidade inclui backups/CoreGui. “No Workspace” não inclui Lighting nem implica ausência de uso futuro pelo código.
- [CONFIRMADO NO CÓDIGO] As localizações são exemplos de uso de cada referência, não uma lista de todas as instâncias que a reutilizam.
- [CONFIRMADO NO CÓDIGO] Biblioteca de arte: ServerStorage.CumbiaPartyBuildTools.PhaseBArtAssets contém CoconutPalm, SeaGrape, TropicalShrub e FloweringShrub, cada um com body_geom MeshPart.
- [CONFIRMADO NO CÓDIGO] Contagens geométricas no DataModel: 715 MeshParts, 6911 Parts, 624 WedgeParts e 50 UnionOperations; incluem cópias preservadas e elementos internos.
- [NÃO ENCONTRADO] Nenhuma instância Sound, Animation, VideoFrame, ParticleEmitter ou SurfaceAppearance encontrada na contagem acessível.
- [CONFIRMADO NO CÓDIGO] Foram encontrados 12 Beams, 78 PointLights e 6 SpotLights, incluindo preservações.
- [NÃO ENCONTRADO] A busca literal de rbxassetid:// seguido de números nos Source não encontrou referências; IDs construídos dinamicamente ou formatos diferentes não estão cobertos por essa busca.

| Estado | Tipo.propriedade | URI | Quantidade | No Workspace | Local de exemplo |
|---|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | Decal.Texture | `rbxasset://textures/SpawnLocation.png` | 7 | 1 | `Workspace.SpawnLocation.Decal` |
| [CONFIRMADO NO CÓDIGO] | Decal.Texture | `rbxasset://textures/ViewSelector/back.png` | 1 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model.00p` |
| [CONFIRMADO NO CÓDIGO] | Decal.Texture | `rbxasset://textures/ViewSelector/bottom.png` | 1 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model.0n0` |
| [CONFIRMADO NO CÓDIGO] | Decal.Texture | `rbxasset://textures/ViewSelector/front.png` | 1 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model.00n` |
| [CONFIRMADO NO CÓDIGO] | Decal.Texture | `rbxasset://textures/ViewSelector/left.png` | 1 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model.n00` |
| [CONFIRMADO NO CÓDIGO] | Decal.Texture | `rbxasset://textures/ViewSelector/right.png` | 1 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model.p00` |
| [CONFIRMADO NO CÓDIGO] | Decal.Texture | `rbxasset://textures/ViewSelector/top.png` | 1 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model.0p0` |
| [CONFIRMADO NO CÓDIGO] | FileMesh.MeshId | `rbxasset://models/ViewSelector/Axis.mesh` | 3 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model.y.Mesh` |
| [CONFIRMADO NO CÓDIGO] | ImageButton.Image | `rbxasset://textures/ViewSelector/face_arrow.png` | 4 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.ArrowButtons.UpArrow` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.MeshId | `rbxasset://models/ViewSelector/Basic.mesh` | 1 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.MeshId | `rbxasset://models/ViewSelector/Corner.mesh` | 8 | 0 | `CoreGui.ViewSelectorScreenGui.Panel.Viewport.Model.pnp` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.MeshId | `rbxassetid://107909211282578` | 169 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.CumbiaPartyLobby.EnvironmentArtV3.WestGardens.JardimFlorido.body_geom` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.TextureID | `rbxassetid://125457340756101` | 169 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.CumbiaPartyLobby.EnvironmentArtV3.WestGardens.JardimFlorido.body_geom` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.TextureID | `rbxassetid://129399418118183` | 253 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.CumbiaPartyLobby.EnvironmentArtV3.WestGardens.Arbusto.body_geom` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.MeshId | `rbxassetid://136124667664184` | 91 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.CumbiaPartyLobby.EnvironmentArtV3.WestGardens.SeaGrape.body_geom` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.MeshId | `rbxassetid://139180146222116` | 253 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.CumbiaPartyLobby.EnvironmentArtV3.WestGardens.Arbusto.body_geom` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.TextureID | `rbxassetid://73604055343311` | 193 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.CumbiaPartyLobby.EnvironmentArtV3.CentralGardens.CoconutPalm.body_geom` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.MeshId | `rbxassetid://81095927200471` | 193 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.CumbiaPartyLobby.EnvironmentArtV3.CentralGardens.CoconutPalm.body_geom` |
| [CONFIRMADO NO CÓDIGO] | MeshPart.TextureID | `rbxassetid://90420491893544` | 91 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseC.CumbiaPartyLobby.EnvironmentArtV3.WestGardens.SeaGrape.body_geom` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxBk | `rbxasset://textures/sky/sky512_bk.tex` | 6 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Lighting.IslandSky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxDn | `rbxasset://textures/sky/sky512_dn.tex` | 6 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Lighting.IslandSky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxFt | `rbxasset://textures/sky/sky512_ft.tex` | 6 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Lighting.IslandSky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxLf | `rbxasset://textures/sky/sky512_lf.tex` | 6 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Lighting.IslandSky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxRt | `rbxasset://textures/sky/sky512_rt.tex` | 6 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Lighting.IslandSky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxUp | `rbxasset://textures/sky/sky512_up.tex` | 6 | 0 | `ServerStorage.CumbiaPartyBackups.BeforeVisualV3PhaseA.Lighting.IslandSky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxUp | `rbxassetid://15983964246` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxFt | `rbxassetid://15983965025` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxRt | `rbxassetid://15983966246` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxDn | `rbxassetid://15983966825` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxLf | `rbxassetid://15983967420` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxBk | `rbxassetid://15983968922` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxUp | `rbxassetid://6412503613` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxRt | `rbxassetid://6444884337` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxLf | `rbxassetid://6444884337` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxFt | `rbxassetid://6444884337` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxBk | `rbxassetid://6444884337` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Sky.SkyboxDn | `rbxassetid://6444884785` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Lighting.Sky` |
| [CONFIRMADO NO CÓDIGO] | Texture.Texture | `rbxassetid://6372755229` | 2 | 0 | `ServerStorage.CumbiaPartyBackups.LobbyV1_BeforeIslandV2.Baseplate.Texture` |

## Verificações realizadas e não testado

- [CONFIRMADO NO CÓDIGO] Executadas: enumeração recursiva de arquivos e instâncias, leitura de Source, comparação literal das cópias com a implementação atual, consultas de propriedades, inspeção dos contratos e quatro leituras de voxels.
- [CONFIRMADO NO CÓDIGO] A contagem dos Source legíveis corresponde aos 177 scripts/módulos enumerados; nenhuma falha de leitura de Source foi registrada.
- [CONFIRMADO NO CÓDIGO] As propriedades de asset consultadas não produziram erros; valores vazios foram omitidos.
- [CONFIRMADO NO CÓDIGO] Testes existentes foram inventariados, mas NÃO EXECUTADOS: TournamentService_Test, BotService_Test, LobbyService_Test, WorldBindings_Test, NoteValidator_Test, UndergroundWorld_Test, ArenaService_Test e BattlePresentation_Test.
- [SUPOSIÇÃO] Funcionamento de gameplay, respawn, recuperação de queda, precisão rítmica, multiplayer, dispositivos móveis, câmera, renderização e carregamento dos assets permanece NÃO TESTADO.
- [CONFIRMADO NO CÓDIGO] Nenhum publish, download/upload de asset, alteração de monetização ou acesso ao conteúdo de DataStores de produção foi realizado.

- [CONFIRMADO NO CÓDIGO] Os hashes SHA-256 dos 12 arquivos preexistentes fora de .git permaneceram iguais após a criação deste inventário.

## O que não consegui acessar ou verificar

- [NÃO ENCONTRADO] DataModels Client e Server em execução: apenas Edit estava disponível; o modo do Studio foi preservado.
- [NÃO ENCONTRADO] PlayerGui de uma sessão real, UI gerada durante gameplay, personagens e estados de partidas: não disponíveis nesta inspeção Edit.
- [NÃO ENCONTRADO] Arquivo físico .rbxl correspondente ao Studio dentro da pasta do projeto; o nome da janela não fornece o caminho completo no disco.
- [NÃO ENCONTRADO] Código local em src e casos locais em tests: as pastas contêm somente .gitkeep.
- [NÃO ENCONTRADO] Conteúdo de design/estado atual: GAME_DESIGN.md e CURRENT_STATE.md estavam vazios.
- [NÃO ENCONTRADO] Conteúdo binário, metadados de propriedade/licença e disponibilidade no servidor de cada asset remoto: foram lidas apenas referências existentes nas propriedades.
- [NÃO ENCONTRADO] Cobertura completa de voxels, geometria interna de UnionOperations, conteúdo binário de TerrainRegions e aparência visual final: não extraídos/renderizados.
- [NÃO ENCONTRADO] Instâncias fora da árvore acessível de game (incluindo objetos sem Parent), outros places não conectados e estado publicado: não abrangidos.
- [CONFIRMADO NO CÓDIGO] Uma coleta ampla excedeu o limite de resposta do MCP; foi substituída por consultas menores e agregação de assets. Não se utilizou o JSON truncado como fonte do inventário.
- [CONFIRMADO NO CÓDIGO] Os caminhos completos de scripts, remotes e ScreenGuis foram recuperados sem truncamento no conjunto estruturado final; a tabela de assets é agregada explicitamente.

