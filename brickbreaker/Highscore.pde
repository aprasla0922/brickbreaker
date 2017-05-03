class Highscore{
  public String[][] highscores;
  
  Highscore(){
    highscores = new String[10][2];
  }
  
  public void readHighscore(){
     String[] lines = loadStrings("Highscores.txt");
     for(int i=0; i<lines.length && i<10; i++){
       String[] tmp = lines[i].split(" ");
       highscores[i][0] = tmp[0];
       highscores[i][1] = tmp[1];
     }
  }
  
  public void addHighscore(String name, int score){
    for(int i =0; i<10; i++){
      if(highscores[i]==null){
        highscores[i][0] = name;
        highscores[i][1] = "" + score;
      }else if(score>Integer.parseInt(highscores[i][1])){
        insertScore(i, name, score);
        return;
      }
    }
  }
  
  private void insertScore(int pos, String name, int score){
    String[] tmp = new String[2];
    String[] tmp1 = new String[2];
    tmp[0] = name; tmp[1] = ""+score;
    for(int i = pos; i<10; i++){
      tmp1 = highscores[pos].clone();
      highscores[pos] = tmp.clone();
      tmp = tmp1.clone();
    }
  }
  
  public void writeHighscore(){
    PrintWriter writer = createWriter("Highscores.txt");
    for(int i=0; i<highscores.length; i++){
      writer.println(highscores[i][0] + " " + highscores[i][1]);
    }
    writer.close();
  }
}