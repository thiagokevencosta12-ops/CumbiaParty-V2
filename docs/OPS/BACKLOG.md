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
- [SUPOSIÇÃO] CP2-000e-1 — Preparar: conferir referência e backup preservado com as dispensas abaixo, registrar inventário e conferir origem/identidade da cópia já criada segundo o dono, `CumbiaParty_V2_Descartavel.rbxl`. Aprovação do dono: PENDENTE.
- [SUPOSIÇÃO] CP2-000e-2 — Extrair: obter os 24 Sources pelo método MCP atual e registrar manifesto. Depende do aceite de CP2-000e-1. Aprovação do dono: PENDENTE.
- [SUPOSIÇÃO] CP2-000e-3 — Conferir em disco: comparar origem independente, bytes, SHA-256, classes e referências; exigir 24/24 correspondências. Depende do aceite de CP2-000e-2. Aprovação do dono: PENDENTE.
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
