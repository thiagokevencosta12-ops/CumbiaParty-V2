# Game Design: Cumbia Party V2

## Conceito
Campeonato de tecladistas no Roblox. Jogadores competem em minigames de
ritmo ao som de cumbia. Sensação central: competição e adrenalina.

## Loop principal
Lobby → escolhe um dos três minigames → entra na fila → joga conforme
as regras do minigame → campeão → volta ao lobby.

## Direção visual
- Underground. O greybox atual (CumbiaBattleWorld) é a base.
- O cenário tropical da V1 fica preservado como Referência e não entra
  na V2.

## Regras gerais
- Cada partida tem 8 participantes. Bots entram só para completar as
  vagas que faltarem (ex.: 3 jogadores = 5 bots).
- O SERVIDOR decide todos os resultados (notas, dano, pontuação,
  eliminação, quem sentou primeiro). O cliente nunca decide.
- Eliminado volta ao lobby.
- Teclas oficiais dos minigames de ritmo (X1 e Sobrevivência): A/S/D/F.
  A V1 usava D/F/J/K; a mudança é um requisito novo da V2.
- [PÓS-MVP] Espectador: o eliminado pode ir ao minigame assistir e
  escolher ver a tela de um jogador.

## Minigame 1: Torneio X1 (MVP)
- Batalha de ritmo 1x1 em chave de eliminação, 8 participantes.
- Quatro colunas (teclas A/S/D/F e toque no celular).
- Janelas de acerto: Perfect / Good / Miss.
- Vence quem zerar o HP do adversário.
- [A CONFIRMAR, vem da auditoria da V1] 100 HP por jogador, desempate
  aleatório.
- [NÃO DECIDIDO] dano de cada nota (Perfect/Good), o que acontece se a
  música acabar com os dois vivos, duração da batalha, nível dos bots.

## Minigame 2: Dança das Cadeiras
- Jogadores correm em círculo ao redor das cadeiras, em uma só direção.
- Controle: velocidade normal ou corridinha leve (não usa A/S/D/F).
- Corridinha usa ESTAMINA: ao esgotar, é preciso esperar recarregar.
- O sistema escolhe a música, inverte o sentido e para a música em
  momentos aleatórios.
- Ao parar, quem senta primeiro na cadeira fica com ela (o servidor
  decide a ordem).
- Quem fica sem cadeira é eliminado.
- Cada rodada remove uma cadeira. Fim: dos dois últimos, só um senta e
  é campeão.
- Câmera mostra o círculo inteiro.
- Inspiração apenas na mecânica; arte e personagens próprios.
- [NÃO DECIDIDO] valores da estamina, intervalo da parada aleatória e se
  há aviso, tempo de reação dos bots, empate técnico no clique.

## Minigame 3: Sobrevivência
- 8 tecladistas em um octógono, todos tocam o MESMO chart ao mesmo tempo.
- Quatro colunas (teclas A/S/D/F e toque no celular), iguais ao X1.
- A pontuação ZERA a cada onda.
- Ao fim da onda, é eliminado quem MAIS ERROU. Conta como erro: nota com
  Miss e aperto de tecla fora do tempo.
- Desempate: 1) menos Perfect; 2) menos Good; 3) sorteio.
- A dificuldade sobe a cada onda.
- Repete até sobrar um campeão.
- [NÃO DECIDIDO] como a dificuldade sobe, duração da onda, nível dos
  bots.

## Música
- Fonte: faixas geradas no Mureka, plano com licença comercial.
- Tipo de direito: LICENÇA DE USO, válida SÓ enquanto o plano estiver
  ativo (não continua após o cancelamento).
- Consequência: a assinatura é custo contínuo enquanto o jogo estiver
  publicado; antes de cancelar, remover ou substituir as faixas.
- Confirmado pelo dono: uso comercial em jogo permitido; cobre faixas
  geradas antes do plano; sem restrição de plataforma/monetização.
- [A CONFIRMAR ANTES DE PUBLICAR] o que os termos dizem exatamente
  sobre áudio de referência e se o método atual os respeita.
- Trilha final: gerar por descrição de estilo, sem enviar faixas
  existentes. Faixas atuais só para protótipo.
- Testes iniciais usam som provisório ou metrônomo.
- Guardar por faixa: arquivo, prompt, data e plano; cópia dos termos.
- Trocar a música exige refazer o chart.

## Fora do escopo por enquanto
- Minigame 4 (Score Attack da V1 fica como Referência)
- Loja, roleta e itens cosméticos
- Monetização e progresso persistente
- Espectador (pós-MVP)

## Pendências gerais
- Público e dispositivos-alvo
- Música: ver seção "Música" (direitos pendentes de confirmação)
- Níveis de habilidade dos bots