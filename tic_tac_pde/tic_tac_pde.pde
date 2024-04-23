boolean vsComputerButton = false;
boolean vsPlayerButton = false;
boolean gameStarted = false;

int[][] board = new int[3][3];
int currentPlayer = 1; // 1 para jogador X, -1 para jogador O, 0 para o computador
boolean gameover = false;
PFont font;
Button restartButton; // Botão

void setup() {
  size(300, 350);
  font = createFont("Arial", 32);
  textFont(font);
  textAlign(CENTER, CENTER);
  
  // Inicializa o botão de reinício
  restartButton = new Button(width/2 - 50, height - 50, 100, 30, "Reiniciar");
}

void draw() {
  background(255);
  
  if (!gameStarted) {
    displayOptions();
  } else {
    playGame();
  }
  
  //botão de reinício 
  if (gameover) {
    restartButton.display();
  }
}

void displayOptions() {
  fill(200);
  rect(50, 100, 200, 50);
  fill(0);
  text("computador", width/2, 125);
  
  fill(200);
  rect(50, 200, 200, 50);
  fill(0);
  text("jogador", width/2, 225);
}

void playGame() {
  drawBoard();
  
  int result = checkWinner();
  if (result != 0) {
    String resultString = (result == 1) ? "Jogador X venceu!" : (result == -1) ? "Jogador O venceu!" : "Empate!";
    fill(255,0,0);
    text(resultString, width/2, height/2);
    gameover = true;
  } else if (currentPlayer == -1 && vsComputerButton) { // Verifica se é a vez do computador jogar
    computerMove(); // Chama a função para o computador fazer sua jogada
  }
}

void drawBoard() {
  stroke(0);
  strokeWeight(4);
  for (int i = 1; i < 3; i++) {
    line(i * width/3, 0, i * width/3, height);
    line(0, i * height/3, width, i * height/3);
  }
  
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      int x = i * width/3 + width/6;
      int y = j * height/3 + height/6;
      if (board[i][j] == 1) {
        drawX(x, y);
      } else if (board[i][j] == -1) {
        drawO(x, y);
      }
    }
  }
}

void drawX(int x, int y) {
  int size = width/6;
  line(x - size, y - size, x + size, y + size);
  line(x + size, y - size, x - size, y + size);
}

void drawO(int x, int y) {
  int size = width/6;
  noFill();
  ellipse(x, y, size * 2, size * 2);
}

void mousePressed() {
  if (!gameStarted) {
    if (mouseX > 50 && mouseX < 250) {
      if (mouseY > 100 && mouseY < 150) {
        vsComputerButton = true;
        gameStarted = true;
        currentPlayer = 1;
        resetBoard(); // Inicializa o tabuleiro
      } else if (mouseY > 200 && mouseY < 250) {
        vsPlayerButton = true;
        gameStarted = true;
        currentPlayer = 1;
        resetBoard(); // Inicializa o tabuleiro
      }
    }
  } else {
    if (!gameover) { // Permitir jogadas enquanto o jogo não acabou
      int x = int((mouseX + 0.5) / (width / 3));
      int y = int((mouseY + 0.5) / (height / 3));
      
      if (x >= 0 && x < 3 && y >= 0 && y < 3 && board[x][y] == 0) {
        board[x][y] = currentPlayer;
        currentPlayer *= -1; // Alterna o jogador atual
      }
    } else if (restartButton.isClicked(mouseX, mouseY)) {
      // Se o botão de reinício for clicado, reinicie o jogo
      resetBoard();
      gameover = false;
    }
  }
}

int checkWinner() {
  // Verifica linhas e colunas
  for (int i = 0; i < 3; i++) {
    if (board[i][0] != 0 && board[i][0] == board[i][1] && board[i][0] == board[i][2]) {
      return board[i][0];
    }
    if (board[0][i] != 0 && board[0][i] == board[1][i] && board[0][i] == board[2][i]) {
      return board[0][i];
    }
  }
  
  // Verifica diagonais
  if (board[0][0] != 0 && board[0][0] == board[1][1] && board[0][0] == board[2][2]) {
    return board[0][0];
  }
  if (board[2][0] != 0 && board[2][0] == board[1][1] && board[2][0] == board[0][2]) {
    return board[2][0];
  }
  
  // Verifica empate
  boolean full = true;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        full = false;
        break;
      }
    }
  }
  if (full) {
    return 2; // Empate
  }
  
  return 0; // Jogo não acabou
}

void resetBoard() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      board[i][j] = 0;
    }
  }
  gameover = false;
}

void computerMove() {
  // Lista para armazenar todas as células vazias
  ArrayList<PVector> emptyCells = new ArrayList<PVector>();
  
  // Encontra todas as células vazias
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        emptyCells.add(new PVector(i, j)); // Adiciona a célula vazia à lista
      }
    }
  }
  
  // Escolhe uma célula aleatória da lista de células vazias
  if (emptyCells.size() > 0) {
    int index = int(random(emptyCells.size()));
    PVector cell = emptyCells.get(index);
    int x = int(cell.x);
    int y = int(cell.y);
    
    // Faz a jogada do computador
    board[x][y] = -1; // Marca como O
    currentPlayer = 1; // Define a vez do jogador humano
  }
}

// Classe para o botão
class Button {
  float x, y; // Posição do botão
  float w, h; // Largura e altura do botão
  String label; // Texto do botão
  
  // Construtor
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w * 2;
    this.h = h;
    this.label = label;
  }
  
  // Exibe o botão
  void display() {
    stroke(200); //0
    fill(200);
    rect(x, y, w, h);
    fill(0);
    text(label, x + w/2, y + h/2);
  }
  
  // Verifica se o botão foi clicado
  boolean isClicked(float mouseX, float mouseY) {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}
