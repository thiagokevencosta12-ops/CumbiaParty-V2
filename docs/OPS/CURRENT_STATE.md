# Estado atual — RASCUNHO

- [SUPOSIÇÃO] Síntese documental de 22/10/2026: [inventário V1](V1_INVENTORY.md) (I), [dependências](../TECH/V1_DEPENDENCIES.md) (D) e [classificação](V1_CLASSIFICATION.md). Não houve leitura de código/objetos no Studio nesta tarefa; os relatos técnicos abaixo não são confirmação direta nem equivalência com produção.

## O que existe segundo a auditoria

- [SUPOSIÇÃO] A V1 auditada contém ritmo/solo (RhythmService, NoteValidator), X1 com HP (BattleService), ondas (WaveGenerator), competidores/bots e torneio com oito vagas (CompetitorService, BotService, TournamentService). I, “Módulos prioritários”; D, “Fluxos de dados”.
- [SUPOSIÇÃO] LobbyService, WorldBindings e ArenaService conectam retorno, respawn e arenas ao mapa CumbiaBattleWorld, perfil Underground. A interface usa ClientBootstrap e controllers; há nove RemoteEvents atuais. Cenário tropical, ferramentas e versões antigas estão preservados. I, “Mapa, lobby, iluminação, oceano e respawn”, “UI — ScreenGuis” e “RemoteEvents e RemoteFunctions”.
- [NÃO ENCONTRADO] Implementação local em src/tests e definição de produto em GAME_DESIGN.md. As fontes descrevem scripts no Studio, sem vínculo com commits locais de implementação. I, “Pasta do projeto”; D, “Verificação e limites”.

## O que parece funcionar pela estrutura descrita

- [SUPOSIÇÃO] Entrada → validação → julgamento → dano → avanço da chave forma um fluxo coerente. RhythmService calcula pontos/grades; BattleService calcula HP; TournamentService decide campeão. Guardas de estado parecem reduzir processamento duplicado, sem demonstrar segurança completa. D, “Fluxos de dados” e “R2 — pontuação, double-award e prêmios”.
- [SUPOSIÇÃO] Bots usam o mesmo julgador; arenas têm reserva/liberação e o cliente recebe snapshots para ressincronizar. São caminhos implementados segundo D, “Quem chama quem no servidor” e “Fluxos de dados”, não resultados de teste.

## O que parece quebrado, frágil ou incompleto

- [SUPOSIÇÃO] Julgamento ainda depende de inputTime do cliente dentro das tolerâncias: risco de precisão artificial a investigar em RhythmService/NoteValidator (D, R1).
- [SUPOSIÇÃO] Há lacunas de ciclo de vida: expiração de X1 sem ReleaseSession, históricos sem poda no ClientBootstrap/LobbyController e desconexão parcial ao destruir GUI (D, R3–R5). Retenção ou erros são possíveis; impacto não medido.
- [SUPOSIÇÃO] Snapshots completos e reconstrução da UI podem custar tráfego/CPU; falhas durante CreateSession/BindBattle podem deixar estado parcial. TournamentService/BattleService/TournamentController precisam de validação dirigida (D, R6–R7).
- [NÃO ENCONTRADO] Mecânicas próprias de Survival, Chairs, Score Attack, roleta, loja e freestyle: os nomes de áreas não comprovam implementação. Também faltam evidências de catálogo musical/animações e prêmios persistentes. I, “Mapa, lobby, iluminação, oceano e respawn”/“Assets”; D, R2.
- [NÃO ENCONTRADO] Defeito reproduzido ou sistema comprovadamente funcional nesta tarefa. Não há base para declarar a V1 pronta ou reutilizável integralmente.

## Verificação e não testado

- [SUPOSIÇÃO] Este rascunho serve para triagem; a classificação detalha evidência e recomendação por sistema, sem aprovar migração.
- [NÃO ENCONTRADO] Validação dinâmica nesta tarefa: NÃO TESTADOS gameplay, multiplayer, respawn, mobile, câmera, segurança, replay, callbacks concorrentes, falhas parciais, desempenho e memória. Os oito testes inventariados não foram executados (I, “Verificações realizadas e não testado”; D, “Verificação e limites”).

## Perguntas que só o dono pode responder

1. [NÃO ENCONTRADO] Quais modos, regras e direção visual definem a primeira entrega da V2?
2. [NÃO ENCONTRADO] Qual é a versão oficial da V1, e quais comportamentos você já validou ou viu falhar?
3. [NÃO ENCONTRADO] Quais dispositivos, concorrência e tolerância de latência são metas do produto?
4. [NÃO ENCONTRADO] Quais músicas/assets têm uso autorizado, e haverá progresso, prêmios ou monetização a preservar?
