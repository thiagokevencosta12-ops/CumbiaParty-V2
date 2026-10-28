# Estado atual — pós-migração CP2-000e (27/10/2026)

## Produto e decisões

- [SUPOSIÇÃO] O dono definiu Torneio X1 como MVP, Dança das Cadeiras e Sobrevivência como os outros minigames, visual Underground e D/F/J/K como teclas oficiais de ritmo do X1 e da Sobrevivência em decisão de 27/10/2026. O toque por quatro colunas permanece; Dança das Cadeiras não usa teclas de ritmo. Regras em [GAME_DESIGN](../PRODUCT/GAME_DESIGN.md).
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

- [SUPOSIÇÃO] CP2-001 CANCELADO por decisão do dono em 27/10/2026; o Play parcial na descartável foi uma tentativa descartada. CP2-000c continua sem conclusão suficiente segundo o backlog.
- [NÃO ENCONTRADO] NÃO TESTADO: respawn, saída antecipada da fila, múltiplos humanos, notas em tempo controlado, resultados internos de bots/servidor, suíte UnitTest, mobile, segurança, desempenho, memória, propriedades completas dos objetos externos, abertura/restauração do pré-migração e checkout futuro dos blobs de `src/`.

## CP2-001 — histórico da primeira tentativa descartada (27/10/2026)

- [CONFIRMADO NO CÓDIGO] Na primeira tentativa, o disco continha A/S/D/F nas colunas 1–4 nos cinco arquivos de src/ então editados. Nenhum script do servidor lia LaneKeys. A árvore StarterGui da sessão tinha D/F/J/K gravados nos rótulos de Lane1–Lane4; a atualização persistente da GUI no .rbxl era pendência daquela tentativa, encerrada pelo cancelamento.
- [SUPOSIÇÃO] O dono relatou aceite acidental da prévia de 15 itens, seguido de desconexão e fechamento da descartável sem salvar. O agente não salvou o place.
- [CONFIRMADO NO CÓDIGO] Antes do fechamento, o MCP viu os cinco Sources editados iguais ao disco (BattleHUD após remover um CR), nove Sources extras com apenas CR removidos, atributos e estrutura preservados, e game.Name alterado para CumbiaParty_V2_Trabalho. O PID 13428 do Rojo foi encerrado com executável e horário conferidos.
- [NÃO ENCONTRADO] NÃO TESTADO na primeira tentativa: conteúdo persistido do .rbxl após fechar, Play, teclado real, toque, acertos em tempo controlado, fila e torneio com bots. A necessidade então registrada de novo procedimento de sincronização foi encerrada pelo cancelamento.

## CP2-001 — histórico da retomada descartada e Play parcial (27/10/2026)

- [SUPOSIÇÃO] O dono aceitou a prévia de 15 itens, incluindo Name da raiz, cinco Sources editados e nove Sources com CR removido. A captura da prévia desta segunda conexão não foi colada; a leitura pós-sync do Studio confirmou o efeito.
- [CONFIRMADO NO CÓDIGO] Os 24 Sources pré-sync repetiram o snapshot da descartável. Pós-sync, cinco Sources editados e nove apenas sem CR foram as únicas alterações de Source; game.Name mudou para CumbiaParty_V2_Trabalho. Classes, atributos, estado de execução, 11 ancestrais e estrutura de 10.736 objetos permaneceram iguais.
- [CONFIRMADO NO CÓDIGO] Em Play, GUI e CAS mapearam A/S/D/F às colunas 1–4. Teclas J/K e A/S/D/F foram enviadas; solo terminou com Great 1 e 700 pontos, sem atribuição de nota a tecla específica. A fila passou a 1/8, o torneio exibiu oito competidores e terminou com KO na onda 7; voltar restaurou lobby e câmera Custom. Dois Plays foram parados e o Studio voltou a Edit.
- [NÃO ENCONTRADO] NÃO TESTADO nessa retomada: toque mobile, nota individual em tempo controlado por tecla, prova visual isolada de J/K ignoradas e resultados internos de bots/servidor. Os rótulos D/F/J/K persistiam na GUI do .rbxl; o cliente os substituía em runtime. A pendência de alterar esses rótulos foi encerrada pelo cancelamento. Fechamento sem salvar e parada do Rojo ainda não tinham sido registrados naquele momento.

## CP2-001a — decisão vigente e limites (27/10/2026)

- [SUPOSIÇÃO] Decisão do dono: D/F/J/K permanece layout oficial das quatro colunas de ritmo no Torneio X1 e na Sobrevivência; toque por coluna mantido. Dança das Cadeiras não usa teclas de ritmo. CP2-001 foi CANCELADO. Motivo informado pelo dono: pesquisa própria; nenhum detalhe adicional foi fornecido.
- [SUPOSIÇÃO] O dono relatou que descartou com `git restore` as edições de `src/` da CP2-001 e fechou a descartável sem salvar. As execuções acima são histórico de tentativa descartada.
- [CONFIRMADO NO CÓDIGO] Leitura local de CP2-001a encontrou D/F/J/K em `src/client/Controllers/InputController.luau` e somente os três documentos da CP2-001 modificados no `git status --short` inicial.
- [SUPOSIÇÃO] Rótulos D/F/J/K persistidos na GUI do `.rbxl` deixam de ser pendência de troca; o `.rbxl` não foi relido nesta tarefa.
- [SUPOSIÇÃO] CP2-005 em diante e os ADRs não dependem de A/S/D/F. No backlog, CP2-007a era o único ticket com dependência direta de CP2-001; a dependência passa a CP2-000e e CP2-000c. As referências vigentes a A/S/D/F foram corrigidas nos documentos autorizados; registros históricos da migração e da tentativa descartada permanecem históricos.
- [NÃO ENCONTRADO] NÃO TESTADO em CP2-001a: Studio, Rojo, persistência do `.rbxl`, toque mobile, notas individuais, julgamento e resultados internos do servidor/bots. Nenhum teste de gameplay foi executado.
