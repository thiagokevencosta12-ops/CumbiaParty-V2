# V1 — classificação para avaliação da V2

## Base e critérios

- [SUPOSIÇÃO] Avaliação documental de 22/10/2026, baseada no [inventário](V1_INVENTORY.md) (I) e nas [dependências](../TECH/V1_DEPENDENCIES.md) (D). As evidências abaixo são relatos dessas auditorias; não houve releitura de código/objetos no Studio nesta tarefa. Nenhuma conclusão recebe confirmação direta no código.
- [SUPOSIÇÃO] As classificações são recomendações técnicas provisórias, não decisões de produto nem autorização de migração. Refatorar indica um candidato com problemas concretos documentados; não garante que seu reaproveitamento compense.
- [SUPOSIÇÃO] Reutilizar exige evidência suficiente de adequação à V2 e validação; Referência preserva conhecimento sem propor copiar a implementação; Descartar significa excluir do conjunto de migração, sem apagar arquivos ou objetos.
- [NÃO ENCONTRADO] Critérios de gameplay da V2 em GAME_DESIGN.md e validação dinâmica que sustentem Reutilizar sem ressalvas. Nenhum sistema recebe essa categoria nesta avaliação; ausência de falha documentada não demonstra adequação.
- [SUPOSIÇÃO] Cada linha marcada abrange sua recomendação, justificativa e evidência documental. Seções são citadas pelo título; referências Módulo:linha são as registradas em D, não linhas verificadas nesta tarefa. Caminhos completos estão em I, “Scripts e ModuleScripts — implementação atual e ferramentas”, e D, “Localização das evidências”.

## Mecânicas e infraestrutura

| Estado | Sistema / módulos | Classe | Justificativa e evidência concreta |
|---|---|---|---|
| [SUPOSIÇÃO] | Ritmo, solo e holds — RhythmService, NoteValidator | Refatorar | O servidor julga, mas inputTime influencia precisão e holds; revisar confiança temporal e liberação da sessão antes de migrar. I, “Módulos prioritários”: StartChart/Submit/judge; D, “R1 — timestamp do cliente influencia o julgamento” e “R3 — retenção após solo/X1 direto”: RhythmService:62,150. |
| [SUPOSIÇÃO] | X1, convites, HP e dano — BattleService | Refatorar | Expiração não libera sessão Rhythm; criação pode falhar após alocar estado. D, “Fluxos de dados”, item 3; “R3 — retenção após solo/X1 direto” e “R7 — caminhos excepcionais de criação/cleanup”: BattleService:97,140,193. |
| [SUPOSIÇÃO] | Geração de ondas — WaveGenerator | Referência | GeneratePair documenta determinismo e espelhamento, mas não adequação musical ou balanceamento da V2. I, “Módulos prioritários”; D, “Quem chama quem no servidor”, BattleService → WaveGenerator. |
| [SUPOSIÇÃO] | Identidade e reservas — CompetitorService | Referência | CreateServer/Reserve/Release e ownership são uma base conceitual; ciclo de vida depende do torneio e não foi testado. I, “Módulos prioritários”; D, “Estado, retenção e cleanup”, linha Competitor. |
| [SUPOSIÇÃO] | Entradas dos bots — BotService | Referência | Schedule/Update enviam SubmitServerInput ao mesmo julgador, sem atribuir resultado direto; faltam testes e decisão de dificuldade. I, “Módulos prioritários”; D, “Quem chama quem no servidor”, TournamentService → BotService → RhythmService. |
| [SUPOSIÇÃO] | Fila, chave e campeão — TournamentService | Refatorar | Há progressão e reservas, mas criação parcial e BindBattle precisam de recuperação definida. D, “Fluxos de dados”, itens 4–5; “R7 — caminhos excepcionais de criação/cleanup”: TournamentService:116. |
| [SUPOSIÇÃO] | Simulação bot × bot — TournamentService, RhythmService, BattleService, BotService | Refatorar | Engines isoladas usam relógio próprio; orçamento cooperativo não limita rigidamente o frame. D, “Fluxos de dados”, item 6; “R6 — alocação e amplificação de snapshots”: TournamentService.startMatch/Update. |
| [SUPOSIÇÃO] | Inicialização e limites de requisição — ServerBootstrap | Refatorar | Limite por janela fixa e ausência de teardown central pedem revisão de custo e ciclo de vida. D, “R5 — teardown parcial de GUI e reinicialização” e “R6 — alocação e amplificação de snapshots”; ServerBootstrap:31,53 e Heartbeat. |
| [SUPOSIÇÃO] | Transporte e snapshots — NetworkTypes, ServerBootstrap, RhythmService, BattleService, TournamentService | Refatorar | Tipos não validam payload em execução; snapshots repetem chart e estado. I, “RemoteEvents e RemoteFunctions”: ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState; D, “Quem chama quem no servidor”, NetworkTypes; “R6”, RhythmService:22/BattleService:46,97/TournamentService:60. |
| [SUPOSIÇÃO] | Regras e perfis — GameConfig, WorldConfig | Referência | Regras do protótipo e alias Lobby ligado ao perfil espacial não equivalem a requisitos da V2. I, “Módulos prioritários”: protocolo 3, quatro colunas, 100 HP, oito vagas; D, “Quem chama quem no servidor”, Configurações compartilhadas → consumidores. |
| [SUPOSIÇÃO] | Lobby, retorno, recuperação e respawn — LobbyService | Refatorar | Há validação espacial e de atividade, mas ExitView pode retornar sucesso sem refletir falha de Lobby.Return; conexões globais carecem de teardown. D, “Quem chama quem no servidor”, ServerBootstrap → TournamentService → LobbyService; “Estado, retenção e cleanup”, Lobby e bootstrap. |
| [SUPOSIÇÃO] | Resolução espacial — WorldBindings | Referência | Resolve/valida marcadores, suporte e complexo, mas depende da geometria/perfis existentes. D, “Quem chama quem no servidor”, LobbyService/ArenaService → WorldBindings:106,156,163; I, “Mapa, lobby, iluminação, oceano e respawn”. |
| [SUPOSIÇÃO] | Arenas físicas e participantes — ArenaService | Refatorar | Reserva/restauração têm caminhos definidos; liberação após perda depende do torneio e BindBattle pode falhar fora do pcall. D, “Estado, retenção e cleanup”, Arena; “R7”, Arena.BindBattle/TournamentService:116. |

## Cliente e apresentação

| Estado | Sistema / módulos | Classe | Justificativa e evidência concreta |
|---|---|---|---|
| [SUPOSIÇÃO] | Coordenação do cliente — ClientBootstrap | Refatorar | suppressed acumula tokens; destruição da GUI não faz toda a desconexão. D, “R4 — históricos sem limite no cliente”: ClientBootstrap:15,41; “R5”: ClientBootstrap:109. |
| [SUPOSIÇÃO] | Entrada e bloqueio de movimento — InputController | Referência | Start/Stop e restauração são descritos, sem comprovação em dispositivos/respawn. D, “Cliente e apresentação”, ClientBootstrap → InputController e InputController → controles Roblox. |
| [SUPOSIÇÃO] | Notas, feedback e interface principal — UIController, CumbiaPartyGui | Refatorar | Separa intenção/feedback de estatística autoritativa, mas depende de cleanup parcial do bootstrap. I, “UI — ScreenGuis”; D, “Cliente e apresentação”, TryLane/PollHolds; “R5”, UI.Destroy. |
| [SUPOSIÇÃO] | Interface de torneio — TournamentController | Refatorar | renderContent destrói/recria conteúdo a cada Render; rever atualização antes de migrar. D, “R6 — alocação e amplificação de snapshots”: TournamentController:50,90. |
| [SUPOSIÇÃO] | Navegação do lobby — LobbyController | Refatorar | returned guarda IDs sem poda; avaliar retenção e retorno automático. D, “Cliente e apresentação”, LobbyController → TournamentController/Remotes; “R4”: LobbyController:10,26. |
| [SUPOSIÇÃO] | Câmera e sincronização de arena — ArenaController | Refatorar | GUI.Destroying restaura câmera, mas desconexão completa depende de outro ciclo de vida. D, “Cliente e apresentação”; “R5”: ArenaController:72,104. |
| [SUPOSIÇÃO] | HUD de batalha — BattleHUD | Referência | Adaptador do HUD existente, sem validação visual ou decisão de UX da V2. I, “Scripts e ModuleScripts — implementação atual e ferramentas”; D, “Cliente e apresentação”, UIController → BattleHUD/CompetitorPortrait. |
| [SUPOSIÇÃO] | Introdução e enquadramentos — BattlePresentationView, BattlePresentationConfig | Referência | Apresentação sincronizada documentada, sem confirmação de duração/estilo desejados. D, “Cliente e apresentação”, ArenaController → BattlePresentationView; “Fluxos de dados”, item 4 (7,9 s após lead de 0,4 s). |
| [SUPOSIÇÃO] | Retratos — CompetitorPortrait | Referência | Retratos em Frames são descritos como provisórios; não presumir arte final. I, “Scripts e ModuleScripts — implementação atual e ferramentas”; D, “Cliente e apresentação”, UIController/TournamentController. |
| [SUPOSIÇÃO] | Efeitos e ajustes de festival — CumbiaPartyFestivalFX | Referência | Script documentado como desabilitado e GUI criada em runtime; não comprova uso atual. I, “UI — ScreenGuis”: CumbiaFestivalSettings; “Scripts e ModuleScripts — implementação atual e ferramentas”. |

## Mundo, ferramentas e preservações

| Estado | Sistema / módulos ou objetos | Classe | Justificativa e evidência concreta |
|---|---|---|---|
| [SUPOSIÇÃO] | Greybox atual — CumbiaBattleWorld, WorldConfig, GreyboxBuilder | Referência | Hub, setores, suporte e arenas existem segundo auditoria; layout e perfil Underground ainda dependem da direção da V2. I, “Mapa, lobby, iluminação, oceano e respawn” e “Detalhamento dos setores, marcadores e modelos de arte”. |
| [SUPOSIÇÃO] | Cenário tropical e horizonte — CumbiaPartyLobby, CumbiaPartyHorizon | Referência | Preservados em ServerStorage.GreyboxPreservation; valor visual não comprova integração atual. I, “Mapa, lobby, iluminação, oceano e respawn” e “Objetos principais e preservações”; GreyboxMigration é a ferramenta associada. |
| [SUPOSIÇÃO] | Iluminação, céu e oceano — PhaseCOceanPlan, CumbiaPartyFestivalFX, Lighting, Terrain | Referência | Há água amostrada e efeitos desativados; cobertura do oceano e aparência final não foram validadas. I, “Mapa, lobby, iluminação, oceano e respawn” e “O que não consegui acessar ou verificar”. |
| [SUPOSIÇÃO] | Autoria de ambiente — PhaseATerrainPlan, PhaseBEnvironmentPlan, PhaseCOceanPlan, PhaseDFestivalPlan | Referência | Ferramentas de autoria específicas das fases anteriores, sem prova de execução segura/adequação à V2. I, “Scripts e ModuleScripts — implementação atual e ferramentas”. |
| [SUPOSIÇÃO] | Construção/restauração — GreyboxBuilder, GreyboxMigration, PhaseCRestore, PhaseDRestore | Referência | Guardar procedimentos como histórico; não executar restauração/migração por inferência. I, “Scripts e ModuleScripts — implementação atual e ferramentas”. |
| [SUPOSIÇÃO] | Arte vegetal — PhaseBArtAssets; PhaseBEnvironmentPlan | Referência | CoconutPalm, SeaGrape, TropicalShrub e FloweringShrub têm referências de mesh/textura; disponibilidade e licença não foram verificadas. I, “Assets” e “O que não consegui acessar ou verificar”. |
| [SUPOSIÇÃO] | Testes e executor — UnitTestRunner, RunUnitTest e oito casos | Referência | Existência e nomes não demonstram cobertura nem aprovação; runner está documentado como desabilitado. I, “Verificações realizadas e não testado”: TournamentService_Test, BotService_Test, LobbyService_Test, WorldBindings_Test, NoteValidator_Test, UndergroundWorld_Test, ArenaService_Test, BattlePresentation_Test. |
| [SUPOSIÇÃO] | Versões históricas divergentes — CumbiaPartyBackups e preservações Phase1B/Phase1BWest/Phase1BFence/Phase2 | Referência | Guardar contexto de mudanças, sem misturar versões. I, “Scripts e ModuleScripts — cópias preservadas”: ServerBootstrap, TournamentService, LobbyService, UIController, GameConfig, NetworkTypes, WorldConfig, WorldBindings, GreyboxBuilder e testes divergentes; “Objetos principais e preservações”. |
| [SUPOSIÇÃO] | Cópias redundantes de Source e remotes — subconjunto de CumbiaPartyBackups | Descartar | Excluir duplicatas do pacote proposto de migração, mantendo o arquivo histórico original. I, “Scripts e ModuleScripts — cópias preservadas”: RhythmService, BattleService, WaveGenerator, CompetitorService, BotService, NoteValidator, InputController e outros marcados “Sim”; I, “RemoteEvents e RemoteFunctions”: sete conjuntos preservados. Igualdade de Source não prova igualdade de propriedades; revalidar antes de qualquer seleção futura. |
| [SUPOSIÇÃO] | UI interna do Studio — RobloxGui, ViewSelectorScreenGui, Gen3dGui, ImageLoader | Descartar | Excluir da lista de sistemas de gameplay a migrar; não são a CumbiaPartyGui. I, “UI — ScreenGuis”, caminhos CoreGui. Nenhuma remoção de objeto é proposta nesta tarefa. |

## Sem evidência suficiente para classificar a mecânica

| Estado | Sistema procurado | Classe | Limite da evidência |
|---|---|---|---|
| [NÃO ENCONTRADO] | Sobrevivência | — | I, “Mapa, lobby, iluminação, oceano e respawn”: SouthSurvival/BeatDropSurvival são objetos; “Scripts e ModuleScripts — implementação atual e ferramentas” não identifica serviço da mecânica. |
| [NÃO ENCONTRADO] | Dança das cadeiras | — | I, “Mapa, lobby, iluminação, oceano e respawn”: EastChairs/MusicalChairs não demonstram regras ou resultado; nenhum módulo específico identificado na lista de implementação atual. |
| [NÃO ENCONTRADO] | Score Attack como modo próprio | — | I, “Detalhamento dos setores, marcadores e modelos de arte”: WestScoreAttack.ScoreStage/StationReserve; RhythmService solo não comprova integração desse modo. |
| [NÃO ENCONTRADO] | Roleta, loja, casual e freestyle | — | I, “Mapa, lobby, iluminação, oceano e respawn”: Hub.A_Roulette/B_Shop/C_Casual/D_Freestyle; nenhum script próprio da mecânica identificado. Não inferir monetização pela área Shop. |
| [NÃO ENCONTRADO] | Música, catálogo e dança animada | — | I, “Assets”: ausência relatada de Sound/Animation e de IDs literais nos Source; não identifica módulo de catálogo/sincronização musical. Isso não exclui construção dinâmica ou outros places. |
| [NÃO ENCONTRADO] | Persistência, economia e concessão de prêmios | — | D, “R2 — pontuação, double-award e prêmios”: nenhum caminho de DataStore/BadgeService/ProcessReceipt encontrado nos serviços/bootstraps examinados. Campeão e score em memória não comprovam recompensa persistente. |

## Limites de validação

- [NÃO ENCONTRADO] Evidência de testes executados nesta tarefa: nenhum Play, teste unitário, ensaio multiplayer, medição de memória/tráfego ou validação visual foi realizado. As fontes também registram testes dinâmicos não executados (I, “Verificações realizadas e não testado”; D, “Verificação e limites”).
- [SUPOSIÇÃO] R1–R7 de D são motivos para investigação e critérios de revisão; não demonstram exploração, vazamento mensurado ou defeito reproduzido. A classificação não autoriza publicar, excluir, modificar monetização ou acessar DataStore de produção.

## Perguntas que só o dono pode responder

1. [NÃO ENCONTRADO] Qual experiência define a V2: ritmo por ondas, músicas com charts autorais, festa social ou combinação? Quais modos entram na primeira entrega?
2. [NÃO ENCONTRADO] O visual desejado é Underground, tropical ou outro? Quais elementos da V1 são obrigatórios por identidade do projeto?
3. [NÃO ENCONTRADO] Quais regras devem permanecer: quatro colunas, holds, HP, turnos, oito participantes, preenchimento por bots e desempate aleatório?
4. [NÃO ENCONTRADO] Quais dispositivos, público, concorrência e tolerância de latência devem orientar os critérios de aceitação?
5. [NÃO ENCONTRADO] Qual arquivo/place é a V1 oficial? Existem outros places, versões publicadas ou implementações fora desta pasta que devam entrar na auditoria?
6. [NÃO ENCONTRADO] Quais músicas, animações e assets têm direitos/permissões de uso confirmados pelo projeto?
7. [NÃO ENCONTRADO] Haverá progresso persistente, prêmios ou monetização na V2? Há dados existentes que precisarão ser preservados?
8. [NÃO ENCONTRADO] Quais comportamentos da V1 você considera corretos, quais problemas já observou e quais registros de testes possui?
