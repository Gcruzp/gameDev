//Declare a 3x3 grid of TicTacToeBox objects
Grid[] g = new Grid[9];

// gameStatus:
// 0 - Display Home screen
// 1 - Display Tic Tac Toe grid
// 2 - Display Game over screen
int gameStatus = 0;

// Determine which player's turn it is
int currentPlayer = 1;

class Grid {
  float x;
  float y;
  float boxSize;
  boolean leftPressed = false;
  boolean rightPressed = false;

  Grid(float x, float y, float boxSize) {
    this.x = x;
    this.y = y;
    this.boxSize = boxSize;
  }

  void display() {
    stroke(0);
    noFill();
    rect(x, y, boxSize, boxSize);
  }
}

void setup() {
  size(600, 600);
  displayHomeScreen();
  // initialize array
  float boxSize = width / 3.0;
  int id = 0;
  for (int k = 0; k < 3; k++) {
    for (int j = 0; j < 3; j++) {
      float x = j*boxSize;
      float y = k*boxSize;
      g[id] = new Grid(x, y, boxSize);
      id++;
    }
  }
}

void draw() {
  // Draw the appropriate screen based on gameStatus
  if (gameStatus == 1) {
    background(255);
    for (int i = 0; i < g.length; i++) {
      g[i].display(); // Display each object
      if (g[i].leftPressed == true) {
        text("X", g[i].x + g[i].boxSize/2, g[i].y + g[i].boxSize/2);
      }
      if (g[i].rightPressed == true) {
        text("O", g[i].x + g[i].boxSize/2, g[i].y + g[i].boxSize/2);
      }
    }
  } else if (gameStatus == 2) {
    background(0);
    displayGameOver();
  }
}

void mousePressed() {
  // Check the gameStatus and respond to mouse clicks accordingly
  if (gameStatus == 1) {
    for (int i = 0; i < g.length; i++) {
      if ((mouseX >= g[i].x) && (mouseX <= g[i].x +g[i].boxSize) && (mouseY >= g[i].y) && (mouseY <= g[i].y + g[i].boxSize)) {
        println("id =", i);
        if (mouseButton == LEFT) {
          g[i].leftPressed = true;
        }
        if (mouseButton == RIGHT) {
          g[i].rightPressed = true;
        }
      }
    }
  } else if (gameStatus == 0 && mouseX > 250 && mouseX < 350 && mouseY > 250 && mouseY < 300) {
    // Transition to the game screen when PLAY is clicked
    gameStatus = 1;
  }
}

void displayHomeScreen() {
  // Display the home screen with instructions
  background(255);
  fill(0);
  textAlign(CENTER, TOP);
  textSize(50);
  text("Tic-Tac-Toe", width/2, 100);
  textSize(25);
  fill(0);
  text("Click PLAY to start", width/2, 200);
  noFill();
  rect(250, 250, 100, 50);
  textSize(20);
  fill(0);
  text("PLAY", width/2, 265);
}

void displayGameOver() {
  // Display the game over screen with a prompt to play again
  fill(255, 0, 0);
  textAlign(CENTER, TOP);
  textSize(50);
  text("GAME OVER!", width/2, 100);
  textSize(25);
  fill(0, 0, 255);
  text("CLICK TO PLAY AGAIN", width/2, 200);
}
