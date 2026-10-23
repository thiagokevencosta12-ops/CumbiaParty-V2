# CP2-000d — Plano de migração do código para Rojo

## Escopo e evidências

- [SUPOSIÇÃO] Plano de execução futura, revisado conforme autorização do dono em 23/10/2026. Esta entrega é documental: somente `docs/TECH/MIGRATION_PLAN.md` e `docs/OPS/BACKLOG.md` podem ser alterados; não autoriza migração, conexão Rojo, syncback, Play, publicação ou alterações no Studio.
- [CONFIRMADO NO CÓDIGO] Na retomada, este arquivo não existia; `src/` e `tests/` continham somente `.gitkeep`. A busca local não encontrou configuração `*.project.json`.
- [CONFIRMADO NO CÓDIGO] O [ADR-0001](../../decisions/ADR-0001.md) registra Rojo 7.7.1 via Rokit, prova disco → Studio e reversão Git em projeto descartável; também determina que mapa e objetos visuais permanecem no `.rbxl`. Isso é evidência documental, não repetição da prova nesta sessão.
- [CONFIRMADO NO CÓDIGO] O [spotcheck](../OPS/V1_AUDIT_SPOTCHECK.md) registra sete itens correspondentes à auditoria na cópia de trabalho, incluindo estrutura, D/F/J/K e dependência de `inputTime`. Nenhum desses resultados foi revalidado no Studio nesta retomada.
- [SUPOSIÇÃO] Fontes de seleção: [inventário](../OPS/V1_INVENTORY.md), [classificação](../OPS/V1_CLASSIFICATION.md), [dependências](V1_DEPENDENCIES.md), [contratos](NETWORK_CONTRACTS.md), [arquitetura](ARCHITECTURE.md), [design](../PRODUCT/GAME_DESIGN.md) e [estado atual](../OPS/CURRENT_STATE.md). Propostas e requisitos usam [SUPOSIÇÃO], inclusive quando aprovados pelo dono; confirmações locais e relatos documentais são identificados explicitamente.
- [CONFIRMADO NO CÓDIGO] O [backlog](../OPS/BACKLOG.md) registra CP2-000d como planejamento documental concluído por este documento e separa a execução no CP2-000e, ainda dependente da aprovação da lista pelo dono.

## Premissas, limites e pendências

- [SUPOSIÇÃO] A migração inicial será mecânica: preservar Source, nomes, classes, hierarquia e propriedades relevantes; não refatorar nem converter regras da V1 para V2 no mesmo lote. Copiar uma base para versionamento não significa aprová-la para o MVP.
- [SUPOSIÇÃO] A/S/D/F, correções de R1–R7, dano, empate, holds, Great e dificuldade dos bots pertencem a tickets próprios. O servidor continuará responsável por notas, pontos, dano e resultados; a migração não deve transferir autoridade ao cliente.
- [SUPOSIÇÃO] Não há pergunta impeditiva para escrever este plano. Antes de executar, será necessário conferir a identidade do place, integridade do backup, inventário atual e prévia de sincronização; qualquer divergência bloqueia a conexão até revisão.
- [SUPOSIÇÃO] O escopo explícito desta revisão substitui a regra geral de atualizar CURRENT_STATE.md: somente este plano e o backlog serão alterados. CURRENT_STATE.md, ADR, `src/`, `tests/`, configurações e Studio permanecerão intactos.

## Backup obrigatório e fonte inicial

- [SUPOSIÇÃO] Base histórica intocável: `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V1_2026-10-22.rbxl`; cópia operacional prevista: `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V2_Trabalho.rbxl`, conforme CURRENT_STATE.md.
- [SUPOSIÇÃO] Pré-requisito obrigatório antes de qualquer migração: `C:\Users\Thiago-PC1\CumbiaParty-Arquivos\CumbiaParty_V2_Trabalho_pre-migracao.rbxl`. Preservar esse arquivo sem conectar Rojo a ele nem sobrescrevê-lo durante o trabalho.
- [CONFIRMADO NO CÓDIGO] A consulta local encontrou o arquivo pré-migração no caminho acima, com 1.794.879 bytes. Existência e tamanho foram verificados; seu conteúdo não foi aberto no Studio.
- [NÃO ENCONTRADO] Integridade, capacidade de abertura e equivalência desse backup ao estado imediatamente anterior à migração não foram verificadas nesta sessão.
- [SUPOSIÇÃO] Na execução futura, registrar SHA-256, tamanho, data e identificação da cópia de trabalho; validar a abertura de uma cópia descartável do backup, sem salvar no original. Se houver alterações posteriores ao backup, preservar também uma cópia datada e decidir qual estado será a referência antes de prosseguir.
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
- [CONFIRMADO NO CÓDIGO] Evidência documental externa: a documentação oficial [Properties, linha v7](https://rojo.space/docs/v7/properties/#attributes) declara `Attributes` em qualquer instância e suporte em build, live sync e arquivos de projeto. Portanto, o suporte documentado abrange Folder, Script, LocalScript e ModuleScript; não é exclusivo de scripts. Cada valor de atributo deve ter tipo explícito na representação JSON.
- [CONFIRMADO NO CÓDIGO] Evidência documental externa: [Sync Details](https://rojo.space/docs/v7/sync-details/#meta-files) descreve propriedades em `.meta.json`, inclusive para scripts, e `init.meta.json` para diretórios. [Project Format](https://rojo.space/docs/v7/project-format/#instance-description) descreve `$properties` por instância. Isso permite planejar `Attributes` nos nós das pastas e scripts via `$properties`, ou em `properties` nos metadados apropriados.
- [CONFIRMADO NO CÓDIGO] Evidência documental externa: a [release 7.7.1](https://github.com/rojo-rbx/rojo/releases/tag/v7.7.1) confirma a versão fixada e correções de caminhos Windows e de acesso do plugin ao GitHub. As páginas acima são da linha v7, sem identificação exclusiva da revisão 7.7.1; sua leitura não equivale a executar uma prova nessa versão.
- [NÃO ENCONTRADO] Essas fontes não confirmam que todos os atributos já existentes serão preservados quando omitidos do mapeamento, nem garantem o resultado desta migração concreta. Não estabelecem uma prova de preservação dos valores e tipos encontrados em CumbiaParty na 7.7.1. `$ignoreUnknownInstances` trata de instâncias desconhecidas, não constitui garantia de preservação de atributos.
- [SUPOSIÇÃO] Estratégia proposta: registrar e representar explicitamente todos os atributos encontrados nos nós gerenciados, com tipos e valores fiéis, sem declarar simultaneamente duas representações do mesmo conjunto. Qualquer tipo sem representação comprovada bloqueia a migração daquele nó até revisão; não descartar ou converter silenciosamente.

### Prova obrigatória na cópia descartável

1. [SUPOSIÇÃO] Confirmar CLI e plugin 7.7.1, identidade da cópia descartável e snapshot inicial: caminhos, classes, nomes, atributos completos com tipos/valores e propriedades de execução. Usar cópia do place completo, mantendo backup e base congelada intactos.
2. [SUPOSIÇÃO] Ensaiar separadamente Folder e cada classe de script presente. Em cópias descartáveis independentes do mesmo estado inicial, comparar um caso com atributos explicitamente declarados e um caso com um atributo preexistente omitido; incluir também omissão de toda a propriedade Attributes. Registrar se o atributo omitido permanece, muda ou desaparece, sem extrapolar esse resultado para outros tipos/versões.
3. [SUPOSIÇÃO] Conferir a prévia, aplicar apenas na cópia descartável e reler `GetAttributes()`. Comparar conjunto de chaves, tipos e valores por instância; verificar também classes, hierarquia, Source e objetos fora do mapeamento. Alterar somente Source no disco, sincronizar novamente e repetir a comparação para verificar preservação em atualização subsequente.
4. [SUPOSIÇÃO] Aceitar a configuração final somente com igualdade integral dos atributos originais e sem remoções, substituições ou alterações externas não autorizadas. Guardar snapshots, versão, configuração e diferenças no relatório futuro. A experiência de omissão informa o comportamento, mas a configuração final deve preservar o conjunto completo; qualquer perda interrompe a execução.
- [NÃO ENCONTRADO] Essa prova de atributos na versão 7.7.1 não foi executada nesta entrega documental.

## Decisões do dono

- [SUPOSIÇÃO] Solicitar aprovação explícita da lista fechada abaixo antes do CP2-000e. Aprovar esta revisão documental não aprova automaticamente a lista nem autoriza executar a migração. Cada nome da tabela representa um script no caminho indicado; não inclui descendentes adicionais.

| Estado | Caminho pai no Studio | Scripts candidatos | Quantidade |
|---|---|---|---|
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty` | `ServerBootstrap` | 1 |
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty.Services` | `ArenaService`, `BattleService`, `BotService`, `CompetitorService`, `LobbyService`, `RhythmService`, `TournamentService`, `WaveGenerator`, `WorldBindings` | 9 |
| [SUPOSIÇÃO] | `ServerScriptService.CumbiaParty.Validation` | `NoteValidator` | 1 |
| [SUPOSIÇÃO] | `ReplicatedStorage.CumbiaParty.Shared` | `GameConfig`, `NetworkTypes`, `WorldConfig`, `BattlePresentationConfig` | 4 |
| [SUPOSIÇÃO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty` | `ClientBootstrap` | 1 |
| [SUPOSIÇÃO] | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers` | `UIController`, `InputController`, `CompetitorPortrait`, `TournamentController`, `LobbyController`, `ArenaController`, `BattleHUD`, `BattlePresentationView` | 8 |

- [SUPOSIÇÃO] Decisão 1 — Aprovar os 24 candidatos (11 servidor + 4 compartilhados + 9 cliente), com os caminhos e destinos descritos neste plano? Estado: PENDENTE.
- [SUPOSIÇÃO] Decisão 2 — Aprovar a exclusão de `ServerStorage.UnitTest`, `ServerScriptService.UnitTestRunner` e `StarterPlayer.StarterPlayerScripts.CumbiaPartyFestivalFX` da migração inicial? Exclusão significa não exportar/mapear; preservar os objetos e seu estado no `.rbxl`, sem apagar ou ativar nada. Estado: PENDENTE.
- [SUPOSIÇÃO] Decisão 3 — Aprovar que a migração, revisão e execução da suíte UnitTest fiquem para ticket próprio, ainda a definir? As verificações de fidelidade, atributos, preservação e funcionamento da migração continuam obrigatórias no CP2-000e. Estado: PENDENTE.
- [NÃO ENCONTRADO] Aprovação dessas três decisões para execução não está registrada nesta entrega. Registrar a resposta do dono antes de iniciar CP2-000e; divergências do inventário exigem nova revisão da lista.

## Extração do Source pelo MCP e verificação de fidelidade

1. [SUPOSIÇÃO] Na execução autorizada, selecionar explicitamente a sessão Studio da cópia de trabalho em modo Edit e resolver cada um dos 24 caminhos completos, validando nome, classe e ausência de duplicatas. Ler a propriedade `Source` via MCP, sem executar `require`, módulos ou o jogo e sem modificar instâncias.
2. [SUPOSIÇÃO] Preferir leitura bruta de `Source` por uma consulta Luau somente de leitura via MCP, retornando texto em transporte estruturado com escapes reversíveis, caminho e comprimento em bytes. `script_read` apresenta números de linha e serve para inspeção; sua saída formatada não será copiada diretamente para os arquivos. Se a resposta exceder limites, transportar blocos com offsets e comprimento total, reconstruir na ordem e rejeitar lacunas, sobreposições ou truncamento.
3. [SUPOSIÇÃO] Gravar o texto decodificado nos destinos aprovados usando a ferramenta local de arquivos, em UTF-8 sem BOM acrescentado, sem interpolação pelo shell, reindentação, formatador, mudança de nomes ou conversão automática de finais de linha. Preservar CRLF/LF, espaços, caracteres Unicode e presença/ausência da quebra final conforme a origem. A gravação é etapa explícita no disco, não syncback nem sincronização bidirecional.
4. [SUPOSIÇÃO] Registrar manifesto por script: caminho original, classe, destino, quantidade de bytes, SHA-256 dos bytes do Source recebido, finais de linha e propriedades/atributos. Ler novamente o arquivo do disco e comparar bytes e SHA-256 com o buffer extraído; realizar uma segunda leitura independente pelo MCP e comparar integralmente com o arquivo. Hash apenas do arquivo, sem comparação com a origem, não prova fidelidade.
5. [SUPOSIÇÃO] Registrar qualquer normalização de fim de linha como diferença, mesmo se o texto parecer equivalente. Uma comparação adicional normalizada pode diagnosticar a causa, mas não substitui o aceite por igualdade exata; divergência bloqueia até correção ou decisão explícita do dono. Conferir também configurações Git que possam transformar os arquivos, sem alterá-las automaticamente.
6. [SUPOSIÇÃO] Após sincronização na cópia descartável, reler Source dos 24 objetos pelo MCP e comparar novamente com os arquivos e manifesto, além de nomes, classes, hierarquia, atributos e propriedades de execução. Exigir 24/24 correspondências, nenhuma ausência, duplicação ou diferença inexplicada. Preservar evidências antes de transferir o procedimento à cópia de trabalho.
- [NÃO ENCONTRADO] Extração, arquivos Source, manifesto de hashes e comparação disco/Studio ainda não foram produzidos ou executados; esta seção define o método futuro.

## Sequência futura e critérios de parada

1. [SUPOSIÇÃO] Preparar: obter as aprovações da seção Decisões do dono, revisar o escopo do CP2-000e, conferir base e backup obrigatório, registrar estado Git e inventário da cópia de trabalho. Fixar a versão registrada no ADR no futuro `rokit.toml`; não instalar nem executar ferramentas nesta entrega.
2. [SUPOSIÇÃO] Extrair: seguir o método MCP → arquivos descrito acima para os 24 candidatos, sem executar módulos. Registrar manifesto com origem, destino, classe, Disabled/Enabled quando aplicável, RunContext, atributos completos de scripts e pastas mapeadas e hash do Source; tratar diferenças de fim de linha explicitamente. Uma dependência ausente exige revisar a lista, não importar backups indiscriminadamente.
3. [SUPOSIÇÃO] Conferir em disco: comparar cada Source ao original e revisar requires, referências relativas e classes resultantes das extensões de arquivo. Não renomear os objetos do Studio. Separar extração de qualquer melhoria de código em commits pequenos, quando a execução estiver autorizada.
4. [SUPOSIÇÃO] Configurar em projeto descartável: preparar mapeamento restrito e política de preservação de filhos desconhecidos; executar a prova de atributos descrita acima com cópia do place completo. Conferir prévia antes de aplicar. Se aparecer remoção de mapa, GUI, Remote, backup, ferramenta ou objeto fora da lista, parar e corrigir o mapeamento.
5. [SUPOSIÇÃO] Aplicar somente à cópia descartável: comparar hierarquia, classes, propriedades e Source antes/depois. Confirmar que existe apenas um bootstrap ativo por lado e que o runner de testes permanece desabilitado; preservar as instâncias externas ao mapeamento.
6. [SUPOSIÇÃO] Validar em execução autorizada: primeiro inicialização e Output, depois lobby → fila → torneio com bots → resultado → retorno, entrada pelas teclas atuais D/F/J/K, câmera, GUI, saída e respawn. Comparar com a base pré-migração; registrar falhas herdadas separadas das regressões. Migração, revisão do runner e execução da suíte UnitTest ficam para ticket próprio, conforme decisão pendente do dono; não fazem parte do CP2-000e.
7. [SUPOSIÇÃO] Transferir o procedimento à cópia de trabalho somente depois de evidências satisfatórias na cópia descartável, backup validado e prévia restrita. Conferir a barra de título e a sessão conectada; nunca conectar à V1 congelada nem ao backup pré-migração.
8. [SUPOSIÇÃO] Encerrar a execução futura: registrar versão, manifesto, diferenças, testes e NÃO TESTADO; atualizar CURRENT_STATE.md e demais registros somente no escopo autorizado para essa etapa. Nenhuma publicação faz parte da migração.

- [SUPOSIÇÃO] Parar diante de perda de objeto, diferença de Source não explicada, duplicação de bootstrap, referências quebradas, mudança de comportamento ou dúvida sobre o place conectado. Não usar syncback como tentativa de reparo; após três tentativas sem sucesso do mesmo bug, interromper e propor nova abordagem, conforme AGENTS.md.

## Reversão por restauração do arquivo

1. [SUPOSIÇÃO] Em caso de falha, interromper a sincronização e desconectar o plugin antes de restaurar; encerrar Play se houver. Registrar a falha e preservar separadamente a cópia defeituosa se necessário, sem sobrescrever o backup.
2. [SUPOSIÇÃO] Restaurar a cópia operacional a partir de `CumbiaParty_V2_Trabalho_pre-migracao.rbxl`, mantendo o arquivo original de backup intacto. Fazer a restauração em uma nova cópia e confirmar a abertura, identidade, hierarquia e scripts com Rojo desconectado; substituição de arquivo relevante exige autorização explícita.
3. [SUPOSIÇÃO] Voltar os arquivos de código/configuração ao ponto anterior à migração por reversão Git revisada, preservando alterações independentes. Git sozinho não restaura mapa, Terrain, GUI, Remotes ou objetos do `.rbxl`.
4. [SUPOSIÇÃO] Não reconectar enquanto código e configuração não forem compatíveis com o estado restaurado e a prévia não estiver aprovada. Repetir as verificações de inicialização e fluxo na cópia restaurada antes de retomar a migração.
- [SUPOSIÇÃO] As ferramentas `PhaseCRestore`, `PhaseDRestore` ou `GreyboxMigration` não são o mecanismo de reversão deste plano. A reversão depende da restauração do arquivo pré-migração completo.
- [NÃO ENCONTRADO] Ensaio de restauração e validação do backup em execução: NÃO TESTADO nesta entrega.

## Aceite do plano e limites desta entrega

- [SUPOSIÇÃO] Aceite documental: fontes e limites explícitos; lista de scripts e fronteira Rojo/Studio; backups e Phase* fora de src/ por padrão; backup pré-migração obrigatório; sequência com verificações e critérios de parada; reversão por restauração do `.rbxl`; separação entre migração mecânica e implementação da V2.
- [CONFIRMADO NO CÓDIGO] A elaboração anterior registrou leituras locais e existência/tamanho do backup. Nesta revisão foram lidos CURRENT_STATE.md, GAME_DESIGN.md, AGENTS.md, este plano e o backlog, consultadas as fontes oficiais do Rojo e inspecionado o estado Git. Nenhuma ferramenta do Studio foi chamada nesta revisão; os relatos anteriores não representam novas verificações.
- [NÃO ENCONTRADO] Migração, Rojo, syncback, build, sincronização, Play, testes unitários, multiplayer, mobile, segurança, desempenho, memória e equivalência funcional: NÃO TESTADOS nesta retomada. Este plano não é evidência de migração concluída.
- [CONFIRMADO NO CÓDIGO] CP2-000d concluído como entrega documental neste plano e registrado no backlog. CP2-000e é a execução futura; sua conclusão não é afirmada aqui.
- [SUPOSIÇÃO] Executar CP2-000e exige aprovações da seção Decisões do dono, cumprimento dos pré-requisitos e evidências futuras de fidelidade e preservação. A aprovação da edição destes dois documentos não autoriza executar CP2-000e.
