class Laser{
  float origy;
  float laserx, lasery;
  float yalt;
  int health = 5;
  public Laser(float xp,float yp){
    laserx = xp;
    lasery = yp;
    yalt = yp;
    origy = yp;
   }
    
  public void move(){
    stroke(255,0,0);
    strokeWeight(8);
    if (yalt > lasery-75) {
      yalt-=10;
    } else {
      lasery-=10;
      yalt-=10;
    }
    line(laserx,yalt,laserx,lasery);
    
    // hit detection
    if (lasery < -50) {
      health--;
      reset();

    }
    
    for (int i = 0; i < Bricks.size(); i ++){
      // IF hits
      float bricky = Bricks.get(i).ypos;
      float brickx = Bricks.get(i).xpos;
      float bricksize = Bricks.get(i).size;
      if ((yalt >= bricky && yalt <= bricky+bricksize) && laserx >= brickx && laserx <= brickx+bricksize*3) {
        health--;
        reset();
        Bricks.get(i).die(true);
      }
    }
  }
  
  public void reset() {
      lasery = origy;
      yalt = origy;
      laserx = paddleX + paddle.width/6;
  }
}