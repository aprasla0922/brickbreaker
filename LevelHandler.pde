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
      if (whichLevel == 1)
      {
        currentFile = fileOne;
      }
      else if (whichLevel == 2)
      {
        currentFile = fileTwo;
      }
      else if( whichLevel ==3){
        currentFile = fileThree;
      }
    Bricks.clear();
    Table levelData = loadTable(currentFile);
      for (TableRow r : levelData.rows()) {
        String x = r.getString(0);
        String y = r.getString(1);
        String size = r.getString(2);
        String health = r.getString(3);
        Bricks.add(new Brick(Float.parseFloat(x),Float.parseFloat(y),Float.parseFloat(size),Integer.parseInt(health)));
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
        if(currentLevel != 3){
          print("next level");
          currentLevel += 1;
          levelStart = true;
        }
      }
    }
  }
}