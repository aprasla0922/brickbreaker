import java.util.Iterator;
import java.util.LinkedList;

class Ball {
  float xpos;
  float ypos;
  float size;
  float vx;
  float vy;
  int speed;
  boolean start;
  
  LinkedList<Sparkle> sparkles = new LinkedList<Sparkle>();
  
  public Ball (float x, float y,float s, int sp){
    xpos = x;
    ypos = y;
    size = s;
    speed = sp;
    fill(0);
    ellipse(xpos,ypos,size,size);
    start = false;
  }
  
  class Sparkle {
    //inner class for secondary animation
    float xpos;
    float ypos;
    float size;
    float vx;
    float vy;
    int speed;
    int dir; //top left, top right, bottom left, bottom right
     int lifetime = 10; //in frames
      PShape img = loadShape("star.svg");
   
    public Sparkle (float x, float y,int sp, int dir){
      this.xpos = x;
      this.ypos = y;
      this.speed = sp;
      switch(dir) {
        case 0: //top right
          this.vx = speed;
          this.vy = -speed;
          break;
        case 1: //top left
          this.vx = -speed;
          this.vy = -speed;
          break;
        case 2: //bottom right
          this.vx = speed;
          this.vy = speed;
          break;
        case 3: //bottom left
          this.vx = -speed;
          this.vy = speed;
          break;
      }
      
    }
    public void move() {
      this.xpos += this.vx;
      this.ypos += this.vy;
      lifetime--;
      shape(img, this.xpos, this.ypos, 30,30);
    }
  }
  
  void moveSparkles() {
    for (Sparkle s : sparkles) {
      s.move();
    }
  }
  
  void removeSparkles() {
    Iterator<Sparkle> it = sparkles.iterator();
    while (it.hasNext()) {
      if (it.next().lifetime <=0) it.remove();
    }
  }
    
  void addSparkles() {
    for (int i = 0; i < 4; i++) {
      sparkles.add(new Sparkle(xpos, ypos, 5, i));
    }
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
     //addSparkles();
    }
    if (ypos < size/2){
      vy = vy * -1;
      //addSparkles();
    }
    
    //ball hits paddle
    if (ypos+size/2>= 565 && (xpos >= paddleX && xpos <= paddleX+paddle.width/3)) {
      vy = vy*-1;
      ypos = ypos -7;
      addSparkles();
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
      if(current.dead){
         current.animation.Show();
         if(current.animation.terminate){
           Bricks.remove(current); 
         }
      }else if(isBetween(xpos,current.xpos,current.xpos + current.size*3) && isBetween(ypos,current.ypos,current.ypos +current.size)){
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
        //addSparkles();
      } 
    }
  }
  removeSparkles();
  moveSparkles();
  fill(0);
  ellipse(xpos,ypos,size,size);
  }
  
  public void reset(){
    vx = 0;
    vy = 0;
    xpos = initialBallX;
    ypos = initialBallY;
    speed = 5;
    this.start = false;
  }
}

public static boolean isBetween(float a,float b,float c)
{
  if (a >= b && a <= c){
    return true;
  } 
  return false;
}