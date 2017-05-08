import ddf.minim.*;

AudioPlayer bounce;
AudioPlayer laser;
AudioPlayer bgsound;
Minim minim;  // audio context

ArrayList <Brick> Bricks;
ArrayList <Powerup> Powerups;
ArrayList <Laser> Lasers;
Ball ball;
color backColor = color(255, 215, 0);
float initialBallX;
float ballSize = 30;
float initialBallY;
boolean gameOver = false;
PImage paddle;
PImage[] powup;
int paddleX;
boolean paddleLeft = false, paddleRight = false;
//Level start is the indicator that the level has begun (ball is stationary)
boolean levelStart = true;
Level levelHandler;
int currentLevel = 1;
ScoreKeeping currentGame;

enum MenuState {
  MAIN, PLAYING, HIGHSCORE;
}

MenuState state = MenuState.MAIN;

void setup() {
  minim = new Minim(this);
  bounce = minim.loadFile("click.mp3");
  laser = minim.loadFile("laser.mp3");
  bgsound = minim.loadFile("background.mp3");
  bgsound.loop();
  
  paddleX = width/2-80;
  paddle = loadImage("paddle.png");
  powup = new PImage[]{loadImage("heart.png"), loadImage("hourglass.png"), loadImage("powerup.png"), loadImage("laser.png")};
  Bricks = new ArrayList<Brick>();
  Powerups = new ArrayList<Powerup>();
  Lasers = new ArrayList<Laser>();
  size(1062, 600);
  background(backColor);

  //row staggering variables
  initialBallX = width/2;
  initialBallY = height - ballSize-30;
  ball = new Ball(initialBallX, initialBallY, ballSize, 5);
  currentGame = new ScoreKeeping();
  levelHandler = new Level("LevelOne.csv", "LevelTwo.csv", "LevelThree.csv");
}

void draw() {
  background(backColor);
  
  for (Laser l : Lasers) {
    if (l.health > 0) {
      l.move();
    }
  }
  
  if (state == MenuState.MAIN) {
    fill(0);
    textSize(100);
    text("Brickbreaker", 225, 100);
    textSize(50);
    if (overRect(width/2 - 75, 300, 4 * 50, 80)) fill(200,0,0);
    else fill(0);
    text("Play", width/2 - 75, 300, 200, 80);
    if (overRect(width/2 - 150, 380, 9 * 50, 80)) fill(200,0,0);
    else fill(0);
    text("Highscores", width/2 - 150, 380, 450, 80);
  } else if (state == MenuState.HIGHSCORE) {
    fill(0);
    Highscore highscore = new Highscore();
    highscore.readHighscore(); 
    textSize(20);
    text("Highscores:", 445, height/4 - 35);
      for(int i =0; i<10; i++){
        text(highscore.highscores[i][0] + "        " + highscore.highscores[i][1], 450, height/4 + i*25);
      }
      textSize(50);
      if (overRect(width/2 - 150, height - 100, 450, 80)) fill(200,0,0);
      else fill(0);
      text("Main menu", width/2 - 150, height - 100, 450, 80);
  } else {
    image(paddle, paddleX, 565, paddle.width/3, paddle.height/6);
  currentGame.display();
  levelHandler.Load(currentLevel);
  //image(paddle,paddleX+50,565,paddle.width/6,paddle.height/6);
  if (!gameOver) {
    ball.Move();
    if (paddleLeft) {
      if (paddleX-20 > 0) {
        paddleX-=20;
        if (!ball.start) { 
          ball.xpos-=20;
        }
      } else if (paddleX > 0) {
        if (!ball.start) {
          ball.xpos=ball.xpos-paddleX;
        }
        paddleX = 0;
      }
    } else if (paddleRight) {
      float pright = paddleX+paddle.width/3;
      if (pright+20 < width) {
        paddleX+=20;
        if (!ball.start) { 
          ball.xpos+=20;
        }
      } else if (pright < width) {
        if (!ball.start) {
          ball.xpos = ball.xpos + width-pright;
        } 
        paddleX+= width-pright;
      }
    }
  } else{
    Bricks.clear();
  }
  }
}

void keyPressed() {
  // enter name for high score
  if (gameOver) {
    if (key==BACKSPACE) {
      currentGame.deleteLetter();
    } else if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
      currentGame.inputname += key;
    }
  }
  // resets ball
  if (key == ' ' && ball.start == false) {
    ball.release();
    ball.start = true;
  } else if (key == CODED) {  // move paddle
    if (keyCode == LEFT) {
      paddleLeft = true;
    } else if (keyCode == RIGHT) {
      paddleRight = true;
    }
  }
  if (key == ' ') {
    levelStart = false;
  }
}

void keyReleased() {
  // move paddle
  if (key == CODED) {
    if (keyCode == LEFT) {
      paddleLeft = false;
    } else if (keyCode == RIGHT) {
      paddleRight = false;
    }
  }
}

void mousePressed() {
  // the button click in game over screen & resets the game
  if (325<mouseX && mouseX<745 && (height/2-175)<mouseY && mouseY<(height/2-140) && gameOver) {
    paddleX = width/2-80;
    currentGame.addScore();
    currentGame = new ScoreKeeping();
    ball.reset();
    //reset board  
    currentLevel = 1;
    Bricks.clear();
    levelStart = true;
    gameOver = false;
    //levelHandler.Load(currentLevel);
    state = MenuState.MAIN;
  } else if (state == MenuState.MAIN) {
    if (overRect(width/2 - 75, 300, 4 * 50, 80)) { //"play"
       state = MenuState.PLAYING;
    } else if (overRect(width/2 - 150, 380, 9 * 50, 80)) { //"highscore"
      state = MenuState.HIGHSCORE;
    }
  } else if (state == MenuState.HIGHSCORE) {
    if (overRect(width/2 - 150, height - 100, 450, 80)) {
      state = MenuState.MAIN;
    }
  }
}

// closing the app
void stop(){
 bounce.close();
 laser.close();
 bgsound.close();
 minim.stop();
 super.stop();
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}