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
  int lowbound = 100;
  int highbound = width - 100;
  //create background
  for (int col = 100; col < height /2; col += 20)
  {
    for (int row = lowbound; row < highbound; row += 60){
      Brick b = new Brick(row,col,20);
      Bricks.add(b);
    }
    lowbound += 60;
    highbound -= 60;
  }
  initialBallX = width/2;
  initialBallY = height - ballSize-30;
  ball = new Ball(initialBallX, initialBallY,ballSize,5);
  currentGame = new ScoreKeeping();
}

void draw(){
  background(backColor);
  image(paddle,paddleX,565,paddle.width/3,paddle.height/6);
  //image(paddle,paddleX+50,565,paddle.width/6,paddle.height/6);
  for (int i = 0; i < Bricks.size(); i ++){
    Brick b = Bricks.get(i);
    if(!b.dead){
      b.Show();
    }
  }
  for (int i = 0; i < Powerups.size(); i ++){
    Powerups.get(i).Show();
  }
  if (Bricks.size() == 0) {
    gameOver = true;
  }
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
  if(gameOver){
    if(key==BACKSPACE){
      currentGame.deleteLetter();
    }else if((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')){
      currentGame.inputname += key; 
    }
  }
 if (key == ' ' && ball.start == false){
   ball.release();
   ball.start = true;
 }else if (key == ENTER){
      currentGame.addScore();
      currentGame = new ScoreKeeping();
      ball.reset();
      //reset board  
      Bricks.clear();
      int lowbound = 100;
      int highbound = width - 100;
      //create background
      for (int col = 100; col < height /2; col += 20){
        for (int row = lowbound; row < highbound; row += 60){
          Brick b = new Brick(row,col,20);
          Bricks.add(b);
        }
        lowbound += 60;
        highbound -= 60;
      }
  }else if (key == CODED) {
    if (keyCode == LEFT) {
      paddleLeft = true;
    } else if (keyCode == RIGHT) {
      paddleRight = true;
    }
  }
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == LEFT){
      paddleLeft = false; 
    }else if(keyCode == RIGHT){
      paddleRight = false; 
    }
  }
}