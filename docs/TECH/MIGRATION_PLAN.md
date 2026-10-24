# CP2-000d — Plano de migração do código para Rojo

## Escopo e evidências

- [SUPOSIÇÃO] Plano de execução futura, revisado conforme autorização do dono em 23/10/2026. Esta entrega é documental: somente `docs/TECH/MIGRATION_PLAN.md` e `docs/OPS/BACKLOG.md` podem ser alterados; não autoriza migração, conexão Rojo, syncback, Play, publicação ou alterações no Studio.
- [SUPOSIÇÃO] Segundo o registro da retomada anterior, este arquivo não existia; `src/` e `tests/` continham somente `.gitkeep`. A busca local daquela retomada não encontrou configuração `*.project.json`; esse estado histórico não foi revalidado nesta revisão.
- [SUPOSIÇÃO] O [ADR-0001](../../decisions/ADR-0001.md) registra Rojo 7.7.1 via Rokit, prova disco → Studio e reversão Git em projeto descartável; também determina que mapa e objetos visuais permanecem no `.rbxl`. Isso é evidência documental, não repetição da prova nesta sessão.
- [SUPOSIÇÃO] O [spotcheck](../OPS/V1_AUDIT_SPOTCHECK.md) registra sete itens correspondentes à auditoria na cópia de trabalho, incluindo estrutura, D/F/J/K e dependência de `inputTime`. Nenhum desses resultados foi revalidado no Studio nesta retomada.
- [SUPOSIÇÃO] Fontes de seleção: [inventário](../OPS/V1_INVENTORY.md), [classificação](../OPS/V1_CLASSIFICATION.md), [dependências](V1_DEPENDENCIES.md), [contratos](NETWORK_CONTRACTS.md), [arquitetura](ARCHITECTURE.md), [design](../PRODUCT/GAME_DESIGN.md) e [estado atual](../OPS/CURRENT_STATE.md). Propostas e requisitos usam [SUPOSIÇÃO], inclusive quando aprovados pelo dono; leituras locais e relatos documentais usam [SUPOSIÇÃO] e têm sua origem identificada; confirmação no código exige leitura no Studio nesta sessão, que não faz parte desta revisão.
- [SUPOSIÇÃO] O [backlog](../OPS/BACKLOG.md) registra CP2-000d como planejamento documental concluído e separa a execução no CP2-000e: as três decisões do dono foram aprovadas em 24/10/2026; as aprovações das etapas de execução continuam PENDENTES.

## Premissas, limites e pendências

- [SUPOSIÇÃO] A migração inicial será mecânica: preservar Source, nomes, classes, hierarquia e propriedades relevantes; não refatorar nem converter regras da V1 para V2 no mesmo lote. Copiar uma base para versionamento não significa aprová-la para o MVP.
- [SUPOSIÇÃO] A/S/D/F, correções de R1–R7, dano, empate, holds, Great e dificuldade dos bots pertencem a tickets próprios. O servidor continuará responsável por notas, pontos, dano e resultados; a migração não deve transferir autoridade ao cliente.
- [SUPOSIÇÃO] Não há pergunta impeditiva para escrever este plano. Antes de executar, será necessário conferir a identidade do place, estado do backup com as dispensas e riscos aceitos pelo dono, inventário atual e prévia de sincronização; qualquer divergência bloqueia a conexão até revisão.
- [SUPOSIÇÃO] O escopo explícito desta revisão substitui a regra geral de atualizar CURRENT_STATE.md: somente este plano e o backlog serão alterados. CURRENT_STATE.md, ADR, `src/`, `tests/`, configurações e Studio permanecerão intactos.

## Backup obrigatório e fonte inicial

- [SUPOSIÇÃO] Base histórica intocável: `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V1_2026-10-22.rbxl`; cópia operacional prevista: `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V2_Trabalho.rbxl`, conforme CURRENT_STATE.md.
- [SUPOSIÇÃO] Pré-requisito obrigatório antes de qualquer migração: `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V2_Trabalho_pre-migracao.rbxl`. Preservar esse arquivo sem conectar Rojo a ele nem sobrescrevê-lo durante o trabalho.
- [SUPOSIÇÃO] O registro da consulta local anterior relata o arquivo pré-migração no caminho acima, com 1.794.879 bytes. Existência e tamanho não foram revalidados nesta revisão; seu conteúdo não foi aberto no Studio.
- [NÃO ENCONTRADO] Integridade, capacidade de abertura e equivalência desse backup ao estado imediatamente anterior à migração não foram verificadas nesta sessão.
- [SUPOSIÇÃO] Decisões do dono em 24/10/2026: segunda cópia do backup da V1 em outro local DISPENSADA; teste de abertura de `CumbiaParty_V2_Trabalho_pre-migracao.rbxl` DISPENSADO. Riscos aceitos pelo dono. O pré-migração continua NÃO TESTADO e, enquanto não for testado, não deve ser descrito como ponto de restauração confiável.
- [SUPOSIÇÃO] Relato do dono em 24/10/2026, não verificado por agente: criou `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V2_Descartavel.rbxl`, copiada de `CumbiaParty_V2_Trabalho.rbxl` (modificado em 23/10/2026 11:44), com o Studio fechado. Relata que as duas cópias são iguais, que abriu e testou a descartável e que mecânicas e demais itens funcionam.
- [SUPOSIÇÃO] Estado de referência relatado pelo dono: `CumbiaParty_V2_Trabalho.rbxl` de 23/10/2026 11:44, posterior ao pré-migração de 23/10/2026 02:00. O relato de funcionamento da descartável serve de linha de base herdada para CP2-000e-6, sem constituir teste executado pelo agente.
- [NÃO ENCONTRADO] Hashes e tamanhos exatos da referência e da descartável não foram registrados em documento; as alterações entre 23/10/2026 02:00 e 11:44 não foram documentadas.
- [SUPOSIÇÃO] Na execução futura autorizada, registrar SHA-256, tamanho, data e identificação da cópia de trabalho e da descartável; conferir origem e identidade e preservar os arquivos de referência. As dispensas não eliminam as demais verificações de fidelidade e preservação.
- [SUPOSIÇÃO] A extração inicial deve ler a cópia de trabalho confirmada, usando uma lista explícita de scripts ativos. Não extrair recursivamente todo o DataModel nem escolher fontes apenas pelo nome: backups podem conter nomes repetidos e versões divergentes.

## Fronteira de responsabilidade do Rojo

- [SUPOSIÇÃO] Após extração e conferência, o disco será a fonte de verdade dos scripts incluídos no mapeamento; o fluxo normal será repositório → Studio. Alterações nesses scripts serão feitas nos arquivos. Importação inicial é uma operação separada e revisada; não haverá syncback automático ou bidirecional.
- [SUPOSIÇÃO] O futuro `default.project.json` declarará somente as folhas de código aprovadas e os ancestrais necessários. Não usará um mapeamento abrangente de Workspace, StarterGui, ServerStorage, ReplicatedStorage ou StarterPlayer para pastas locais vazias.
- [SUPOSIÇÃO] Preservar filhos desconhecidos em todos os ancestrais compartilhados, usando configuração compatível com a versão fixada e comprovada no projeto descartável. A configuração sozinha não basta: a prévia precisa demonstrar ausência de remoções ou substituições fora da lista autorizada.
- [SUPOSIÇÃO] Nomes e classes dos ancestrais existentes devem coincidir; colisão, duplicata, mudança de classe ou recriação inesperada de objeto exige parar. Não aceitar uma sincronização que proponha apagar objetos não gerenciados.

| Estado | Objeto do Studio | Destino local proposto | Responsabilidade |
|---|---|---|---|
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty.ServerBootstrap` | `src/server/ServerBootstrap.server.luau` | Rojo: Script e Source; preservar propriedades de execução verificadas na extração. |
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty.Services` | `src/server/Services/<nome>.luau` | Rojo: somente os nove ModuleScripts listados abaixo. |
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty.Validation.NoteValidator` | `src/server/Validation/NoteValidator.luau` | Rojo: ModuleScript. |
| [SUPOSIÇÃO] | `ReplicatedStorage.CumbiaParty.Shared` | `src/shared/<nome>.luau` | Rojo: somente os quatro ModuleScripts listados abaixo; não assumir posse de Remotes. |
| [SUPOSIÇÃO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap` | `src/client/ClientBootstrap.client.luau` | Rojo: LocalScript e propriedades verificadas. |
| [SUPOSIÇÃO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers` | `src/client/Controllers/<nome>.luau` | Rojo: somente os oito ModuleScripts listados abaixo. |
| [SUPOSIÇÃO] | `ReplicatedStorage.CumbiaParty.Remotes` | Sem destino em `src/` | `.rbxl`: manter os nove RemoteEvents existentes, nomes e classes. |
| [SUPOSIÇÃO] | `StarterGui.CumbiaPartyGui` e demais elementos visuais | Sem destino em `src/` | `.rbxl`: manter GUI e propriedades; scripts podem depender dessa árvore. |
| [SUPOSIÇÃO] | Workspace, CumbiaBattleWorld, Terrain, Lighting, modelos, meshes, marcadores e spawns | Sem destino em `src/` | `.rbxl`: edição visual e backups; não gerenciados pelo Rojo neste plano. |
| [SUPOSIÇÃO] | `ServerStorage.CumbiaPartyBackups`, `GreyboxPreservation` e demais preservações | Fora de `src/` e do projeto Rojo | Preservar no `.rbxl`; não copiar para runtime nem apagar. |
| [SUPOSIÇÃO] | `CumbiaPartyBuildTools`, todos os `Phase*`, `GreyboxTools` e ferramentas de autoria/restauração | Fora de `src/` e do projeto Rojo por padrão | Preservar como referência; eventual exportação exige escopo próprio e pasta não mapeada. |
| [SUPOSIÇÃO] | `ServerStorage.UnitTest`, `ServerScriptService.UnitTestRunner` | Sem migração inicial; eventual `tests/` em ticket próprio | Preservar runner desabilitado; não executar automaticamente nem mapear ServerStorage inteiro. |
| [SUPOSIÇÃO] | `StarterPlayer.StarterPlayerScripts.CumbiaPartyFestivalFX`, CoreGui e objetos internos do Studio | Sem destino no projeto Rojo | Fora da lista inicial; preservar estado existente, sem ativar efeitos nem exportar interfaces internas. |

- [SUPOSIÇÃO] Lista inicial dos serviços: ArenaService, BattleService, BotService, CompetitorService, LobbyService, RhythmService, TournamentService, WaveGenerator e WorldBindings.
- [SUPOSIÇÃO] Lista inicial compartilhada: GameConfig, NetworkTypes, WorldConfig e BattlePresentationConfig.
- [SUPOSIÇÃO] Lista inicial dos controllers: UIController, InputController, CompetitorPortrait, TournamentController, LobbyController, ArenaController, BattleHUD e BattlePresentationView.
- [SUPOSIÇÃO] Total esperado da lista inicial: 24 scripts/módulos, sendo 11 no servidor, 4 compartilhados e 9 no cliente, derivados do inventário; recontar antes de exportar. Os 12 objetos da amostra de ServerScriptService incluem UnitTestRunner, que está fora desses 11.
- [SUPOSIÇÃO] Os nove Remotes a preservar são ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest e LobbyState, conforme auditoria. Não duplicar os conjuntos de backup.
- [SUPOSIÇÃO] `WorldConfig` permanece código compartilhado; isso não torna a geometria gerenciada pelo Rojo. Preservar caminhos de require, WaitForChild, referências de GUI e bindings espaciais. Não remover perfis ou ramos legados nesta migração mecânica.
- [SUPOSIÇÃO] Esse projeto de código não reconstrói sozinho um place completo: o `.rbxl` continua obrigatório para mapa, GUI, Remotes e demais instâncias não mapeadas.

## Atributos das pastas e dos scripts — Rojo 7.7.1

- [SUPOSIÇÃO] Os atributos encontrados nas pastas CumbiaParty, conforme relato do dono, fazem parte do estado a preservar. Conferir `ServerScriptService.CumbiaParty`, `ReplicatedStorage.CumbiaParty` e `StarterPlayer.StarterPlayerScripts.CumbiaParty`, seus ancestrais mapeados e os 24 scripts; não presumir que extrair Source também extrai atributos.
- [NÃO ENCONTRADO] Nomes, tipos e valores desses atributos não estão registrados nos documentos locais consultados nem foram relidos no Studio nesta revisão. O manifesto da execução deverá registrar `GetAttributes()` por caminho e classe, incluindo conjuntos vazios, sem inventar valores.
- [SUPOSIÇÃO] Evidência documental externa: a documentação oficial [Properties, linha v7](https://rojo.space/docs/v7/properties/#attributes) declara `Attributes` em qualquer instância e suporte em build, live sync e arquivos de projeto. Portanto, o suporte documentado abrange Folder, Script, LocalScript e ModuleScript; não é exclusivo de scripts. Cada valor de atributo deve ter tipo explícito na representação JSON. A página é da linha v7, sem comprovação específica desta migração na 7.7.1.
- [SUPOSIÇÃO] Evidência documental externa: [Sync Details](https://rojo.space/docs/v7/sync-details/#meta-files) descreve propriedades em `.meta.json`, inclusive para scripts, e `init.meta.json` para diretórios. [Project Format](https://rojo.space/docs/v7/project-format/#instance-description) descreve `$properties` por instância. Isso permite planejar `Attributes` nos nós das pastas e scripts via `$properties`, ou em `properties` nos metadados apropriados. Ambas as páginas são da linha v7, sem prova executada na 7.7.1.
- [SUPOSIÇÃO] Evidência documental externa: a [release 7.7.1](https://github.com/rojo-rbx/rojo/releases/tag/v7.7.1) confirma a versão fixada e correções de caminhos Windows e de acesso do plugin ao GitHub. As páginas acima são da linha v7, sem identificação exclusiva da revisão 7.7.1; sua leitura não equivale a executar uma prova nessa versão.
- [NÃO ENCONTRADO] Essas fontes não confirmam que todos os atributos já existentes serão preservados quando omitidos do mapeamento, nem garantem o resultado desta migração concreta. Não estabelecem uma prova de preservação dos valores e tipos encontrados em CumbiaParty na 7.7.1. `$ignoreUnknownInstances` trata de instâncias desconhecidas, não constitui garantia de preservação de atributos.
- [SUPOSIÇÃO] Estratégia proposta: registrar e representar explicitamente todos os atributos encontrados nos nós gerenciados, com tipos e valores fiéis, sem declarar simultaneamente duas representações do mesmo conjunto. Qualquer tipo sem representação comprovada bloqueia a migração daquele nó até revisão; não descartar ou converter silenciosamente.

### Prova obrigatória na cópia descartável

1. [SUPOSIÇÃO] Confirmar CLI e plugin 7.7.1, identidade da cópia descartável e snapshot inicial: caminhos, classes, nomes, atributos completos com tipos/valores e propriedades de execução. Usar cópia do place completo, mantendo backup e base congelada intactos.
2. [SUPOSIÇÃO] Ensaiar separadamente Folder e cada classe de script presente. Em cópias descartáveis independentes do mesmo estado inicial, comparar um caso com atributos explicitamente declarados e um caso com um atributo preexistente omitido; incluir também omissão de toda a propriedade Attributes. Registrar se o atributo omitido permanece, muda ou desaparece, sem extrapolar esse resultado para outros tipos/versões.
3. [SUPOSIÇÃO] Conferir a prévia, aplicar apenas na cópia descartável e reler `GetAttributes()`. Comparar conjunto de chaves, tipos e valores por instância; verificar também classes, hierarquia, Source e objetos fora do mapeamento. Alterar somente Source no disco, sincronizar novamente e repetir a comparação para verificar preservação em atualização subsequente.
4. [SUPOSIÇÃO] Aceitar a configuração final somente com igualdade integral dos atributos originais e sem remoções, substituições ou alterações externas não autorizadas. Guardar snapshots, versão, configuração e diferenças no relatório futuro. A experiência de omissão informa o comportamento, mas a configuração final deve preservar o conjunto completo; qualquer perda interrompe a execução.
- [NÃO ENCONTRADO] Essa prova de atributos na versão 7.7.1 não foi executada nesta entrega documental.

## Decisões do dono

- [SUPOSIÇÃO] Lista fechada abaixo aprovada por decisão do dono em 24/10/2026. A aprovação das três decisões não inicia nenhuma etapa nem autoriza executar a migração. Cada nome da tabela representa um script no caminho indicado; não inclui descendentes adicionais.

| Estado | Caminho pai no Studio | Scripts candidatos | Quantidade |
|---|---|---|---|
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty` | `ServerBootstrap` | 1 |
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty.Services` | `ArenaService`, `BattleService`, `BotService`, `CompetitorService`, `LobbyService`, `RhythmService`, `TournamentService`, `WaveGenerator`, `WorldBindings` | 9 |
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty.Validation` | `NoteValidator` | 1 |
| [SUPOSIÇÃO] | `ReplicatedStorage.CumbiaParty.Shared` | `GameConfig`, `NetworkTypes`, `WorldConfig`, `BattlePresentationConfig` | 4 |
| [SUPOSIÇÃO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty` | `ClientBootstrap` | 1 |
| [SUPOSIÇÃO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers` | `UIController`, `InputController`, `CompetitorPortrait`, `TournamentController`, `LobbyController`, `ArenaController`, `BattleHUD`, `BattlePresentationView` | 8 |

- [SUPOSIÇÃO] Decisão 1 — Aprovar os 24 candidatos (11 servidor + 4 compartilhados + 9 cliente), com os caminhos e destinos descritos neste plano? Estado: APROVADA em 24/10/2026 — decisão do dono ("sim").
- [SUPOSIÇÃO] Decisão 2 — Aprovar a exclusão de `ServerStorage.UnitTest`, `ServerScriptService.UnitTestRunner` e `StarterPlayer.StarterPlayerScripts.CumbiaPartyFestivalFX` da migração inicial? Exclusão significa não exportar/mapear; preservar os objetos e seu estado no `.rbxl`, sem apagar ou ativar nada. Estado: APROVADA em 24/10/2026 — decisão do dono ("concordo").
- [SUPOSIÇÃO] Decisão 3 — Aprovar que a migração, revisão e execução da suíte UnitTest fiquem para ticket próprio, ainda a definir? As verificações de fidelidade, atributos, preservação e funcionamento da migração continuam obrigatórias no CP2-000e. Estado: APROVADA em 24/10/2026 — decisão do dono ("deixe para depois").
- [SUPOSIÇÃO] As três decisões foram aprovadas pelo dono em 24/10/2026; CP2-000e-1 e as demais etapas continuam com aprovação PENDENTE. Divergências do inventário exigem nova revisão da lista.

## Extração do Source pelo MCP e verificação de fidelidade

1. [SUPOSIÇÃO] Na execução autorizada, selecionar explicitamente a sessão Studio da cópia de trabalho em modo Edit e resolver cada um dos 24 caminhos completos, validando nome, classe e ausência de duplicatas. Ler a propriedade `Source` via MCP, sem executar `require`, módulos ou o jogo e sem modificar instâncias.
2. [SUPOSIÇÃO] Preferir leitura bruta de `Source` por uma consulta Luau somente de leitura via MCP, retornando texto em transporte estruturado com escapes reversíveis, caminho e comprimento em bytes. `script_read` apresenta números de linha e serve para inspeção; sua saída formatada não será copiada diretamente para os arquivos. Se a resposta exceder limites, transportar blocos com offsets e comprimento total, reconstruir na ordem e rejeitar lacunas, sobreposições ou truncamento.
3. [SUPOSIÇÃO] Gravar o texto decodificado nos destinos aprovados usando a ferramenta local de arquivos, em UTF-8 sem BOM acrescentado, sem interpolação pelo shell, reindentação, formatador, mudança de nomes ou conversão automática de finais de linha. Preservar CRLF/LF, espaços, caracteres Unicode e presença/ausência da quebra final conforme a origem. A gravação é etapa explícita no disco, não syncback nem sincronização bidirecional.
4. [SUPOSIÇÃO] Registrar manifesto por script: caminho original, classe, destino, quantidade de bytes, SHA-256 dos bytes do Source recebido, finais de linha e propriedades/atributos. Ler novamente o arquivo do disco e comparar bytes e SHA-256 com o buffer extraído; realizar uma segunda leitura independente pelo MCP e comparar integralmente com o arquivo. Hash apenas do arquivo, sem comparação com a origem, não prova fidelidade.
5. [SUPOSIÇÃO] Registrar qualquer normalização de fim de linha como diferença, mesmo se o texto parecer equivalente. Uma comparação adicional normalizada pode diagnosticar a causa, mas não substitui o aceite por igualdade exata; divergência bloqueia até correção ou decisão explícita do dono. Conferir também configurações Git que possam transformar os arquivos, sem alterá-las automaticamente.
6. [SUPOSIÇÃO] Após sincronização na cópia descartável, reler Source dos 24 objetos pelo MCP e comparar novamente com os arquivos e manifesto, além de nomes, classes, hierarquia, atributos e propriedades de execução. Exigir 24/24 correspondências, nenhuma ausência, duplicação ou diferença inexplicada. Preservar evidências antes de transferir o procedimento à cópia de trabalho.
- [NÃO ENCONTRADO] Extração, arquivos Source, manifesto de hashes e comparação disco/Studio ainda não foram produzidos ou executados; esta seção define o método futuro.

## Alternativas para obter o Source — proposta para decisão

- [SUPOSIÇÃO] A documentação oficial da [release 7.7.0 — Syncback](https://github.com/rojo-rbx/rojo/releases/tag/v7.7.0#syncback), da linha v7, descreve importação de um arquivo salvo para o disco, selecionada pelo projeto e por `syncbackRules`. Isso não é prova executada na versão 7.7.1 nem leitura do estado não salvo do Studio. A comparação abaixo combina essa documentação com o procedimento MCP proposto neste plano; riscos e esforço são avaliações propostas.

| Estado / aspecto | (a) MCP em blocos — método atual | (b) Syncback na cópia descartável — alternativa |
|---|---|---|
| [SUPOSIÇÃO] Risco | Leitura restrita aos 24 caminhos; controlar truncamento, offsets, lacunas e reconstrução antes de gravar. | Usa o arquivo salvo `CumbiaParty_V2_Descartavel.rbxl`; projeto e saída local isolados para conter exportações ou alterações indevidas no disco. |
| [SUPOSIÇÃO] Fidelidade verificável | Segunda leitura independente da origem; comparar bytes completos, quantidade de bytes e SHA-256 com o arquivo, incluindo finais de linha e quebra final. | Exigir a mesma comparação independente com o Source da origem correspondente ao arquivo salvo, para os 24 scripts; sucesso da exportação ou hash só do destino não prova identidade. |
| [SUPOSIÇÃO] Atributos | Extrair manifesto separado de Source, com chaves, tipos e valores dos scripts e pastas. | Auditar representação exportada e filtros de propriedades; comparar com o manifesto, sem presumir preservação integral. O suporte geral documentado a Attributes não garante o resultado do syncback. |
| [SUPOSIÇÃO] Objetos fora do mapeamento | Não extrair; verificar preservação nas sincronizações futuras. | Revisar descendentes selecionados e exclusões `ignoreTrees`/`ignorePaths`; um ancestral amplo pode incluir objetos extras. Exigir saída restrita ao escopo e preservação das exclusões. |
| [SUPOSIÇÃO] Esforço | Mais transporte e reconstrução em blocos, com manifesto e conferência explícitos. | Pode reduzir o transporte manual, mas exige configuração isolada e revisão dos arquivos e metadados gerados; não elimina o manifesto nem a comparação independente. |

- [SUPOSIÇÃO] Fontes complementares: [Properties — Attributes](https://rojo.space/docs/v7/properties/#attributes), [Sync Details — Meta Files](https://rojo.space/docs/v7/sync-details/#meta-files) e [Project Format](https://rojo.space/docs/v7/project-format/#instance-description), todas da linha v7. Descrevem atributos, metadados e mapeamento; não demonstram fidelidade desta extração na 7.7.1. As regras de exclusão do syncback são descritas na release acima; não confundir com a preservação de instâncias durante live sync.
- [NÃO ENCONTRADO] Garantia de identidade byte a byte do Source e preservação integral dos atributos desta migração nas fontes consultadas; comparação de bytes/SHA-256 e ensaio de syncback: NÃO TESTADO.
- [SUPOSIÇÃO] Recomendação PROPOSTA, para decisão do dono: manter MCP em blocos como método atual; considerar syncback somente após decisão específica e ensaio isolado. Aprovar esta edição documental não escolhe syncback nem altera o método atual; nenhuma execução é autorizada aqui.

## Sequência futura e critérios de parada

- [SUPOSIÇÃO] Todas as etapas abaixo são futuras. Nenhuma começa sem aprovação escrita do dono do resultado da etapa anterior e da própria etapa. Para CP2-000e-1, exigir aprovação escrita do plano e da própria etapa; as três Decisões do dono estão aprovadas em 24/10/2026. Aprovação desta revisão documental não concede nenhuma dessas autorizações de execução.

### CP2-000e-1 — Preparar

- [SUPOSIÇÃO] Aprovação do dono: APROVADA neste ticket em 24/10/2026, seguida da aprovação explícita do plano e das consultas `rojo --version` e `rokit --version`. Origem: instruções do dono nesta conversa; não é uma propriedade do código.
- [SUPOSIÇÃO] Escopo autorizado: inspeção somente de leitura e relatório neste documento e no registro CP2-000e-1 do backlog. As instruções deste ticket prevalecem sobre os requisitos históricos de hashes/tamanhos de `.rbxl`, configuração e atualização de CURRENT_STATE. CP2-000e-2 a -8 permanecem PENDENTES; este relatório não autoriza iniciá-las.

#### Relatório de 24/10/2026 — sete itens

1. [CONFIRMADO NO CÓDIGO] Decisões: a leitura deste arquivo nesta sessão confirmou as decisões 1, 2 e 3 registradas como APROVADAS em 24/10/2026: lista dos 24 scripts; exclusão de UnitTest, UnitTestRunner e CumbiaPartyFestivalFX; suíte UnitTest em ticket próprio. Esta confirmação é do registro no repositório.
2. [CONFIRMADO NO CÓDIGO] Git inicial: `git status --short` retornou vazio, árvore limpa. `git log -1`: `c50c9951d7c01652018b4bae81daa7b82c9fe7ab`, Thiago, 24/10/2026 07:24:45 -04:00, mensagem `docs: CP2-000d-rev3 decisões do dono e estado dos pré-requisitos`.
3. [CONFIRMADO NO CÓDIGO] Arquivos: listagem local nesta sessão em `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\`, somente nomes e datas de modificação, apresentada abaixo. Não foram calculados hashes nem tamanhos exatos dos `.rbxl`, conforme dispensa do dono.
4. [CONFIRMADO NO CÓDIGO] Identidade e modo: `list_roblox_studios` retornou uma única sessão, ID `a84afcec-168b-4427-996c-68a6099df5fb`, nome `CumbiaParty_V2_Trabalho.rbxl`; `get_studio_state` confirmou modo Edit, DataModel disponível Edit e foco Edit. Todas as consultas ao inventário usaram esse ID e `datamodel_type: Edit`. A identificação é a informada pelo MCP; não é prova de equivalência entre o conteúdo em memória e o arquivo salvo.
5. [CONFIRMADO NO CÓDIGO] Inventário: 24/24 caminhos aprovados resolvidos, com nomes e classes esperados (11 servidor, 4 compartilhados, 9 cliente). Cada segmento foi conferido enumerando filhos e contando correspondências exatas: uma por segmento, sem duplicatas nos caminhos aprovados. `GetAttributes()` foi consultado nos 24 scripts e nas pastas abaixo; conjuntos vazios estão explícitos. Não foi feita uma busca global por homônimos em backups ou outras árvores fora do escopo.
6. [CONFIRMADO NO CÓDIGO] Exclusões existentes e únicas nos respectivos caminhos: `ServerStorage.UnitTest` = Folder; `ServerScriptService.UnitTestRunner` = Script; `StarterPlayer.StarterPlayerScripts.CumbiaPartyFestivalFX` = LocalScript. Não foram modificados nem executados.
   - [SUPOSIÇÃO] UnitTest, UnitTestRunner e CumbiaPartyFestivalFX não serão tocados ou mapeados na migração inicial, conforme decisão 2; suíte UnitTest permanece em ticket próprio.
7. [CONFIRMADO NO CÓDIGO] Versões executadas: `C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe --version` retornou `Rojo 7.7.1`, consistente com o ADR-0001 lido nesta sessão; `C:\Users\Thiago-PC1\.rokit\bin\rokit.exe --version` retornou `rokit 1.2.0`. Nenhum outro comando dessas ferramentas foi executado e nada foi instalado.

| Evidência | Nome do arquivo | Modificação (UTC-04:00) |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | CumbiaParty_V1_2026-10-22.rbxl | 2026-10-22 19:21:51 |
| [CONFIRMADO NO CÓDIGO] | CumbiaParty_V2_Trabalho.rbxl | 2026-10-23 11:44:36 |
| [CONFIRMADO NO CÓDIGO] | CumbiaParty_V2_Descartavel.rbxl | 2026-10-23 11:44:36 |
| [CONFIRMADO NO CÓDIGO] | CumbiaParty_V2_Trabalho_pre-migracao.rbxl | 2026-10-23 02:00:31 |

| Evidência | Caminho aprovado | Nome | Classe | Unicidade | Atributos |
|---|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.ServerBootstrap` | ServerBootstrap | Script | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.ArenaService` | ArenaService | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.BattleService` | BattleService | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.BotService` | BotService | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.CompetitorService` | CompetitorService | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.LobbyService` | LobbyService | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.RhythmService` | RhythmService | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.TournamentService` | TournamentService | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.WaveGenerator` | WaveGenerator | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services.WorldBindings` | WorldBindings | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Validation.NoteValidator` | NoteValidator | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` | GameConfig | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ReplicatedStorage.CumbiaParty.Shared.NetworkTypes` | NetworkTypes | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ReplicatedStorage.CumbiaParty.Shared.WorldConfig` | WorldConfig | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig` | BattlePresentationConfig | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap` | ClientBootstrap | LocalScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController` | UIController | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController` | InputController | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait` | CompetitorPortrait | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.TournamentController` | TournamentController | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.LobbyController` | LobbyController | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController` | ArenaController | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD` | BattleHUD | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattlePresentationView` | BattlePresentationView | ModuleScript | 1 por segmento; sem duplicatas | `{}` (vazio) |

| Evidência | Pasta | Classe | Atributos: nome, tipo e valor |
|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `ReplicatedStorage.CumbiaParty` | Folder | `ArchitectureVersion`: `number` = `3` |
| [CONFIRMADO NO CÓDIGO] | `ReplicatedStorage.CumbiaParty.Shared` | Folder | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty` | Folder | `ArchitectureVersion`: `number` = `3` |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Services` | Folder | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `ServerScriptService.CumbiaParty.Validation` | Folder | `{}` (vazio) |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty` | Folder | `ArchitectureVersion`: `number` = `3` |
| [CONFIRMADO NO CÓDIGO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers` | Folder | `{}` (vazio) |

#### Divergências, limites e veredito

- [CONFIRMADO NO CÓDIGO] Nenhuma divergência de nome, classe, ausência ou duplicata no inventário dos 24 caminhos aprovados. As pastas CumbiaParty possuem `ArchitectureVersion`, tipo `number`, valor `3`; todos os 24 scripts possuem atributos vazios. Não havia valores anteriores documentados para comparar; esta é a linha de base observada.
- [CONFIRMADO NO CÓDIGO] Divergências operacionais: `rojo --version` e `rokit --version` por nome falharam porque os comandos não foram encontrados no PATH desta sessão. O intermediário `.rokit\bin\rojo.exe --version` retornou `ERROR home directory not found`. A consulta direta ao executável instalado confirmou Rojo 7.7.1; não houve alteração de PATH, configuração ou instalação.
- [CONFIRMADO NO CÓDIGO] Divergências documentais históricas: o plano anterior dizia que a aprovação de CP2-000e-1 estava pendente e exigia hashes/tamanhos dos `.rbxl`. Para esta etapa, valem a aprovação e a dispensa expressas neste ticket, registradas acima; os registros das etapas -2 a -8 não foram alterados.
- [CONFIRMADO NO CÓDIGO] Source não foi lido e nenhum require foi executado. As consultas Luau apenas enumeraram instâncias e leram Name, ClassName e GetAttributes; não escreveram propriedades, atributos ou instâncias. Não houve Play, gravação no Studio, criação/sobrescrita de `.rbxl`, sincronização, publicação ou commit.
- [NÃO ENCONTRADO] NÃO TESTADO: abertura, integridade, restauração e equivalência de conteúdo dos arquivos `.rbxl`; equivalência do arquivo salvo com o Studio; origem da cópia descartável verificada independentemente do relato do dono. Nomes e datas iguais não comprovam equivalência. Hashes e tamanhos exatos foram dispensados, não calculados.
- [NÃO ENCONTRADO] NÃO TESTADO: Source, require, extração e fidelidade, Rojo build/serve/syncback/sincronização, versão do plugin, preservação de atributos após sincronização, gameplay, UnitTest, multiplayer, mobile, segurança, desempenho e memória. As dispensas anteriores de segunda cópia da V1 e abertura do pré-migração permanecem; a confiabilidade do pré-migração para restauração não foi demonstrada.
- [SUPOSIÇÃO] Veredito: **pronto** para o aceite da CP2-000e-1, considerando os sete itens conferidos, as dispensas expressas e a ausência de divergências do inventário. Não significa migração realizada nem autorização para CP2-000e-2 a -8.

### CP2-000e-2 — Extrair

- [SUPOSIÇÃO] Execução e plano APROVADOS pelo dono neste ticket em 24/10/2026; CP2-000e-3 a -8 permanecem PENDENTES. Esta autorização substitui exclusivamente o registro histórico de aprovação pendente desta etapa.
- [CONFIRMADO NO CÓDIGO] Extraídos os 24 Sources da única sessão MCP CumbiaParty_V2_Trabalho.rbxl, ID a84afcec-168b-4427-996c-68a6099df5fb, confirmada em Edit. Caminhos únicos e classes aprovadas conferidos; leitura bruta por Luau somente de leitura, sem script_read.
- [CONFIRMADO NO CÓDIGO] Gravados 11 arquivos servidor, 4 compartilhados e 9 cliente nos destinos aprovados, total de 162095 bytes. Transporte hexadecimal reversível em blocos de até 4000 bytes com offsets e comprimentos validados; UTF-8 validado antes da gravação binária, sem BOM acrescentado, normalização ou formatação.
- [CONFIRMADO NO CÓDIGO] Releituras do disco: 24/24 iguais integralmente aos bytes recebidos e respectivos SHA-256. [Manifesto](MIGRATION_MANIFEST.md) contém origem, classe, destino, bytes, hashes recebido/disco, finais de linha, quebra final, Disabled/RunContext, atributos vazios, blocos e verificações por script.
- [CONFIRMADO NO CÓDIGO] Preservados 3 Sources CRLF, 14 LF e 7 mistos; 7 sem quebra final. WorldBindings possui 1 CR isolado e WorldConfig 107. Nenhuma divergência de fidelidade entre disco e recebido.
- [CONFIRMADO NO CÓDIGO] Git inicialmente limpo; core.autocrlf=true. Nenhum .gitattributes encontrado no repositório; atributos efetivos text/eol/working-tree-encoding/filter unspecified para os 24 destinos. Configuração e atributos Git não alterados.
- [SUPOSIÇÃO] core.autocrlf=true pode normalizar texto para LF no índice e usar CRLF em checkout, alterando bytes/hashes futuros; casos mistos/CR isolado dependem da detecção de texto. Conversão por add/checkout NÃO TESTADA; detalhes e origem da configuração no manifesto.
- [CONFIRMADO NO CÓDIGO] Check adicional dos 24 untracked por git diff --no-index --check encontrou whitespace em 10 arquivos e avisos de conversão LF→CRLF em 19. Bytes herdados preservados, sem correção; diagnósticos individuais no manifesto. O git diff --check comum não abrange arquivos untracked.
- [CONFIRMADO NO CÓDIGO] Source foi lido apenas pelo MCP; nenhum require, módulo, Play, comando Rojo/Rokit, escrita no Studio, .rbxl, configuração ou commit foi executado.
- [NÃO ENCONTRADO] NÃO TESTADO: segunda leitura independente pelo MCP e conferência integral da etapa -3, compilação, testes funcionais/UnitTest/gameplay, sincronização e preservação pelo Rojo.
- [SUPOSIÇÃO] Veredito: pronto para aceite da CP2-000e-2; 24 arquivos gravados, manifesto completo e 24/24 releituras iguais ao recebido. As próximas etapas não estão autorizadas.

#### CP2-000e-2a — Desativar conversão Git em src/

- [SUPOSIÇÃO] Decisão e plano APROVADOS pelo dono neste ticket: preservar os finais de linha dos arquivos migrados; CP2-000e-3 a -8 continuam PENDENTES.
- [CONFIRMADO NO CÓDIGO] Criado `.gitattributes` na raiz com a única regra `src/** -text`. A regra desativa a conversão de finais de linha pelo mecanismo text do Git sob src/, sem alterar core.autocrlf=true nem qualquer configuração.
- [SUPOSIÇÃO] A política vale para QUALQUER arquivo futuro em src/, além dos 24 Sources e do .gitkeep existente. Deve ser revista se essa intenção mudar, inclusive caso tipos de arquivos com outra política sejam adicionados a src/.
- [SUPOSIÇÃO] Manifesto e demais documentos ficam fora da regra: não são cópias de Source cuja identidade binária é exigida. Documentos, ADR e AGENTS.md mantêm o tratamento Git anterior. Criar a regra não reescreve arquivos existentes nem corrige blobs de commits anteriores; nenhuma renormalização será feita neste ticket.
- [CONFIRMADO NO CÓDIGO] SHA-256 antes/depois: 26/26 iguais (24 Sources, src/.gitkeep e MIGRATION_MANIFEST.md). Nenhum desses arquivos foi alterado; as alterações preexistentes da etapa -2 foram preservadas.
- [CONFIRMADO NO CÓDIGO] `git add --dry-run` nos 24 destinos: saída 0, listou os 24 como candidatos a add, sem avisos LF/CRLF e sem staging. A primeira tentativa no sandbox falhou ao criar .git/index.lock; a repetição fora do sandbox foi autorizada e concluída. `git check-attr -a` retornou text: unset para todos os 24, conforme saída abaixo.
- [CONFIRMADO NO CÓDIGO] Comparação complementar `git diff --no-index --check -- /dev/null <caminho-relativo>`: nenhum aviso de conversão para src/. Uma consulta inicial com caminhos absolutos ainda emitiu 19 avisos; ela não foi usada como evidência da aplicação dos atributos. A repetição com caminhos relativos e o dry-run do Git no repositório confirmaram ausência dos avisos.
- [CONFIRMADO NO CÓDIGO] O aviso de MIGRATION_MANIFEST.md CONTINUA: LF will be replaced by CRLF the next time Git touches it, observado no check no-index. check-attr -a não retornou atributos para o manifesto, plano, backlog, AGENTS.md ou ADR-0001.md; comportamento esperado por estarem fora de src/.
- [SUPOSIÇÃO] Este .gitattributes é pré-requisito para CP2-000e-3. A etapa -3 continua exigindo igualdade EXATA de bytes e SHA-256 com segunda leitura independente pelo MCP; a regra Git não substitui essa prova.
- [SUPOSIÇÃO] Prova futura após commit, somente mediante nova aprovação: registrar SHA-256 dos 24 arquivos atuais; confirmar que o mesmo commit inclui .gitattributes e Sources; ler os blobs desse commit por git cat-file com captura binária e comparar bytes/SHA-256 com o disco e manifesto; fazer checkout desse commit em cópia de teste separada e repetir as comparações. Não usar redirecionamento textual do PowerShell para os blobs; usar buffers binários. Exigir 24/24 iguais e registrar commit e resultados. Um hash antes/depois só no disco, sem conferir os blobs, não demonstra sozinho o conteúdo armazenado.
- [NÃO ENCONTRADO] NÃO TESTADO: commit, leitura/comparação de blobs de um commit futuro, checkout em cópia de teste, segunda leitura MCP da etapa -3, execução dos scripts e sincronização. Nenhum Rojo, Studio, .rbxl, configuração Git, staging efetivo ou commit foi realizado neste ticket.

Saída observada de git check-attr -a — [CONFIRMADO NO CÓDIGO]:

```text
src/client/ClientBootstrap.client.luau: text: unset
src/client/Controllers/ArenaController.luau: text: unset
src/client/Controllers/BattleHUD.luau: text: unset
src/client/Controllers/BattlePresentationView.luau: text: unset
src/client/Controllers/CompetitorPortrait.luau: text: unset
src/client/Controllers/InputController.luau: text: unset
src/client/Controllers/LobbyController.luau: text: unset
src/client/Controllers/TournamentController.luau: text: unset
src/client/Controllers/UIController.luau: text: unset
src/server/ServerBootstrap.server.luau: text: unset
src/server/Services/ArenaService.luau: text: unset
src/server/Services/BattleService.luau: text: unset
src/server/Services/BotService.luau: text: unset
src/server/Services/CompetitorService.luau: text: unset
src/server/Services/LobbyService.luau: text: unset
src/server/Services/RhythmService.luau: text: unset
src/server/Services/TournamentService.luau: text: unset
src/server/Services/WaveGenerator.luau: text: unset
src/server/Services/WorldBindings.luau: text: unset
src/server/Validation/NoteValidator.luau: text: unset
src/shared/BattlePresentationConfig.luau: text: unset
src/shared/GameConfig.luau: text: unset
src/shared/NetworkTypes.luau: text: unset
src/shared/WorldConfig.luau: text: unset
```

### CP2-000e-3 — Conferir em disco

- [SUPOSIÇÃO] Objetivo: comprovar fidelidade dos arquivos à origem.
- [SUPOSIÇÃO] Pré-requisitos: aceite escrito da CP2-000e-2 e aprovação escrita desta etapa; arquivos e manifesto disponíveis.
- [SUPOSIÇÃO] O que será feito: comparar cada Source com segunda leitura independente da origem, bytes e SHA-256; revisar requires, referências relativas, classes resultantes das extensões e possíveis conversões de finais de linha pelo Git, sem alterar configurações automaticamente. Não renomear objetos. Separar extração de melhorias de código em commits pequenos quando autorizados na execução futura.
- [SUPOSIÇÃO] Critério de aceite: 24/24 correspondências exatas, classes e referências conferidas, sem diferença inexplicada; divergências bloqueiam o avanço.
- [SUPOSIÇÃO] NÃO TESTADO nesta etapa: sincronização, preservação no Studio e gameplay.
- [SUPOSIÇÃO] Aprovação do dono: APROVADA para execução da etapa -3 e item 7; aceite do resultado não declarado.

- [SUPOSIÇÃO] Execução, plano e item 7 APROVADOS pelo dono em 24/10/2026. Conferência interrompida em divergência de referências; aceite integral não declarado. CP2-000e-4 a -8 continuam PENDENTES.
- [CONFIRMADO NO CÓDIGO] Sessão MCP única CumbiaParty_V2_Trabalho.rbxl em Edit; segunda leitura independente: 24/24 iguais em bytes e SHA-256 ao disco e manifesto, 162095 bytes; classes/extensões 24/24. Relatório completo em [conferência CP2-000e-3](MIGRATION_MANIFEST.md#cp2-000e-3--conferência-independente-em-disco-24102026).
- [CONFIRMADO NO CÓDIGO] Item 7: 24/24 blobs do commit 7969b6a6fc2a273148bf06a4310575ef1ebc377f iguais ao disco em bytes e SHA-256, via git cat-file e buffers binários em memória. Mesmo commit contém src/** -text. Sem checkout, cópia de teste ou commit.
- [CONFIRMADO NO CÓDIGO] Revisão textual: 50 requires (48 internos existentes, 2 externos de controles Roblox) e 30 WaitForChild/FindFirstChild/variantes listados no manifesto; Remotes, GUI e referências de mapa discriminados. CR CR LF explica os dois -text: 1 CR isolado em WorldBindings e 107 em WorldConfig; reconciliados 3 crlf, 14 lf, 5 mixed, 2 -text com 3 CRLF, 14 LF, 7 mistos.
- [NÃO ENCONTRADO] Divergência: perfil inativo Tropical referencia Workspace.CumbiaPartyLobby, oito marcadores e terminal OpenTournament ausentes em Edit. Underground é o perfil ativo e seus 19 RequiredPaths existem. Investigação interrompida ao encontrar as ausências; nada corrigido.
- [NÃO ENCONTRADO] NÃO TESTADO: checkout futuro (item 7 prova somente os blobs), dependências e GUI/personagens em runtime, compilação/execução, require, Play/gameplay/UnitTest, Rojo/sincronização/preservação e equivalência Studio/.rbxl salvo.

### CP2-000e-4 — Configurar e provar atributos na cópia descartável

- [SUPOSIÇÃO] Objetivo: comprovar mapeamento restrito e preservação de atributos.
- [SUPOSIÇÃO] Pré-requisitos: aceite escrito da CP2-000e-3 e aprovação escrita desta etapa; criação prévia obrigatória de `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V2_Descartavel.rbxl`, cópia completa da referência validada, com origem e identidade registradas na CP2-000e-1; CLI e plugin na versão registrada no ADR.
- [SUPOSIÇÃO] O que será feito: preparar mapeamento restrito e política de preservação de filhos desconhecidos; executar a prova de atributos descrita neste plano em cópias descartáveis independentes. Conferir prévia antes de aplicar; remoção de mapa, GUI, Remote, backup, ferramenta ou outro objeto fora da lista exige parar e corrigir o mapeamento.
- [SUPOSIÇÃO] Critério de aceite: configuração final preserva integralmente chaves, tipos e valores dos atributos e não produz alterações externas não autorizadas; snapshots e diferenças registrados.
- [SUPOSIÇÃO] NÃO TESTADO nesta etapa: fluxo funcional e transferência à cópia de trabalho.
- [SUPOSIÇÃO] Aprovação do dono: PENDENTE

### CP2-000e-5 — Validar sincronização na cópia descartável

- [SUPOSIÇÃO] Objetivo: verificar a migração mecânica com a configuração final.
- [SUPOSIÇÃO] Pré-requisitos: aceite escrito da CP2-000e-4 e aprovação escrita desta etapa; configuração final e prévia restrita revisadas; cópia descartável identificada.
- [SUPOSIÇÃO] O que será feito: aplicar somente à cópia descartável e comparar hierarquia, classes, propriedades, atributos e Source antes/depois, incluindo bytes e SHA-256. Conferir apenas um bootstrap ativo por lado, runner desabilitado e preservação de instâncias externas ao mapeamento.
- [SUPOSIÇÃO] Critério de aceite: 24/24 Sources correspondentes ao manifesto, sem ausências, duplicações, mudanças externas ou diferenças inexplicadas; exclusões e propriedades preservadas.
- [SUPOSIÇÃO] NÃO TESTADO nesta etapa: gameplay e transferência à cópia de trabalho.
- [SUPOSIÇÃO] Aprovação do dono: PENDENTE

### CP2-000e-6 — Validar funcionamento

- [SUPOSIÇÃO] Objetivo: identificar regressões funcionais na cópia descartável.
- [SUPOSIÇÃO] Pré-requisitos: aceite escrito da CP2-000e-5 e aprovação escrita desta etapa, incluindo execução do jogo para comparação com a referência V2_Trabalho de 23/10/2026 11:44. O funcionamento da descartável relatado pelo dono em 24/10/2026 é a linha de base herdada, não verificada por agente; não demonstra o estado do pré-migração de 02:00.
- [SUPOSIÇÃO] O que será feito: conferir inicialização e Output; testar lobby → fila → torneio com bots → resultado → retorno, entrada D/F/J/K, câmera, GUI, saída e respawn. Comparar com a base e separar falhas herdadas de regressões. Migração, revisão do runner e execução da suíte UnitTest ficam para ticket próprio, conforme decisão do dono aprovada em 24/10/2026; não fazem parte do CP2-000e.
- [SUPOSIÇÃO] Critério de aceite: evidências do fluxo e dos cenários acima, com falhas classificadas e nenhuma regressão de migração não resolvida; resultado submetido ao dono.
- [SUPOSIÇÃO] NÃO TESTADO nesta etapa: suíte UnitTest, mobile, multiplayer amplo, segurança, desempenho e memória; registrar também qualquer cenário previsto que não puder ser executado.
- [SUPOSIÇÃO] Aprovação do dono: PENDENTE

### CP2-000e-7 — Transferir à cópia de trabalho

- [SUPOSIÇÃO] Objetivo: repetir o procedimento validado na cópia operacional.
- [SUPOSIÇÃO] Pré-requisitos: aceite escrito da CP2-000e-6 e aprovação escrita desta etapa; evidências satisfatórias na descartável, backup preservado com as dispensas e prévia restrita. O teste de abertura do pré-migração foi dispensado pelo dono em 24/10/2026: continua NÃO TESTADO e não é ponto de restauração confiável enquanto não testado. Por ser anterior ao V2_Trabalho de 23/10/2026 11:44 e o intervalo desde 02:00 não ter sido documentado, restaurar por ele pode perder alterações desse intervalo — risco aceito pelo dono.
- [SUPOSIÇÃO] O que será feito: conferir barra de título e sessão conectada; transferir o procedimento e repetir verificações de Source, bytes/SHA-256, hierarquia, classes, atributos, propriedades, exclusões e validação funcional. Nunca conectar à V1 congelada nem ao backup pré-migração.
- [SUPOSIÇÃO] Critério de aceite: 24/24 correspondências, preservação verificada e validação funcional registrada na cópia de trabalho, sem regressão não resolvida.
- [SUPOSIÇÃO] NÃO TESTADO nesta etapa: suítes e cenários não executados, incluindo os limites da CP2-000e-6; não extrapolar o resultado para outros dispositivos ou cargas.
- [SUPOSIÇÃO] Aprovação do dono: PENDENTE

### CP2-000e-8 — Encerrar documentalmente

- [SUPOSIÇÃO] Objetivo: consolidar evidências e limites da execução futura.
- [SUPOSIÇÃO] Pré-requisitos: aceite escrito da CP2-000e-7 e aprovação escrita desta etapa, com os documentos que poderão ser atualizados explicitamente definidos.
- [SUPOSIÇÃO] O que será feito: registrar versão, manifesto, diferenças, testes e NÃO TESTADO; atualizar CURRENT_STATE.md e demais registros somente no escopo autorizado para essa etapa futura. Nenhuma publicação faz parte da migração.
- [SUPOSIÇÃO] Critério de aceite: relatório completo e coerente com as evidências, sem afirmar execução ou sucesso não demonstrados; encerramento submetido ao dono.
- [SUPOSIÇÃO] NÃO TESTADO nesta etapa: nenhuma execução adicional; permanecem não testados todos os itens sem evidência nas etapas anteriores.
- [SUPOSIÇÃO] Aprovação do dono: PENDENTE

- [SUPOSIÇÃO] Parar diante de perda de objeto, diferença de Source não explicada, duplicação de bootstrap, referências quebradas, mudança de comportamento ou dúvida sobre o place conectado. Não usar syncback como tentativa de reparo; após três tentativas sem sucesso do mesmo bug, interromper e propor nova abordagem, conforme AGENTS.md.

## Reversão por restauração do arquivo

1. [SUPOSIÇÃO] Em caso de falha, interromper a sincronização e desconectar o plugin antes de restaurar; encerrar Play se houver. Registrar a falha e preservar separadamente a cópia defeituosa se necessário, sem sobrescrever o backup.
2. [SUPOSIÇÃO] Restaurar a cópia operacional a partir de `CumbiaParty_V2_Trabalho_pre-migracao.rbxl`, mantendo o arquivo original de backup intacto. Seu teste de abertura foi dispensado pelo dono em 24/10/2026: permanece NÃO TESTADO e não deve ser descrito como ponto de restauração confiável enquanto não testado. Como é de 23/10/2026 02:00, anterior ao V2_Trabalho de 11:44, restaurar por ele pode perder alterações do intervalo não documentado — risco aceito pelo dono. Fazer a restauração em uma nova cópia e confirmar a abertura, identidade, hierarquia e scripts com Rojo desconectado; substituição de arquivo relevante exige autorização explícita.
3. [SUPOSIÇÃO] Voltar os arquivos de código/configuração ao ponto anterior à migração por reversão Git revisada, preservando alterações independentes. Git sozinho não restaura mapa, Terrain, GUI, Remotes ou objetos do `.rbxl`.
4. [SUPOSIÇÃO] Não reconectar enquanto código e configuração não forem compatíveis com o estado restaurado e a prévia não estiver aprovada. Repetir as verificações de inicialização e fluxo na cópia restaurada antes de retomar a migração.
- [SUPOSIÇÃO] As ferramentas `PhaseCRestore`, `PhaseDRestore` ou `GreyboxMigration` não são o mecanismo de reversão deste plano. A reversão depende da restauração do arquivo pré-migração completo.
- [NÃO ENCONTRADO] Ensaio de restauração e validação do backup em execução: NÃO TESTADO nesta entrega.

## Aceite do plano e limites desta entrega

- [SUPOSIÇÃO] Aceite documental: fontes e limites explícitos; lista de scripts e fronteira Rojo/Studio; backups e Phase* fora de src/ por padrão; backup pré-migração obrigatório; sequência com verificações e critérios de parada; reversão por restauração do `.rbxl`; separação entre migração mecânica e implementação da V2.
- [SUPOSIÇÃO] A elaboração anterior registrou leituras locais e existência/tamanho do backup. Nesta revisão foram lidos CURRENT_STATE.md, GAME_DESIGN.md, AGENTS.md, este plano e o backlog, consultadas as fontes oficiais do Rojo e inspecionado o estado Git. Nenhuma ferramenta do Studio foi chamada nesta revisão; os relatos anteriores não representam novas verificações.
- [NÃO ENCONTRADO] Migração, Rojo, syncback, build, sincronização, Play, testes unitários, multiplayer, mobile, segurança, desempenho, memória e equivalência funcional: NÃO TESTADOS nesta retomada. Este plano não é evidência de migração concluída.
- [SUPOSIÇÃO] CP2-000d concluído como entrega documental neste plano e registrado no backlog. CP2-000e é a execução futura; sua conclusão não é afirmada aqui.
- [SUPOSIÇÃO] As três decisões da seção Decisões do dono estão aprovadas em 24/10/2026. Executar CP2-000e exige aprovações específicas das etapas, ainda PENDENTES, cumprimento dos pré-requisitos com as dispensas registradas e evidências futuras de fidelidade e preservação. A aprovação da edição destes dois documentos não autoriza executar CP2-000e.

## CP2-000e-3a — Registro complementar (24/10/2026)

- [SUPOSIÇÃO] Execução somente de leitura e plano de registro nos três documentos APROVADOS pelo dono. [Relatório CP2-000e-3a](MIGRATION_MANIFEST.md#cp2-000e-3a--seleção-do-perfil-tropical-24102026). Sem aceitar ou rejeitar -3; decisão do dono. CP2-000e-4 a -8 PENDENTES.
- [CONFIRMADO NO CÓDIGO] src/shared/WorldConfig.luau:4 seleciona Underground; Tropical e Underground são os dois perfis espaciais. GameConfig:97 consome o ativo. LobbyService:89 chama Resolve sem perfil; WorldBindings:107 usa o ativo e resolve seus caminhos com assert (6,19,109,116,134). Com Underground, a raiz é CumbiaBattleWorld, não CumbiaPartyLobby. Referências e chamadores constam com arquivo/linha no relatório.
- [NÃO ENCONTRADO] Nenhuma seleção explícita ou troca runtime para Tropical nas buscas dos 24 Sources.
- [SUPOSIÇÃO] O dono contesta a hipótese "referências do perfil inativo, inofensivas": NÃO se sustenta como conclusão de inocuidade em execução ou fundamento de aceite. Registrada como pendência a esclarecer a contradição apontada pelo dono com seu relato de que a descartável inicia e funciona; não foi reproduzida.
- [CONFIRMADO NO CÓDIGO] Ressalva: o caminho normal só resolveria CumbiaPartyLobby e seus marcadores se Tropical fosse usado; os asserts não tornam obrigatórias as referências do perfil inativo. A leitura atual não demonstra essa contradição com o relato.
- [SUPOSIÇÃO] Reconciliação entre Sources/perfil da descartável e evidências da cópia de trabalho pendente de escopo futuro autorizado, sem decisão sobre -3.
- [NÃO ENCONTRADO] NÃO TESTADO: execução, require, Play, inicialização/gameplay, UnitTest, estado atual do Studio, equivalência disco/Studio/.rbxl e Rojo. Inspeção textual apenas; sem commit.

## CP2-000e-3b — Conferência estrutural em Edit (24/10/2026)

- [SUPOSIÇÃO] Execução e plano aprovados pelo dono; [evidências CP2-000e-3b](MIGRATION_MANIFEST.md#cp2-000e-3b--objetos-dos-perfis-em-edit-24102026). Sem aceite da etapa -3: decisão do dono. CP2-000e-4 a -8 PENDENTES.
- [CONFIRMADO NO CÓDIGO] Leitura atual de WorldConfig:4 confirma Underground ativo. Sessão MCP única CumbiaParty_V2_Trabalho.rbxl em Edit; 85 caminhos distintos conferidos por enumeração de instâncias, Name e ClassName: presentes, únicos e com classes compatíveis. Contagens previstas/observadas: 13/13 retornos, 19/19 RequiredPaths e 5/5 arenas; diferenças zero. As arenas já integram os RequiredPaths. Tabela completa, intermediários, arquivo/linha e distinção entre assert e nil/fallback no manifesto.
- [NÃO ENCONTRADO] Tropical: CumbiaPartyLobby, oito retornos e terminal ausentes nos caminhos configurados, reconferidos nesta sessão. A ausência da raiz implica ausência desses caminhos descendentes; não é busca global por nomes.
- [CONFIRMADO NO CÓDIGO] SpawnLocation e Terrain de Workspace existem e são únicos; não se afirma ausência de todos os objetos Tropical. As ausências do perfil inativo não são ausências do contrato Underground.
- [CONFIRMADO NO CÓDIGO] A conferência prova presença, classe e unicidade; não prova posição, suporte físico nem funcionamento. Nenhum obrigatório Underground ausente ou ambíguo foi observado.
- [SUPOSIÇÃO] Funcionamento relatado pelo dono continua relato do dono, NÃO TESTADO por agente; sem conclusão de funcionamento ou aceite de -3.
- [NÃO ENCONTRADO] NÃO TESTADO: posição, suporte físico/raycast, propriedades físicas, funcionamento, Play, require, execução/compilação de módulos, UnitTest, equivalência atual disco/Studio/.rbxl salvo e Rojo/sincronização. Nenhum commit.
