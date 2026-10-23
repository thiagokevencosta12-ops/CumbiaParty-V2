# Backlog inicial — Cumbia Party V2

- [SUPOSIÇÃO] Tickets propostos a partir de [ARCHITECTURE](../TECH/ARCHITECTURE.md), [NETWORK_CONTRACTS](../TECH/NETWORK_CONTRACTS.md), [V1_CLASSIFICATION](V1_CLASSIFICATION.md), [GAME_DESIGN](../PRODUCT/GAME_DESIGN.md) e [CURRENT_STATE](CURRENT_STATE.md). Cada marcação abrange objetivo, aceite, risco e dependências; nenhum ticket está concluído. Risco é estimativa técnica.
- [SUPOSIÇÃO] Decisões do dono são bloqueadores, não valores a inferir da V1. O CP2-001 é uma prova isolada do pipeline existente, sem certificar segurança ou regras finais do MVP. Não autoriza publicar nem alterar a base histórica.

## Prova inicial

### CP2-001 — A/S/D/F de ponta a ponta

- [SUPOSIÇÃO] Objetivo: trocar D/F/J/K por A/S/D/F no X1 da cópia de trabalho e provar entrada → servidor → feedback.
- [SUPOSIÇÃO] Aceite: em teste cliente/servidor no Studio, cada tecla aciona sua coluna e recebe resultado do servidor; J/K deixam de acionar colunas; rótulos conferem; alteração sincronizada é inspecionável no repositório. Registrar procedimento e resultado.
- [SUPOSIÇÃO] Risco: médio. Dependências: (a) cópia de trabalho do Studio definida como local da alteração; (b) escolha Rojo ou Script Sync na fase de prova do pipeline; (c) identificação da base oficial da V1.

## Decisões do dono — bloqueiam combate

| Estado | ID / objetivo | Aceite | Risco | Dependências |
|---|---|---|---|---|
| [SUPOSIÇÃO] | CP2-002 — DECISÃO DO DONO: empate X1 | Registrar regra aprovada para fim da música com ambos vivos, incluindo HP igual. | médio | Dono; regra final [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-003 — DECISÃO DO DONO: dano por nota | Aprovar dano Perfect/Good, efeito de Miss e HP inicial; resolver Great/holds herdados antes de migrar. | médio | Dono; valores finais [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-004 — DECISÃO DO DONO: duração | Aprovar duração/condição de término e relação com música, ondas e turnos. | médio | Dono, CP2-002; duração [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-005 — DECISÃO DO DONO: bots | Aprovar nível de habilidade e critérios verificáveis de comportamento. | médio | Dono; parâmetros [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-006 — DECISÃO DO DONO: latência | Aprovar tolerância e tratamento de entrada atrasada/futura, subsidiados por investigação de R1. | alto | Dono; política final [NÃO ENCONTRADO]. |

## Implementação do MVP X1

| Estado | ID / objetivo | Aceite verificável | Risco | Dependências |
|---|---|---|---|---|
| [SUPOSIÇÃO] | CP2-007 — Validar entradas no servidor (R1) | Investigar inputTime forjado; implementar política aprovada; executar testes de limites temporais, NaN/infinito, IDs, sessão alheia, replay, duplicação, ordem e spam. Resultados seguem política; cliente não atribui nota/dano. | ALTO | CP2-001; aceite depende de CP2-006. Investigação pode subsidiar a decisão. |
| [SUPOSIÇÃO] | CP2-008 — Combate X1 autoritativo | Julgamento aplica dano/HP aprovados; KO, fim por duração e empate seguem decisões; evento repetido não duplica dano nem conclusão. Executar testes cliente/servidor. | alto | CP2-002, CP2-003, CP2-004, CP2-005, CP2-006 e CP2-007. |
| [SUPOSIÇÃO] | CP2-009 — Fila, bots e chave | Testar oito vagas, bots somente nas faltantes, mesmo julgador para bots, avanço único, desistência e campeão; impedir reserva dupla. | alto | CP2-008. |
| [SUPOSIÇÃO] | CP2-010 — Lobby, arena e liberação | Testar entrada/retorno do eliminado, saída e respawn; injetar falha de criação e verificar liberação de reservas/sessões/arena; repetir partidas sem callbacks duplicados. | alto | CP2-009; CumbiaBattleWorld identificado na cópia de trabalho. |
| [SUPOSIÇÃO] | CP2-011 — HUD e apresentação Underground | Conferir A/S/D/F, toque, HP/resultado do servidor e câmera; testar recriação da GUI e restauração de controles, sem acúmulo de conexões/históricos. | médio | CP2-010; dispositivos de aceite [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-012 — Música e chart do MVP | Identificar faixa com direito de uso confirmado, implementar alinhamento áudio/notas e verificar início/fim com regras aprovadas. | alto | CP2-008; faixa/licença e chart aprovados [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-013 — Validar MVP integrado | Executar lobby → fila → X1 → campeão/retorno com humanos e bots; registrar testes de latência, saída, repetição, tráfego e memória, falhas e itens não testados. | alto | CP2-011, CP2-012; dispositivos/concorrência/metas de desempenho acordados com dono [NÃO ENCONTRADO]. |

## Épicos futuros — fora do MVP

| Estado | ID / objetivo | Aceite do planejamento | Risco | Dependências |
|---|---|---|---|---|
| [SUPOSIÇÃO] | CP2-014 — Dança das Cadeiras | Decompor regras aprovadas em tickets de corrida/estamina, música, ocupação decidida pelo servidor e eliminação; listar decisões pendentes. | alto | CP2-013 e priorização do dono; parâmetros finais [NÃO ENCONTRADO]. |
| [SUPOSIÇÃO] | CP2-015 — Sobrevivência | Decompor chart comum A/S/D/F, pontuação zerada por onda, erros/desempate e eliminação no servidor; listar parâmetros pendentes. | alto | CP2-013 e priorização do dono; progressão/duração/bots [NÃO ENCONTRADO]. |
