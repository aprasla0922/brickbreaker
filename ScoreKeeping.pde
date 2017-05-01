class ScoreKeeping{
  int Score = 0;
  int LivesLeft = 3;
  ArrayList<PImage> livesLeft = new ArrayList<PImage>();
  PImage heart;
  public ScoreKeeping(){
    heart = loadImage("heart.png");
    for (int i = 0; i < 3; i ++){
      livesLeft.add(heart);
    }
    gameOver = false;
    //clear text
    fill(backColor);
    textSize(100);
    text("Game Over",300,height/2+75); 
    textSize(20);
    text("Press Enter to Restart", 450, height/2 + 100);
  }
  public void display(){
    textSize(16);
    fill(0);
    text("Score : " + Score, 0, 15);
    text("Lives Left : ", 0,35);
    for (int i = 0; i < livesLeft.size(); i ++){
      pushMatrix();
      scale(.09);
      image(livesLeft.get(i),20+ i * 400,460);
      popMatrix();
    }
    if (!gameOver && ball.vx == 0 && ball.vy == 0){       
      fill(0);
      text("Press Space to Begin", 450, height/2 + 100);
    }
    if (gameOver){
      textSize(100);
      text("Game Over",300,height/2+75); 
      textSize(20);
      text("Press Enter to Restart", 450, height/2 + 100);
    }
  }
  public void loseLife(){
    if (livesLeft.size() != 0)
    {
      livesLeft.remove(livesLeft.get(livesLeft.size()-1));
    }
    else
    {
      gameOver = true;
    }
    }
  public void gainLife(){
    livesLeft.add(heart);
  }
  }