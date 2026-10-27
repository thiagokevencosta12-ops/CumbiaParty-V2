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

## CP2-000e-3 — Conferência independente em disco (24/10/2026)

- [SUPOSIÇÃO] Execução, plano e item 7 aprovados pelo dono neste ticket. Escopo documental restrito a manifesto, plano e backlog; -4 a -8 PENDENTES. Os registros acima permanecem históricos da etapa -2; esta seção registra as novas verificações.
- [CONFIRMADO NO CÓDIGO] Sessão MCP única CumbiaParty_V2_Trabalho.rbxl, ID a84afcec-168b-4427-996c-68a6099df5fb; modo, DataModel disponível e foco Edit. Git inicial limpo, HEAD 7969b6a6fc2a273148bf06a4310575ef1ebc377f.
- [CONFIRMADO NO CÓDIGO] Segunda leitura independente dos 24 Sources via execute_luau em Edit, somente consultas. Resolução segmento a segmento com rejeição de nomes duplicados/ausentes; caminho, classe e comprimento bruto retornados. Cada Source relido nesta etapa, sem reutilizar buffers da -2, dividido em blocos hexadecimais reversíveis de até 4000 bytes. Validados offsets contíguos, comprimento hexadecimal, cobertura total e classe; comparação Buffer.equals com leitura binária fs.readFile, sem normalização.
- [CONFIRMADO NO CÓDIGO] Resultado: 24/24 bytes idênticos MCP/disco; SHA-256 MCP/disco/manifesto iguais, total 162095 bytes. Classes/extensões 24/24: ServerBootstrap Script/.server.luau; ClientBootstrap LocalScript/.client.luau; outros 22 ModuleScript/.luau. Nenhuma divergência de fidelidade.
- [CONFIRMADO NO CÓDIGO] Item 7: git cat-file blob <commit>:<caminho>, capturado por execFileSync sem encoding em buffers binários, sem redirecionamento textual. 24/24 blobs iguais integralmente ao disco e SHA-256; o mesmo commit contém .gitattributes com src/** -text. Nenhum checkout, cópia de teste, staging ou commit feito.
- [NÃO ENCONTRADO] O item 7 prova os blobs do commit identificado, não o resultado de um checkout futuro: checkout futuro NÃO TESTADO.

### Comparação por arquivo

- [CONFIRMADO NO CÓDIGO] Na tabela, SHA-256 é o valor comum confirmado de MCP, disco, manifesto e blob; igualdade significa comparação integral de bytes MCP/disco e blob/disco, além dos hashes. Caminhos de origem e classes são os das 24 entradas anteriores, relidos nesta etapa.

| Estado | Arquivo | Bytes | SHA-256 comum | Bytes e classe/extensão | Blocos offset:bytes |
|---|---|---:|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `src/server/ServerBootstrap.server.luau` | 4375 | `1baa4e9f146362bd92fbe38c9e77fabb260acdf3a7a99a6acf6d90c84bd60771` | IGUAIS; classe OK | 0:4000, 4000:375 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/ArenaService.luau` | 12216 | `7f6629b1b9529189e8ab9ed0163be43405ea39e5983364863066e81587a2e142` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:4000, 12000:216 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BattleService.luau` | 10446 | `b2384aa78986b30f26443c933e4112d26300b92b90a929c1baf98eb18dd039ca` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:2446 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BotService.luau` | 2779 | `c8542295c0f28d08a1c17d0af1741a844edd8e3d0c01e8f5667b4dc0e1a58c47` | IGUAIS; classe OK | 0:2779 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/CompetitorService.luau` | 2029 | `d58bfb6bf98266dd9c02f087757ecdfcb81cb9adc53df6834eb21de5d829eba8` | IGUAIS; classe OK | 0:2029 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/LobbyService.luau` | 6171 | `73c5b253ef261abd6c51085f4f75601fd81d5a40685db540608465d0c00de272` | IGUAIS; classe OK | 0:4000, 4000:2171 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/RhythmService.luau` | 9122 | `5fc8494c77a5178ce2735c8d901b6bbf39be20e8401eaaff2cae72a2bbf95f86` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:1122 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/TournamentService.luau` | 14884 | `650eb4ca3294ef8bdfcfdf5e30e920bd537fdcd788406fcd24098e5ba7dac23d` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:4000, 12000:2884 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/WaveGenerator.luau` | 2227 | `3670f60acbc001852c7f3c860d87c52ab121fe4e50962764c901eff4e6031093` | IGUAIS; classe OK | 0:2227 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/WorldBindings.luau` | 10877 | `edd7233145490ef190041c7516aef14d0d21357861a3f122ee3e2537ce0857bc` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:2877 |
| [CONFIRMADO NO CÓDIGO] | `src/server/Validation/NoteValidator.luau` | 1978 | `5399120305f12d3ca7673802101635204860c2242c5b8d289734bf3cf8696b3e` | IGUAIS; classe OK | 0:1978 |
| [CONFIRMADO NO CÓDIGO] | `src/shared/GameConfig.luau` | 4449 | `7e55816a5e52454aeb339a12812e963765114d9116f1be593761a03d133fca09` | IGUAIS; classe OK | 0:4000, 4000:449 |
| [CONFIRMADO NO CÓDIGO] | `src/shared/NetworkTypes.luau` | 2430 | `3d1b601b16332855d11807054c05c8da5cbdf8eeb2f988d30782a74c3d4d8ba6` | IGUAIS; classe OK | 0:2430 |
| [CONFIRMADO NO CÓDIGO] | `src/shared/WorldConfig.luau` | 8811 | `242b3caee54351343f174163d588ca8283a132317131b6448bf1d5f36225fd69` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:811 |
| [CONFIRMADO NO CÓDIGO] | `src/shared/BattlePresentationConfig.luau` | 1414 | `f9276d6ed30d91fb79bce7844d1964bfbc7c36cdd421556e81ef8b33e03e1ae3` | IGUAIS; classe OK | 0:1414 |
| [CONFIRMADO NO CÓDIGO] | `src/client/ClientBootstrap.client.luau` | 6188 | `67568128d427f254e4dc30a40d979b550d33bbf4473820e27bc818929941dd21` | IGUAIS; classe OK | 0:4000, 4000:2188 |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/UIController.luau` | 14409 | `19dda8ca889b241c230c971fac8da728758ee8e47178c0af252477be09d0a1e4` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:4000, 12000:2409 |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/InputController.luau` | 6263 | `0933aaa503e55abd7e0938b3d0925f4e78100f952d4d7dcda56b1f50320140e8` | IGUAIS; classe OK | 0:4000, 4000:2263 |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/CompetitorPortrait.luau` | 1605 | `5bce4720c123a800d2ecb52b6dfe271ae49b858877fb83ef9eaae3e70f3f7adc` | IGUAIS; classe OK | 0:1605 |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/TournamentController.luau` | 8500 | `3db4187efd8e172795c7121ebcad077a37329203762df6665de3dcb2d0caf28f` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:500 |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/LobbyController.luau` | 4329 | `cdc30647bcfc85a7ee4f59aeaf50308f716f6218d847f422ff20b68da7c8d1f7` | IGUAIS; classe OK | 0:4000, 4000:329 |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/ArenaController.luau` | 5663 | `4848a77f8cc666fac73f912dcec04c05e7f7267a357455581db0d31ef3694fa5` | IGUAIS; classe OK | 0:4000, 4000:1663 |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/BattleHUD.luau` | 10500 | `11ec855fb26b6f2182cbd7de180b50a6582f5c63c683e5a4b9595072a0290019` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:2500 |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/BattlePresentationView.luau` | 10430 | `743535107a5a906784b9e5a94eb2348e566e2d4feace4644542f9d3db5dd22d6` | IGUAIS; classe OK | 0:4000, 4000:4000, 8000:2430 |

### Finais de linha e os dois -text

- [CONFIRMADO NO CÓDIGO] git ls-files --eol: índice e disco mostram 3 crlf, 14 lf, 5 mixed, 2 -text entre os 24 scripts. attr/-text aplica-se a todos os 24, pela regra existente; i/-text e w/-text são classificação do conteúdo somente de WorldBindings e WorldConfig. src/.gitkeep (none) não entra nas contagens.
- [CONFIRMADO NO CÓDIGO] WorldBindings: 194 CRLF, zero LF isolado, um CR isolado, offset zero-based 10872, em return table.freeze(W) seguido por 0D 0D 0A 0D 0A. WorldConfig: 109 CRLF, zero LF isolado e 107 CR isolados, todos no padrão 0D 0D 0A; primeiros offsets 12, 97, 191 e 229. Nenhum dos dois contém NUL.
- [CONFIRMADO NO CÓDIGO] A rotina convert_is_binary do [código-fonte oficial Git, convert.c](https://github.com/git/git/blob/master/convert.c) classifica conteúdo com CR isolado como binário para conversão; gather_convert_stats_ascii retorna -text antes de classificar LF/CRLF. Isso explica a saída observada.
- [CONFIRMADO NO CÓDIGO] Reconciliação: os 7 mistos anteriores incluem 5 arquivos CRLF+LF (ArenaService, LobbyService, NetworkTypes, ArenaController, BattleHUD) e 2 CRLF+CR isolado (WorldBindings, WorldConfig). Portanto 3 CRLF + 14 LF + 7 mistos descreve os bytes; 3 crlf + 14 lf + 5 mixed + 2 -text descreve a heurística Git. Nenhuma alteração/normalização necessária ou realizada.

### Requires — revisão estática

- [CONFIRMADO NO CÓDIGO] 50 chamadas: 48 destinos internos existentes e ModuleScript no inventário relido; duas dependências externas de controles Roblox. Linhas contadas por LF (CR preservado). Root resolve ReplicatedStorage.CumbiaParty; script.Parent é resolvido a partir da origem de cada script. Chamadas não executadas.

| Estado | Arquivo:linha | Argumento de require | Destino / resultado |
|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `src/server/ServerBootstrap.server.luau:5` | `Root.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/ServerBootstrap.server.luau:6` | `script.Parent.Services.RhythmService` | `ServerScriptService.CumbiaParty.Services.RhythmService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/ServerBootstrap.server.luau:7` | `script.Parent.Services.BattleService` | `ServerScriptService.CumbiaParty.Services.BattleService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/ServerBootstrap.server.luau:8` | `script.Parent.Services.CompetitorService` | `ServerScriptService.CumbiaParty.Services.CompetitorService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/ServerBootstrap.server.luau:9` | `script.Parent.Services.TournamentService` | `ServerScriptService.CumbiaParty.Services.TournamentService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/ServerBootstrap.server.luau:10` | `script.Parent.Services.LobbyService` | `ServerScriptService.CumbiaParty.Services.LobbyService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/ServerBootstrap.server.luau:12` | `script.Parent.Services.ArenaService` | `ServerScriptService.CumbiaParty.Services.ArenaService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/ArenaService.luau:6` | `script.Parent.CompetitorService` | `ServerScriptService.CumbiaParty.Services.CompetitorService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/ArenaService.luau:7` | `script.Parent.WorldBindings` | `ServerScriptService.CumbiaParty.Services.WorldBindings` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/ArenaService.luau:8` | `Root.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/ArenaService.luau:9` | `Root.Shared.BattlePresentationConfig` | `ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BattleService.luau:5` | `Root.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BattleService.luau:6` | `script.Parent.WaveGenerator` | `ServerScriptService.CumbiaParty.Services.WaveGenerator` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BattleService.luau:7` | `script.Parent.RhythmService` | `ServerScriptService.CumbiaParty.Services.RhythmService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BattleService.luau:8` | `script.Parent.CompetitorService` | `ServerScriptService.CumbiaParty.Services.CompetitorService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BotService.luau:3` | `game.ReplicatedStorage.CumbiaParty.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BotService.luau:4` | `script.Parent.CompetitorService` | `ServerScriptService.CumbiaParty.Services.CompetitorService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/BotService.luau:8` | `script.Parent.RhythmService` | `ServerScriptService.CumbiaParty.Services.RhythmService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/LobbyService.luau:7` | `Root.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/LobbyService.luau:8` | `script.Parent.WorldBindings` | `ServerScriptService.CumbiaParty.Services.WorldBindings` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/LobbyService.luau:9` | `script.Parent.BattleService` | `ServerScriptService.CumbiaParty.Services.BattleService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/LobbyService.luau:10` | `script.Parent.RhythmService` | `ServerScriptService.CumbiaParty.Services.RhythmService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/LobbyService.luau:11` | `script.Parent.TournamentService` | `ServerScriptService.CumbiaParty.Services.TournamentService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/RhythmService.luau:6` | `Root.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/RhythmService.luau:7` | `script.Parent.CompetitorService` | `ServerScriptService.CumbiaParty.Services.CompetitorService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/RhythmService.luau:8` | `script.Parent.Parent.Validation.NoteValidator` | `ServerScriptService.CumbiaParty.Validation.NoteValidator` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/TournamentService.luau:6` | `Root.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/TournamentService.luau:7` | `script.Parent.CompetitorService` | `ServerScriptService.CumbiaParty.Services.CompetitorService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/TournamentService.luau:8` | `script.Parent.RhythmService` | `ServerScriptService.CumbiaParty.Services.RhythmService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/TournamentService.luau:9` | `script.Parent.BattleService` | `ServerScriptService.CumbiaParty.Services.BattleService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/TournamentService.luau:10` | `script.Parent.BotService` | `ServerScriptService.CumbiaParty.Services.BotService` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/WaveGenerator.luau:4` | `game.ReplicatedStorage.CumbiaParty.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Services/WorldBindings.luau:3` | `game.ReplicatedStorage.CumbiaParty.Shared.WorldConfig` | `ReplicatedStorage.CumbiaParty.Shared.WorldConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/server/Validation/NoteValidator.luau:2` | `game:GetService("ReplicatedStorage").CumbiaParty.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/shared/GameConfig.luau:97` | `script.Parent.WorldConfig` | `ReplicatedStorage.CumbiaParty.Shared.WorldConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/ClientBootstrap.client.luau:5` | `Root.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/ClientBootstrap.client.luau:6` | `script.Parent.Controllers.UIController` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/ClientBootstrap.client.luau:7` | `script.Parent.Controllers.InputController` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/ClientBootstrap.client.luau:8` | `script.Parent.Controllers.TournamentController` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.TournamentController` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/ClientBootstrap.client.luau:9` | `script.Parent.Controllers.LobbyController` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.LobbyController` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/ClientBootstrap.client.luau:59` | `script.Parent.Controllers.ArenaController` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/UIController.luau:5` | `game.ReplicatedStorage.CumbiaParty.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/UIController.luau:6` | `script.Parent.CompetitorPortrait` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/UIController.luau:7` | `script.Parent.BattleHUD` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/InputController.luau:8` | `game.ReplicatedStorage.CumbiaParty.Shared.GameConfig` | `ReplicatedStorage.CumbiaParty.Shared.GameConfig` — existe nos 24. |
| [NÃO ENCONTRADO] | `src/client/Controllers/InputController.luau:25` | `modern.ControlModule` | StarterPlayer.PlayerModule.ControlModule — externo; não encontrado em Edit; ramo condicionado à existência. |
| [NÃO ENCONTRADO] | `src/client/Controllers/InputController.luau:27` | `legacy` | LocalPlayer.PlayerScripts.PlayerModule — externo; runtime NÃO TESTADO. |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/TournamentController.luau:4` | `script.Parent.CompetitorPortrait` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/ArenaController.luau:6` | `Root.Shared.BattlePresentationConfig` | `ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig` — existe nos 24. |
| [CONFIRMADO NO CÓDIGO] | `src/client/Controllers/ArenaController.luau:7` | `script.Parent.BattlePresentationView` | `StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattlePresentationView` — existe nos 24. |

### WaitForChild / FindFirstChild e variantes

- [CONFIRMADO NO CÓDIGO] 30 chamadas abaixo, incluindo FindFirstChildOfClass. A existência de modelos em StarterGui/StarterPlayer não prova cópias em PlayerGui/PlayerScripts ou comportamento em execução.

| Arquivo:linha | Chamada | Destino / evidência |
|---|---|---|
| `src/server/ServerBootstrap.server.luau:4` | `WaitForChild("CumbiaParty")` | [CONFIRMADO NO CÓDIGO] ReplicatedStorage.CumbiaParty existe, contêiner externo aos 24. |
| `src/server/Services/ArenaService.luau:46` | `FindFirstChild("ArenaRuntime")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: ausente em Edit; o código exige ausência e prevê criação em ArenaService:47, sem executar. |
| `src/server/Services/ArenaService.luau:116` | `FindFirstChild("HumanoidRootPart")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/ArenaService.luau:116` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/CompetitorService.luau:17` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/LobbyService.luau:48` | `FindFirstChild("HumanoidRootPart")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/LobbyService.luau:49` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/LobbyService.luau:72` | `FindFirstChild("HumanoidRootPart")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/LobbyService.luau:75` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/LobbyService.luau:94` | `FindFirstChild("HumanoidRootPart")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/RhythmService.luau:79` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/server/Services/WorldBindings.luau:128` | `FindFirstChildOfClass("Terrain")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: Workspace.Terrain existe (Terrain). |
| `src/client/ClientBootstrap.client.luau:4` | `WaitForChild("CumbiaParty")` | [CONFIRMADO NO CÓDIGO] ReplicatedStorage.CumbiaParty existe, contêiner externo aos 24. |
| `src/client/ClientBootstrap.client.luau:12` | `WaitForChild("PlayerGui")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/client/ClientBootstrap.client.luau:12` | `WaitForChild("CumbiaPartyGui")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: modelo StarterGui.CumbiaPartyGui existe; cópia PlayerGui NÃO TESTADA. |
| `src/client/Controllers/UIController.luau:168` | `FindFirstChild("Avatar")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: gui.Main.CombatHUD.HP1/HP2 existem; Avatar é criado se ausente em UIController:170; runtime NÃO TESTADO. |
| `src/client/Controllers/UIController.luau:210` | `FindFirstChild("Tail")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: noteViews[note.id].Tail é criado condicionalmente para hold em UIController:140; runtime NÃO TESTADO. |
| `src/client/Controllers/InputController.luau:19` | `WaitForChild("PlayerScripts")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/client/Controllers/InputController.luau:22` | `FindFirstChild("PlayerModule")` | [NÃO ENCONTRADO] Fora dos 24: StarterPlayer.PlayerModule/ControlModule ausentes em Edit; alternativa LocalPlayer.PlayerScripts.PlayerModule depende de runtime, NÃO TESTADA. |
| `src/client/Controllers/InputController.luau:23` | `FindFirstChild("PlayerModule")` | [NÃO ENCONTRADO] Fora dos 24: StarterPlayer.PlayerModule/ControlModule ausentes em Edit; alternativa LocalPlayer.PlayerScripts.PlayerModule depende de runtime, NÃO TESTADA. |
| `src/client/Controllers/InputController.luau:24` | `FindFirstChild("ControlModule")` | [NÃO ENCONTRADO] Fora dos 24: StarterPlayer.PlayerModule/ControlModule ausentes em Edit; alternativa LocalPlayer.PlayerScripts.PlayerModule depende de runtime, NÃO TESTADA. |
| `src/client/Controllers/InputController.luau:120` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/client/Controllers/InputController.luau:124` | `FindFirstChild("Main")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: StarterGui.CumbiaPartyGui.Main e Main.SizeLimit (UISizeConstraint) existem; cópia runtime NÃO TESTADA. |
| `src/client/Controllers/InputController.luau:125` | `FindFirstChild("ClientBootstrap")` | [CONFIRMADO NO CÓDIGO] Dentro dos 24: StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap existe (LocalScript); cópia runtime NÃO TESTADA. |
| `src/client/Controllers/InputController.luau:135` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/client/Controllers/CompetitorPortrait.luau:10` | `FindFirstChild("Portrait")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: parent.Portrait depende do argumento; criação textual em CompetitorPortrait:13; runtime NÃO TESTADO. |
| `src/client/Controllers/LobbyController.luau:37` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/client/Controllers/ArenaController.luau:28` | `FindFirstChildOfClass("Humanoid")` | [NÃO ENCONTRADO] Fora dos 24: objeto de jogador/personagem em runtime; nenhum jogador na sessão Edit; NÃO TESTADO em execução. |
| `src/client/Controllers/BattleHUD.luau:36` | `FindFirstChild("SizeLimit")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: StarterGui.CumbiaPartyGui.Main e Main.SizeLimit (UISizeConstraint) existem; cópia runtime NÃO TESTADA. |
| `src/client/Controllers/BattleHUD.luau:36` | `FindFirstChildOfClass("UISizeConstraint")` | [CONFIRMADO NO CÓDIGO] Fora dos 24: StarterGui.CumbiaPartyGui.Main e Main.SizeLimit (UISizeConstraint) existem; cópia runtime NÃO TESTADA. |

### Outras referências externas e divergência que interrompeu a conferência

- [CONFIRMADO NO CÓDIGO] Remotes fora dos 24, todos presentes como RemoteEvent em ReplicatedStorage.CumbiaParty.Remotes: ClientReady, SubmitNote, BattleState, NoteResult, RhythmControl, TournamentRequest, TournamentState, LobbyRequest, LobbyState. Referenciados pelos bootstraps, serviços e controllers; BattleService/RhythmService também usam Root.Remotes[event], cujo valor é dinâmico. Dispatch em execução NÃO TESTADO.
- [CONFIRMADO NO CÓDIGO] GUI fora dos 24: StarterGui.CumbiaPartyGui (ScreenGui), Main, StatusLabel, Main.Board (Lane1–Lane4, Key e HitButton), Main.CombatHUD.HP1/HP2 (Fill e Label), Results (Title/Summary), StartButton, CancelButton, DuelButton, TargetButton, Feedback, Score, Timing, Combo, Counts, Footer e Title presentes. Frames de apresentação, torneio, retratos, notas/holds e lobby têm criação no texto dos controllers; não foram criados/executados nesta etapa.
- [CONFIRMADO NO CÓDIGO] WorldConfig define ActiveProfileId="Underground". Os 19 RequiredPaths existem com classe Model sob Workspace.CumbiaBattleWorld: FloorSupport=FloorSupport; Hub=Hub; NorthTournament=NorthTournament; SouthSurvival=SouthSurvival; EastChairs=EastChairs; WestScoreAttack=WestScoreAttack; Gallery=NorthTournament.ObservationGallery; NorthStairs=Hub.North; SouthStairs=Hub.South; EastStairs=Hub.East; WestStairs=Hub.West; Ring1=NorthTournament.Ring1; Ring2=NorthTournament.Ring2; Ring3=NorthTournament.Ring3; Ring4=NorthTournament.Ring4; Final=NorthTournament.Final; FinalCage=NorthTournament.Final.OctagonCage; SurvivalArena=SouthSurvival.Survival; ChairsArena=EastChairs.Chairs.
- [CONFIRMADO NO CÓDIGO] Referências externas adicionais observadas: Bindings.UndergroundSpawn (SpawnLocation); 13 marcadores de retorno em Bindings.Returns; Interactions.NorthTournament.Terminal.OpenTournament (ProximityPrompt); arenas NorthTournament.Ring1–Ring4/Final com KeyboardA/B (Model), PhysicalBindings (Folder), StationA/B, CameraA/B e ExitA/B (Part). WorldBindings.resolvePath usa GetChildren e nomes de WorldConfig; nenhum método do módulo foi executado.
- [NÃO ENCONTRADO] Divergência de referência no perfil INATIVO Tropical: Workspace.CumbiaPartyLobby não encontrado; consequentemente ausentes CumbiaPartyLobby.Markers.{LobbyReturn,RecoveryNorthwest,RecoveryNorth,RecoveryNortheast,RecoverySoutheast,RecoverySouth,RecoverySouthwest,RecoveryWest} e CumbiaPartyLobby.CumbiaTiles.TournamentTerminal.OpenTournament. Esses destinos constam textualmente de WorldConfig, fora dos 24 scripts. Workspace.SpawnLocation existe (SpawnLocation) e Workspace.Terrain existe. Investigação interrompida ao detectar essas ausências, conforme ticket; nenhum reparo.
- [SUPOSIÇÃO] Veredito histórico da conferência: fidelidade binária e prova dos blobs satisfeitas 24/24; naquele momento, aceite integral não declarado devido às referências Tropical ausentes. Decisão posterior: CP2-000e-3 ACEITA PELO DONO em 24/10/2026, com ressalva ("decisão do dono: aceito"), conforme CP2-000e-3c abaixo; não autoriza avançar às etapas -4 a -8.
- [NÃO ENCONTRADO] NÃO TESTADO: checkout futuro; resolução em runtime de PlayerModule/ControlModule, PlayerGui/PlayerScripts e personagens; execução/compilação dos 24 scripts, require, gameplay, Play, UnitTest, sincronização/preservação Rojo, propriedades físicas/suporte por raycast, equivalência Studio/arquivo .rbxl salvo. Investigação adicional interrompida na divergência.
- [CONFIRMADO NO CÓDIGO] Nenhuma escrita em src/, .gitattributes, configurações Git, project.json, rokit.toml, Studio ou .rbxl; nenhum comando Rojo/Rokit, require, execução de módulos, Play ou commit. Somente os três registros documentais autorizados foram preparados para escrita.

## CP2-000e-3a — Seleção do perfil Tropical (24/10/2026)

- [SUPOSIÇÃO] Execução somente de leitura e plano de registro APROVADOS pelo dono. Escrita limitada a este manifesto, MIGRATION_PLAN.md e BACKLOG.md. Sem aceitar ou rejeitar -3; decisão do dono. CP2-000e-4 a -8 PENDENTES.
- [CONFIRMADO NO CÓDIGO] Evidências desta sessão: leitura textual e buscas nos 24 Sources .luau em src/, sem executar código. Linhas seguem rg -n por LF, preservando finais originais, inclusive CR CR LF.
- [CONFIRMADO NO CÓDIGO] src/shared/WorldConfig.luau:4 define local ActiveProfileId="Underground". Existem Tropical (54–58) e Underground (59–85), ambos Ready=true; Ready não seleciona o perfil. GetProfile(id), em 96–100, consulta profiles[id] sem alterar o ativo. GetActiveProfile(), em 101–105, usa o seletor local e exige Ready=true. Os perfis são congelados em 88–94 e a interface exportada em 106.
- [CONFIRMADO NO CÓDIGO] src/shared/GameConfig.luau:97 apenas expõe o Lobby do perfil ativo. GameConfig:85–90 define dificuldades de bots (Beginner, Intermediate, Advanced, Expert), consumidas em src/server/Services/BotService.luau:15; não são perfis espaciais.

### Referências e chamadores

| Classificação | Arquivo e linhas | Papel |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | src/shared/WorldConfig.luau:5–21,54–58 | Define tropicalLobby, regiões, oito marcadores e caminhos Tropical; não o seleciona. |
| [CONFIRMADO NO CÓDIGO] | src/shared/WorldConfig.luau:23 | Comentário sobre Terrain tropical preservado. |
| [CONFIRMADO NO CÓDIGO] | src/shared/WorldConfig.luau:4,95–106 | Seletor Underground e consultas/exportação dos perfis. |
| [CONFIRMADO NO CÓDIGO] | src/shared/GameConfig.luau:96–97 | Alias do Lobby ativo. |
| [CONFIRMADO NO CÓDIGO] | src/server/Services/WorldBindings.luau:3,37,162 | Importa WorldConfig; comentários sobre Tropical não o ativam. |
| [CONFIRMADO NO CÓDIGO] | src/server/Services/WorldBindings.luau:47–104,106–149 | Valida e resolve o perfil recebido; quando omitido, usa o ativo (107). |
| [CONFIRMADO NO CÓDIGO] | src/server/Services/WorldBindings.luau:163–166 | ResolveArenaComplex aceita perfil opcional, usa o ativo quando omitido e encaminha o perfil a Resolve quando há ArenaComplex; não muda o seletor. |
| [CONFIRMADO NO CÓDIGO] | src/server/Services/LobbyService.luau:7–8,17,89 | Consome configuração, informa ProfileId dos bindings ou nil e chama Resolve() sem perfil explícito. |
| [CONFIRMADO NO CÓDIGO] | src/server/Services/ArenaService.luau:7,30,43–44 | Permite bindings injetados; no caminho padrão chama ResolveArenaComplex() sem perfil explícito. |
| [CONFIRMADO NO CÓDIGO] | src/server/ServerBootstrap.server.luau:10–16 | Inicializa lobby e arena sem selecionar Tropical. |
| [CONFIRMADO NO CÓDIGO] | src/shared/NetworkTypes.luau:26; src/client/Controllers/TournamentController.luau:41; src/client/Controllers/LobbyController.luau:34 | OpenTournament é ação/interface de torneio, não ativação Tropical. WorldConfig:84 também a define para Underground; WorldBindings:94 valida a ação; LobbyService:91–97 conecta o terminal resolvido. |

- [NÃO ENCONTRADO] Nas buscas dos 24 Sources, nenhuma chamada GetProfile("Tropical"), passagem explícita de Tropical aos resolvedores ou troca runtime de ActiveProfileId. Aceitar um perfil como argumento não prova a existência de chamador ativando Tropical.

### Resolução e ausências

- [CONFIRMADO NO CÓDIGO] Caminho normal: src/server/ServerBootstrap.server.luau:11 → src/server/Services/LobbyService.luau:89 → src/server/Services/WorldBindings.luau:106–109. Resolve usa o ativo em 107. Na configuração lida, resolve CumbiaBattleWorld (WorldConfig:60), não CumbiaPartyLobby.
- [CONFIRMADO NO CÓDIGO] Se Tropical fosse selecionado ou passado explicitamente a Resolve, a raiz seria Workspace.CumbiaPartyLobby (WorldConfig:55; WorldBindings:109), e o spawn Workspace.SpawnLocation (WorldBindings:111). Os oito marcadores seriam Workspace.CumbiaPartyLobby.Markers.{LobbyReturn,RecoveryNorthwest,RecoveryNorth,RecoveryNortheast,RecoverySoutheast,RecoverySouth,RecoverySouthwest,RecoveryWest} (WorldConfig:16,21; WorldBindings:115–119).
- [CONFIRMADO NO CÓDIGO] O terminal Tropical seria Workspace.CumbiaPartyLobby.CumbiaTiles.TournamentTerminal.OpenTournament (WorldConfig:57; WorldBindings:133–137), exigindo ProximityPrompt com pai BasePart.
- [CONFIRMADO NO CÓDIGO] WorldBindings:11–22 percorre GetChildren por nome; check usa assert em 6 e acusa segmento ausente em 19. Não há fallback ou retorno nil nos caminhos obrigatórios. Satisfeita a validação de dados anterior, raiz ausente interrompe a resolução antes de spawn, marcadores e terminal; marcador/terminal ausente também gera erro quando alcançado. Lobby.Init não captura esse erro, nem sua chamada no bootstrap é protegida por pcall.
- [CONFIRMADO NO CÓDIGO] Retornos opcionais distintos: WorldBindings.GetMarker:151–155 retorna nil sem bindings ou quando marcador/raiz sai da árvore esperada; LobbyService:53–57 recusa reposicionamento com false se marcador/suporte faltar. ResolveArenaComplex:165 retorna nil sem ArenaComplex, como em Tropical; ArenaService:44 retorna false. Isso não contorna a resolução obrigatória do lobby.
- [SUPOSIÇÃO] Ausências Tropical e presenças Underground observadas em Edit na etapa -3 são evidências históricas, não reconferidas no Studio nesta sessão.

### Hipótese contestada e pendência

- [SUPOSIÇÃO] O dono solicita registrar que a hipótese "referências do perfil inativo, inofensivas" NÃO se sustenta e aponta contradição com seu relato de que a descartável inicia e funciona. A inocuidade em execução não está demonstrada e não será fundamento de aceite; a contradição apontada fica como pendência a esclarecer, não como falha reproduzida.
- [CONFIRMADO NO CÓDIGO] Ressalva à justificativa proposta: os asserts se aplicam aos caminhos do perfil selecionado. O seletor lido é Underground; não se confirmou a premissa de que o caminho normal resolve CumbiaPartyLobby e seus marcadores nessa configuração. As referências Tropical são obrigatórias quando Tropical é resolvido, não incondicionalmente. O código lido, por si só, não demonstra contradição com o relato de funcionamento em Underground.
- [SUPOSIÇÃO] Pendência: reconciliar, em escopo futuro autorizado, Sources/perfil efetivamente usados na descartável, relato do dono e ausências observadas na cópia de trabalho. Não presumir identidade atual disco/Studio/.rbxl nem tratar o relato como teste do agente. Sem aceite ou rejeição de -3; -4 a -8 PENDENTES.
- [NÃO ENCONTRADO] NÃO TESTADO: execução/compilação, require, Play, inicialização real, gameplay, UnitTest, resolução física/raycast, estado atual do Studio, equivalência disco/Studio/.rbxl e Rojo/sincronização/preservação. Nenhuma consulta ao Studio nesta investigação; nenhum commit.

## CP2-000e-3b — Objetos dos perfis em Edit (24/10/2026)

- [SUPOSIÇÃO] Execução somente de leitura e plano aprovados pelo dono neste ticket; registro limitado a MIGRATION_MANIFEST.md, MIGRATION_PLAN.md e BACKLOG.md. Aceite de -3 reservado ao dono; -4 a -8 continuam PENDENTES.
- [CONFIRMADO NO CÓDIGO] Fontes lidas nesta sessão: src/shared/WorldConfig.luau (WC) e src/server/Services/WorldBindings.luau (WB); referências abaixo usam linhas de rg -n. WC:4 seleciona Underground. As observações de instâncias abaixo foram obtidas nesta sessão via MCP e são identificadas como evidência de Studio, sem presumir identidade entre Source do Studio e disco.
- [CONFIRMADO NO CÓDIGO] Evidência de Studio: list_roblox_studios retornou uma única sessão, CumbiaParty_V2_Trabalho.rbxl, id a84afcec-168b-4427-996c-68a6099df5fb. get_studio_state retornou Current Studio Mode: Edit, Available DataModels: Edit, Focused DataModel: Edit.
- [CONFIRMADO NO CÓDIGO] Método: consultas execute_luau em Edit limitadas a enumerar GetChildren e ler Name/ClassName, comparando nomes exatos por segmento desde game. Nenhum require, módulo ou resolvedor foi executado. Todas as ramificações homônimas foram enumeradas, sem selecionar arbitrariamente a primeira. Os segmentos intermediários também estão na tabela e têm uma ocorrência.
- [CONFIRMADO NO CÓDIGO] Contagens: WC:44 contém 13 retornos; WC:63–81 contém 19 RequiredPaths; WC:82 contém cinco arenas. No Studio foram encontrados 13/13 retornos (Returns tem exatamente 13 filhos diretos), 19/19 RequiredPaths e 5/5 arenas configuradas, únicos e com classe compatível. Diferença em relação à previsão: zero em cada categoria. As cinco arenas já pertencem aos 19 RequiredPaths, portanto não são somadas duas vezes.
- [CONFIRMADO NO CÓDIGO] Total conferido: 85 caminhos Underground distintos = raiz (1) + spawn (1) + retornos (13) + RequiredPaths (19) + prompt (1) + componentes de arenas (45: cinco PhysicalBindings, 30 pontos e dez teclados) + outros segmentos intermediários (5). As contagens são do contrato configurado; não são um inventário de todos os objetos do mapa.
- [CONFIRMADO NO CÓDIGO] Esta conferência prova presença, classe e unicidade dos caminhos na sessão Edit observada. Não prova posição, suporte físico nem funcionamento.

### Underground — objetos obrigatórios por assert

- [CONFIRMADO NO CÓDIGO] WB:6 define check com assert; WB:11–22 exige existência e unicidade de cada segmento. Resolve (106–149) exige raiz, spawn, todos os retornos, RequiredPaths e terminal; o pai do prompt precisa ser BasePart (136). ResolveArenaComplex (163–191), quando ArenaComplex existe como em Underground, exige as cinco arenas, PhysicalBindings, StationA/B, CameraA/B, ExitA/B e KeyboardA/B. PhysicalBindings e intermediários sem teste de classe não são obrigatoriamente Folder/Model.
- [CONFIRMADO NO CÓDIGO] Na tabela, “1” é uma única ocorrência no caminho exato; “compatível” se limita à classe e à unicidade. Part é compatível com BasePart. Não significa que os demais asserts físicos foram satisfeitos.

| Classificação | Caminho | Esperado | Encontrado | Classe | Resultado | Arquivo/linha |
|---|---|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld` | Model ou Folder | 1 | Model | Presente, único, compatível | WC:60; WB:109–110 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.UndergroundSpawn` | SpawnLocation | 1 | SpawnLocation | Presente, único, compatível | WC:61; WB:111–112 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.HubReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.NorthReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.SouthReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.EastReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.WestReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.GalleryReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.Ring1Return` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.Ring2Return` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.Ring3Return` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.Ring4Return` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.FinalReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.SurvivalReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns.ChairsReturn` | BasePart | 1 | Part | Presente, único, compatível | WC:44–46,49,83; WB:115–117 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.FloorSupport` | Model | 1 | Model | Presente, único, compatível | WC:63; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub` | Model | 1 | Model | Presente, único, compatível | WC:64; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament` | Model | 1 | Model | Presente, único, compatível | WC:65; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.SouthSurvival` | Model | 1 | Model | Presente, único, compatível | WC:66; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.EastChairs` | Model | 1 | Model | Presente, único, compatível | WC:67; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.WestScoreAttack` | Model | 1 | Model | Presente, único, compatível | WC:68; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.ObservationGallery` | Model | 1 | Model | Presente, único, compatível | WC:69; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.North` | Model | 1 | Model | Presente, único, compatível | WC:70; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.South` | Model | 1 | Model | Presente, único, compatível | WC:71; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.East` | Model | 1 | Model | Presente, único, compatível | WC:72; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Hub.West` | Model | 1 | Model | Presente, único, compatível | WC:73; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1` | Model | 1 | Model | Presente, único, compatível | WC:74; WB:122–124; WC:82; WB:169–171,190 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2` | Model | 1 | Model | Presente, único, compatível | WC:75; WB:122–124; WC:82; WB:169–171,190 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3` | Model | 1 | Model | Presente, único, compatível | WC:76; WB:122–124; WC:82; WB:169–171,190 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4` | Model | 1 | Model | Presente, único, compatível | WC:77; WB:122–124; WC:82; WB:169–171,190 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final` | Model | 1 | Model | Presente, único, compatível | WC:78; WB:122–124; WC:82; WB:169–171,190 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.OctagonCage` | Model | 1 | Model | Presente, único, compatível | WC:79; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.SouthSurvival.Survival` | Model | 1 | Model | Presente, único, compatível | WC:80; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.EastChairs.Chairs` | Model | 1 | Model | Presente, único, compatível | WC:81; WB:122–124 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions.NorthTournament.Terminal.OpenTournament` | ProximityPrompt | 1 | ProximityPrompt | Presente, único, compatível | WC:84; WB:133–136 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.PhysicalBindings` | Instância (classe não restringida) | 1 | Folder | Presente, único, compatível | WC:82; WB:172 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.PhysicalBindings.StationA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.PhysicalBindings.CameraA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.PhysicalBindings.ExitA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.KeyboardA` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.PhysicalBindings.StationB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.PhysicalBindings.CameraB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.PhysicalBindings.ExitB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring1.KeyboardB` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.PhysicalBindings` | Instância (classe não restringida) | 1 | Folder | Presente, único, compatível | WC:82; WB:172 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.PhysicalBindings.StationA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.PhysicalBindings.CameraA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.PhysicalBindings.ExitA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.KeyboardA` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.PhysicalBindings.StationB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.PhysicalBindings.CameraB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.PhysicalBindings.ExitB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring2.KeyboardB` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.PhysicalBindings` | Instância (classe não restringida) | 1 | Folder | Presente, único, compatível | WC:82; WB:172 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.PhysicalBindings.StationA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.PhysicalBindings.CameraA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.PhysicalBindings.ExitA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.KeyboardA` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.PhysicalBindings.StationB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.PhysicalBindings.CameraB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.PhysicalBindings.ExitB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring3.KeyboardB` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.PhysicalBindings` | Instância (classe não restringida) | 1 | Folder | Presente, único, compatível | WC:82; WB:172 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.PhysicalBindings.StationA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.PhysicalBindings.CameraA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.PhysicalBindings.ExitA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.KeyboardA` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.PhysicalBindings.StationB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.PhysicalBindings.CameraB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.PhysicalBindings.ExitB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Ring4.KeyboardB` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.PhysicalBindings` | Instância (classe não restringida) | 1 | Folder | Presente, único, compatível | WC:82; WB:172 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.PhysicalBindings.StationA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.PhysicalBindings.CameraA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.PhysicalBindings.ExitA` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.KeyboardA` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.PhysicalBindings.StationB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.PhysicalBindings.CameraB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.PhysicalBindings.ExitB` | BasePart | 1 | Part | Presente, único, compatível | WC:82; WB:174–177 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.NorthTournament.Final.KeyboardB` | Model | 1 | Model | Presente, único, compatível | WC:82; WB:184–185 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings` | Instância (classe não restringida) | 1 | Model | Presente, único, compatível | WC:61,46; WB:11–22 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Bindings.Returns` | Instância (classe não restringida) | 1 | Model | Presente, único, compatível | WC:46; WB:11–22 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions` | Instância (classe não restringida) | 1 | Model | Presente, único, compatível | WC:84; WB:11–22 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions.NorthTournament` | Instância (classe não restringida) | 1 | Model | Presente, único, compatível | WC:84; WB:11–22 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.CumbiaBattleWorld.Interactions.NorthTournament.Terminal` | BasePart | 1 | Part | Presente, único, compatível | WC:84; WB:136; WB:11–22 |

### Opcionais, nil e fallback — separados dos obrigatórios

- [CONFIRMADO NO CÓDIGO] WB:107,164 permite argumentos omitidos: perfil ativo e workspace são os defaults, sem fallback para outro objeto ausente. WB:122 usa RequiredPaths or {}; Underground fornece as 19 entradas. WB:127–130 só exige Terrain quando UseTerrainSupport é true; WC:62 o desativa para Underground.
- [CONFIRMADO NO CÓDIGO] WB:165 retorna nil se não houver ArenaComplex; Tropical não o define (WC:54–58), Underground o define (WC:82), logo as arenas Underground não são opcionais nessa configuração. Nenhum caminho nominal opcional adicional foi encontrado em Resolve/ResolveArenaComplex.
- [CONFIRMADO NO CÓDIGO] GetMarker (WB:151–155) e GetSupport (156–160) podem retornar nil fora de suas condições; raycast também pode não encontrar suporte. Isso não transforma caminhos obrigatórios em opcionais: Resolve exige suporte de retornos/spawn em WB:141–147, e ResolveArenaComplex exige suporte de estações/saídas em WB:178–180.
- [NÃO ENCONTRADO] NÃO TESTADO: asserts de posição/regiões (WB:113,118,179), Anchored/CanCollide (177), raycast/normal/altura do suporte (141–147,180) e distância entre estações (187). Nenhuma dessas propriedades foi consultada ou validada.

### Tropical — reconferência dos caminhos do perfil inativo

- [CONFIRMADO NO CÓDIGO] WC:16,21,55–57 define os caminhos abaixo; WB:127–130 busca Terrain por classe, não pelo nome. A consulta também contou as instâncias de classe Terrain diretamente em Workspace: uma.
- [NÃO ENCONTRADO] Evidência de Studio desta sessão: CumbiaPartyLobby e todos os destinos abaixo dessa raiz estão ausentes nos caminhos configurados. Para os descendentes, zero significa ausência no caminho completo pela raiz ausente; não afirma inexistência de nomes iguais em outros locais do jogo.
- [CONFIRMADO NO CÓDIGO] Workspace.SpawnLocation e Workspace.Terrain existem e são únicos. Portanto, não é correto afirmar que todos os objetos referenciados por Tropical estão ausentes. A tabela atual reconfirma e delimita o relato histórico.
- [CONFIRMADO NO CÓDIGO] Esses caminhos são exigidos por Resolve se Tropical for fornecido/selecionado; a ausência da raiz impediria avançar na resolução. Não são exigências do perfil Underground ativo lido no disco.

| Classificação | Caminho | Esperado se Tropical for usado | Encontrado | Classe | Resultado | Arquivo/linha |
|---|---|---|---|---|---|---|
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby` | Model ou Folder | 0 | — | Ausente no caminho configurado | WC:55; WB:109–110 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.SpawnLocation` | SpawnLocation | 1 | SpawnLocation | Presente, único, compatível | WC:55; WB:111–112 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers` | Instância (classe não restringida) | 0 | — | Ausente no caminho configurado | WC:21; WB:11–22 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers.LobbyReturn` | BasePart | 0 | — | Ausente no caminho configurado | WC:16,21; WB:115–117 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers.RecoveryNorthwest` | BasePart | 0 | — | Ausente no caminho configurado | WC:16,21; WB:115–117 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers.RecoveryNorth` | BasePart | 0 | — | Ausente no caminho configurado | WC:16,21; WB:115–117 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers.RecoveryNortheast` | BasePart | 0 | — | Ausente no caminho configurado | WC:16,21; WB:115–117 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers.RecoverySoutheast` | BasePart | 0 | — | Ausente no caminho configurado | WC:16,21; WB:115–117 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers.RecoverySouth` | BasePart | 0 | — | Ausente no caminho configurado | WC:16,21; WB:115–117 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers.RecoverySouthwest` | BasePart | 0 | — | Ausente no caminho configurado | WC:16,21; WB:115–117 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.Markers.RecoveryWest` | BasePart | 0 | — | Ausente no caminho configurado | WC:16,21; WB:115–117 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.CumbiaTiles` | Instância (classe não restringida) | 0 | — | Ausente no caminho configurado | WC:57; WB:11–22 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.CumbiaTiles.TournamentTerminal` | BasePart | 0 | — | Ausente no caminho configurado | WC:57; WB:136 |
| [NÃO ENCONTRADO] | `Workspace.CumbiaPartyLobby.CumbiaTiles.TournamentTerminal.OpenTournament` | ProximityPrompt | 0 | — | Ausente no caminho configurado | WC:57; WB:134–135 |
| [CONFIRMADO NO CÓDIGO] | `Workspace.Terrain` | Terrain (busca por classe) | 1 | Terrain | Presente, único, compatível | WC:56; WB:127–130 |

### Limites e pendências

- [CONFIRMADO NO CÓDIGO] Nenhum obrigatório Underground ausente, duplicado ou com classe incompatível foi observado nos 85 caminhos conferidos. Isso é evidência estrutural limitada, não aceite da etapa -3.
- [SUPOSIÇÃO] Funcionamento relatado pelo dono permanece relato do dono, NÃO TESTADO por agente; não se conclui que o jogo funciona. Decisão de aceite de -3 é do dono; CP2-000e-4 a -8 PENDENTES.
- [NÃO ENCONTRADO] NÃO TESTADO: posição, suporte físico, propriedades físicas, funcionamento, Play, require, execução/compilação de módulos, UnitTest, gameplay, equivalência atual disco/Source do Studio/.rbxl salvo, fidelidade binária e sincronização/preservação Rojo nesta etapa.
- [CONFIRMADO NO CÓDIGO] Escrita restrita aos três registros autorizados; alterações preexistentes preservadas. Nenhum commit, comando Rojo, escrita no Studio/.rbxl, alteração em src/, .gitattributes ou configuração Git. CURRENT_STATE.md não atualizado por estar fora do escopo específico autorizado.

## CP2-000e-3c — Aceite da etapa -3 (24/10/2026)

- [SUPOSIÇÃO] Decisão expressa do dono em 24/10/2026: CP2-000e-3 **ACEITA PELO DONO, com ressalva** — "decisão do dono: aceito". Este registro substitui as pendências históricas de decisão de aceite da etapa -3 nos relatos de -3, -3a e -3b, preservando as evidências e os limites daqueles relatos.
- [SUPOSIÇÃO] Resumo das evidências anteriores aceitas pelo dono, sem nova validação neste ticket: fidelidade 24/24 em bytes e SHA-256 entre MCP, disco, manifesto e blobs do commit 7969b6a6fc2a273148bf06a4310575ef1ebc377f.
- [SUPOSIÇÃO] Referências ausentes do perfil Tropical (raiz, marcadores e terminal): conhecidas, inativas e herdadas; por decisão do dono, a limpeza fica para a V2.
- [SUPOSIÇÃO] Ressalva 3 — restrição vigente para as etapas seguintes: **não trocar ActiveProfileId para Tropical**, pois causaria assert no servidor pelas referências ausentes, conforme a análise registrada em CP2-000e-3a. O aceite não autoriza essa troca.
- [NÃO ENCONTRADO] NÃO TESTADO: checkout futuro, posição, suporte físico, funcionamento e gameplay.
- [SUPOSIÇÃO] O funcionamento é relato do dono; não constitui teste executado pelo agente.
- [SUPOSIÇÃO] CP2-000e-4 continua com aprovação **PENDENTE**; aceitar a -3 não inicia nem autoriza a -4. As aprovações de -5 a -8 também permanecem PENDENTES.

## CP2-000e-4+5 — Preparação e interrupção antes da sincronização (24/10/2026)

- [SUPOSIÇÃO] Dono aprovou execução e plano das etapas -4 e -5 somente em CumbiaParty_V2_Descartavel.rbxl, reabertura da mesma descartável sem salvar entre ensaios e reconferência do snapshot. Alteração de Source e atributos preexistentes em scripts dispensados da prova e mantidos NÃO TESTADOS. Etapas -6 a -8 PENDENTES.
- [CONFIRMADO NO CÓDIGO] MCP list_roblox_studios retornou uma única sessão bffcdf69-33c3-4f23-8ace-a71fa4ec0206, CumbiaParty_V2_Descartavel.rbxl; get_studio_state confirmou modo, DataModel e foco Edit. O título da janela exibiu C:/Users/Thiago-PC1/CumbiaParty-Arquivos/CumbiaParty_V2_Descartavel.rbxl.
- [CONFIRMADO NO CÓDIGO] Os 24 caminhos foram resolvidos por correspondência única em cada segmento. Sources lidos via execute_luau em hexadecimal, sem require, e comparados por bytes e SHA-256 com disco: 24/24 iguais, 162095 bytes. A resposta da tentativa conjunta foi truncada; descartada e refeita em lotes de três scripts. O envio conjunto ao cálculo local excedeu 64000 bytes; refeito por script, sem escrita de arquivos auxiliares.
- [CONFIRMADO NO CÓDIGO] Atributos dos 24 scripts: conjunto vazio; cada script tem zero filhos. ServerBootstrap é Script, ClientBootstrap é LocalScript; ambos Disabled=false e RunContext=Enum.RunContext.Legacy. Os outros 22 são ModuleScript, sem propriedades de execução aplicáveis. UnitTestRunner e CumbiaPartyFestivalFX: Disabled=true, RunContext.Legacy. A enumeração de BaseScripts em ServerScriptService e StarterPlayer encontrou somente esses quatro, um bootstrap ativo por lado.
- [CONFIRMADO NO CÓDIGO] default.project.json criado com 24 folhas $path individuais e ancestrais necessários, emitLegacyScripts=true, $ignoreUnknownInstances=true em todos os nós. Attributes explicitamente vazios nos 24 scripts e nos ancestrais sem atributos; ArchitectureVersion={Float64:3} nas três pastas CumbiaParty. Raiz DataModel sem $properties. Não foram criados rokit.toml ou metadados auxiliares.
- [SUPOSIÇÃO] A representação numérica explícita segue [Properties v7](https://rojo.space/docs/v7/properties/#attributes); a fronteira de mapeamento segue [Project Format v7](https://rojo.space/docs/v7/project-format/). Documentação não prova preservação nesta sessão; $ignoreUnknownInstances não garante preservação de atributos.
- [CONFIRMADO NO CÓDIGO] CLI retornou Rojo 7.7.1; menu e painel do plugin exibiram Rojo 7.7.1. Todos os comandos CLI usaram o executável completo C:/Users/Thiago-PC1/.rokit/tool-storage/rojo-rbx/rojo/7.7.1/rojo.exe, sem mudar PATH.
- [CONFIRMADO NO CÓDIGO] Comandos CLI executados: --version; serve --help; serve default.project.json --address 127.0.0.1 --port 34872 (duas execuções). A primeira rejeitou $className junto de $path de arquivo, mesmo com classes iguais. Somente o JSON foi corrigido para inferir classes pelas extensões .luau/.server.luau/.client.luau. A segunda iniciou o servidor em localhost:34872. Processo encerrado por Ctrl+C na sessão 31607, retorno exit_code=1.
- [CONFIRMADO NO CÓDIGO] Bloqueio operacional: automação retornou layouts inconsistentes ao ativar/clicar no Studio; clique do submenu Rojo foi bloqueado por atingir janela RobloxStudio diferente do alvo. Houve também aviso de interação do usuário. Em nova observação o painel mostrava erro de conexão com servidor indisponível e estado desconectado. Nenhuma prévia foi aceita pelo agente.
- [NÃO ENCONTRADO] Não foi obtida prévia confiável nem evidência de sincronização bem-sucedida. Os três ensaios (declarado, atributo omitido e propriedade Attributes omitida), reabertura entre ensaios, comparação pós-sync e configuração final comprovada permanecem NÃO TESTADOS. A configuração atual é candidata, não aceite de -4 ou conclusão de -5.
- [CONFIRMADO NO CÓDIGO] Nenhuma escrita MCP no DataModel, alteração de Source, syncback, Play, require, publicação, commit ou gravação de .rbxl foi executada pelo agente. Escopo escrito: default.project.json e os três registros autorizados. CURRENT_STATE.md preservado pela restrição específica deste ticket.
- [SUPOSIÇÃO] Retomada proposta: obter interface estável ou condução manual do painel pelo dono; repetir identidade/Edit e snapshot antes de iniciar servidor ou conectar. Não aceitar remoções/substituições externas. Interromper diante de perda ou divergência, sem corrigir objetos.

### Snapshot inicial — Sources

| Estado | Caminho | Classe | Bytes | SHA-256 |
|---|---|---|---:|---|
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap | LocalScript | 6188 | 67568128d427f254e4dc30a40d979b550d33bbf4473820e27bc818929941dd21 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController | ModuleScript | 5663 | 4848a77f8cc666fac73f912dcec04c05e7f7267a357455581db0d31ef3694fa5 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD | ModuleScript | 10500 | 11ec855fb26b6f2182cbd7de180b50a6582f5c63c683e5a4b9595072a0290019 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattlePresentationView | ModuleScript | 10430 | 743535107a5a906784b9e5a94eb2348e566e2d4feace4644542f9d3db5dd22d6 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait | ModuleScript | 1605 | 5bce4720c123a800d2ecb52b6dfe271ae49b858877fb83ef9eaae3e70f3f7adc |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController | ModuleScript | 6263 | 0933aaa503e55abd7e0938b3d0925f4e78100f952d4d7dcda56b1f50320140e8 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.LobbyController | ModuleScript | 4329 | cdc30647bcfc85a7ee4f59aeaf50308f716f6218d847f422ff20b68da7c8d1f7 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.TournamentController | ModuleScript | 8500 | 3db4187efd8e172795c7121ebcad077a37329203762df6665de3dcb2d0caf28f |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController | ModuleScript | 14409 | 19dda8ca889b241c230c971fac8da728758ee8e47178c0af252477be09d0a1e4 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.ServerBootstrap | Script | 4375 | 1baa4e9f146362bd92fbe38c9e77fabb260acdf3a7a99a6acf6d90c84bd60771 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.ArenaService | ModuleScript | 12216 | 7f6629b1b9529189e8ab9ed0163be43405ea39e5983364863066e81587a2e142 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.BattleService | ModuleScript | 10446 | b2384aa78986b30f26443c933e4112d26300b92b90a929c1baf98eb18dd039ca |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.BotService | ModuleScript | 2779 | c8542295c0f28d08a1c17d0af1741a844edd8e3d0c01e8f5667b4dc0e1a58c47 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.CompetitorService | ModuleScript | 2029 | d58bfb6bf98266dd9c02f087757ecdfcb81cb9adc53df6834eb21de5d829eba8 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.LobbyService | ModuleScript | 6171 | 73c5b253ef261abd6c51085f4f75601fd81d5a40685db540608465d0c00de272 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.RhythmService | ModuleScript | 9122 | 5fc8494c77a5178ce2735c8d901b6bbf39be20e8401eaaff2cae72a2bbf95f86 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.TournamentService | ModuleScript | 14884 | 650eb4ca3294ef8bdfcfdf5e30e920bd537fdcd788406fcd24098e5ba7dac23d |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WaveGenerator | ModuleScript | 2227 | 3670f60acbc001852c7f3c860d87c52ab121fe4e50962764c901eff4e6031093 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WorldBindings | ModuleScript | 10877 | edd7233145490ef190041c7516aef14d0d21357861a3f122ee3e2537ce0857bc |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Validation.NoteValidator | ModuleScript | 1978 | 5399120305f12d3ca7673802101635204860c2242c5b8d289734bf3cf8696b3e |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig | ModuleScript | 1414 | f9276d6ed30d91fb79bce7844d1964bfbc7c36cdd421556e81ef8b33e03e1ae3 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.GameConfig | ModuleScript | 4449 | 7e55816a5e52454aeb339a12812e963765114d9116f1be593761a03d133fca09 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.NetworkTypes | ModuleScript | 2430 | 3d1b601b16332855d11807054c05c8da5cbdf8eeb2f988d30782a74c3d4d8ba6 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.WorldConfig | ModuleScript | 8811 | 242b3caee54351343f174163d588ca8283a132317131b6448bf1d5f36225fd69 |

### Snapshot inicial — ancestrais mapeados

| Estado | Caminho | Classe | Filhos diretos | Atributos completos | Filhos (nome:classe) |
|---|---|---|---:|---|---|
| [CONFIRMADO NO CÓDIGO] | StarterPlayer | StarterPlayer | 2 | {} | StarterCharacterScripts:StarterCharacterScripts; StarterPlayerScripts:StarterPlayerScripts |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts | StarterPlayerScripts | 2 | {} | CumbiaParty:Folder; CumbiaPartyFestivalFX:LocalScript |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty | Folder | 2 | ArchitectureVersion: number 3 | ClientBootstrap:LocalScript; Controllers:Folder |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers | Folder | 8 | {} | ArenaController:ModuleScript; BattleHUD:ModuleScript; BattlePresentationView:ModuleScript; CompetitorPortrait:ModuleScript; InputController:ModuleScript; LobbyController:ModuleScript; TournamentController:ModuleScript; UIController:ModuleScript |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService | ServerScriptService | 2 | {} | CumbiaParty:Folder; UnitTestRunner:Script |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty | Folder | 3 | ArchitectureVersion: number 3 | ServerBootstrap:Script; Services:Folder; Validation:Folder |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services | Folder | 9 | {} | ArenaService:ModuleScript; BattleService:ModuleScript; BotService:ModuleScript; CompetitorService:ModuleScript; LobbyService:ModuleScript; RhythmService:ModuleScript; TournamentService:ModuleScript; WaveGenerator:ModuleScript; WorldBindings:ModuleScript |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Validation | Folder | 1 | {} | NoteValidator:ModuleScript |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage | ReplicatedStorage | 1 | {} | CumbiaParty:Folder |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty | Folder | 2 | ArchitectureVersion: number 3 | Remotes:Folder; Shared:Folder |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared | Folder | 4 | {} | BattlePresentationConfig:ModuleScript; GameConfig:ModuleScript; NetworkTypes:ModuleScript; WorldConfig:ModuleScript |

### Referência estrutural dos objetos externos

- [CONFIRMADO NO CÓDIGO] Enumerados 10736 registros incluindo raízes, ancestrais e scripts gerenciados: caminho, classe e quantidade de filhos. A tabela conserva contagens e hashes por raiz; lista detalhada ficou em memória da sessão. Hash calculado sobre JSON.stringify dos registros recebidos, ordenados no Studio por caminho/classe, não é hash do arquivo .rbxl.
- [NÃO ENCONTRADO] Propriedades visuais/físicas e Sources dos objetos externos não foram capturados integralmente. Serviços internos do Studio não integram esta referência. Não há comparação pós-sync nem prova de preservação integral de todas as propriedades externas. Antes de retomar em outra sessão, reconstruir o snapshot detalhado.

| Estado | Raiz | Registros incluindo raiz | SHA-256 estrutural |
|---|---|---:|---|
| [CONFIRMADO NO CÓDIGO] | Lighting | 7 | c7151b8ba43a6e79fae8f174c2028a4fbc0613a85306ce795e2956c268bb5da7 |
| [CONFIRMADO NO CÓDIGO] | MaterialService | 1 | 28d29dec74dd5efa3f11f0030880c70fbfadba3ef794cd603f52e48fbd57fd6a |
| [CONFIRMADO NO CÓDIGO] | ReplicatedFirst | 1 | 12f4af8dfde6faffc34752a20f2f97a43504547f55059fb9929f31680c2f2cfa |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage | 17 | bafbf108a18c62bd7839098f121eeb054df62cfcb94b628c0acd228788754b7b |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService | 16 | f4daa44f1e9ae63e6ffd6020b66f95c8cf7cb4986edf9b1ddba25aa716d9a20e |
| [CONFIRMADO NO CÓDIGO] | ServerStorage | 9094 | d6f9dab51f3bc3e0985aa4a09c923ba610d4a699336ef58df993488b1d7acb68 |
| [CONFIRMADO NO CÓDIGO] | SoundService | 1 | 29f732e7aa19617765796d3c0d6c69c33371759b1d145b7311b47695baf944b2 |
| [CONFIRMADO NO CÓDIGO] | StarterGui | 76 | 4a6696bf8918b99cc7c6a44e58991f5d6d31cb70e0490da1e1c01c9029531743 |
| [CONFIRMADO NO CÓDIGO] | StarterPack | 1 | d06401d1b97f2da3664469d57de0265855e79711fd934864d45e3b9d484a7e8d |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer | 15 | 812854fc504bb15e79a753c89a312cdf8839b27084a1a0086654991751b67d78 |
| [CONFIRMADO NO CÓDIGO] | Teams | 1 | 9ad388974bf453685f3b10b98f723ae37c60f7163b26861cd9fc7c343cb3b6f6 |
| [CONFIRMADO NO CÓDIGO] | TextChatService | 9 | 969eacd318e96c401400f75c1dab745c209f3443a91c889e9647a149385e0342 |
| [CONFIRMADO NO CÓDIGO] | Workspace | 1497 | 732a9956782acd7ac8f77a6f6cf246bf3df9fcd656a97031da739de7b265840d |

- [NÃO ENCONTRADO] NÃO TESTADO adicional: gameplay, UnitTest, multiplayer, mobile, segurança, desempenho, memória, compilação/execução dos scripts, equivalência do .rbxl salvo, teste de abertura do pré-migração e etapas -6 a -8.

## CP2-000e-5a — Resultado da sincronização e decisão sobre CR (24/10/2026)

- [CONFIRMADO NO CÓDIGO] Após a conexão relatada pelo dono, a leitura MCP em Edit encontrou 14/24 Sources com SHA-256 idêntico ao snapshot inicial/disco e 10/24 com SHA-256 diferente. A comparação dos bytes dos dez mostrou somente remoção de CR (\r): removendo CR do Source inicial, os bytes coincidem integralmente com o Source posterior. O critério original de 24/24 SHA-256 exatos **NÃO foi atendido**. Nenhum Source foi corrigido.
- [SUPOSIÇÃO] Causa provável: Rojo normaliza CRLF para LF ao sincronizar scripts. A atribuição causal ao Rojo não foi comprovada na documentação nem por ensaio isolado; o fato observado é somente a remoção de CR após a conexão.
- [SUPOSIÇÃO] Decisão expressa do dono em 24/10/2026, opção 1: aceitar a remoção de CR como diferença conhecida desta sincronização. Critério revisado da etapa -5: SHA-256 exato nos 14 scripts sem diferença; nos dez caminhos fechados da tabela abaixo, igualdade de bytes após remover CR do Source inicial. Qualquer outra diferença continua divergência. **Etapa -5 ACEITA PELO DONO com esse critério**, sem transformar os dez hashes brutos em iguais.
- [CONFIRMADO NO CÓDIGO] Classes, caminhos, hierarquia, atributos (chave, tipo e valor), Disabled/RunContext e contagens de filhos dos 11 ancestrais coincidiram com o snapshot. As três pastas CumbiaParty mantiveram ArchitectureVersion do tipo number, valor 3; os 24 scripts mantiveram atributos vazios. UnitTestRunner e CumbiaPartyFestivalFX continuaram desabilitados; ServerBootstrap e ClientBootstrap continuaram habilitados, um por lado. A enumeração estrutural de 10.736 objetos preservou caminhos, classes e contagens de filhos, incluindo Remotes, GUI, UnitTest e backups.
- [SUPOSIÇÃO] Relato do dono, não verificado por agente: viu a prévia, clicou Accept, desconectou o Rojo e fechou CumbiaParty_V2_Descartavel.rbxl **sem salvar**. A declaração “não salvei” substitui a pendência de informação do dono sobre o fechamento, mas não equivale a verificação independente do arquivo em disco.
- [NÃO ENCONTRADO] Conteúdo da prévia não foi fornecido: NÃO TESTADO se propôs remoções ou substituições. Persistência no .rbxl salvo, gameplay e funcionamento também NÃO TESTADOS.
- [SUPOSIÇÃO] Status aprovado pelo dono para a etapa -4: **prova parcial concluída; aceite integral pendente**. O caso declarado preservou ArchitectureVersion = number 3 nas três pastas após a conexão. Ensaios de atributo omitido, de toda a propriedade Attributes omitida, alteração de Source e atributos preexistentes em scripts: NÃO TESTADOS.
- [SUPOSIÇÃO] Consequência para -7: se o mesmo comportamento ocorrer na cópia de trabalho, os dez scripts da tabela ficarão sem CR no Studio, enquanto os arquivos src/ manterão CR. default.project.json continua candidato até -7; não foi validado no place de trabalho.
- [CONFIRMADO NO CÓDIGO] Nesta etapa documental, o processo iniciado para rojo serve foi reconfirmado como PID 48224, executável C:/Users/Thiago-PC1/.rokit/tool-storage/rojo-rbx/rojo/7.7.1/rojo.exe, início 2026-10-24 14:25:09 (horário local), e encerrado somente por Stop-Process -Id 48224; consulta posterior não encontrou esse PID. Nenhum outro processo foi alvo.
- [SUPOSIÇÃO] Etapas -6 a -8 permanecem PENDENTES. As afirmações históricas de -4/-5 pendentes acima descrevem o momento anterior e são substituídas, quanto ao status atual, por esta decisão.

| Estado | Source (caminho Studio) | SHA-256 inicial/disco | SHA-256 posterior no Studio |
|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap | 67568128d427f254e4dc30a40d979b550d33bbf4473820e27bc818929941dd21 | 46ae61050bbcf38feb78c62861b3399fb3df096f6d27cddfb1dc949952721c41 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController | 4848a77f8cc666fac73f912dcec04c05e7f7267a357455581db0d31ef3694fa5 | 01bd555a35b80c463989935013c2968fece19e349cd435fb6f987a2b8c9c920d |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD | 11ec855fb26b6f2182cbd7de180b50a6582f5c63c683e5a4b9595072a0290019 | a97035931a6715be9693ee1be018ade0693dfba8ba3cee4a48270ca56c2e1de8 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.ServerBootstrap | 1baa4e9f146362bd92fbe38c9e77fabb260acdf3a7a99a6acf6d90c84bd60771 | 5b99966d4956602c48aab484f8684dfcf24a054dedbb741a98de63d1f8fb6528 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.ArenaService | 7f6629b1b9529189e8ab9ed0163be43405ea39e5983364863066e81587a2e142 | ac43050443af55f2aea859860cb6a8904e8a7d21ab9daf52a46e0a00adbd1e48 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.LobbyService | 73c5b253ef261abd6c51085f4f75601fd81d5a40685db540608465d0c00de272 | 8a44ed450f504ff4c569be8bb97f7a0d4589a116ea2adaaddf706145a6ee4e6b |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.TournamentService | 650eb4ca3294ef8bdfcfdf5e30e920bd537fdcd788406fcd24098e5ba7dac23d | 853437a364575a032d3ea67f36c6519ccf763b9d1f69eaf7b4a395f90c360bbf |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WorldBindings | edd7233145490ef190041c7516aef14d0d21357861a3f122ee3e2537ce0857bc | f540e3b7064fa6a62174a8a37aa2ce7a3fc9f40c6a55bcc0eda53cffa7fbacc2 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.NetworkTypes | 3d1b601b16332855d11807054c05c8da5cbdf8eeb2f988d30782a74c3d4d8ba6 | 19a4f59153189a20f72a7001570664ba97fe685f1e51e20b0405969aaf0267ae |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.WorldConfig | 242b3caee54351343f174163d588ca8283a132317131b6448bf1d5f36225fd69 | 53dd4209c385f4e324cf120c085f433b871f2178cdff25126c1a0b6cd57bd1ff |

## CP2-000e-6 — Rodadas funcionais A e B na descartável (25/10/2026)

- [SUPOSIÇÃO] Dono aprovou somente a etapa -6 na CumbiaParty_V2_Descartavel.rbxl. As etapas -7 e -8 continuam PENDENTES. O dono relatou que a descartável reaberta antes da rodada A não tinha sido salva após a sincronização anterior; após a rodada B, relatou que desconectou o Rojo e fechou novamente sem salvar. Nenhuma gravação do .rbxl foi executada pelo agente.
- [CONFIRMADO NO CÓDIGO] Sessão MCP única 27d46571-0521-4c99-881f-20814afe8868, CumbiaParty_V2_Descartavel.rbxl, em Edit antes da rodada A. Os 24 Sources tinham os SHA-256 e comprimentos originais do disco; os 11 ancestrais preservavam classe, filhos e atributos, com ArchitectureVersion number 3 nas três pastas CumbiaParty. As 13 raízes inventariadas totalizavam 10.736 objetos, com as contagens originais. Isso reconfirmou o estado não sincronizado antes do Play.
- [CONFIRMADO NO CÓDIGO] Rodada A: start_stop_play iniciou Play com DataModels Client e Server; get_console_output registrou duas mensagens de inicialização — `[CumbiaParty] Rhythm solo + Combat X1 + Tournament V1 prontos.` e `[CumbiaParty] Cliente pronto: solo, convite X1 e Hold Notes.` — e três ocorrências de `ContentId: rbxassetid://203785492 failed due to: Asset type does not match requested type`. Nenhum outro erro apareceu na saída consultada. Player único no servidor; nove RemoteEvents esperados presentes. Cliente iniciou no lobby, câmera Custom e teclas D/F/J/K na GUI.
- [CONFIRMADO NO CÓDIGO] Na A, clique no botão TORNEIO abriu o painel; Join mudou a fila de 0/8 para 1/8 e iniciou contagem. Após a contagem, GUI de batalha apareceu e câmera ficou Scriptable. Entradas D/F/J/K enviadas por user_keyboard_input; a GUI mostrou `Good 1`, pontuação 400 e `Fora do tempo` em uma leitura. O torneio avançou até onda 7; o painel informou `TORNEIO CONCLUÍDO • 8 competidores` e resumo `Encerramento: KO`. Botão VOLTAR fechou o painel, reexibiu LobbyHUD e restaurou câmera Custom.
- [CONFIRMADO NO CÓDIGO] Rodada A: atalho Escape, R, Return foi enviado como tentativa de reset; depois havia personagem com 100 HP no lobby e posição observada de Z=10 antes para Z=0 após. Não foi capturada identidade única do personagem nem evento CharacterAdded, portanto respawn efetivo é INCONCLUSIVO.
- [CONFIRMADO NO CÓDIGO] Play A foi parado e Studio voltou a Edit antes de iniciar Rojo. Comando usado: `C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe serve default.project.json --address 127.0.0.1 --port 34872`; servidor anunciou localhost:34872. O agente não operou o painel Rojo.
- [SUPOSIÇÃO] Dono apresentou captura da prévia com duas edições listadas, ambas em scripts gerenciados: ReplicatedStorage.CumbiaParty.Shared.WorldConfig e ServerScriptService.CumbiaParty.Services.WorldBindings; em seguida respondeu `aceito`. A captura não exibia o detalhe interno das propriedades. Não havia remoção, substituição fora dos 24 scripts nem mudança de ArchitectureVersion visível na lista exibida.
- [CONFIRMADO NO CÓDIGO] Em Edit após o aceite, 14/24 Sources permaneceram byte a byte iguais; os dez caminhos fechados da seção CP2-000e-5a diferiram somente pela remoção de CR e ficaram iguais após removê-lo. Classes, caminhos, atributos dos scripts, Disabled/RunContext e contagens dos 11 ancestrais coincidiram; ArchitectureVersion permaneceu number 3 nas três pastas. ServerBootstrap e ClientBootstrap habilitados, UnitTestRunner e CumbiaPartyFestivalFX desabilitados. Os 10.736 objetos inventariados mantiveram caminhos, classes e contagens de filhos; os hashes estruturais por raiz coincidiram com o snapshot anterior.
- [CONFIRMADO NO CÓDIGO] Rodada B: Play iniciou em Client e Server; mesmo player único, nove Remotes, lobby, câmera Custom e teclas D/F/J/K. TORNEIO e Join levaram a 1/8 com contagem; GUI de batalha e câmera Scriptable apareceram. Entradas D/F/J/K foram enviadas. A GUI informou `TORNEIO CONCLUÍDO • 8 competidores`, `Encerramento: KO` na onda 8; VOLTAR restaurou LobbyHUD e câmera Custom. O mesmo atalho de reset foi enviado; novamente havia personagem com 100 HP, Z=10 antes e Z=0 após, sem prova direta de CharacterAdded. Play B foi parado e Studio voltou a Edit.
- [CONFIRMADO NO CÓDIGO] Output relevante da B foi igual ao da A: as mesmas duas mensagens de inicialização e três avisos do mesmo ContentId; nenhum outro erro apareceu na saída consultada. Não foi executado require, suíte UnitTest, syncback ou escrita direta no Studio. ActiveProfileId não foi alterado.

### Comparação funcional A × B

| Estado | Cenário | A | B | Classificação |
|---|---|---|---|---|
| [CONFIRMADO NO CÓDIGO] | Bootstraps e Output consultado | 2 mensagens de pronto; 3 avisos do asset | Mesmas mensagens e avisos | Herdado nas duas rodadas; nenhuma regressão observada nesse Output |
| [CONFIRMADO NO CÓDIGO] | Lobby, fila e chave | Lobby → 1/8 → batalha → torneio concluído com 8 competidores | Mesmo fluxo observado | Sem regressão observada no roteiro executado |
| [CONFIRMADO NO CÓDIGO] | D/F/J/K e GUI | Entradas enviadas; GUI mostrou Good, pontos e fora do tempo | Entradas enviadas; valores de acerto diferentes | Inconclusivo quanto à equivalência de julgamento por depender do instante das teclas |
| [CONFIRMADO NO CÓDIGO] | Resultado e retorno | KO na onda 7; VOLTAR restaurou lobby e câmera Custom | KO na onda 8; VOLTAR restaurou lobby e câmera Custom | Resultado/retorno observados; diferença de onda inconclusiva |
| [NÃO ENCONTRADO] | Respawn | Atalho de reset, personagem depois com 100 HP | Mesmo procedimento e estado posterior | Inconclusivo: evento de respawn não observado |

- [NÃO ENCONTRADO] NÃO TESTADO: conteúdo detalhado da prévia; confirmação independente de desconexão e de fechamento sem salvar; persistência do place salvo; saída da fila antes da partida; abandono da sessão por um jogador real; torneio com múltiplos humanos; validação dos bots/resultado pelo estado interno do servidor; nota em tempo controlado; câmera visual quadro a quadro; suíte UnitTest, mobile, multiplayer, segurança, desempenho e memória. A saída consultada não garante recuperação de mensagens fora da retenção do Output.
- [CONFIRMADO NO CÓDIGO] Processo rojo serve desta rodada reconfirmado antes de encerrar: PID 36732, executável `C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe`, início 2026-10-24 21:57:39 (horário local). Stop-Process -Id 36732 encerrou somente esse PID; verificação imediata não o encontrou.
- [SUPOSIÇÃO] Veredito proposto: nenhuma regressão foi observada no roteiro funcional executado, com as limitações acima; aceite final da etapa -6 permanece decisão do dono. Etapas -7 e -8 PENDENTES; default.project.json continua candidato, sem transferência à V2_Trabalho.


## CP2-000e-7 — Transferência à cópia de trabalho (25/10/2026)

- [SUPOSIÇÃO] Dono aprovou execução e plano exclusivamente na CumbiaParty_V2_Trabalho.rbxl. Aceitou a CP2-000e-6 em 25/10/2026 com respawn, saída da fila, múltiplos humanos, UnitTest, mobile, segurança e desempenho NÃO TESTADOS. A CP2-000e-8 continua PENDENTE.
- [SUPOSIÇÃO] Decisão expressa do dono: não criar cópia pre-rojo; ponto de retorno é o pre-migracao, NÃO TESTADO e anterior ao V2_Trabalho. Risco de perda das alterações do intervalo ao restaurar aceito pelo dono.
- [CONFIRMADO NO CÓDIGO] Sessão MCP única 7510caed-e1db-4a25-a458-ca5930902cc6, CumbiaParty_V2_Trabalho.rbxl, com modo, DataModel disponível e foco Edit. Snapshot inicial: 24/24 Sources iguais em bytes e SHA-256 ao disco e à tabela original da descartável, total 162095 bytes; 14 sem CR e dez com CR. Classes, atributos vazios, ausência de filhos dos scripts e Disabled/RunContext conferidos.
- [CONFIRMADO NO CÓDIGO] Os 11 ancestrais coincidiram com a referência em classe, filhos e atributos; ArchitectureVersion number 3 nas três pastas CumbiaParty. ServerBootstrap e ClientBootstrap habilitados, um por lado; UnitTestRunner e CumbiaPartyFestivalFX desabilitados, todos RunContext.Legacy. As 13 raízes totalizam 10736 objetos, mesmas contagens da referência.
- [CONFIRMADO NO CÓDIGO] Snapshot estrutural detalhado reconstruído em memória por lotes de até 150 registros, com caminho, classe e quantidade de filhos. Os hashes desta etapa usam JSON.stringify de objetos com chaves na ordem path, class, children, ordenados no Studio por caminho/classe; esta serialização é explicitada para comparação antes/depois e não presume igualdade com hashes históricos de outra serialização.
- [CONFIRMADO NO CÓDIGO] Escrita restrita ao manifesto, plano e backlog; CURRENT_STATE.md preservado pela restrição específica. Nenhuma escrita direta no Studio, require, alteração para Tropical, syncback, gravação .rbxl ou commit. O nome do projeto existente no JSON é CumbiaParty_V2_Descartavel; arquivo preservado conforme escopo, com alvo confirmado pela sessão MCP.
- [NÃO ENCONTRADO] Sincronização, prévia, comparação pós-sync e Play desta etapa ainda NÃO TESTADOS; execução aguardará prévia analisável e declaração do dono “aceitei”. Persistência do place salvo e propriedades/Sources completos dos objetos externos NÃO TESTADOS.

### Snapshot inicial dos Sources na V2_Trabalho

| Estado | Caminho | Bytes | SHA-256 |
|---|---|---:|---|
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController | 5663 | 4848a77f8cc666fac73f912dcec04c05e7f7267a357455581db0d31ef3694fa5 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD | 10500 | 11ec855fb26b6f2182cbd7de180b50a6582f5c63c683e5a4b9595072a0290019 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattlePresentationView | 10430 | 743535107a5a906784b9e5a94eb2348e566e2d4feace4644542f9d3db5dd22d6 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait | 1605 | 5bce4720c123a800d2ecb52b6dfe271ae49b858877fb83ef9eaae3e70f3f7adc |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController | 6263 | 0933aaa503e55abd7e0938b3d0925f4e78100f952d4d7dcda56b1f50320140e8 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.LobbyController | 4329 | cdc30647bcfc85a7ee4f59aeaf50308f716f6218d847f422ff20b68da7c8d1f7 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.TournamentController | 8500 | 3db4187efd8e172795c7121ebcad077a37329203762df6665de3dcb2d0caf28f |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController | 14409 | 19dda8ca889b241c230c971fac8da728758ee8e47178c0af252477be09d0a1e4 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap | 6188 | 67568128d427f254e4dc30a40d979b550d33bbf4473820e27bc818929941dd21 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.ArenaService | 12216 | 7f6629b1b9529189e8ab9ed0163be43405ea39e5983364863066e81587a2e142 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.BattleService | 10446 | b2384aa78986b30f26443c933e4112d26300b92b90a929c1baf98eb18dd039ca |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.BotService | 2779 | c8542295c0f28d08a1c17d0af1741a844edd8e3d0c01e8f5667b4dc0e1a58c47 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.CompetitorService | 2029 | d58bfb6bf98266dd9c02f087757ecdfcb81cb9adc53df6834eb21de5d829eba8 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.LobbyService | 6171 | 73c5b253ef261abd6c51085f4f75601fd81d5a40685db540608465d0c00de272 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.RhythmService | 9122 | 5fc8494c77a5178ce2735c8d901b6bbf39be20e8401eaaff2cae72a2bbf95f86 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.TournamentService | 14884 | 650eb4ca3294ef8bdfcfdf5e30e920bd537fdcd788406fcd24098e5ba7dac23d |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WaveGenerator | 2227 | 3670f60acbc001852c7f3c860d87c52ab121fe4e50962764c901eff4e6031093 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WorldBindings | 10877 | edd7233145490ef190041c7516aef14d0d21357861a3f122ee3e2537ce0857bc |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Validation.NoteValidator | 1978 | 5399120305f12d3ca7673802101635204860c2242c5b8d289734bf3cf8696b3e |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.ServerBootstrap | 4375 | 1baa4e9f146362bd92fbe38c9e77fabb260acdf3a7a99a6acf6d90c84bd60771 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig | 1414 | f9276d6ed30d91fb79bce7844d1964bfbc7c36cdd421556e81ef8b33e03e1ae3 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.GameConfig | 4449 | 7e55816a5e52454aeb339a12812e963765114d9116f1be593761a03d133fca09 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.NetworkTypes | 2430 | 3d1b601b16332855d11807054c05c8da5cbdf8eeb2f988d30782a74c3d4d8ba6 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.WorldConfig | 8811 | 242b3caee54351343f174163d588ca8283a132317131b6448bf1d5f36225fd69 |

### Snapshot estrutural inicial da V2_Trabalho

| Estado | Raiz | Objetos incluindo raiz | SHA-256 (path, class, children) |
|---|---|---:|---|
| [CONFIRMADO NO CÓDIGO] | Lighting | 7 | 80a0ab234e943e8aeb3c7322ae81dce2aebf07b1b9d86dca7f6b8b32d8da05e1 |
| [CONFIRMADO NO CÓDIGO] | MaterialService | 1 | 3781904bda97d3c084e4b58c75cf20fa0940282a3a4a184dbf61ff21e6e0173d |
| [CONFIRMADO NO CÓDIGO] | ReplicatedFirst | 1 | 7686dd90729420081210da5ef8f7f4a794c209f9aab31a8ccb1455cbe0742e27 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage | 17 | 8d1f3e0ada18501164aa1a03c2473b4e668b95a8c18acbb70825866f047c6205 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService | 16 | a89e0491d3f196ca262534aae42d2b7a023ace573ef939a8bce3d8f371bf1446 |
| [CONFIRMADO NO CÓDIGO] | ServerStorage | 9094 | 31b437bcd8bc2b7bece80ad14e34da04869acc3233580ffe4c32539c9d9f66bb |
| [CONFIRMADO NO CÓDIGO] | SoundService | 1 | 0713cbbc593d42379b87710943abbb13515edafd712d7393bdc32593006cd74c |
| [CONFIRMADO NO CÓDIGO] | StarterGui | 76 | 8bf1c9633ac0bd60014a0bbaf7c061f83381be89bdf88377286bc8a8a55e2920 |
| [CONFIRMADO NO CÓDIGO] | StarterPack | 1 | 67d48d23d0d932eef2d26ac991e29cf9b2bff602a598116a65f9256cba340989 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer | 15 | 8d9788defb7fda1050fc7cb054c31c1cb1f64f22e8681c5aa4fd66b7504cd50e |
| [CONFIRMADO NO CÓDIGO] | Teams | 1 | ad488d7a2c5e798ebc53df334800af538cc721d51666f65f4ba89cbb27342467 |
| [CONFIRMADO NO CÓDIGO] | TextChatService | 9 | 54346434b70bfea23e4155f9b4648f68860fbd04d9d6f893ab1fe0ab060dbedd |
| [CONFIRMADO NO CÓDIGO] | Workspace | 1497 | 7ef386b54c75532331a0240b6a106fbd4dea178f1f1b4e69f421eaf31e320f98 |

- [CONFIRMADO NO CÓDIGO] Rojo 7.7.1 iniciado com `serve default.project.json --address 127.0.0.1 --port 34872`; anunciou localhost:34872. PID 28076, executável `C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe`, início 2026-10-25T18:52:29.0394169Z (14:52:29 em America/New_York), sessão de comando 56148. Antes de iniciar, consulta elevada não encontrou rojo.exe nem listener na porta 34872; a primeira consulta CIM no sandbox retornou Access denied. Processo permanece ativo aguardando condução manual do dono e prévia, sem aceite do agente.

### Interrupção após aceite da prévia pelo dono

- [SUPOSIÇÃO] Dono apresentou captura da prévia com os dez scripts da lista fechada de CR e uma edição adicional na raiz CumbiaParty_V2_Trabalho.rbxl (lápis e contador 1). O detalhe das propriedades não estava visível. Após o agente solicitar que não aceitasse até esclarecer a raiz, o dono informou “aceitei”. Isso registra a ação relatada, sem presumir aprovação específica de alteração adicional na raiz.
- [CONFIRMADO NO CÓDIGO] Leitura MCP posterior: sessão única 7510caed-e1db-4a25-a458-ca5930902cc6 continua identificada como CumbiaParty_V2_Trabalho.rbxl, em Edit; game.Name retornou CumbiaParty_V2_Descartavel, classe DataModel e atributos vazios. As três pastas CumbiaParty mantêm ArchitectureVersion number 3. O nome da sessão/arquivo e o nome atual do DataModel são distintos.
- [SUPOSIÇÃO] A edição indicada na raiz provavelmente corresponde ao nome do projeto existente em default.project.json. Não foi capturado game.Name diretamente no snapshot anterior; a propriedade exata proposta na prévia não foi disponibilizada, portanto a causa e o antes/depois dessa propriedade não estão comprovados por duas leituras MCP.
- [CONFIRMADO NO CÓDIGO] Fluxo interrompido para esclarecer a alteração adicional da raiz, conforme regra de parar diante de divergência ou dúvida. Nenhum Play, correção direta, edição de configuração ou salvamento foi executado pelo agente.
- [NÃO ENCONTRADO] Comparação completa pós-sync dos 24 Sources e estrutura, rodada funcional da -7 e persistência do place salvo permanecem NÃO TESTADAS. Encerramento do Rojo ainda não realizado; aguardando desconexão informada pelo dono para reconferir PID, executável e horário antes de encerrar exclusivamente o processo desta etapa.

### Encerramento do processo após interrupção

- [SUPOSIÇÃO] Dono informou que desconectou o Rojo e fechou o place sem salvar; autorizou encerrar o PID 28076. O fechamento sem salvar é relato do dono, não verificação independente do arquivo em disco.
- [CONFIRMADO NO CÓDIGO] Antes de encerrar, Get-Process confirmou PID 28076, executável C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe e início UTC 2026-10-25T18:52:29.0394169Z, iguais à identidade registrada ao iniciar. Stop-Process recebeu somente esse objeto de processo; WaitForExit(5000) retornou True e a consulta posterior não encontrou o PID. Nenhum outro processo foi encerrado.
- [SUPOSIÇÃO] CP2-000e-7 permanece INTERROMPIDA, sem conclusão ou aceite final, pela alteração adicional da raiz não esclarecida. CP2-000e-8 continua PENDENTE. Uma retomada exige novo snapshot da cópia de trabalho e decisão sobre a alteração da raiz, respeitando o escopo autorizado.
- [NÃO ENCONTRADO] Permanecem NÃO TESTADOS: comparação completa pós-sync, Play da -7, persistência do place salvo e confirmação independente do fechamento sem salvar; preservadas as lacunas aceitas da -6. Nenhum salvamento ou commit pelo agente.

## CP2-000e-7a — Diagnóstico do nome do DataModel (25/10/2026)

- [SUPOSIÇÃO] Dono aprovou diagnóstico somente leitura e, depois de receber os resultados, aprovou registro exclusivamente neste manifesto, em MIGRATION_PLAN.md e em BACKLOG.md. Decisão sobre o campo name permanece PENDENTE; nenhuma opção foi aplicada. CP2-000e-7 permanece INTERROMPIDA e CP2-000e-8 PENDENTE.
- [CONFIRMADO NO CÓDIGO] A primeira listagem MCP desta investigação retornou sessão única com name null; o diagnóstico foi interrompido. Após reabertura informada pelo dono, list_roblox_studios identificou a sessão única b3ca9f48-fc88-45dd-b4bd-e42ba2586892 como CumbiaParty_V2_Trabalho.rbxl. get_studio_state confirmou modo, DataModel disponível e foco Edit.
- [CONFIRMADO NO CÓDIGO] Baseline recapturado por leitura ANTES da consulta ao JSON: 2026-10-25T22:13:20Z, equivalente a 18:13:20 em America/New_York. Nome do arquivo informado pelo MCP: CumbiaParty_V2_Trabalho.rbxl. Nome da instância DataModel, lido de game.Name: CumbiaParty_V2_Trabalho.rbxl, incluindo a extensão. São informações distintas, embora tenham o mesmo texto nesta captura.
- [CONFIRMADO NO CÓDIGO] default.project.json:2 contém "name": "CumbiaParty_V2_Descartavel"; a raiz tree declara $className DataModel. Esse name difere do game.Name capturado. O JSON foi somente lido.
- [CONFIRMADO NO CÓDIGO] O registro histórico CP2-000e-7 deste manifesto relata game.Name CumbiaParty_V2_Descartavel após o aceite da prévia, com nome da sessão/arquivo CumbiaParty_V2_Trabalho.rbxl. Nesta investigação foi lido o registro histórico; não foi reproduzida a sincronização.
- [SUPOSIÇÃO] O renome e sua atribuição ao Rojo continuam inferidos: game.Name não foi capturado antes daquela sincronização, e o detalhe da propriedade proposta na raiz não foi disponibilizado. A reabertura sem salvar é relato do dono; esta captura atual não substitui um par de leituras imediatamente antes/depois da mesma sincronização.
- [NÃO ENCONTRADO] Nome exato da raiz exibida na prévia histórica da descartável não transcrito nos registros consultados. O registro da etapa -6 descreve duas edições em scripts, sem detalhe das propriedades. A comparação visual solicitada fica inconclusiva; nenhum acesso à descartável foi realizado.

### Documentação oficial e limite da conclusão

- [SUPOSIÇÃO] Conforme [Project Format — Rojo v7](https://rojo.space/docs/v7/project-format/), consultado nesta investigação, name identifica o projeto e é usado ao construir um modelo/place; tree descreve a instância raiz. A aplicação desse name ao DataModel durante a sincronização é hipótese compatível com o histórico, não conclusão explicitamente demonstrada por essa página nem prova experimental na versão 7.7.1.
- [NÃO ENCONTRADO] As páginas oficiais Project Format e [Sync Details — Rojo v7](https://rojo.space/docs/v7/sync-details/) consultadas não forneceram afirmação explícita suficiente para provar que o live sync renomeia game.Name neste caso. Nenhum comando Rojo foi executado, inclusive --version.

### Busca de dependências do nome

- [CONFIRMADO NO CÓDIGO] Pesquisa textual em todos os 24 arquivos de src/ por rg e nos 24 Sources atuais da sessão Edit por consulta MCP. Os caminhos do JSON foram resolvidos segmento a segmento, exigindo correspondência única e LuaSourceContainer, e Source foi lido como texto. Nenhum Source foi executado ou requerido.
- [CONFIRMADO NO CÓDIGO] Termos pesquisados incluíram game.Name com espaços opcionais, game seguido de acesso por colchetes, CumbiaParty_V2 (no Studio, prefixo mais amplo CumbiaParty_V), Descartavel, Trabalho, .rbxl, PlaceId, PlaceName, GetProductInfo e DataModel, sem distinguir maiúsculas/minúsculas. Em src/ também foram inspecionadas ocorrências de game, Game, .Name, GetFullName e Place.
- [NÃO ENCONTRADO] Zero ocorrências dos padrões específicos do nome/place nos 24 arquivos e nos 24 Sources. Não há arquivo/linha de ocorrência a listar. A inspeção ampliada de src/ encontrou uso de serviços e nomes de outras instâncias, sem uso direto identificado do nome do DataModel.
- [SUPOSIÇÃO] Ausência de ocorrência textual não prova ausência de dependência indireta, nome construído dinamicamente ou comportamento em execução.

### Opções propostas, sem aplicação, e pendências

- [SUPOSIÇÃO] Opção A: manter name CumbiaParty_V2_Descartavel conserva a configuração usada na prova anterior da descartável. Pode voltar a propor esse nome para a raiz; não elimina a necessidade de esclarecer a propriedade na prévia e medir game.Name antes/depois. A comparação pós-sync e o roteiro funcional pendentes da -7 continuam necessários.
- [SUPOSIÇÃO] Opção B: trocar somente name para CumbiaParty_V2_Trabalho pode alinhar o nome pretendido da raiz, mas ainda difere do baseline CumbiaParty_V2_Trabalho.rbxl pela extensão. A prova anterior não valida automaticamente a configuração alterada. Antes de adotá-la, seria necessária nova prova autorizada: prévia detalhada, comparação dos nomes antes/depois, 24 Sources pelo critério revisado de CR, classes/caminhos/estrutura/atributos e validação funcional. Isto é proposta, não autorização para editar ou ensaiar.
- [SUPOSIÇÃO] PENDENTE — dono decidir o valor de name. O JSON permanece inalterado; a aprovação deste registro não decide o nome nem autoriza retomar a -7.
- [SUPOSIÇÃO] PENDENTE — na próxima sincronização expressamente autorizada, reconfirmar sessão única/arquivo/Edit, capturar game.Name imediatamente ANTES e imediatamente DEPOIS, com horário e identificação da sessão; registrar separadamente nome do arquivo, name do JSON, propriedade detalhada da prévia e resultado. Comparar também com o baseline de 22:13:20Z desta investigação.
- [CONFIRMADO NO CÓDIGO] Escrita restrita aos três documentos aprovados. Nenhuma escrita no Studio, salvamento do place, comando Rojo, alteração do JSON/src/.gitattributes/Git config, acesso à descartável/V1/pre-migracao ou commit nesta investigação. CURRENT_STATE.md permanece fora do escopo específico.
- [NÃO ENCONTRADO] NÃO TESTADO: renome por sincronização na 7.7.1, configuração alternativa, comparação completa pós-sync da -7, persistência do place, gameplay, compilação/execução dos Sources e dependências indiretas. Busca textual não equivale a equivalência binária disco/Studio nem a teste funcional.

## CP2-000e-7b — Prova do name na descartável (26/10/2026)

- [SUPOSIÇÃO] Dono aprovou execução e plano exclusivamente em CumbiaParty_V2_Descartavel.rbxl, opção 2: trocar name para CumbiaParty_V2_Trabalho. CP2-000e-7 permanece INTERROMPIDA; -8 PENDENTE. Proibidos salvamento do place, commit, syncback, escrita direta no Studio e troca de ActiveProfileId para Tropical.
- [CONFIRMADO NO CÓDIGO] MCP identificou sessão única 268358ea-5dfb-4083-9a2e-a87717f9db1d, CumbiaParty_V2_Descartavel.rbxl, em Edit. game.Name ANTES, texto exato: `CumbiaParty_V2_Descartavel.rbxl`, em 2026-10-27T02:11:55Z (26/10/2026 22:11:55 America/New_York); reconfirmado com o mesmo texto em 2026-10-27T02:13:17Z, antes de Connect/aceite.
- [CONFIRMADO NO CÓDIGO] Os 24 Sources coincidem integralmente em bytes e SHA-256 com src/ e os hashes originais registrados neste manifesto: 162095 bytes, 14 sem CR e dez com CR. Captura inicial excedeu o limite de transporte; descartada e repetida em lotes completos, sem executar Sources. Os 11 ancestrais coincidem em classes, filhos e atributos com a referência; ArchitectureVersion number 3 nas três pastas. Scripts sem atributos/filhos; ServerBootstrap e ClientBootstrap habilitados, um por lado de execução; UnitTestRunner e CumbiaPartyFestivalFX desabilitados, todos Legacy. Cópias de bootstrap em ServerStorage foram inventariadas separadamente.
- [CONFIRMADO NO CÓDIGO] Reenumerados 10736 objetos nas 13 raízes da referência, com mesmas contagens; caminhos, classes e número de filhos mantidos em memória para comparação pós-sync. Hashes desta captura usam JSON de objetos com chaves na ordem path,class,children; não são comparados diretamente aos hashes históricos com serialização não reconstruída.
- [SUPOSIÇÃO] O dono relata que não salvou a descartável após sincronizações anteriores. A igualdade atual dos Sources com o baseline original reconfirma o estado aberto não normalizado; não comprova independentemente o histórico de salvamento.
- [CONFIRMADO NO CÓDIGO] default.project.json alterado somente no campo name, de CumbiaParty_V2_Descartavel para CumbiaParty_V2_Trabalho; demais bytes preservados e leitura posterior conferida. SHA-256 ANTES: `af85794a0cac3dbef7bb7474cfabcbee085d9e858fde6d84ca72db1ecdcc816f`; DEPOIS: `79a3bdce9457c0a2f71797eb6b785e590f81cc33acff3573c552d3f7122f9024`.
- [CONFIRMADO NO CÓDIGO] Iniciado somente o Rojo PID 2576, executável C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe, início 2026-10-27T02:13:10.5552627Z (26/10/2026 22:13:10 America/New_York). Comando: serve default.project.json --address 127.0.0.1 --port 34872. Endpoint local /api/rojo respondeu com serverVersion 7.7.1 e projectName CumbiaParty_V2_Trabalho. Consulta posterior de listener por Get-NetTCPConnection retornou Access denied; confirmação de disponibilidade foi pela resposta HTTP, não por essa consulta.
- [NÃO ENCONTRADO] Aguardando prévia detalhada do dono e posterior “aceitei”. Se a propriedade da raiz não estiver visível, avisar antes do aceite; rejeitar detalhe insuficiente, remoção/substituição fora dos 24 scripts ou mudança de ArchitectureVersion. DEPOIS, efeito no game.Name, critério pós-sync, Play, desconexão, fechamento sem salvar e encerramento do PID ainda NÃO TESTADOS/não realizados nesta etapa.

### Snapshot ANTES — SHA-256 dos 24 Sources

| Estado | Caminho Studio | Bytes | SHA-256 |
|---|---|---:|---|
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController | 5663 | 4848a77f8cc666fac73f912dcec04c05e7f7267a357455581db0d31ef3694fa5 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD | 10500 | 11ec855fb26b6f2182cbd7de180b50a6582f5c63c683e5a4b9595072a0290019 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattlePresentationView | 10430 | 743535107a5a906784b9e5a94eb2348e566e2d4feace4644542f9d3db5dd22d6 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait | 1605 | 5bce4720c123a800d2ecb52b6dfe271ae49b858877fb83ef9eaae3e70f3f7adc |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController | 6263 | 0933aaa503e55abd7e0938b3d0925f4e78100f952d4d7dcda56b1f50320140e8 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.LobbyController | 4329 | cdc30647bcfc85a7ee4f59aeaf50308f716f6218d847f422ff20b68da7c8d1f7 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.TournamentController | 8500 | 3db4187efd8e172795c7121ebcad077a37329203762df6665de3dcb2d0caf28f |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController | 14409 | 19dda8ca889b241c230c971fac8da728758ee8e47178c0af252477be09d0a1e4 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap | 6188 | 67568128d427f254e4dc30a40d979b550d33bbf4473820e27bc818929941dd21 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.ArenaService | 12216 | 7f6629b1b9529189e8ab9ed0163be43405ea39e5983364863066e81587a2e142 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.BattleService | 10446 | b2384aa78986b30f26443c933e4112d26300b92b90a929c1baf98eb18dd039ca |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.BotService | 2779 | c8542295c0f28d08a1c17d0af1741a844edd8e3d0c01e8f5667b4dc0e1a58c47 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.CompetitorService | 2029 | d58bfb6bf98266dd9c02f087757ecdfcb81cb9adc53df6834eb21de5d829eba8 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.LobbyService | 6171 | 73c5b253ef261abd6c51085f4f75601fd81d5a40685db540608465d0c00de272 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.RhythmService | 9122 | 5fc8494c77a5178ce2735c8d901b6bbf39be20e8401eaaff2cae72a2bbf95f86 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.TournamentService | 14884 | 650eb4ca3294ef8bdfcfdf5e30e920bd537fdcd788406fcd24098e5ba7dac23d |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WaveGenerator | 2227 | 3670f60acbc001852c7f3c860d87c52ab121fe4e50962764c901eff4e6031093 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WorldBindings | 10877 | edd7233145490ef190041c7516aef14d0d21357861a3f122ee3e2537ce0857bc |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Validation.NoteValidator | 1978 | 5399120305f12d3ca7673802101635204860c2242c5b8d289734bf3cf8696b3e |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.ServerBootstrap | 4375 | 1baa4e9f146362bd92fbe38c9e77fabb260acdf3a7a99a6acf6d90c84bd60771 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig | 1414 | f9276d6ed30d91fb79bce7844d1964bfbc7c36cdd421556e81ef8b33e03e1ae3 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.GameConfig | 4449 | 7e55816a5e52454aeb339a12812e963765114d9116f1be593761a03d133fca09 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.NetworkTypes | 2430 | 3d1b601b16332855d11807054c05c8da5cbdf8eeb2f988d30782a74c3d4d8ba6 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.WorldConfig | 8811 | 242b3caee54351343f174163d588ca8283a132317131b6448bf1d5f36225fd69 |

### Snapshot ANTES — estrutura

| Estado | Raiz | Registros | SHA-256 (path,class,children) |
|---|---|---:|---|
| [CONFIRMADO NO CÓDIGO] | Lighting | 7 | 80a0ab234e943e8aeb3c7322ae81dce2aebf07b1b9d86dca7f6b8b32d8da05e1 |
| [CONFIRMADO NO CÓDIGO] | MaterialService | 1 | 3781904bda97d3c084e4b58c75cf20fa0940282a3a4a184dbf61ff21e6e0173d |
| [CONFIRMADO NO CÓDIGO] | ReplicatedFirst | 1 | 7686dd90729420081210da5ef8f7f4a794c209f9aab31a8ccb1455cbe0742e27 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage | 17 | 8d1f3e0ada18501164aa1a03c2473b4e668b95a8c18acbb70825866f047c6205 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService | 16 | a89e0491d3f196ca262534aae42d2b7a023ace573ef939a8bce3d8f371bf1446 |
| [CONFIRMADO NO CÓDIGO] | ServerStorage | 9094 | 31b437bcd8bc2b7bece80ad14e34da04869acc3233580ffe4c32539c9d9f66bb |
| [CONFIRMADO NO CÓDIGO] | SoundService | 1 | 0713cbbc593d42379b87710943abbb13515edafd712d7393bdc32593006cd74c |
| [CONFIRMADO NO CÓDIGO] | StarterGui | 76 | 8bf1c9633ac0bd60014a0bbaf7c061f83381be89bdf88377286bc8a8a55e2920 |
| [CONFIRMADO NO CÓDIGO] | StarterPack | 1 | 67d48d23d0d932eef2d26ac991e29cf9b2bff602a598116a65f9256cba340989 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer | 15 | 8d9788defb7fda1050fc7cb054c31c1cb1f64f22e8681c5aa4fd66b7504cd50e |
| [CONFIRMADO NO CÓDIGO] | Teams | 1 | ad488d7a2c5e798ebc53df334800af538cc721d51666f65f4ba89cbb27342467 |
| [CONFIRMADO NO CÓDIGO] | TextChatService | 9 | 54346434b70bfea23e4155f9b4648f68860fbd04d9d6f893ab1fe0ab060dbedd |
| [CONFIRMADO NO CÓDIGO] | Workspace | 1497 | 7ef386b54c75532331a0240b6a106fbd4dea178f1f1b4e69f421eaf31e320f98 |

### CP2-000e-7b — Após o aceite e Play (27/10/2026)

- [SUPOSIÇÃO] Dono informou que as dez entradas de scripts da prévia exibiam Property Source e depois declarou “aceitei”. Capturas fornecidas mostraram a lista com uma edição na raiz e dez em scripts, detalhe da raiz Name Current “CumbiaParty_V2_Descartavel.rbxl” → Incoming “CumbiaParty_V2_Trabalho”, e um diff de Source compatível com a remoção de CR. A declaração sobre os outros detalhes é relato do dono; o agente não capturou todas as dez linhas Property.
- [CONFIRMADO NO CÓDIGO] MCP manteve sessão única Descartavel em Edit. game.Name DEPOIS, texto exato: `CumbiaParty_V2_Trabalho`, em 2026-10-27T04:22:52Z (27/10/2026 00:22:52 America/New_York). ANTES foi `CumbiaParty_V2_Descartavel.rbxl`. A sincronização renomeou a raiz em Edit para o name do JSON neste ensaio. O arquivo da sessão continuou CumbiaParty_V2_Descartavel.rbxl.
- [CONFIRMADO NO CÓDIGO] 14/24 Sources mantiveram SHA-256 e bytes exatos; os outros dez são exatamente os caminhos fechados da -5a e, após remover CR do Source ANTES, coincidem integralmente com o DEPOIS. Nenhuma outra diferença de Source. Os SHA-256 DEPOIS desses dez coincidiram com a tabela histórica da -5a. Classes, caminhos, atributos vazios, filhos dos 24 scripts, Disabled/RunContext e os 11 ancestrais coincidiram integralmente; ArchitectureVersion number 3 nas três pastas. Um bootstrap habilitado por lado; UnitTestRunner e CumbiaPartyFestivalFX desabilitados. Estrutura completa das 13 raízes: 10736 caminhos/classes/contagens idênticos ao ANTES, inclusive objetos fora do mapa Rojo.
- [CONFIRMADO NO CÓDIGO] Play curto iniciado e parado pelo MCP, com retorno a Edit. Output consultado: as mesmas duas mensagens de inicialização da -6 e três avisos ContentId rbxassetid://203785492 de tipo incompatível; também mensagens do plugin Assistant sobre restauração de CameraType após execute_luau. Um jogador observado; nove RemoteEvents não recontados nesta rodada. No Client de Play, game.Name retornou `CumbiaParty_V2_Descartavel.rbxl`; no Server de Play, `Game`. Esses DataModels de runtime não substituem a leitura da raiz em Edit para o ensaio do renome.
- [CONFIRMADO NO CÓDIGO] TORNEIO abriu painel; Join mudou de 0/8 para 1/8 e iniciou contagem; batalha iniciou com câmera Scriptable; entradas D/F/J/K geraram feedback (inclusive Fora do tempo), Perfect 1, Miss 1 e 1000 pontos em uma leitura. Torneio avançou até onda 8, mostrou `TORNEIO CONCLUÍDO • 8 competidores`, campeão bot Dante Rio e `Encerramento: KO`. VOLTAR fechou painel e restaurou LobbyHUD e câmera Custom. Comparado à -6: mesmo roteiro principal e KO (onda 8 como rodada B); nenhum erro novo do jogo observado no Output consultado.
- [NÃO ENCONTRADO] NÃO TESTADO: propriedades completas dos objetos externos, .rbxl salvo, persistência do renome, respawn, saída antecipada da fila, múltiplos humanos, validação interna de resultados no servidor, suíte UnitTest, mobile, segurança, desempenho e memória. A janela do Output pode não conter mensagens antigas. Desconexão, fechamento sem salvar e encerramento exclusivo do PID 2576 pendentes de relato do dono.

| Estado | Caminho Studio com CR removido | SHA-256 DEPOIS |
|---|---|---|
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController | 01bd555a35b80c463989935013c2968fece19e349cd435fb6f987a2b8c9c920d |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD | a97035931a6715be9693ee1be018ade0693dfba8ba3cee4a48270ca56c2e1de8 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap | 46ae61050bbcf38feb78c62861b3399fb3df096f6d27cddfb1dc949952721c41 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.ArenaService | ac43050443af55f2aea859860cb6a8904e8a7d21ab9daf52a46e0a00adbd1e48 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.LobbyService | 8a44ed450f504ff4c569be8bb97f7a0d4589a116ea2adaaddf706145a6ee4e6b |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.TournamentService | 853437a364575a032d3ea67f36c6519ccf763b9d1f69eaf7b4a395f90c360bbf |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WorldBindings | f540e3b7064fa6a62174a8a37aa2ce7a3fc9f40c6a55bcc0eda53cffa7fbacc2 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.ServerBootstrap | 5b99966d4956602c48aab484f8684dfcf24a054dedbb741a98de63d1f8fb6528 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.NetworkTypes | 19a4f59153189a20f72a7001570664ba97fe685f1e51e20b0405969aaf0267ae |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.WorldConfig | 53dd4209c385f4e324cf120c085f433b871f2178cdff25126c1a0b6cd57bd1ff |

### CP2-000e-7b — Encerramento do ensaio (27/10/2026)

- [SUPOSIÇÃO] Dono informou “pronto” após instrução para desconectar Rojo e fechar CumbiaParty_V2_Descartavel.rbxl sem salvar. A desconexão, o fechamento efetivo e a ausência de salvamento são relato do dono; não foram verificados independentemente no arquivo .rbxl.
- [CONFIRMADO NO CÓDIGO] list_roblox_studios não apresentou mais sessão identificada como CumbiaParty_V2_Descartavel.rbxl; retornou uma entrada com name null. Essa listagem não prova, sozinha, que não há Studio aberto.
- [CONFIRMADO NO CÓDIGO] Antes de encerrar, Get-Process confirmou PID 2576, caminho exato C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe e início 2026-10-27T02:13:10.5552627Z. Stop-Process -Id 2576 encerrou exclusivamente esse processo; consulta imediata confirmou ausência do PID.
- [CONFIRMADO NO CÓDIGO] Nenhum salvamento do place, commit, syncback, escrita direta no Studio ou alteração de ActiveProfileId foi executado pelo agente. CP2-000e-7 permanece INTERROMPIDA; CP2-000e-8 PENDENTE. A prova -7b concluiu somente o efeito de name na descartável e seu roteiro funcional.
- [NÃO ENCONTRADO] Persistência do .rbxl salvo e comprovação independente do fechamento sem salvar continuam NÃO TESTADOS.


## CP2-000e-7 — Retomada na cópia de trabalho (27/10/2026)

- [SUPOSIÇÃO] Dono aprovou plano e execução somente em CumbiaParty_V2_Trabalho.rbxl; -6 aceita em 25/10 com lacunas, sem cópia pre-rojo, retorno pre-migracao NÃO TESTADO e anterior ao V2_Trabalho, risco aceito. -7b concluída; -8 permanece PENDENTE. Sem salvamento, commit, syncback, escrita direta no Studio ou troca de ActiveProfileId para Tropical.
- [CONFIRMADO NO CÓDIGO] Sessão MCP única 41426914-7cf1-401e-b517-c0560dceb223 identificada por arquivo CumbiaParty_V2_Trabalho.rbxl, em Edit. game.Name ANTES, texto exato: `CumbiaParty_V2_Trabalho.rbxl`, em 2026-10-27T04:37:58Z (27/10/2026 00:37:58 America/New_York), reconfirmado em 2026-10-27T04:40:15Z antes de Connect/aceite.
- [CONFIRMADO NO CÓDIGO] 24/24 SHA-256 dos Sources ANTES iguais ao disco e à tabela original da descartável: 162095 bytes, 14 sem CR e dez com CR. Classes corretas, atributos vazios, zero filhos nos 24 scripts. Os 11 ancestrais coincidem em classe, contagem e atributos com o baseline; ArchitectureVersion number 3 nas três pastas. Um bootstrap habilitado por lado de execução; UnitTestRunner e CumbiaPartyFestivalFX desabilitados, todos Legacy; cópias em ServerStorage inventariadas separadamente.
- [CONFIRMADO NO CÓDIGO] Estrutura recapturada em lotes: 10736 registros nas 13 raízes, caminhos/classes/contagens conservados em memória. Contagens iguais à referência original e hashes com serialização path,class,children iguais à tabela ANTES da -7b. Transferências ao buffer que excederam o limite de 64000 bytes foram rejeitadas; concluídas em lotes menores e consolidação conferida. Nenhum Source executado/requerido.
- [CONFIRMADO NO CÓDIGO] JSON somente lido, name CumbiaParty_V2_Trabalho, SHA-256 79a3bdce9457c0a2f71797eb6b785e590f81cc33acff3573c552d3f7122f9024. Rojo iniciado: PID 36684; executável C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe; início 2026-10-27T04:40:14.9876543Z (27/10/2026 00:40:14 America/New_York); serve default.project.json --address 127.0.0.1 --port 34872.
- [NÃO ENCONTRADO] Aguardando prévia do dono e “aceitei”: esperado Name da raiz + dez Sources. game.Name DEPOIS ainda não capturado. NÃO TESTADO nesta retomada: pós-sync, Play, propriedades completas externas, persistência do place, respawn, saída de fila, múltiplos humanos, UnitTest, mobile, segurança e desempenho. Desconexão e encerramento do PID ainda pendentes.

### SHA-256 ANTES desta retomada

| Estado | Caminho | Bytes | SHA-256 |
|---|---|---:|---|
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.ArenaController | 5663 | 4848a77f8cc666fac73f912dcec04c05e7f7267a357455581db0d31ef3694fa5 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattleHUD | 10500 | 11ec855fb26b6f2182cbd7de180b50a6582f5c63c683e5a4b9595072a0290019 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.BattlePresentationView | 10430 | 743535107a5a906784b9e5a94eb2348e566e2d4feace4644542f9d3db5dd22d6 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.CompetitorPortrait | 1605 | 5bce4720c123a800d2ecb52b6dfe271ae49b858877fb83ef9eaae3e70f3f7adc |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.InputController | 6263 | 0933aaa503e55abd7e0938b3d0925f4e78100f952d4d7dcda56b1f50320140e8 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.LobbyController | 4329 | cdc30647bcfc85a7ee4f59aeaf50308f716f6218d847f422ff20b68da7c8d1f7 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.TournamentController | 8500 | 3db4187efd8e172795c7121ebcad077a37329203762df6665de3dcb2d0caf28f |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.Controllers.UIController | 14409 | 19dda8ca889b241c230c971fac8da728758ee8e47178c0af252477be09d0a1e4 |
| [CONFIRMADO NO CÓDIGO] | StarterPlayer.StarterPlayerScripts.CumbiaParty.ClientBootstrap | 6188 | 67568128d427f254e4dc30a40d979b550d33bbf4473820e27bc818929941dd21 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.ArenaService | 12216 | 7f6629b1b9529189e8ab9ed0163be43405ea39e5983364863066e81587a2e142 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.BattleService | 10446 | b2384aa78986b30f26443c933e4112d26300b92b90a929c1baf98eb18dd039ca |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.BotService | 2779 | c8542295c0f28d08a1c17d0af1741a844edd8e3d0c01e8f5667b4dc0e1a58c47 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.CompetitorService | 2029 | d58bfb6bf98266dd9c02f087757ecdfcb81cb9adc53df6834eb21de5d829eba8 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.LobbyService | 6171 | 73c5b253ef261abd6c51085f4f75601fd81d5a40685db540608465d0c00de272 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.RhythmService | 9122 | 5fc8494c77a5178ce2735c8d901b6bbf39be20e8401eaaff2cae72a2bbf95f86 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.TournamentService | 14884 | 650eb4ca3294ef8bdfcfdf5e30e920bd537fdcd788406fcd24098e5ba7dac23d |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WaveGenerator | 2227 | 3670f60acbc001852c7f3c860d87c52ab121fe4e50962764c901eff4e6031093 |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Services.WorldBindings | 10877 | edd7233145490ef190041c7516aef14d0d21357861a3f122ee3e2537ce0857bc |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.Validation.NoteValidator | 1978 | 5399120305f12d3ca7673802101635204860c2242c5b8d289734bf3cf8696b3e |
| [CONFIRMADO NO CÓDIGO] | ServerScriptService.CumbiaParty.ServerBootstrap | 4375 | 1baa4e9f146362bd92fbe38c9e77fabb260acdf3a7a99a6acf6d90c84bd60771 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.BattlePresentationConfig | 1414 | f9276d6ed30d91fb79bce7844d1964bfbc7c36cdd421556e81ef8b33e03e1ae3 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.GameConfig | 4449 | 7e55816a5e52454aeb339a12812e963765114d9116f1be593761a03d133fca09 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.NetworkTypes | 2430 | 3d1b601b16332855d11807054c05c8da5cbdf8eeb2f988d30782a74c3d4d8ba6 |
| [CONFIRMADO NO CÓDIGO] | ReplicatedStorage.CumbiaParty.Shared.WorldConfig | 8811 | 242b3caee54351343f174163d588ca8283a132317131b6448bf1d5f36225fd69 |

### CP2-000e-7 — Aceite e conferência DEPOIS (27/10/2026)

- [SUPOSIÇÃO] Dono forneceu captura parcial da prévia, confirmou que todos os scripts mostravam Source e declarou “aceitei”. Captura mostrou Name Current CumbiaParty_V2_Trabalho.rbxl → Incoming CumbiaParty_V2_Trabalho e Source em NetworkTypes; os demais detalhes de Source são relato do dono. A imagem não mostrava integralmente o final da lista.
- [CONFIRMADO NO CÓDIGO] Sessão única manteve arquivo CumbiaParty_V2_Trabalho.rbxl e Edit. game.Name DEPOIS, texto exato: `CumbiaParty_V2_Trabalho`, em 2026-10-27T04:43:36Z (27/10/2026 00:43:36 America/New_York). ANTES: `CumbiaParty_V2_Trabalho.rbxl`.
- [CONFIRMADO NO CÓDIGO] 14/24 SHA-256 exatos; dez Sources iguais após remover CR do ANTES, nos mesmos caminhos e com hashes DEPOIS iguais à -5a/-7b. Classes, atributos, filhos e execução dos scripts preservados. Os 11 ancestrais e inventário de execução coincidem; ArchitectureVersion number 3 nas três pastas, um bootstrap por lado, runner e FX desabilitados. Comparação integral dos 10736 registros nas 13 raízes confirmou igualdade de caminho, classe e contagem de filhos, inclusive fora do mapa Rojo.

### CP2-000e-7 — Play curto e pendência de desconexão (27/10/2026)

- [CONFIRMADO NO CÓDIGO] Play iniciado e parado via MCP; retorno a Edit confirmado. Servidor apresentou um jogador e nove filhos em Remotes. Output consultado mostrou as duas mensagens de bootstraps prontos e três avisos ContentId rbxassetid://203785492 de tipo incompatível, iguais aos registros -6/-7b; nenhum erro adicional observado no Output consultado.
- [CONFIRMADO NO CÓDIGO] TORNEIO abriu painel; Join mudou fila de 0/8 para 1/8 com contagem. Batalha iniciou com câmera Scriptable. Entradas D/F/J/K enviadas; leituras mostraram Miss e Broken Hold, zero pontos e nenhum acerto confirmado nesta rodada. Torneio chegou a TORNEIO CONCLUÍDO • 8 competidores, campeã bot Luna Sol, jogador eliminado e resumo Encerramento: KO na onda 7. VOLTAR fechou painel, exibiu LobbyHUD e restaurou câmera Custom.
- [SUPOSIÇÃO] Comparação com -6/-7b: nenhuma regressão observada no roteiro executado; onda 7 coincide com rodada A da -6, enquanto B/-7b registraram onda 8. Diferenças de campeão, onda e notas não demonstram equivalência nem regressão de julgamento, pois entradas não tiveram tempo controlado. Resultado interno do servidor não foi validado.
- [NÃO ENCONTRADO] NÃO TESTADO: persistência do .rbxl/renome salvo, propriedades completas dos objetos externos, respawn, saída antecipada da fila, múltiplos humanos, notas em tempo controlado, validação interna dos bots/resultados, UnitTest, mobile, segurança, desempenho e memória. Output pode não incluir mensagens fora de sua retenção. Desconexão pelo dono e encerramento exclusivo do PID 36684 ainda PENDENTES; -8 continua PENDENTE.
- [CONFIRMADO NO CÓDIGO] Agente não salvou place, não fez commit/syncback/escrita direta no Studio e não alterou ActiveProfileId. Somente os três documentos autorizados foram editados.

### CP2-000e-7 — Encerramento da execução (27/10/2026)

- [SUPOSIÇÃO] Dono informou “desconectei”. Desconexão registrada como relato do dono, sem verificação independente do painel Rojo.
- [CONFIRMADO NO CÓDIGO] Antes de encerrar, Get-Process confirmou PID 36684, executável C:\Users\Thiago-PC1\.rokit\tool-storage\rojo-rbx\rojo\7.7.1\rojo.exe e início exato 2026-10-27T04:40:14.9876543Z. Stop-Process -Id 36684 encerrou exclusivamente esse processo; consulta imediata confirmou ausência do PID em 2026-10-27T04:49:49.3849086Z (27/10/2026 00:49:49 America/New_York).
- [CONFIRMADO NO CÓDIGO] Execução autorizada da -7 encerrada após comparação ANTES/DEPOIS e Play curto, com retorno a Edit. Agente não salvou o place, não fez commit e não operou o painel Rojo. Escrita restrita aos três documentos autorizados.
- [SUPOSIÇÃO] Aceite final da transferência continua decisão do dono; CP2-000e-8 permanece PENDENTE. Registros históricos de -7 interrompida e pendências de desconexão acima descrevem momentos anteriores e são sucedidos por esta execução.
- [NÃO ENCONTRADO] NÃO TESTADO: persistência do place/renome salvo, comprovação independente de ausência de salvamento pelo dono, propriedades completas externas, respawn, saída antecipada da fila, múltiplos humanos, julgamento controlado e resultados internos, UnitTest, mobile, segurança, desempenho e memória.
