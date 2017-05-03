import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
class Level{
  String fileOne;
  String fileTwo;
  String fileThree;
  public Level (String fileOne, String fileTwo, String fileThree){
    this.fileOne = fileOne;
    this.fileTwo = fileTwo;
    this.fileThree = fileThree;
  }
  public void Load(int whichLevel){
    if(levelStart == true)
    {
    String currentFile = "";
    if(whichLevel == 1)
    {
      currentFile = fileOne;
    }
    else if (whichLevel == 2)
    {
      currentFile = fileTwo;
    }
    else{
      currentFile = fileThree;
    }
    Bricks.clear();
    BufferedReader br =  null;
    String line = "";
    try {
      br = new BufferedReader(new FileReader(currentFile));
      while ((line = br.readLine()) != null) {
        String[] brickData = line.split(",");
        Bricks.add(new Brick(Float.parseFloat(brickData[0]),Float.parseFloat(brickData[1]),Float.parseFloat(brickData[2]),Integer.parseInt(brickData[3])));
      }
    } 
    catch (FileNotFoundException e) {
            e.printStackTrace();
        } 
    catch (IOException e) {
            e.printStackTrace();
      }
    }
  else{
      for (int i = 0; i < Bricks.size(); i ++) {
        Bricks.get(i).Show();
      }
      for (int i = 0; i < Powerups.size(); i ++) {
        Powerups.get(i).Show();
      }
      if (Bricks.size() == 0) {
        gameOver = true;
      }  
    }
  }
}