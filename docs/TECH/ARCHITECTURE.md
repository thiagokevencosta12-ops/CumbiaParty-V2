# Arquitetura — Cumbia Party V2

## Base e leitura

- [SUPOSIÇÃO] Síntese de [V1_INVENTORY](../OPS/V1_INVENTORY.md), [V1_DEPENDENCIES](V1_DEPENDENCIES.md), [V1_CLASSIFICATION](../OPS/V1_CLASSIFICATION.md), [VISION](../PRODUCT/VISION.md), [GAME_DESIGN](../PRODUCT/GAME_DESIGN.md) e [CURRENT_STATE](../OPS/CURRENT_STATE.md). Não houve nova inspeção no Studio; evidências da V1 são atribuídas às auditorias.
- [SUPOSIÇÃO] Requisitos e propostas da V2 usam esta marcação para distingui-los de implementação comprovada; as decisões do dono citadas abaixo já estão aprovadas. Perguntas antigas respondidas pelo produto não são pendências atuais.
- [NÃO ENCONTRADO] Implementação local da V2, identificação da base oficial da V1 e escolha de sincronização Studio/repositório (Rojo ou Script Sync).

## Destino aprovado

- [SUPOSIÇÃO] Requisito V2: visual Underground, com CumbiaBattleWorld como base; três minigames: X1, Dança das Cadeiras e Sobrevivência. MVP: somente Torneio X1.
- [SUPOSIÇÃO] Fluxo: lobby → fila → oito participantes, completados por bots → chave de batalhas 1x1 → campeão → lobby; eliminado retorna ao lobby.
- [SUPOSIÇÃO] Requisito X1: quatro colunas D/F/J/K e toque no celular; Perfect/Good/Miss; vence quem zerar o HP adversário. Layout mantido por decisão do dono em 27/10/2026.
- [SUPOSIÇÃO] Servidor decide notas, dano, HP, eliminações e campeão; cliente envia intenções e apresenta resultados. Feedback local não confirma resultado.

## Responsabilidades e aproveitamento

| Estado | Camada / referência V1 | Destino proposto para o MVP |
|---|---|---|
| [SUPOSIÇÃO] | Servidor: ServerBootstrap, RhythmService, NoteValidator | Inicializar rotas e validar/julgar entradas; refatorar confiança temporal e ciclo de vida. |
| [SUPOSIÇÃO] | Servidor: BattleService, TournamentService | Controlar combate e chave; refatorar encerramento, liberação e recuperação de falha parcial. |
| [SUPOSIÇÃO] | Servidor: CompetitorService, BotService, WaveGenerator | Referências para reservas, bots pelo mesmo julgador e geração de notas; não pressupor migração integral. |
| [SUPOSIÇÃO] | Servidor: LobbyService, ArenaService, WorldBindings | Refatorar lobby/arenas; bindings como referência para reserva, posicionamento e restauração. |
| [SUPOSIÇÃO] | Cliente: ClientBootstrap, UIController e controllers | Entrada D/F/J/K, HUD, câmera e navegação; refatorar coordenação, retenção e desconexão de eventos. |
| [SUPOSIÇÃO] | Compartilhado: GameConfig, WorldConfig, NetworkTypes | Referências de configuração, mundo e mensagens; tipos não substituem validadores do servidor. |

- [SUPOSIÇÃO] A classificação não recomenda reutilização sem ressalvas. Estrutura final de arquivos da V2 depende da prova do pipeline; os nomes acima são referências da V1, não arquivos já migrados.
- [SUPOSIÇÃO] Fluxo técnico: entrada → SubmitNote → validação/julgamento no servidor → dano/HP → NoteResult/BattleState → HUD; conclusão → avanço da chave → TournamentState. Ver [NETWORK_CONTRACTS](NETWORK_CONTRACTS.md).

## Bloqueadores e limites

- [NÃO ENCONTRADO] Definição final de empate/fim da música, dano por nota, duração, nível dos bots e latência. Não adotar automaticamente valores da V1.
- [NÃO ENCONTRADO] Decisão sobre preservar holds, turnos e Great da V1; o design especifica Perfect/Good/Miss. Catálogo, direitos de uso e implementação de sincronização musical também permanecem pendentes.
- [SUPOSIÇÃO] R1–R7 orientam revisão: inputTime, resultados únicos, liberação de sessões, históricos limitados, desconexão de eventos, custo de snapshots e recuperação de criação parcial. São riscos documentados, não falhas reproduzidas nesta tarefa.
- [SUPOSIÇÃO] Dança das Cadeiras e Sobrevivência são épicos futuros. Loja, roleta, cosméticos, monetização, persistência, espectador e minigame 4 ficam fora do MVP.
- [NÃO ENCONTRADO] Evidência de gameplay, multiplayer, segurança ou desempenho validados. Execução e aceite seguem [BACKLOG](../OPS/BACKLOG.md).
