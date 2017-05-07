class Laser{
  float laserx, lasery;
  
  public Laser(float xp,float yp){
    laserx = xp;
    lasery = yp;
   }
    
  public void Show(){
    stroke(backColor);
    strokeWeight(2);
  }
  
  public void disappear(){
    
  }
  
  public void die(){
  }
}