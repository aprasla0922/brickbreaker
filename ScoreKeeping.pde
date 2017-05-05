class ScoreKeeping{
  color backColor = color(255,215,0);
  int Score = 0;
  int LivesLeft = 3;
  ArrayList<PImage> livesLeft = new ArrayList<PImage>();
  PImage heart;
  String inputname = "";
  Highscore highscore;
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
    highscore = new Highscore();
    highscore.readHighscore();
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
      background(backColor);
      textSize(100);
      text("Game Over",300,height/2-200); 
      textSize(20);
      text("Press Enter to Continue Game", 375, height/2 - 150);
      text("Your score: " + Score, 450, height/2 - 125);
      text("Enter your name: " + inputname, 440, height/2 - 100);
      text("Highscores:", 445, height/2 - 35);
      for(int i =0; i<10; i++){
        text(highscore.highscores[i][0] + "        " + highscore.highscores[i][1], 450, height/2 + i*25);
      }
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
  
  public void addScore(){
    if(inputname.equals("")) inputname = "xxx";
    highscore.addScore(inputname, Score); 
    highscore.writeHighscore();
  }
  
  public void deleteLetter(){
    if(inputname.length()==0) return;
    inputname = inputname.substring(0, inputname.length()-1);
  }
  
  }