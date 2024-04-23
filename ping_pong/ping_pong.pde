//Variáveis para o posicionamento da bola
int ballX, ballY;
int ballSize = 10;
int ballSpeedX = 3;
int ballSpeedY = 3;
//Variáveis para o posicionamento das palhetas do jogador
int playerPaddleX, playerPaddleY;
int playerWidth = 10;
int playerHeight = 40;
int playerSpeedY = 0;
//Variáveis para o posicionamento das palhetas do adversário
int cpuPaddleX, cpuPaddleY;
int cpuWidth = 10;
int cpuHeight = 100;
int cpuSpeedY = 0;
//Variáveis para marcar a pontuação
int scorePlayer;
int scoreCPU;

//Função de inicialização
void setup() {
  //Determinar o tamanho e a cor de fundo da tela
  size(640, 360);
  background(0);
  //Atribui posição inicial da bola
  ballX = width / 2;
  ballY = height / 2;
  //Atribui posição inicial da palheta do jogador
  playerPaddleX = 10;
  playerPaddleY = height / 2 - 50;
  //Atribuir posição inicial da palheta do adversário
  cpuPaddleX = width - 20;
  cpuPaddleY = height / 2 - 50;
  //Determina o tamanho da fonte do texto
  textSize(32);
}

//Função de repetição
void draw() {
  //Atualiza a cor de fundo toda vez que a tela for desenhada
  background(0);
  //Chamadas de função para execução do jogo
  score();
  ballMovement();
  cpuPaddle();
  playerPaddle();
  // Desenha a bola
  noStroke();
  fill(255);
  ellipse(ballX, ballY, ballSize, ballSize);
}

//Função da movimentação da bola
void ballMovement() {
  //Atualização da posição da bola
  ballX = ballX + ballSpeedX;
  ballY = ballY + ballSpeedY;
  //Verificação da colisão da bola com as extremidades laterais
  if (ballX > width) {
    ballX = width / 2;
    ballY = height / 2;
    ballSpeedX = ballSpeedX * -1;
    scorePlayer += 1;
  }
  if (ballX < 0) {
    ballX = width / 2;
    ballY = height / 2;
    ballSpeedX = ballSpeedX * -1;
    scoreCPU += 1;
  }
  //Verificação da colisão da bola com as extremidades superior e inferior da tela
  if (ballY > height) {
    ballY = height - ballSize / 2;
    ballSpeedY = ballSpeedY * -1;
  }
  if (ballY < 0) {
    ballY = ballSize / 2;
    ballSpeedY = ballSpeedY * -1;
  }
}

//Função da palheta do adversário
void cpuPaddle() {
  //Atualizando a posição da palheta do adversário
  cpuPaddleY = cpuPaddleY + cpuSpeedY;
  
  //Verificação da colisão da bola com a palheta do adversário
  if (ballX + ballSize / 2 >= cpuPaddleX && ballX - ballSize / 2 <= cpuPaddleX + cpuWidth &&
      ballY + ballSize / 2 >= cpuPaddleY && ballY - ballSize / 2 <= cpuPaddleY + cpuHeight) {
    ballSpeedX = -ballSpeedX; // Inverte a direção da bola
    ballX = cpuPaddleX - ballSize / 2; // Corrige a posição da bola para que ela não fique presa na palheta
  }
  
  //Criação do comportamento da palheta inimiga
  if (ballX > width / 2) {
    if (ballY - ballSize > cpuPaddleY + cpuHeight / 2) {
      cpuSpeedY = 2;
    } else if (ballY + ballSize < cpuPaddleY + cpuHeight / 2) {
      cpuSpeedY = -2;
    } else {
      cpuSpeedY = 0;
    }
  } else {
    cpuSpeedY = 0;
  }
  
  //Limitação dos movimentos da palheta dentro do espaço da tela
  if (cpuPaddleY + cpuHeight > height) {
    cpuPaddleY = height - cpuHeight;
  }
  if (cpuPaddleY < 0) {
    cpuPaddleY = 0;
  }
  
  // Desenha a palheta do adversário
  noStroke();
  fill(255);
  rect(cpuPaddleX, cpuPaddleY, cpuWidth, cpuHeight);
}

//Função da palheta do jogador
void playerPaddle() {
  //Atualizando a posição da palheta do jogador
  playerPaddleY = playerPaddleY + playerSpeedY;
  //Limitação dos movimentos da palheta dentro do espaço da tela
  if (playerPaddleY + playerHeight > height) {
    playerPaddleY = height - playerHeight;
  }
  if (playerPaddleY < 0) {
    playerPaddleY = 0;
  }
  // Desenha a palheta do jogador
  noStroke();
  fill(255);
  rect(playerPaddleX, playerPaddleY, playerWidth, playerHeight);
}

// Exibe o placar
void score() {
  fill(255);
  text(scorePlayer, 160, 50);
  text(scoreCPU, 480, 50);
}

//Verificação do pressionamento dos botões para movimentação da palheta do jogador
void keyPressed() {
  if (key == 's' || key == 'S') {
    playerSpeedY = 5;
  }
  if (key == 'w' || key == 'W') {
    playerSpeedY = -5;
  }
}

//Verificação do soltar dos botões para movimentação da palheta do jogador
void keyReleased() {
  if (key == 's' || key == 'S' || key == 'w' || key == 'W') {
    playerSpeedY = 0;
  }
}
