//this class creates the growing circle explosions.
//

class Explosion {
 PVector pos =  new PVector();
 
 boolean alive = true;
 
 float birth;
 float death = 500;
 float steps = 100;
 
 float initSize = 1;
 float endSize = 500;
 float sizeInt;
 
 float initAlpha = 255;
 float endAlpha = 100;
 float alphaInt;
 
 float stepInt;
 
 Explosion(float x, float y){
   pos.x = x;
   pos.y = y;
   
   birth = millis();
   sizeInt = endSize/death;
   alphaInt = endAlpha/death;
   stepInt = death/steps;
   
 }
 /*
 void update(){
  float life = millis()-birth;
  
  float alpha = lerp(initAlpha, endAlpha, life);
  float size = lerp(initSize, endSize, life);
   
 }
 */
 //it calculates the amount of each property between the min/max based on its lifespan and the amount of time elapsed;
 void update(){
   strokeWeight(1);
  if(millis() - birth < death){
   noFill();
   float m = millis()-birth;
   float step = m/stepInt;
   stroke(255,255-alphaInt*step-150);
   ellipse(pos.x, pos.y, initSize+sizeInt*step, initSize+sizeInt*step);
  }else{
    alive = false; 
   }
   
 }
 
}

void checkMissles(){
 for(int i = 0; i < missles.size(); i++){
   
   Missle m = missles.get(i);
   if(!m.alive){
    missles.remove(i); 
   }
   
 }
}
  
void checkExplosions(){
 for(int i = 0; i < explosions.size(); i++){
   
   Explosion m = explosions.get(i);
   if(!m.alive){
    explosions.remove(i); 
   }
   
 }
}