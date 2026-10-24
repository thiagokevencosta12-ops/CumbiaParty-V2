# CP2-000e-2 — Manifesto da extração

- [SUPOSIÇÃO] Execução e plano aprovados pelo dono em 24/10/2026. Escopo: 24 Sources, este manifesto e registros CP2-000e-2 no plano/backlog; etapas -3 a -8 PENDENTES.
- [CONFIRMADO NO CÓDIGO] Única sessão MCP: CumbiaParty_V2_Trabalho.rbxl, ID a84afcec-168b-4427-996c-68a6099df5fb; modo, DataModel disponível e foco Edit confirmados antes da extração.
- [CONFIRMADO NO CÓDIGO] Os 24 caminhos foram resolvidos segmento a segmento, exigindo uma única correspondência e a classe aprovada. Metadados e atributos foram relidos via MCP nesta etapa; os 24 conjuntos de atributos estão vazios.
- [CONFIRMADO NO CÓDIGO] Source bruto lido somente por consultas Luau via MCP. Transporte estruturado de blocos de até 4000 bytes, com caminho, classe, comprimento total, offset zero-based e comprimento do bloco; bytes codificados em hexadecimal reversível, sem números de linha ou formatação. Conferidos offsets contíguos, cobertura integral, tamanho hexadecimal e comprimento total, rejeitando lacunas, sobreposições e respostas inválidas. Não houve truncamento detectado.
- [CONFIRMADO NO CÓDIGO] Gravação binária dos bytes decodificados, validando UTF-8 estrito e conversão reversível antes de gravar. Nenhum BOM acrescentado; nenhum dos 24 Sources recebidos tinha BOM. Sem normalização, formatação, reindentação ou alteração de quebra final.
- [CONFIRMADO NO CÓDIGO] Cada arquivo foi relido do disco e comparado integralmente ao buffer recebido, além de SHA-256: 24/24 iguais; total de 162095 bytes. Finais de linha: 3 CRLF, 14 LF e 7 mistos; 7 arquivos sem quebra final. LF e CR isolados são contados sem incluir pares CRLF.
- [CONFIRMADO NO CÓDIGO] Nenhum require ou módulo foi executado, nenhum Play iniciado, nenhuma escrita no Studio ou em .rbxl realizada. Nenhum comando Rojo/Rokit, configuração, instalação ou commit foi executado neste ticket.
- [NÃO ENCONTRADO] NÃO TESTADO: segunda leitura independente do Source pelo MCP e conferência integral da etapa -3; compilação/execução dos scripts, testes funcionais, UnitTest, gameplay, sincronização e preservação pelo Rojo. As leituras dos blocos integram a primeira extração e não equivalem à conferência independente.

## Git e divergências

- [CONFIRMADO NO CÓDIGO] Estado inicial: git status --short vazio. core.autocrlf=true, origem C:/Users/Thiago-PC1/.cache/codex-runtimes/codex-primary-runtime/dependencies/native/git/etc/gitconfig. A consulta não encontrou valores explícitos para core.eol, core.safecrlf ou core.attributesfile. A busca no repositório não encontrou .gitattributes; .git/info/attributes não foi encontrado.
- [CONFIRMADO NO CÓDIGO] git check-attr text eol working-tree-encoding filter retornou unspecified nos quatro atributos para cada um dos 24 destinos. Nenhuma configuração ou .gitattributes foi criada/alterada.
- [SUPOSIÇÃO] Efeito provável de core.autocrlf=true: arquivos reconhecidos como texto podem ser normalizados para LF ao entrar no índice e materializados com CRLF em futuras operações de checkout. Isso pode mudar bytes/hashes em relação ao Source, sobretudo nos arquivos LF ou mistos; conteúdo com CR isolado pode receber tratamento diferente pela detecção de texto. Não foi feito git add/checkout para testar conversões, e a gravação binária atual não passou pelos filtros Git.
- [CONFIRMADO NO CÓDIGO] git diff --no-index --check -- /dev/null <arquivo> foi executado nos 24 arquivos novos, pois git diff --check comum não inclui untracked. Houve avisos de futura conversão LF→CRLF em 19 arquivos. Dez arquivos tiveram diagnóstico de whitespace: todos com linha em branco no EOF; WorldBindings teve também 194 ocorrências de trailing whitespace, WorldConfig 109. Resultados individuais abaixo. Código 1 indica diferenças contra arquivo vazio, sem erro de whitespace; código 3 inclui os diagnósticos de whitespace nesta comparação.
- [CONFIRMADO NO CÓDIGO] Divergências de fidelidade disco/recebido: nenhuma. Whitespace, finais mistos e CR isolados foram preservados exatamente, sem correção. WorldBindings contém 1 CR isolado; WorldConfig contém 107. O resultado do check de whitespace não é declarado como aprovado para esses Sources.
- [SUPOSIÇÃO] Veredito: pronto para aceite da CP2-000e-2 — 24 arquivos e manifesto completos, 24/24 releituras iguais ao recebido. Isto não encerra a conferência independente nem autoriza CP2-000e-3.

## Registros por script

### 1. ServerBootstrap

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.ServerBootstrap`; classe: `Script`; destino: `src/server/ServerBootstrap.server.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 4375 / 4375; SHA-256 recebido: `1baa4e9f146362bd92fbe38c9e77fabb260acdf3a7a99a6acf6d90c84bd60771`; SHA-256 disco: `1baa4e9f146362bd92fbe38c9e77fabb260acdf3a7a99a6acf6d90c84bd60771`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **CRLF**; CRLF=87, LF isolado=0, CR isolado=0; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: false; RunContext: Enum.RunContext.Legacy; atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:375. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=0; linha em branco no EOF=1; aviso de conversão LF→CRLF=0.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 2. ArenaService

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.ArenaService`; classe: `ModuleScript`; destino: `src/server/Services/ArenaService.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 12216 / 12216; SHA-256 recebido: `7f6629b1b9529189e8ab9ed0163be43405ea39e5983364863066e81587a2e142`; SHA-256 disco: `7f6629b1b9529189e8ab9ed0163be43405ea39e5983364863066e81587a2e142`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **misto**; CRLF=1, LF isolado=195, CR isolado=0; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:4000, 12000:216. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=0; linha em branco no EOF=1; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 3. BattleService

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.BattleService`; classe: `ModuleScript`; destino: `src/server/Services/BattleService.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 10446 / 10446; SHA-256 recebido: `b2384aa78986b30f26443c933e4112d26300b92b90a929c1baf98eb18dd039ca`; SHA-256 disco: `b2384aa78986b30f26443c933e4112d26300b92b90a929c1baf98eb18dd039ca`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=223, CR isolado=0; quebra final: ausente; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:2446. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 4. BotService

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.BotService`; classe: `ModuleScript`; destino: `src/server/Services/BotService.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 2779 / 2779; SHA-256 recebido: `c8542295c0f28d08a1c17d0af1741a844edd8e3d0c01e8f5667b4dc0e1a58c47`; SHA-256 disco: `c8542295c0f28d08a1c17d0af1741a844edd8e3d0c01e8f5667b4dc0e1a58c47`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=64, CR isolado=0; quebra final: LF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:2779. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 5. CompetitorService

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.CompetitorService`; classe: `ModuleScript`; destino: `src/server/Services/CompetitorService.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 2029 / 2029; SHA-256 recebido: `d58bfb6bf98266dd9c02f087757ecdfcb81cb9adc53df6834eb21de5d829eba8`; SHA-256 disco: `d58bfb6bf98266dd9c02f087757ecdfcb81cb9adc53df6834eb21de5d829eba8`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=50, CR isolado=0; quebra final: LF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:2029. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 6. LobbyService

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.LobbyService`; classe: `ModuleScript`; destino: `src/server/Services/LobbyService.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 6171 / 6171; SHA-256 recebido: `73c5b253ef261abd6c51085f4f75601fd81d5a40685db540608465d0c00de272`; SHA-256 disco: `73c5b253ef261abd6c51085f4f75601fd81d5a40685db540608465d0c00de272`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **misto**; CRLF=1, LF isolado=129, CR isolado=0; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:2171. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=0; linha em branco no EOF=1; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 7. RhythmService

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.RhythmService`; classe: `ModuleScript`; destino: `src/server/Services/RhythmService.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 9122 / 9122; SHA-256 recebido: `5fc8494c77a5178ce2735c8d901b6bbf39be20e8401eaaff2cae72a2bbf95f86`; SHA-256 disco: `5fc8494c77a5178ce2735c8d901b6bbf39be20e8401eaaff2cae72a2bbf95f86`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=181, CR isolado=0; quebra final: ausente; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:1122. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 8. TournamentService

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.TournamentService`; classe: `ModuleScript`; destino: `src/server/Services/TournamentService.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 14884 / 14884; SHA-256 recebido: `650eb4ca3294ef8bdfcfdf5e30e920bd537fdcd788406fcd24098e5ba7dac23d`; SHA-256 disco: `650eb4ca3294ef8bdfcfdf5e30e920bd537fdcd788406fcd24098e5ba7dac23d`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **CRLF**; CRLF=337, LF isolado=0, CR isolado=0; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:4000, 12000:2884. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=0; linha em branco no EOF=1; aviso de conversão LF→CRLF=0.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 9. WaveGenerator

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.WaveGenerator`; classe: `ModuleScript`; destino: `src/server/Services/WaveGenerator.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 2227 / 2227; SHA-256 recebido: `3670f60acbc001852c7f3c860d87c52ab121fe4e50962764c901eff4e6031093`; SHA-256 disco: `3670f60acbc001852c7f3c860d87c52ab121fe4e50962764c901eff4e6031093`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=55, CR isolado=0; quebra final: ausente; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:2227. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 10. WorldBindings

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Services.WorldBindings`; classe: `ModuleScript`; destino: `src/server/Services/WorldBindings.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 10877 / 10877; SHA-256 recebido: `edd7233145490ef190041c7516aef14d0d21357861a3f122ee3e2537ce0857bc`; SHA-256 disco: `edd7233145490ef190041c7516aef14d0d21357861a3f122ee3e2537ce0857bc`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **misto**; CRLF=194, LF isolado=0, CR isolado=1; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:2877. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=194; linha em branco no EOF=1; aviso de conversão LF→CRLF=0.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 11. NoteValidator

- [CONFIRMADO NO CÓDIGO] Origem: `ServerScriptService.CumbiaParty.Validation.NoteValidator`; classe: `ModuleScript`; destino: `src/server/Validation/NoteValidator.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 1978 / 1978; SHA-256 recebido: `5399120305f12d3ca7673802101635204860c2242c5b8d289734bf3cf8696b3e`; SHA-256 disco: `5399120305f12d3ca7673802101635204860c2242c5b8d289734bf3cf8696b3e`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=32, CR isolado=0; quebra final: ausente; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:1978. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 12. GameConfig

- [CONFIRMADO NO CÓDIGO] Origem: `ReplicatedStorage.CumbiaParty.Shared.GameConfig`; classe: `ModuleScript`; destino: `src/shared/GameConfig.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 4449 / 4449; SHA-256 recebido: `7e55816a5e52454aeb339a12812e963765114d9116f1be593761a03d133fca09`; SHA-256 disco: `7e55816a5e52454aeb339a12812e963765114d9116f1be593761a03d133fca09`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=100, CR isolado=0; quebra final: ausente; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:449. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 13. NetworkTypes

- [CONFIRMADO NO CÓDIGO] Origem: `ReplicatedStorage.CumbiaParty.Shared.NetworkTypes`; classe: `ModuleScript`; destino: `src/shared/NetworkTypes.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 2430 / 2430; SHA-256 recebido: `3d1b601b16332855d11807054c05c8da5cbdf8eeb2f988d30782a74c3d4d8ba6`; SHA-256 disco: `3d1b601b16332855d11807054c05c8da5cbdf8eeb2f988d30782a74c3d4d8ba6`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **misto**; CRLF=30, LF isolado=3, CR isolado=0; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:2430. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=0; linha em branco no EOF=1; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 14. WorldConfig

- [CONFIRMADO NO CÓDIGO] Origem: `ReplicatedStorage.CumbiaParty.Shared.WorldConfig`; classe: `ModuleScript`; destino: `src/shared/WorldConfig.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 8811 / 8811; SHA-256 recebido: `242b3caee54351343f174163d588ca8283a132317131b6448bf1d5f36225fd69`; SHA-256 disco: `242b3caee54351343f174163d588ca8283a132317131b6448bf1d5f36225fd69`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **misto**; CRLF=109, LF isolado=0, CR isolado=107; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:811. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=109; linha em branco no EOF=1; aviso de conversão LF→CRLF=0.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 15. BattlePresentationConfig

- [CONFIRMADO NO CÓDIGO] Origem: `ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig`; classe: `ModuleScript`; destino: `src/shared/BattlePresentationConfig.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 1414 / 1414; SHA-256 recebido: `f9276d6ed30d91fb79bce7844d1964bfbc7c36cdd421556e81ef8b33e03e1ae3`; SHA-256 disco: `f9276d6ed30d91fb79bce7844d1964bfbc7c36cdd421556e81ef8b33e03e1ae3`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=29, CR isolado=0; quebra final: LF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:1414. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 16. ClientBootstrap

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap`; classe: `LocalScript`; destino: `src/client/ClientBootstrap.client.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 6188 / 6188; SHA-256 recebido: `67568128d427f254e4dc30a40d979b550d33bbf4473820e27bc818929941dd21`; SHA-256 disco: `67568128d427f254e4dc30a40d979b550d33bbf4473820e27bc818929941dd21`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **CRLF**; CRLF=124, LF isolado=0, CR isolado=0; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: false; RunContext: Enum.RunContext.Legacy; atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:2188. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=0; linha em branco no EOF=1; aviso de conversão LF→CRLF=0.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 17. UIController

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController`; classe: `ModuleScript`; destino: `src/client/Controllers/UIController.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 14409 / 14409; SHA-256 recebido: `19dda8ca889b241c230c971fac8da728758ee8e47178c0af252477be09d0a1e4`; SHA-256 disco: `19dda8ca889b241c230c971fac8da728758ee8e47178c0af252477be09d0a1e4`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=280, CR isolado=0; quebra final: ausente; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:4000, 12000:2409. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 18. InputController

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController`; classe: `ModuleScript`; destino: `src/client/Controllers/InputController.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 6263 / 6263; SHA-256 recebido: `0933aaa503e55abd7e0938b3d0925f4e78100f952d4d7dcda56b1f50320140e8`; SHA-256 disco: `0933aaa503e55abd7e0938b3d0925f4e78100f952d4d7dcda56b1f50320140e8`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=139, CR isolado=0; quebra final: ausente; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:2263. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 19. CompetitorPortrait

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait`; classe: `ModuleScript`; destino: `src/client/Controllers/CompetitorPortrait.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 1605 / 1605; SHA-256 recebido: `5bce4720c123a800d2ecb52b6dfe271ae49b858877fb83ef9eaae3e70f3f7adc`; SHA-256 disco: `5bce4720c123a800d2ecb52b6dfe271ae49b858877fb83ef9eaae3e70f3f7adc`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=31, CR isolado=0; quebra final: LF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:1605. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 20. TournamentController

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.TournamentController`; classe: `ModuleScript`; destino: `src/client/Controllers/TournamentController.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 8500 / 8500; SHA-256 recebido: `3db4187efd8e172795c7121ebcad077a37329203762df6665de3dcb2d0caf28f`; SHA-256 disco: `3db4187efd8e172795c7121ebcad077a37329203762df6665de3dcb2d0caf28f`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=148, CR isolado=0; quebra final: LF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:500. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 21. LobbyController

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.LobbyController`; classe: `ModuleScript`; destino: `src/client/Controllers/LobbyController.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 4329 / 4329; SHA-256 recebido: `cdc30647bcfc85a7ee4f59aeaf50308f716f6218d847f422ff20b68da7c8d1f7`; SHA-256 disco: `cdc30647bcfc85a7ee4f59aeaf50308f716f6218d847f422ff20b68da7c8d1f7`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=63, CR isolado=0; quebra final: LF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:329. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 22. ArenaController

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController`; classe: `ModuleScript`; destino: `src/client/Controllers/ArenaController.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 5663 / 5663; SHA-256 recebido: `4848a77f8cc666fac73f912dcec04c05e7f7267a357455581db0d31ef3694fa5`; SHA-256 disco: `4848a77f8cc666fac73f912dcec04c05e7f7267a357455581db0d31ef3694fa5`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **misto**; CRLF=1, LF isolado=109, CR isolado=0; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:1663. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=0; linha em branco no EOF=1; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 23. BattleHUD

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD`; classe: `ModuleScript`; destino: `src/client/Controllers/BattleHUD.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 10500 / 10500; SHA-256 recebido: `11ec855fb26b6f2182cbd7de180b50a6582f5c63c683e5a4b9595072a0290019`; SHA-256 disco: `11ec855fb26b6f2182cbd7de180b50a6582f5c63c683e5a4b9595072a0290019`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **misto**; CRLF=1, LF isolado=199, CR isolado=0; quebra final: CRLF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:2500. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 3; trailing whitespace=0; linha em branco no EOF=1; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).

### 24. BattlePresentationView

- [CONFIRMADO NO CÓDIGO] Origem: `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattlePresentationView`; classe: `ModuleScript`; destino: `src/client/Controllers/BattlePresentationView.luau`.
- [CONFIRMADO NO CÓDIGO] Bytes recebidos/disco: 10430 / 10430; SHA-256 recebido: `743535107a5a906784b9e5a94eb2348e566e2d4feace4644542f9d3db5dd22d6`; SHA-256 disco: `743535107a5a906784b9e5a94eb2348e566e2d4feace4644542f9d3db5dd22d6`; comparação integral: IGUAL.
- [CONFIRMADO NO CÓDIGO] Final de linha: **LF**; CRLF=0, LF isolado=261, CR isolado=0; quebra final: LF; BOM: ausente.
- [CONFIRMADO NO CÓDIGO] Disabled: não aplicável (ModuleScript); RunContext: não aplicável (ModuleScript); atributos GetAttributes(): `{}` (vazio).
- [CONFIRMADO NO CÓDIGO] Blocos recebidos (offset:bytes): 0:4000, 4000:4000, 8000:2430. Sem lacunas ou sobreposições.
- [CONFIRMADO NO CÓDIGO] Check no-index: saída 1; trailing whitespace=0; linha em branco no EOF=0; aviso de conversão LF→CRLF=1.
- [NÃO ENCONTRADO] Segunda leitura independente pelo MCP: NÃO TESTADO (etapa -3).
