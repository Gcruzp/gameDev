PFont myFont;
int numRight = 0;
int numWrong = 0;
int winner = 0;

// hangman
PImage hangman;
String[] hangmanImages = {"00.png","0.png", "1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png", "10.png"};
String imageHang = hangmanImages[numWrong];

String[] game = {"PYTHON", "JAVA", "C", "JAVASCRIPT", "RUBY", "SWIFT", "KOTLIN", "PHP", "TYPESCRIPT", "GO", "RUST", "PERL", "LUA", "R", "MATLAB", "SQL", "DART", "SCALA", "HASKELL", "ASSEMBLY", "LISP", "PROLOG", "SCHEME", "COBOL", "FORTRAN", "ADA", "TCL", "ERLANG", "ELIXIR", "CLOJURE", "JULIA", "GROOVY", "CRYSTAL", "DART", "COBOL", "SCRATCH", "LOGO", "ACTIONSCRIPT", "PERL", "BASH", "VHDL", "VERILOG", "CUDA", "LABVIEW"};
String[] animal = {"PEIXE", "GATO", "CACHORRO", "PASSARO", "LEÃO", "TIGRE", "ELEFANTE"};
String[] cidade = {"RECIFE", "OLINDA", "PORTO ALEGRE", "SAO PAULO", "RIO DE JANEIRO", "SALVADOR", "BELO HORIZONTE"};
String[] selectedDictionary;

int answerKey = 0;
String answer ="";
char guessed[];
char wrong[];
int ganhar = 0;
int perder = 0;

String display = "modo de jogo: 'L' para linguagem, 'a' para animal ou 'c' para cidade";
String display2 = "Pressione enter quando acabar";
String display3 = "";
String display4 = "Qual a letra?";
String wrongAnswers = "";

String typing = "";
String guess = "";
boolean dictionarySelected = false;

void setup() {
  size(600, 600);
  myFont = createFont("Verdana", 16, true);
}

void draw() {
  background(255);
  textFont(myFont);
  fill(0);
  
  if (!dictionarySelected) {
  text(display, 10, 200); 
  text(display2, 10, 230); 
  text(typing, 50, 260); 
} else {
  if (perder == 1) {
    background(color(255, 0, 0)); 
    text("VOCE PERDEU!", 200, 200);
  } else if (ganhar == 1) {
    background(color(0, 255, 0)); 
    text("VOCE GANHOU!", 200, 200);
  } else {
    background(255);
    text(display4, 25, 400); // Exibe display4 apenas quando não há ganhador ou perdedor
  }

    wrongAnswers = "Letras erradas: ";
    int ident = 25;
    display3 = "";

    // refresh wrong answer
    for(int i = 0; i < 11; i++) {
      wrongAnswers = wrongAnswers + " " + wrong[i];
    }

    // hangman image:
    hangman = loadImage(imageHang);
    image(hangman, 350,25);

    textFont(myFont);
    fill(0);

    // Exibe as letras corretamente adivinhadas
    float x = ident;
    float y = 520; 
    float spacing = 20; // Define o espaçamento entre as letras
    for (int i = 0; i < guessed.length; i++) {
      text(guessed[i], x, y); // Exibe cada letra corretamente adivinhada
      x += textWidth(guessed[i]) + spacing; // Atualiza a posição horizontal para a próxima letra
    }

    // Exibe as outras informações na tela
    //text(display4, ident, 400);
    text(display2, ident, 430);
    text(typing, ident, 490);
    text(wrongAnswers, ident, 550);
    guess = typing;

    if (guess.length() > 1) {
      display3 = "digite apenas uma letra";
      typing = "";
    } else {
      display3 = "";
    }
  }
}


void keyPressed() {
  if (!dictionarySelected) {
    if (key == 'l') {
      selectedDictionary = game;
      dictionarySelected = true;
      startGame();
    } else if (key == 'a') {
      selectedDictionary = animal;
      dictionarySelected = true;
      startGame();
    } else if (key == 'c') {
      selectedDictionary = cidade;
      dictionarySelected = true;
      startGame();
    } else {
      typing = "Escolha 'g' para game, 'a' para animal ou 'c' para cidade.";
    }
  } else {
    if (key == '\n') {
      play(typing);
      typing = "";
    } else { 
      typing = typing + key;
    }
  }
}

void startGame() {
  answerKey = int(random(0, selectedDictionary.length));
  answer = selectedDictionary[answerKey];
  printAnswer();

  winner = answer.length();

  guessed = new char[answer.length()];
  for (int i = 0; i < answer.length(); i++) {
    guessed[i] = '_';
  }
  wrong = new char[11];
  for (int i = 0; i < 11; i++) {
    wrong[i] = '*';
  }
}

void play(String guess) {
  boolean guessedRight = false;
  guess = guess.toUpperCase();
  char myGuess = guess.charAt(0);
  for (int c = 0; c < answer.length(); c++) {
    if (myGuess == answer.charAt(c)) {
      guessed[c] = myGuess;
      numRight += 1;
      guessedRight = true;
      if (numRight == winner) {
        display = "VOCE GANHOU!!";
        display2 = "";
        ganhar = 1;
      }
    }
  }

  if (!guessedRight) {
    wrong[numWrong] = myGuess;
    numWrong += 1;
    if (numWrong >= 11) { 
      display = "VOCE PERDEU!";
      display2 = "";
      perder = 1;
    }
    // Atualiza a imagem do hangman
    imageHang = hangmanImages[numWrong];
  }
}

void printAnswer() {
  println("Resposta correta: " + answer);
}
