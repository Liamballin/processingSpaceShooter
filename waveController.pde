int wave = 1;
float lastWave = 0;
float waveDelay = 10000;//10 seconds 

// this makes sure there are always enemies on the screen for the player to shoot.
void waveControl(){
  
  if(enemies.size() < 2){
    float enemyCount = random(2,4) + wave % 3;
    
    addEnemy(enemyCount);
       /*for(int i = 0; i < 10; i ++){
        homings.add(new Homing(30*i, 100)); 
*/
lastWave = millis();
wave ++;
}
  }


void addEnemy(float count){
  
 for(int i = 0; i < count; i ++){
  enemies.add(new Enemy_dash(random(0,width),random(0,height))); 
 }
}