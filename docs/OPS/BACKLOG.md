# Backlog inicial — Cumbia Party V2

- [SUPOSIÇÃO] Planejamento baseado em [GAME_DESIGN](../PRODUCT/GAME_DESIGN.md), [CURRENT_STATE](CURRENT_STATE.md), [V1_CLASSIFICATION](V1_CLASSIFICATION.md), [ARCHITECTURE](../TECH/ARCHITECTURE.md) e [NETWORK_CONTRACTS](../TECH/NETWORK_CONTRACTS.md). Marcações abrangem cada linha; riscos são estimativas; nenhum ticket está concluído. Documentos de entrega citados serão criados nos respectivos tickets.
- [SUPOSIÇÃO] Testes iniciais (pipeline, A/S/D/F e R1) usam som provisório ou metrônomo. A conferência da auditoria precede qualquer implementação no jogo; a prova isolada do pipeline ocorre em projeto descartável. Nenhum ticket autoriza publicação ou alteração da base histórica.

## Preparação e prova inicial

| Estado | ID / objetivo | Aceite | Risco | Dependências |
|---|---|---|---|---|
| [SUPOSIÇÃO] | CP2-000a — Identificar base V1 | Dono confirma arquivo/place oficial e cópia de trabalho do Studio, local das alterações; registrar identificação e localização de ambos. | baixo | Dono; base oficial [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-000b — Provar pipeline | Em projeto descartável, demonstrar alteração sincronizada Studio/repositório e repetição do procedimento; registrar escolha Rojo ou Script Sync, direção da sincronização e evidências em `decisions/ADR-0001.md`. | médio | CP2-000a. |
| [SUPOSIÇÃO] | CP2-000c — Conferir auditoria por amostra | Comparar entrada, julgamento/R1, combate, torneio e Remotes com Studio; registrar versão inspecionada, amostra, correspondências e divergências em documento versionado `docs/OPS/V1_AUDIT_SPOTCHECK.md`; resolver divergências impeditivas antes de implementar. | médio | CP2-000a; inspeção na cópia de trabalho. |
| [SUPOSIÇÃO] | CP2-001 — A/S/D/F ponta a ponta | Na cópia de trabalho, trocar D/F/J/K; testar cada coluna até resultado do servidor, rótulos e ausência de entrada por J/K; registrar evidências e alteração sincronizada no repositório. | médio | CP2-000a, CP2-000b, CP2-000c. |

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
