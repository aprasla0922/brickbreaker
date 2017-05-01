class Ball {
  float xpos;
  float ypos;
  float size;
  float vx;
  float vy;
  int speed;
  boolean start;
  public Ball (float x, float y,float s, int sp){
    xpos = x;
    ypos = y;
    size = s;
    speed = sp;
    fill(0);
    ellipse(xpos,ypos,size,size);
    start = false;
  }
  public void release(){
    vx = -speed;
    vy = -speed;
    fill(backColor);
    text("Press Space to Begin", 450, height/2 + 100);
  }
  public void Move(){
    //println("Vel - " + vx + " " + vy);
    if (gameOver){
      xpos = initialBallX;
      ypos = initialBallY;
    }else{
    xpos += vx;
    ypos += vy;
    //bounce against walls
    if(xpos < size/2 || xpos > (width - size/2)){
      vx = vx * -1;
    }
    if (ypos < size/2){
      vy = vy * -1;
    }
    
    //ball hits paddle
    if (ypos+size/2>= 565 && (xpos >= paddleX && xpos <= paddleX+paddle.width/3)) {
      vy = vy*-1;
      ypos = ypos -7;
    }
    
    //ball dies
    if(ypos > (height - size/2)){
      currentGame.loseLife();
      paddleX = width/2-80;
      //reset position
      this.reset();
    }
   
    //next step - bounce against bricks
    for (int i = 0; i < Bricks.size(); i ++){
      Brick current = Bricks.get(i);
      if(isBetween(xpos,current.xpos,current.xpos + current.size*3) && isBetween(ypos,current.ypos,current.ypos +current.size)){
        //deletes bricks
        Bricks.get(i).die(true);
        //figure out what happens to bounce
        if(ypos < current.ypos + 7){
          vy = vy * -1;
        }
        else if( ypos > current.ypos + current.size - 7){
          vy = vy * -1;
        }
        else{
          vx = vx * -1;
        } 
      }
    }
  }
  fill(0);
  ellipse(xpos,ypos,size,size);
  }
  public void reset(){
    vx = 0;
    vy = 0;
    xpos = initialBallX;
    ypos = initialBallY;
    speed = 5;
  }
}

public static boolean isBetween(float a,float b,float c)
{
  if (a >= b && a <= c){
    return true;
  } 
  return false;
}