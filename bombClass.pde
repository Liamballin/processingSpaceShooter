//another unused class

class Bomb{
  PVector pos = new PVector();
  
  float size = 5;
  float birthTime;
  
  
 Bomb(float x, float y){
  pos.x = x;
  pos.y = y;
  birthTime = millis();
 }
 
 void update(){
   
  ellipse(pos.x, pos.y, size, size); 
 }
  
}