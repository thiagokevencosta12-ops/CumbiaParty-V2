# Estado atual — RASCUNHO

## Decisões da V2 (definidas pelo dono)
- MVP: Torneio X1 (batalha 1x1, vence quem zerar o HP do adversário).
- Três minigames: X1, Dança das Cadeiras, Sobrevivência.
- Teclas dos minigames de ritmo: A/S/D/F (a V1 usava D/F/J/K).
- Visual: Underground (base: greybox CumbiaBattleWorld). O cenário
  tropical da V1 NÃO faz parte da V2.
- Fora do escopo por ora: loja, roleta, cosméticos, monetização,
  progresso persistente, espectador, minigame 4.
- Regras completas em docs/PRODUCT/GAME_DESIGN.md.

## Estado do repositório V2
- [CONFIRMADO] Existem docs/PRODUCT (VISION, GAME_DESIGN), a auditoria
  da V1 (V1_INVENTORY, V1_DEPENDENCIES, V1_CLASSIFICATION), ARCHITECTURE,
  NETWORK_CONTRACTS e BACKLOG.
- [NÃO ENCONTRADO] Implementação em src/ e tests/ (pastas vazias).
  A V1 vive no Studio, sem vínculo com commits.
- V1 congelada (não editar): C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V1_2026-10-22.rbxl
- Cópia de trabalho: C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V2_Trabalho.rbxl
- [CONFIRMADO] MCP aponta para a cópia de trabalho (23/10/2026): 12
  scripts listados em ServerScriptService, batendo com o inventário.

## O que existe na V1 (segundo a auditoria)
- [SUPOSIÇÃO] Ritmo solo (RhythmService, NoteValidator), X1 com HP
  (BattleService), ondas (WaveGenerator), competidores/bots e torneio
  de oito vagas (CompetitorService, BotService, TournamentService).
- [SUPOSIÇÃO] LobbyService, WorldBindings e ArenaService ligam retorno,
  respawn e arenas ao mapa CumbiaBattleWorld. Interface via
  ClientBootstrap e controllers; nove RemoteEvents.
- [SUPOSIÇÃO] Cenário tropical, ferramentas de autoria e versões antigas
  estão preservados na V1 (não entram na V2).

## O que parece funcionar (pela estrutura, não testado)
- [SUPOSIÇÃO] Fluxo entrada → validação → julgamento → dano → avanço da
  chave parece coerente. Bots usam o mesmo julgador das notas.

## Frágil ou incompleto (investigar antes de migrar)
- [SUPOSIÇÃO] R1: julgamento usa o horário enviado pelo cliente.
- [SUPOSIÇÃO] R3–R5: lacunas de ciclo de vida (sessão não liberada ao
  expirar X1, históricos sem poda, desconexão parcial da GUI).
- [SUPOSIÇÃO] R6–R7: snapshots pesados e criação parcial de estado.
- Detalhes em docs/TECH/V1_DEPENDENCIES.md.

## Não existe no código da V1 (trabalho novo)
- Dança das Cadeiras e Sobrevivência (só há objetos no mapa).
- Persistência, prêmios, catálogo musical e animações.

## Não testado
- Gameplay, multiplayer, mobile, respawn, câmera, segurança,
  desempenho e memória. Os oito testes inventariados não foram
  executados.

## Pendências do dono
1. Empate no X1: música acaba com os dois vivos (mais HP ou morte súbita?).
2. Valores de dano, estamina, parada da música e dificuldade dos bots.
3. Dispositivos-alvo, concorrência e tolerância de latência.
4. Música: confirmar o que os termos do Mureka dizem sobre áudio de
   referência (licença só vale com plano ativo; ver GAME_DESIGN.md).