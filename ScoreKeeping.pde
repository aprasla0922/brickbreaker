class ScoreKeeping{
  int Score = 0;
  int LivesLeft = 3;
  ArrayList<PImage> livesLeft = new ArrayList<PImage>();
  PImage heart;
  String inputname = "";
  Highscore highscore;  // use to read and write new highscores
  
  public ScoreKeeping(){
    heart = loadImage("heart.png");
    for (int i = 0; i < 3; i ++){
      livesLeft.add(heart);
    }
    gameOver = false;    // set to true for game over screen debugging
    currentLevel = 1;
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
    if(!gameOver){
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
    }
    if (!gameOver && ball.vx == 0 && ball.vy == 0){       
      fill(0);
      text("Press Space to Begin", 450, height/2 + 100);
    }
    if (gameOver){    // game over and high score screen
      background(backColor);
      fill(0);
      textSize(100);
      text("Game Over",300,height/2-200); 
      textSize(20);
      if(325<mouseX && mouseX<745 && (height/2-175)<mouseY && mouseY<(height/2-140)){
        fill(255,150,150);
      }else {fill(255,60,60);}
      rect(320, height/2-175, 420, 35);
      fill(0);
      text("Press Here to Submit Score and Play Again", 325, height/2 - 150);
      text("Your score: " + Score, 450, height/2 - 100);
      text("Enter your name: " + inputname, 440, height/2 - 75);
      text("Highscores:", 445, height/2 - 35);
      for(int i =0; i<10; i++){
        text(highscore.highscores[i][0] + "        " + highscore.highscores[i][1], 450, height/2 + i*25);
      }
      currentLevel = 1;
    }
  }
  
  public void loseLife(){
    if (livesLeft.size() != 1)
    {
      livesLeft.remove(livesLeft.get(livesLeft.size()-1));
    }
    else
    {
      livesLeft.remove(livesLeft.get(livesLeft.size() -1));
      gameOver = true;
      currentLevel = 1;
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