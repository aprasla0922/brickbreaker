import java.util.Random;

class Powerup{
  float xpos;float ypos; float size;
  int type; // 0 = health, 1 = slow ball, 2 = break all, 3 = ball fast
  public Powerup(float xp,float yp,float sizep, int t){
    xpos = xp;
    ypos = yp;
    size = sizep;
    type = t;
  }
  public void Show(){
    ypos+=5;
    image(powup,xpos,ypos,powup.width/size,powup.height/size);
    if (ypos+powup.height/size >= 565 && (xpos >= paddleX && xpos <= paddleX+paddle.width/3)) {
      if (type == 0) {
        currentGame.gainLife();
        System.out.println("gainlife");
      } else if (type == 1) {
        ball.speed-=2;
        if (ball.speed < 1) { ball.speed = 1; }
        System.out.println("speed+");
      } else if (type == 2) {
          for (int i = 0; i < Bricks.size(); i ++){
            Bricks.get(i).die(false);
          }
          System.out.println("die");
      } else if (type == 3) {
        ball.speed+=3;
        System.out.println("speed-");
      }
      Powerups.remove(this);
      return;
    }
    
    if (ypos+powup.height/size > height) {
      Powerups.remove(this);
    }
  }
}