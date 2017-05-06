ArrayList <Brick> Bricks;
ArrayList <Powerup> Powerups;
Ball ball;
color backColor = color(255,215,0);
float initialBallX;
float ballSize = 30;
float initialBallY;
boolean gameOver = false;
PImage paddle;
PImage powup;
int paddleX;
boolean paddleLeft = false, paddleRight = false;
//Level start is the indicator that the level has begun (ball is stationary)
boolean levelStart = true;
Level levelHandler;
int currentLevel = 1;
ScoreKeeping currentGame;

void setup(){
  paddleX = width/2-80;
  paddle = loadImage("paddle.png");
  powup = loadImage("powerup.png");
  Bricks = new ArrayList<Brick>();
  Powerups = new ArrayList<Powerup>();
  size(1062,600);
  background(backColor);
  
  //row staggering variables
  initialBallX = width/2;
  initialBallY = height - ballSize-30;
  ball = new Ball(initialBallX, initialBallY,ballSize,5);
  currentGame = new ScoreKeeping();
  levelHandler = new Level("LevelOne.csv","LevelTwo.csv","LevelThree.csv");
}

void draw(){
  background(backColor);
  image(paddle,paddleX,565,paddle.width/3,paddle.height/6);
  levelHandler.Load(currentLevel);
  currentGame.display();
  //image(paddle,paddleX+50,565,paddle.width/6,paddle.height/6);

  currentGame.display();
  if(!gameOver){
    ball.Move();
    if(paddleLeft){
      if (paddleX-20 > 0) {
          paddleX-=20;
          if (!ball.start) { ball.xpos-=20; }
        } else if (paddleX > 0) {
          if (!ball.start) {ball.xpos=ball.xpos-paddleX; }
          paddleX = 0;
        } 
    }else if(paddleRight){
      float pright = paddleX+paddle.width/3;
        if (pright+20 < width) {
          paddleX+=20;
          if (!ball.start) { ball.xpos+=20; }
        } else if (pright < width) {
          if (!ball.start) {ball.xpos = ball.xpos + width-pright; } 
          paddleX+= width-pright;
        }
    }
  }
}

void keyPressed(){
  // enter name for high score
  if(gameOver){
    if(key==BACKSPACE){
      currentGame.deleteLetter();
    }else if((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')){
      currentGame.inputname += key; 
    }
  }
  // resets ball
  if (key == ' ' && ball.start == false){
    ball.release();
    ball.start = true;
  }else if (key == CODED) {  // move paddle
    if (keyCode == LEFT) {
      paddleLeft = true;
    } else if (keyCode == RIGHT) {
      paddleRight = true;
    }
  }
  if(key == ' '){
    levelStart = false;
  }
}

void keyReleased(){
  // move paddle
  if(key == CODED){
    if(keyCode == LEFT){
      paddleLeft = false; 
    }else if(keyCode == RIGHT){
      paddleRight = false; 
    }
  }
}

void mousePressed(){
  // the button click in game over screen & resets the game
  if(325<mouseX && mouseX<745 && (height/2-175)<mouseY && mouseY<(height/2-140) && gameOver){
    currentGame.addScore();
    currentGame = new ScoreKeeping();
    ball.reset();
    //reset board  
    Bricks.clear();
    levelHandler.Load(currentLevel);
  }
}