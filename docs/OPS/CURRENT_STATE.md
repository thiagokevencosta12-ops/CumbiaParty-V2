# Estado atual — RASCUNHO

## Decisões da V2 (definidas pelo dono)
- MVP: Torneio X1 (batalha 1x1, vence quem zerar o HP do adversário).
- Três minigames: X1, Dança das Cadeiras, Sobrevivência.
- Teclas dos minigames de ritmo: A/S/D/F (a V1 usava D/F/J/K).
- Visual: Underground (base: greybox CumbiaBattleWorld).
- Fora do escopo por ora: loja, roleta, cosméticos, monetização,
  progresso persistente, espectador, minigame 4.
- Regras completas em docs/PRODUCT/GAME_DESIGN.md.

## Estado do repositório V2
- [CONFIRMADO] Existem docs/PRODUCT (VISION, GAME_DESIGN) e a auditoria
  da V1 (V1_INVENTORY, V1_DEPENDENCIES, V1_CLASSIFICATION).
- [NÃO ENCONTRADO] Implementação em src/ e tests/ (pastas vazias).
  A V1 vive no Studio, sem vínculo com commits.

## O que existe na V1 (segundo a auditoria)
- [SUPOSIÇÃO] Ritmo solo (RhythmService, NoteValidator), X1 com HP
  (BattleService), ondas (WaveGenerator), competidores/bots e torneio
  de oito vagas (CompetitorService, BotService, TournamentService).
- [SUPOSIÇÃO] LobbyService, WorldBindings e ArenaService ligam retorno,
  respawn e arenas ao mapa CumbiaBattleWorld. Interface via
  ClientBootstrap e controllers; nove RemoteEvents.
- [SUPOSIÇÃO] Cenário tropical, ferramentas de autoria e versões antigas
  estão preservados (Referência, não entram na V2).

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
4. Músicas e assets com direitos de uso confirmados.
5. Qual é o arquivo/place oficial da V1.