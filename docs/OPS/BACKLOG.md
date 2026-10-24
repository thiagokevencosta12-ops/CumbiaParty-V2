# Backlog inicial — Cumbia Party V2

- [SUPOSIÇÃO] Planejamento baseado em [GAME_DESIGN](../PRODUCT/GAME_DESIGN.md), [CURRENT_STATE](CURRENT_STATE.md), [V1_CLASSIFICATION](V1_CLASSIFICATION.md), [ARCHITECTURE](../TECH/ARCHITECTURE.md) e [NETWORK_CONTRACTS](../TECH/NETWORK_CONTRACTS.md). Marcações abrangem cada linha; riscos são estimativas. Esta revisão mantém a conclusão documental de CP2-000d, registra CP2-000a e CP2-000b como concluídos segundo os documentos locais e mantém CP2-000c sem conclusão; decompõe a execução futura do CP2-000e. Documentos ainda ausentes serão criados nos respectivos tickets.
- [SUPOSIÇÃO] Testes iniciais (pipeline, A/S/D/F e R1) usam som provisório ou metrônomo. A conferência da auditoria precede qualquer implementação no jogo; a prova isolada do pipeline ocorre em projeto descartável. Nenhum ticket autoriza publicação ou alteração da base histórica.

## Preparação e prova inicial

| Estado | ID / objetivo | Aceite | Risco | Dependências |
|---|---|---|---|---|
| [SUPOSIÇÃO] | CP2-000a — Identificar base V1 — CONCLUÍDO (segundo CURRENT_STATE) | Dono confirma arquivo/place oficial e cópia de trabalho do Studio, local das alterações; registrar identificação e localização de ambos. | baixo | Dono; base oficial registrada em [CURRENT_STATE](CURRENT_STATE.md). |
| [SUPOSIÇÃO] | CP2-000b — Provar pipeline — CONCLUÍDO (segundo ADR-0001) | Em projeto descartável, demonstrar alteração sincronizada Studio/repositório e repetição do procedimento; registrar escolha Rojo ou Script Sync, direção da sincronização e evidências em `decisions/ADR-0001.md`. | médio | CP2-000a. |
| [SUPOSIÇÃO] | CP2-000c — Conferir auditoria por amostra — PENDENTE | Comparar entrada, julgamento/R1, combate, torneio e Remotes com Studio; registrar versão inspecionada, amostra, correspondências e divergências em documento versionado `docs/OPS/V1_AUDIT_SPOTCHECK.md`; resolver divergências impeditivas antes de implementar. | médio | CP2-000a; inspeção na cópia de trabalho. |
| [SUPOSIÇÃO] | CP2-000d — Planejar a migração — CONCLUÍDO (documental) | Entregue em [MIGRATION_PLAN](../TECH/MIGRATION_PLAN.md): lista dos 24 scripts, exclusões, atributos, extração/fidelidade, backup, prova descartável, reversão e três decisões aprovadas pelo dono em 24/10/2026. Não significa migração executada. | [SUPOSIÇÃO] baixo | [SUPOSIÇÃO] Insumos: CP2-000a, CP2-000b e CP2-000c; lista aprovada por decisão do dono em 24/10/2026; aprovações das etapas de execução continuam PENDENTES. |
| [SUPOSIÇÃO] | CP2-000e — Executar a migração — PENDENTE | Executar o plano mediante aprovação de cada etapa: backup preservado com as dispensas e riscos aceitos pelo dono, extração fiel dos 24 scripts, prova de atributos e preservação na cópia descartável, sincronização restrita e validação funcional; registrar evidências e NÃO TESTADO. Preservar objetos excluídos; suíte UnitTest em ticket próprio, conforme decisão do dono. | ALTO | CP2-000d; três Decisões do dono aprovadas em 24/10/2026, sem iniciar etapas; aprovações de CP2-000e-1 a -8 continuam PENDENTES. |
| [SUPOSIÇÃO] | CP2-001 — A/S/D/F ponta a ponta | Na cópia de trabalho, trocar D/F/J/K; testar cada coluna até resultado do servidor, rótulos e ausência de entrada por J/K; registrar evidências e alteração sincronizada no repositório. | médio | CP2-000a, CP2-000b, CP2-000c, CP2-000e. |

- [SUPOSIÇÃO] CP2-000a: [CURRENT_STATE](CURRENT_STATE.md) registra os caminhos da V1 congelada e da cópia de trabalho e a identificação da conexão em 23/10/2026; conclusão baseada nesse registro, sem nova verificação no Studio.
- [SUPOSIÇÃO] CP2-000b: [ADR-0001](../../decisions/ADR-0001.md) registra decisão aceita por Rojo 7.7.1, alteração disco → Studio e reversão Git acompanhada pelo Studio em projeto descartável; conclusão baseada nesse registro, sem repetir a prova.
- [SUPOSIÇÃO] CP2-000c permanece sem conclusão: o [spotcheck](V1_AUDIT_SPOTCHECK.md) registra sete correspondências, mas não apresenta combate e torneio como itens próprios de conferência suficientes para demonstrar integralmente o aceite acima.
- [NÃO ENCONTRADO] Evidência suficiente no spotcheck para encerrar CP2-000c quanto à amostra de combate e torneio; não houve nova inspeção ou teste nesta revisão.

### Subitens do CP2-000e — risco ALTO

- [SUPOSIÇÃO] Cada subitem segue os objetivos, pré-requisitos, ações, critérios de aceite e NÃO TESTADO de [Sequência futura](../TECH/MIGRATION_PLAN.md#sequência-futura-e-critérios-de-parada). Nenhuma etapa começa sem aprovação escrita do resultado da anterior e da própria; a primeira exige aprovação do plano e da própria CP2-000e-1; as três Decisões do dono foram aprovadas em 24/10/2026 e não iniciam nenhuma etapa. A revisão documental não autoriza execução.
- [SUPOSIÇÃO] CP2-000e-1 — Preparar: execução e plano APROVADOS pelo dono neste ticket em 24/10/2026; relatório entregue, veredito **pronto** para aceite da etapa. Esta atualização substitui a pendência histórica de aprovação exclusivamente de CP2-000e-1; CP2-000e-2 a -8 continuam PENDENTES. Hashes e tamanhos exatos dos `.rbxl` dispensados; somente consultas `--version` autorizadas para Rojo e Rokit. Evidências completas e limites em [relatório CP2-000e-1](../TECH/MIGRATION_PLAN.md#cp2-000e-1--preparar).
  - [CONFIRMADO NO CÓDIGO] Conferidos nesta sessão: decisões 1–3 registradas como APROVADAS; Git inicialmente limpo no commit `c50c9951d7c01652018b4bae81daa7b82c9fe7ab`; quatro `.rbxl` existentes com nomes/datas registrados; sessão MCP `CumbiaParty_V2_Trabalho.rbxl` em Edit; inventário 24/24 sem divergências de nome, classe ou duplicatas; atributos das pastas e scripts registrados; três exclusões existentes; Rojo 7.7.1 e Rokit 1.2.0 por executáveis instalados.
  - [CONFIRMADO NO CÓDIGO] Source não foi lido e nenhum require foi executado. Nenhuma escrita no Studio, alteração de `.rbxl`, instalação, sincronização, Play ou commit. Falhas de resolução pelo PATH e do intermediário Rojo registradas no relatório, sem alterações de ambiente.
  - [NÃO ENCONTRADO] NÃO TESTADO: integridade/abertura/restauração/equivalência dos `.rbxl`, origem independente da descartável, equivalência Studio/arquivo salvo, Source, extração/fidelidade, plugin e sincronização/preservação pelo Rojo, gameplay, UnitTest, multiplayer, mobile, segurança, desempenho e memória. As dispensas não comprovam confiabilidade do pré-migração.
- [SUPOSIÇÃO] CP2-000e-2 — Extrair: execução/plano APROVADOS pelo dono em 24/10/2026; pronto para aceite. CP2-000e-3 a -8 continuam PENDENTES.
  - [CONFIRMADO NO CÓDIGO] 24 Sources extraídos via MCP da única V2_Trabalho em Edit, gravados nos destinos aprovados; 24/24 releituras do disco iguais aos bytes recebidos e SHA-256. [Manifesto completo](../TECH/MIGRATION_MANIFEST.md): propriedades, atributos vazios, bytes, hashes, finais de linha e blocos por script.
  - [CONFIRMADO NO CÓDIGO] Preservados 3 CRLF, 14 LF, 7 mistos e 7 sem quebra final; sem BOM acrescentado. Nenhuma divergência de fidelidade; check no-index aponta whitespace herdado em 10 arquivos e avisos de conversão em 19. core.autocrlf=true e atributos efetivos unspecified; nenhuma configuração alterada.
  - [SUPOSIÇÃO] Git poderá converter finais de linha em operações futuras; efeitos prováveis detalhados no manifesto, sem normalizar os arquivos extraídos.
  - [CONFIRMADO NO CÓDIGO] Nenhum require, execução de módulos, Play, comando Rojo/Rokit, escrita no Studio/.rbxl ou commit.
  - [NÃO ENCONTRADO] NÃO TESTADO: segunda leitura independente pelo MCP e conferência integral (-3), compilação, execução/UnitTest/gameplay, sincronização e preservação pelo Rojo.
- [SUPOSIÇÃO] CP2-000e-2a — Neutralizar conversão Git: decisão/plano APROVADOS pelo dono; regra `src/** -text` criada, válida também para qualquer arquivo futuro em src/ e sujeita a revisão se essa política mudar. Manifesto, documentos, ADR e AGENTS.md ficam fora; nenhuma renormalização. [Decisão e verificações](../TECH/MIGRATION_PLAN.md#cp2-000e-2a--desativar-conversão-git-em-src).
  - [CONFIRMADO NO CÓDIGO] 24/24 destinos com `text: unset`; git add --dry-run concluído sem avisos LF/CRLF ou staging, após repetição autorizada fora do sandbox. Check no-index com caminhos relativos também sem avisos para src/. Aviso LF→CRLF do manifesto continua, como esperado. SHA-256 antes/depois iguais nos 24 Sources, .gitkeep e manifesto; core.autocrlf=true preservado.
  - [SUPOSIÇÃO] .gitattributes é pré-requisito da etapa -3, que exige igualdade exata de bytes/SHA-256 com leitura independente pelo MCP. Prova futura de blobs e checkout em cópia de teste descrita no plano, sem autorização de execução neste ticket. CP2-000e-3 a -8 permanecem PENDENTES.
  - [NÃO ENCONTRADO] NÃO TESTADO: prova pós-commit, checkout de teste e conferência independente da etapa -3; nenhum commit, Rojo ou Studio executado.
- [SUPOSIÇÃO] CP2-000e-3 — Conferir em disco: ACEITA PELO DONO em 24/10/2026, com ressalva ("decisão do dono: aceito"), conforme CP2-000e-3c abaixo. Restrição vigente nas etapas seguintes: não trocar ActiveProfileId para Tropical. CP2-000e-4 permanece com aprovação PENDENTE e não é iniciada por este aceite.
  - [SUPOSIÇÃO] Registro histórico da execução: execução, plano e item 7 APROVADOS pelo dono em 24/10/2026. Conferência interrompida em divergência de referências; naquele momento, aceite integral não declarado. Aceite posterior com ressalva registrado em CP2-000e-3c abaixo. CP2-000e-4 a -8 continuam PENDENTES.
  - [CONFIRMADO NO CÓDIGO] Sessão MCP única CumbiaParty_V2_Trabalho.rbxl em Edit; segunda leitura independente: 24/24 iguais em bytes e SHA-256 ao disco e manifesto, 162095 bytes; classes/extensões 24/24. Relatório completo em [conferência CP2-000e-3](../TECH/MIGRATION_MANIFEST.md#cp2-000e-3--conferência-independente-em-disco-24102026).
  - [CONFIRMADO NO CÓDIGO] Item 7: 24/24 blobs do commit 7969b6a6fc2a273148bf06a4310575ef1ebc377f iguais ao disco em bytes e SHA-256, via git cat-file e buffers binários em memória. Mesmo commit contém src/** -text. Sem checkout, cópia de teste ou commit.
  - [CONFIRMADO NO CÓDIGO] Revisão textual: 50 requires (48 internos existentes, 2 externos de controles Roblox) e 30 WaitForChild/FindFirstChild/variantes listados no manifesto; Remotes, GUI e referências de mapa discriminados. CR CR LF explica os dois -text: 1 CR isolado em WorldBindings e 107 em WorldConfig; reconciliados 3 crlf, 14 lf, 5 mixed, 2 -text com 3 CRLF, 14 LF, 7 mistos.
  - [NÃO ENCONTRADO] Divergência: perfil inativo Tropical referencia Workspace.CumbiaPartyLobby, oito marcadores e terminal OpenTournament ausentes em Edit. Underground é o perfil ativo e seus 19 RequiredPaths existem. Investigação interrompida ao encontrar as ausências; nada corrigido.
  - [NÃO ENCONTRADO] NÃO TESTADO: checkout futuro (item 7 prova somente os blobs), dependências e GUI/personagens em runtime, compilação/execução, require, Play/gameplay/UnitTest, Rojo/sincronização/preservação e equivalência Studio/.rbxl salvo.
- [SUPOSIÇÃO] CP2-000e-4 — Configurar e provar atributos: criação prévia de `CumbiaParty_V2_Descartavel.rbxl` obrigatória; mapeamento restrito e ensaio de preservação. Depende do aceite de CP2-000e-3. Aprovação do dono: PENDENTE.
- [SUPOSIÇÃO] CP2-000e-5 — Validar sincronização descartável: conferir Source, hierarquia, propriedades, atributos, bootstraps e exclusões. Depende do aceite de CP2-000e-4. Aprovação do dono: PENDENTE.
- [SUPOSIÇÃO] CP2-000e-6 — Validar funcionamento: comparar fluxo e cenários previstos com a referência de 23/10/2026 11:44 e a linha de base herdada relatada pelo dono, separando falhas herdadas de regressões. Depende do aceite de CP2-000e-5. Aprovação do dono: PENDENTE.
- [SUPOSIÇÃO] CP2-000e-7 — Transferir à cópia de trabalho: backup com as dispensas e riscos abaixo (pré-migração NÃO TESTADO e possível perda das alterações do intervalo não documentado ao restaurar) e prévia restrita; repetir fidelidade, preservação e validação funcional. Depende do aceite de CP2-000e-6. Aprovação do dono: PENDENTE.
- [SUPOSIÇÃO] CP2-000e-8 — Encerrar documentalmente: consolidar evidências, versões, manifesto, diferenças e NÃO TESTADO nos registros autorizados. Depende do aceite de CP2-000e-7. Aprovação do dono: PENDENTE.

- [SUPOSIÇÃO] Decisões do dono em 24/10/2026: lista dos 24 scripts (11 servidor + 4 shared + 9 cliente) APROVADA ("sim"); exclusão de UnitTest, UnitTestRunner e CumbiaPartyFestivalFX da migração inicial, preservando os objetos no `.rbxl`, APROVADA ("concordo"); suíte UnitTest em ticket próprio APROVADA ("deixe para depois"), mantendo obrigatórias as verificações de fidelidade e preservação no CP2-000e.
- [SUPOSIÇÃO] Dispensas do dono em 24/10/2026, com riscos aceitos: segunda cópia do backup da V1 em outro local e teste de abertura do `CumbiaParty_V2_Trabalho_pre-migracao.rbxl`. O pré-migração continua NÃO TESTADO e não deve ser descrito como ponto de restauração confiável enquanto não testado.
- [SUPOSIÇÃO] Relato do dono em 24/10/2026, não verificado por agente: criou `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V2_Descartavel.rbxl` a partir de `CumbiaParty_V2_Trabalho.rbxl` (modificado em 23/10/2026 11:44), com Studio fechado; relata que as duas cópias são iguais, abriu e testou a descartável e mecânicas e demais itens funcionam. Esse funcionamento relatado é a linha de base herdada para CP2-000e-6.
- [SUPOSIÇÃO] Referência: V2_Trabalho de 23/10/2026 11:44, posterior ao pré-migração de 23/10/2026 02:00. Restaurar pelo pré-migração pode perder alterações desse intervalo não documentado — risco aceito pelo dono em 24/10/2026.
- [NÃO ENCONTRADO] Hashes e tamanhos exatos da referência e da descartável não registrados em documento; alterações entre 02:00 e 11:44 não documentadas.

## Decisões e investigação — bloqueiam combate

| Estado | ID / objetivo | Aceite | Risco | Dependências |
|---|---|---|---|---|
| [SUPOSIÇÃO] | CP2-002 — DECISÃO DO DONO: empate | Aprovar regra para fim da música com ambos vivos, incluindo HP igual. | médio | Dono; regra [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-003 — DECISÃO DO DONO: dano | Aprovar dano Perfect/Good, efeito de Miss e HP inicial. | médio | Dono; valores [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-004 — DECISÃO DO DONO: duração | Aprovar duração/término e relação com música, ondas e turnos. | médio | Dono, CP2-002; duração [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-005 — DECISÃO DO DONO: bots | Aprovar habilidade e critérios verificáveis de comportamento. | médio | Dono; parâmetros [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-007a — Investigar R1, sem corrigir | Testar inputTime forjado e limites de atraso/futuro na cópia; registrar resultados, limitações e alternativas para decisão de latência, sem alterar a política. | ALTO | CP2-001; precede CP2-006. |
| [SUPOSIÇÃO] | CP2-006 — DECISÃO DO DONO: latência | Aprovar tolerância e tratamento de entradas atrasadas/futuras com base na investigação. | alto | Dono, CP2-007a; política [NÃO ENCONTRADO]. |

## MVP X1 e preparação para publicação

| Estado | ID / objetivo | Aceite | Risco | Dependências |
|---|---|---|---|---|
| [SUPOSIÇÃO] | CP2-007b — Implementar política de entradas | Aplicar política aprovada; testar tempo forjado, limites, NaN/infinito, IDs, sessão alheia, replay, duplicação, ordem e spam; cliente não atribui nota/dano. | ALTO | CP2-006, CP2-007a. |
| [SUPOSIÇÃO] | CP2-008 — Combate autoritativo | Resolver Great/holds herdados conforme design e decisão do dono; testar dano/HP, KO, duração e empate aprovados; eventos repetidos não duplicam dano/conclusão. | alto | CP2-002, CP2-003, CP2-004, CP2-005, CP2-006, CP2-007b. |
| [SUPOSIÇÃO] | CP2-009 — Fila, bots e chave | Testar oito vagas, bots só nas faltantes e pelo mesmo julgador, avanço único, desistência, campeão e ausência de reserva dupla. | alto | CP2-008. |
| [SUPOSIÇÃO] | CP2-010 — Lobby, arena e liberação | Testar retorno, saída, respawn e falha de criação; liberar reservas/sessões/arena; repetir partidas sem callbacks duplicados. | alto | CP2-009; CumbiaBattleWorld identificado. |
| [SUPOSIÇÃO] | CP2-011 — HUD Underground | Conferir A/S/D/F, toque, HP/resultado e câmera; testar recriação da GUI, restauração de controles e retenção limitada. | médio | CP2-010; validação final nos dispositivos de CP2-013a. |
| [SUPOSIÇÃO] | CP2-012a — DECISÃO DO DONO: música | Conforme seção Música: registrar licença Mureka válida só com plano ativo e remoção/substituição antes de cancelar; confirmar termos sobre áudio de referência (conteúdo [NÃO ENCONTRADO]); aprovar trilha final por descrição de estilo, sem enviar faixas existentes; atuais só protótipo. Guardar arquivo, prompt, data, plano e termos por faixa. | alto | Dono e termos. Bloqueia somente publicação/release; CP2-012 pode usar faixas de protótipo enquanto a decisão estiver pendente, sem bloquear início do X1. |
| [SUPOSIÇÃO] | CP2-012 — Música e chart | Implementar/testar alinhamento áudio/notas e início/fim; pode usar protótipo. Ao trocar pela trilha final, refazer chart e repetir validação antes do release. | alto | CP2-008; CP2-012a não bloqueia desenvolvimento/testes. |
| [SUPOSIÇÃO] | CP2-013a — DECISÃO DO DONO: dispositivos/desempenho | Aprovar dispositivos-alvo, concorrência, metas mensuráveis de desempenho/memória/tráfego e condições de medição. | médio | Dono; metas [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-013 — Validar MVP integrado | Executar lobby → fila → X1 → campeão/retorno, humanos/bots; medir metas e testar latência, saída/repetição; registrar falhas e não testado. Protótipo permite validação técnica, não liberação para publicar. | alto | CP2-011, CP2-012, CP2-013a; release exige CP2-012a e revalidação da trilha final. |

## Épicos futuros — fora do MVP

| Estado | ID / objetivo | Aceite do planejamento | Risco | Dependências |
|---|---|---|---|---|
| [SUPOSIÇÃO] | CP2-014 — Dança das Cadeiras | Decompor corrida/estamina, música, ocupação no servidor e eliminação; listar decisões pendentes. | alto | CP2-013 e priorização do dono; parâmetros [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-015 — Sobrevivência | Decompor chart comum A/S/D/F, pontuação por onda, erros/desempate e eliminação no servidor. | alto | CP2-013 e priorização do dono; progressão/duração/bots [NÃO ENCONTRADO]. |

## CP2-000e-3a — Registro complementar (24/10/2026)

- [SUPOSIÇÃO] Execução somente de leitura e plano de registro nos três documentos APROVADOS pelo dono. [Relatório CP2-000e-3a](../TECH/MIGRATION_MANIFEST.md#cp2-000e-3a--seleção-do-perfil-tropical-24102026). Sem aceitar ou rejeitar -3; decisão do dono. CP2-000e-4 a -8 PENDENTES.
- [CONFIRMADO NO CÓDIGO] src/shared/WorldConfig.luau:4 seleciona Underground; Tropical e Underground são os dois perfis espaciais. GameConfig:97 consome o ativo. LobbyService:89 chama Resolve sem perfil; WorldBindings:107 usa o ativo e resolve seus caminhos com assert (6,19,109,116,134). Com Underground, a raiz é CumbiaBattleWorld, não CumbiaPartyLobby. Referências e chamadores constam com arquivo/linha no relatório.
- [NÃO ENCONTRADO] Nenhuma seleção explícita ou troca runtime para Tropical nas buscas dos 24 Sources.
- [SUPOSIÇÃO] O dono contesta a hipótese "referências do perfil inativo, inofensivas": NÃO se sustenta como conclusão de inocuidade em execução ou fundamento de aceite. Registrada como pendência a esclarecer a contradição apontada pelo dono com seu relato de que a descartável inicia e funciona; não foi reproduzida.
- [CONFIRMADO NO CÓDIGO] Ressalva: o caminho normal só resolveria CumbiaPartyLobby e seus marcadores se Tropical fosse usado; os asserts não tornam obrigatórias as referências do perfil inativo. A leitura atual não demonstra essa contradição com o relato.
- [SUPOSIÇÃO] Reconciliação entre Sources/perfil da descartável e evidências da cópia de trabalho pendente de escopo futuro autorizado, sem decisão sobre -3.
- [NÃO ENCONTRADO] NÃO TESTADO: execução, require, Play, inicialização/gameplay, UnitTest, estado atual do Studio, equivalência disco/Studio/.rbxl e Rojo. Inspeção textual apenas; sem commit.

## CP2-000e-3b — Conferência estrutural em Edit (24/10/2026)

- [SUPOSIÇÃO] Execução e plano aprovados pelo dono; [evidências CP2-000e-3b](../TECH/MIGRATION_MANIFEST.md#cp2-000e-3b--objetos-dos-perfis-em-edit-24102026). Sem aceite da etapa -3: decisão do dono. CP2-000e-4 a -8 PENDENTES.
- [CONFIRMADO NO CÓDIGO] Leitura atual de WorldConfig:4 confirma Underground ativo. Sessão MCP única CumbiaParty_V2_Trabalho.rbxl em Edit; 85 caminhos distintos conferidos por enumeração de instâncias, Name e ClassName: presentes, únicos e com classes compatíveis. Contagens previstas/observadas: 13/13 retornos, 19/19 RequiredPaths e 5/5 arenas; diferenças zero. As arenas já integram os RequiredPaths. Tabela completa, intermediários, arquivo/linha e distinção entre assert e nil/fallback no manifesto.
- [NÃO ENCONTRADO] Tropical: CumbiaPartyLobby, oito retornos e terminal ausentes nos caminhos configurados, reconferidos nesta sessão. A ausência da raiz implica ausência desses caminhos descendentes; não é busca global por nomes.
- [CONFIRMADO NO CÓDIGO] SpawnLocation e Terrain de Workspace existem e são únicos; não se afirma ausência de todos os objetos Tropical. As ausências do perfil inativo não são ausências do contrato Underground.
- [CONFIRMADO NO CÓDIGO] A conferência prova presença, classe e unicidade; não prova posição, suporte físico nem funcionamento. Nenhum obrigatório Underground ausente ou ambíguo foi observado.
- [SUPOSIÇÃO] Funcionamento relatado pelo dono continua relato do dono, NÃO TESTADO por agente; sem conclusão de funcionamento ou aceite de -3.
- [NÃO ENCONTRADO] NÃO TESTADO: posição, suporte físico/raycast, propriedades físicas, funcionamento, Play, require, execução/compilação de módulos, UnitTest, equivalência atual disco/Studio/.rbxl salvo e Rojo/sincronização. Nenhum commit.

## CP2-000e-3c — Aceite da etapa -3 (24/10/2026)

- [SUPOSIÇÃO] Decisão expressa do dono em 24/10/2026: CP2-000e-3 **ACEITA PELO DONO, com ressalva** — "decisão do dono: aceito". Este registro substitui as pendências históricas de decisão de aceite da etapa -3 nos relatos de -3, -3a e -3b, preservando as evidências e os limites daqueles relatos.
- [SUPOSIÇÃO] Resumo das evidências anteriores aceitas pelo dono, sem nova validação neste ticket: fidelidade 24/24 em bytes e SHA-256 entre MCP, disco, manifesto e blobs do commit 7969b6a6fc2a273148bf06a4310575ef1ebc377f.
- [SUPOSIÇÃO] Referências ausentes do perfil Tropical (raiz, marcadores e terminal): conhecidas, inativas e herdadas; por decisão do dono, a limpeza fica para a V2.
- [SUPOSIÇÃO] Ressalva 3 — restrição vigente para as etapas seguintes: **não trocar ActiveProfileId para Tropical**, pois causaria assert no servidor pelas referências ausentes, conforme a análise registrada em CP2-000e-3a. O aceite não autoriza essa troca.
- [NÃO ENCONTRADO] NÃO TESTADO: checkout futuro, posição, suporte físico, funcionamento e gameplay.
- [SUPOSIÇÃO] O funcionamento é relato do dono; não constitui teste executado pelo agente.
- [SUPOSIÇÃO] CP2-000e-4 continua com aprovação **PENDENTE**; aceitar a -3 não inicia nem autoriza a -4. As aprovações de -5 a -8 também permanecem PENDENTES.

## CP2-000e-4+5 — Execução parcial interrompida (24/10/2026)

- [SUPOSIÇÃO] Aprovação vigente do dono: -4 e -5 APROVADAS para execução somente na descartável, inclusive plano e reabertura sem salvar entre ensaios. Este registro substitui pendências históricas de autorização de -4/-5; não concede aceite de resultado. -6 a -8 continuam PENDENTES. Alteração de Source e atributos preexistentes em scripts ficam NÃO TESTADOS por decisão do dono.
- [CONFIRMADO NO CÓDIGO] Sessão única MCP CumbiaParty_V2_Descartavel.rbxl em Edit. Snapshot inicial: 24/24 Sources iguais ao disco em bytes e SHA-256; atributos vazios nos scripts e ArchitectureVersion number 3 nas três pastas CumbiaParty. Classes, execução, filhos dos ancestrais e referência estrutural de 10736 objetos registrados no manifesto.
- [CONFIRMADO NO CÓDIGO] default.project.json preparado com somente 24 folhas e ancestrais, filhos desconhecidos preservados por configuração e atributos tipados. CLI/plugin 7.7.1; CLI por caminho completo, sem PATH. Servidor iniciou após correção da declaração de classe das folhas e foi encerrado por Ctrl+C. rokit.toml não necessário nem criado.
- [CONFIRMADO NO CÓDIGO] Execução interrompida antes de aceitar prévia: automação da interface apresentou layouts inconsistentes e bloqueio de clique por janela diferente. Painel observado desconectado após erro de conexão. Nenhuma sincronização aceita pelo agente, escrita MCP no DataModel, alteração de Source, Play, require, syncback, gravação .rbxl ou commit.
- [NÃO ENCONTRADO] -4 e -5 NÃO CONCLUÍDAS. Ensaios de atributos, reabertura entre ensaios, prévia e comparação pós-sync NÃO TESTADOS. Configuração candidata, sem comprovação de preservação. Gameplay e etapas -6 a -8 NÃO TESTADOS.
- [SUPOSIÇÃO] Próximo passo: interface estável ou condução manual do painel pelo dono, repetindo identidade/Edit e snapshot antes da conexão. Evidências, versões, comandos, hashes, limites e bloqueio no registro CP2-000e-4+5 de MIGRATION_MANIFEST.md. CURRENT_STATE.md fora do escopo específico.

## CP2-000e-5a — Decisão do dono e pendências (24/10/2026)

- [SUPOSIÇÃO] -4: **prova parcial concluída; aceite integral pendente**. ArchitectureVersion declarado preservado; omissões, alteração de Source e atributos preexistentes em scripts NÃO TESTADOS.
- [CONFIRMADO NO CÓDIGO] -5: 14/24 SHA-256 exatos; dez Sources diferiram somente pela remoção de CR. Classes, caminhos, atributos, propriedades de execução, ancestrais e 10.736 objetos coincidiram. Critério original 24/24 SHA-256 NÃO atendido. Lista e hashes no [manifesto](../TECH/MIGRATION_MANIFEST.md#cp2-000e-5a--resultado-da-sincronização-e-decisão-sobre-cr-24102026).
- [SUPOSIÇÃO] Decisão do dono: -5 **ACEITA** pelo critério revisado: 14 hashes exatos e igualdade após remover CR nos dez caminhos fechados. Qualquer outra diferença permanece divergência. Causa atribuída ao Rojo somente como hipótese, sem comprovação documental ou ensaio.
- [SUPOSIÇÃO] Relato do dono: prévia vista e aceita; Rojo desconectado; descartável fechada sem salvar. [NÃO ENCONTRADO] Conteúdo da prévia e .rbxl salvo NÃO TESTADOS por agente.
- [SUPOSIÇÃO] -6 a -8 PENDENTES. Na -7, considerar diferença de CR entre Studio e src/; default.project.json permanece candidato. Processo rojo serve PID 48224 encerrado após conferir identidade.
