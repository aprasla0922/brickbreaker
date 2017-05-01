import java.util.Random;

class Brick{
  float xpos;float ypos; float size;
  int health;
  color[] colors = {color(200,200,200), color(30,136,229), color(38,166,154), color(229,57,53), color(94,53,177)};
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
  }
  public void Show(){
    stroke(backColor);
    fill(colors[health]);
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
      currentGame.Score += 10;
      if (power) {
        Random r = new Random();
        int x = r.nextInt(10);
        if (x<=3) {
          Powerups.add(new Powerup(xpos,ypos,8,x));
        }
      }
      Bricks.remove(this);
    }
  }
}