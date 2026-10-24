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
- [SUPOSIÇÃO] Veredito: fidelidade binária e prova dos blobs satisfeitas 24/24; aceite integral não declarado devido às referências Tropical ausentes. O perfil ativo ser Underground não autoriza ignorar a divergência ou avançar às etapas -4 a -8.
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
