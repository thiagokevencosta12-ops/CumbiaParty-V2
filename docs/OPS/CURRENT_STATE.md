# Estado atual — pós-migração CP2-000e (27/10/2026)

## Produto e decisões

- [SUPOSIÇÃO] O dono definiu Torneio X1 como MVP, Dança das Cadeiras e Sobrevivência como os outros minigames, visual Underground e A/S/D/F como teclas de ritmo da V2. A base migrada ainda usa D/F/J/K; a mudança pertence à CP2-001, NÃO INICIADA. Regras em [GAME_DESIGN](../PRODUCT/GAME_DESIGN.md).
- [SUPOSIÇÃO] O servidor deve decidir notas, pontos, dano, eliminação e prêmios. A migração foi mecânica e não prova que todas as decisões existentes já respeitam essa regra. R1–R7 e demais mudanças de gameplay continuam em tickets próprios.
- [SUPOSIÇÃO] Não trocar `ActiveProfileId` para Tropical. O perfil ativo registrado no código é Underground; referências Tropical ausentes foram documentadas na CP2-000e-3a.
- [SUPOSIÇÃO] Continuam pendentes decisões de produto sobre empate quando a música do X1 acaba, dano, estamina, parada da música, dificuldade dos bots, dispositivos e latência. Confirmar os termos de uso de áudio de referência do Mureka antes de publicar; ver GAME_DESIGN.

## Estado técnico

- [CONFIRMADO NO CÓDIGO] O repositório contém 24 Sources em `src/`: 11 do servidor, 4 compartilhados e 9 do cliente; `default.project.json` mapeia esses scripts e ancestrais necessários, com `name = CumbiaParty_V2_Trabalho`. Rojo 7.7.1 e Rokit 1.2.0 são as versões registradas nas etapas anteriores. O [manifesto](../TECH/MIGRATION_MANIFEST.md) detalha caminhos, classes, hashes e diferenças.
- [CONFIRMADO NO CÓDIGO] Na sessão única `CumbiaParty_V2_Trabalho.rbxl` em Edit, após reabertura relatada pelo dono, 14 Sources são iguais aos arquivos em `src/` e dez são iguais após remover CR dos arquivos. Os SHA-256 dos 24 arquivos do repositório coincidem com o manifesto. Classes, atributos vazios dos scripts, `ArchitectureVersion` de tipo number e valor 3 nas três pastas CumbiaParty, e os 11 ancestrais conferidos coincidem. `ServerBootstrap` e `ClientBootstrap` estão habilitados, um por lado, com `RunContext.Legacy`; `UnitTestRunner` e `CumbiaPartyFestivalFX` estão desabilitados.
- [CONFIRMADO NO CÓDIGO] A estrutura das 13 raízes, 10.736 objetos ao todo, tem os mesmos hashes de caminho, classe e número de filhos do snapshot da V2_Trabalho anterior à sincronização. Isso não compara todas as propriedades visuais e físicas dos objetos externos.
- [CONFIRMADO NO CÓDIGO] Após a reabertura, `game.Name = CumbiaParty_V2_Trabalho.rbxl`. Imediatamente após a sincronização da CP2-000e-7 havia sido lido `CumbiaParty_V2_Trabalho`. A diferença observada no nome não é uma divergência de Source.
- [SUPOSIÇÃO] O Studio pode recompor `game.Name` a partir do nome do arquivo local ao abri-lo. A [documentação oficial sobre abertura de arquivos locais](https://create.roblox.com/docs/studio/cli) confirma a abertura de `.rbxl` por caminho, mas não descreve esse efeito no `game.Name`; a causa permanece sem prova direta.
- [SUPOSIÇÃO] O dono relatou que aplicou CP2-000e-7, salvou a V2_Trabalho depois da sincronização, fechou e reabriu o arquivo e desconectou o Rojo. A leitura da sessão reaberta comprova o estado observado nela; o histórico de salvamento e a desconexão são relatos do dono, sem verificação independente.

## Fluxo de trabalho

- [SUPOSIÇÃO] Editar os 24 scripts gerenciados em `src/`, revisar as mudanças no Git e sincronizá-los para a V2_Trabalho pelo Rojo conforme `default.project.json`, conferindo a prévia antes de aceitar. Não usar alterações diretas de Source no Studio como fluxo normal nem fazer syncback automático. `src/` sozinho não reconstrói o jogo completo.
- [CONFIRMADO NO CÓDIGO] Mapa, Terrain, GUI, Remotes e outros objetos fora dos 24 scripts mapeados permanecem no `.rbxl`; o Studio é a fonte para editar esses objetos. Backups, ferramentas de autoria e UnitTest preservados no place não foram migrados para `src/`.
- [CONFIRMADO NO CÓDIGO] CP2-000f concluída documentalmente em 27/10/2026: [rokit.toml](../../rokit.toml) criado na raiz com somente `[tools]` e `rojo = "rojo-rbx/rojo@7.7.1"`, em duas linhas com quebra final. A pendência de ausência do arquivo foi resolvida; instalação não testada.
- [CONFIRMADO NO CÓDIGO] Leitura documental nesta sessão: [ADR-0001](../../decisions/ADR-0001.md) fixa Rojo 7.7.1, mas não escreve literalmente `rojo-rbx/rojo`; o caminho registrado na [etapa CP2-000e-1](../TECH/MIGRATION_PLAN.md#cp2-000e-1--preparar) contém esse identificador e registra Rokit 1.2.0 instalado. A instalação atual não foi reconfirmada por execução.
- [SUPOSIÇÃO] Sintaxe baseada na seção oficial [With Rokit da release 7.7.1](https://github.com/rojo-rbx/rojo/releases/tag/v7.7.1); o [README do Rokit](https://github.com/rojo-rbx/rokit#usage) descreve `rokit install` como instalação das ferramentas do projeto. O arquivo só declara Rojo, sem declarar ou instalar Rokit.
- [CONFIRMADO NO CÓDIGO] A regra lida em `.gitattributes`, `src/** -text`, não abrange `rokit.toml` na raiz; `git check-attr` retornou `text` e `eol` como `unspecified` para ele.
- [SUPOSIÇÃO] Aviso LF→CRLF esperado para o arquivo na raiz, considerando `core.autocrlf=true` registrado na CP2-000e-2a; Git config não foi consultado nem alterado nesta tarefa.
- [NÃO ENCONTRADO] NÃO TESTADO na CP2-000f: leitura de `rokit.toml` pelo Rokit, instalação e resolução efetiva de Rojo 7.7.1 por `rokit install`. Verificação reservada ao dono ou a ticket próprio com aprovação explícita; nenhum comando Rokit/Rojo executado nesta tarefa.
- [SUPOSIÇÃO] Não foi criada cópia pre-rojo por decisão do dono. O ponto de retorno indicado por ele é `CumbiaParty_V2_Trabalho_pre-migracao.rbxl`, anterior à V2_Trabalho de 23/10/2026 11:44 e NÃO TESTADO. Restaurá-lo pode perder alterações do intervalo; risco aceito pelo dono. Não descrevê-lo como restauração confiável.

## Próximo ticket e limites

- [SUPOSIÇÃO] Próximo ticket: CP2-001, implementação e teste ponta a ponta das teclas A/S/D/F. CP2-001 NÃO INICIADA. CP2-000c continua sem conclusão suficiente segundo o backlog.
- [NÃO ENCONTRADO] NÃO TESTADO: respawn, saída antecipada da fila, múltiplos humanos, notas em tempo controlado, resultados internos de bots/servidor, suíte UnitTest, mobile, segurança, desempenho, memória, propriedades completas dos objetos externos, abertura/restauração do pré-migração e checkout futuro dos blobs de `src/`.
