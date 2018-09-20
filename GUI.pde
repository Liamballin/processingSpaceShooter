//these functions update user interface elements

void updateGui(){
 healthBar();
 stats();
 score();
}
//shows the health and sheild bar at the top of the screen
void healthBar(){
 float percent = s1.health;
 float shield = s1.shield;
 fill(0,255,0,100);
  rect(0,0,map(percent, 0,100,0,width), 20); 
 fill(0,0,255,100);
  rect(0,20,map(shield, 0,100,0,width), 20); 

  //redFlash("top");
}
//this is an unused function, it flashes a gradiated red bar at the top of the screen. 
//Its intended use was to be a damage indicator. 
void redFlash(String edge){
  int levels = 10;
  float leng = 30;
 if(edge == "top"){
 for(int i = levels; i > 0; i--){
    fill(255,0,0,10-i);
    rect(0,0,width, i*leng);
  }
 }else if(edge == "left"){
  for(int i = levels; i > 0; i--){
    fill(i*30, 100-i*5);
    rect(0,0, i*leng, height);
  }
 }
}
 void screenFlash(){
   //would have been the redFlash() controller
 }
 
 //shows the score
 void score(){
  textSize(30);
  textAlign(LEFT);
   text(score, 10, height - 50);
  
   
 }
 //shows statistics about the game's performance
 void stats(){
   textSize(10);
  fill(0);
  strokeWeight(1);
  stroke(0);
  
  float w = width-250;
  float h = height-120;
  
  rect(w,h, w, h);
  fill(255);
  text("FPS: "+frameRate,w, h);
  text("homing: "+homings.size(), w, h+20);
  text("missles: "+missles.size(), w, h+40);
  text("explosions: "+explosions.size(), w, h+60);
  text("Sheild: "+s1.shield, w, h+80);

   
   
 }
  
// for(int i = levels; i > 0; i--){
  //  fill(i*30, 100-i*5);
   // rect(width,height-leng*levels,width, height-i*leng);
 // }
  
  