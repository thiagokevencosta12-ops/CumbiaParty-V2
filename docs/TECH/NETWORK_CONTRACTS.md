# Contratos de rede — referência V1 e requisitos V2

## Escopo

- [SUPOSIÇÃO] Resumo documental de [V1_INVENTORY](../OPS/V1_INVENTORY.md), [V1_DEPENDENCIES](V1_DEPENDENCIES.md) e do rascunho anterior. As marcações de código abaixo reproduzem evidências da auditoria V1 de 22/10/2026; não houve nova inspeção no Studio nem teste de protocolo.
- [CONFIRMADO NO CÓDIGO] Segundo a auditoria, os nove RemoteEvents ativos ficam em `ReplicatedStorage.CumbiaParty.Remotes`. Os sete conjuntos de backup não são o transporte ativo; seus caminhos constam no inventário.
- [SUPOSIÇÃO] C→S significa cliente para servidor; S→C, servidor para cliente; `?` indica campo condicional. A tabela resume campos essenciais, não um schema completo para geração de código.

## Mensagens existentes na V1

| Estado | Remote / direção | Payload essencial e responsabilidade |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | ClientReady C→S | Sem argumentos; bootstrap reenvia estado de batalha/ritmo, torneio e eventual arena; cooldown de 1 s. |
| [CONFIRMADO NO CÓDIGO] | SubmitNote C→S | `{protocolVersion,sessionId,noteId,lane,inputTime,action?}`; RhythmService/NoteValidator verificam sessão própria, nota, coluna, tempo, ordem, duplicação e hold. |
| [CONFIRMADO NO CÓDIGO] | RhythmControl C→S | `action`: Start, Cancel, CancelInvite, Invite, Accept, Decline; `sessionId/battleId`, `targetUserId` ou `inviteId` conforme ação. Servidor verifica disponibilidade, propriedade e convite. |
| [CONFIRMADO NO CÓDIGO] | TournamentRequest C→S | `{action}`: Join, LeaveQueue, ExitView, Withdraw, Snapshot; valida participação/reserva e cooldown de 0,35 s. |
| [CONFIRMADO NO CÓDIGO] | LobbyRequest C→S | `{action="Return",preserveView?}`; cooldown de 0,5 s, valida atividade/reserva, área, personagem e destino definido no servidor. |
| [CONFIRMADO NO CÓDIGO] | BattleState S→C | `protocolVersion,userId,minigameId,phase,mode`; sessão/chart/stats/revision/judged ou convite/combat conforme estado. Combat inclui HP, participantes, prazo e resultado. |
| [CONFIRMADO NO CÓDIGO] | NoteResult S→C | Rejeição: `accepted=false,reason,sessionId?,noteId?`; Holding: IDs/startGrade; julgamento final: IDs/grade/completion/revision/stats. |
| [CONFIRMADO NO CÓDIGO] | TournamentState S→C | `protocolVersion,queue,tournament?,error?`; fila, participantes, chave, eliminação e campeão produzidos pelo servidor. |
| [CONFIRMADO NO CÓDIGO] | LobbyState S→C | `action`: OpenTournament, Returned, ArenaAssigned, ArenaReleased; atribuição inclui matchId/arenaId/tournamentId/camera/deadline e apresentação opcional; liberação identifica matchId. |

## Validação e confiança

- [CONFIRMADO NO CÓDIGO] Na V1, SubmitNote exige protocolo 3; IDs são strings não vazias de até 64 caracteres; lane é inteiro finito de 1 a 4; inputTime é finito; action aceita Begin/End/HoldPulse (ausente = Begin). O Player vem do evento, não de identidade alegada no payload.
- [CONFIRMADO NO CÓDIGO] O servidor calcula grade, pontos, combo, dano, HP e vencedor. Campos extras de resultado enviados pelo cliente não entram nesses cálculos. Bots usam SubmitServerInput interno, não um Remote.
- [CONFIRMADO NO CÓDIGO] R1: o julgamento usa inputTime do cliente. A V1 tolera atraso de `clamp(ping + 0,075; 0,075; 0,250)` segundos e futuro de até 0,035 s, além de verificar recebimento, ordem e holds.
- [SUPOSIÇÃO] Informar tempo ideal dentro dessa tolerância pode melhorar a nota; validar intervalo não comprova o instante físico da tecla. A política V2 exige decisão e teste no CP2-007.
- [CONFIRMADO NO CÓDIGO] SubmitNote/RhythmControl/TournamentRequest compartilham limite de 80 eventos/jogador por janela fixa de 1 s; rate limit pode descartar silenciosamente. ClientReady e LobbyRequest têm controles separados.
- [CONFIRMADO NO CÓDIGO] Versão e revisão não são uniformes: apenas SubmitNote exige versão na entrada; NoteResult/LobbyState não possuem protocolVersion; TournamentState/LobbyState não têm revisão monotônica. NetworkTypes não executa validação; não há ACK padronizado para todos os pedidos.

## Aplicação à V2

- [SUPOSIÇÃO] Requisito aprovado: A/S/D/F substitui D/F/J/K na entrada/apresentação; as quatro colunas continuam sendo intenções. Servidor mantém autoridade sobre todos os resultados. Ver [GAME_DESIGN](../PRODUCT/GAME_DESIGN.md).
- [NÃO ENCONTRADO] Contrato implementado da V2, versão final, política de latência, limites finais de payload e decisão sobre holds/Great. Protocolo 3 e tolerâncias acima descrevem a V1, não novos valores aprovados.
- [SUPOSIÇÃO] Aceite proposto: testar payload inválido, NaN/infinito, sessão alheia, replay, duplicação, ordem, spam e tempo forjado; medir snapshots e verificar ressincronização. Planejamento em [BACKLOG](../OPS/BACKLOG.md).
- [NÃO ENCONTRADO] Resultados desses testes, medições de tráfego e contratos de Dança das Cadeiras/Sobrevivência.
