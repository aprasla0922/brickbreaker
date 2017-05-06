import java.util.Random;

class Brick{
  float xpos;float ypos; float size;
  boolean dead = false;    // a brick is dead
  int health;
  color[] colors = {color(200,200,200), color(30,136,229), color(38,166,154), color(229,57,53), color(94,53,177)};
  BreakAnimation animation;
  
  public Brick(float xp,float yp,float sizep){
    xpos = xp;
    ypos = yp;
    size = sizep;
    stroke(backColor);
    Random rand = new Random();
    health = rand.nextInt(5);
    fill(colors[health]);
    strokeWeight(2);
    rect(xp,yp,size*3,size);
    animation = new BreakAnimation(xpos, ypos, size);
  }
  
  public void Show(){
    stroke(backColor);
    if(health<0) fill(colors[0]);
    else fill(colors[health]);
    strokeWeight(2);
    rect(xpos,ypos,size*3,size);
  }
  
  public void disappear(){
    stroke(backColor);
    fill(backColor);
    rect(xpos,ypos,size*3,size);
  }
  
  public void die(boolean power){
    health--; 
    if (health < 0) {
      if(!dead){
        currentGame.Score += 10;
        if (power) {
          Random r = new Random();
          int x = r.nextInt(10);
          if (x<=3) {
            Powerups.add(new Powerup(xpos,ypos,8,x));
          }
        }
        dead = true;
      }
    }
  }
  
  // inner class for brick breaking animation
  public class BreakAnimation{
    boolean terminate = false;
    float xpos, ypos, size;
    float lx, ly, mx, my, rx, ry;
    float dif = 0;
    color c = colors[0];
    
    BreakAnimation(float xpos, float ypos, float size){
      this.xpos = xpos;
      this.ypos = ypos;
      this.size = size;
      this.lx = xpos;
      this.mx = lx+size;
      this.rx = mx+size;
    }
    
    public void Show(){
      stroke(backColor);
      fill(c);
      strokeWeight(2);
      float tmp = ypos + dif;
      rect(lx - dif, tmp, size, size);
      rect(mx, tmp, size, size);
      rect(rx + dif,tmp, size, size);
      dif += 0.5;
      if(size>0){size--;}
      if(dif>10){
        terminate = true;
      }
    }
  }
}