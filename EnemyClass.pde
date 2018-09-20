//TODO create class instance to control waves.
/*

//This is an early version of the enemy class. It worked, but not great. After I started from scratch I had a better idea of what I needed it to do
//and how it would work and that meant I could build the basic parts of it with that in mind. 


class Enemy_dash {
  //vectors 
  PVector pos = new PVector();
  PVector vel = new PVector(0.1,0.1);
  PVector acc = new PVector(); 

  PVector dashVel = new PVector();
  PVector dashTarget = new PVector();

  float dashVelScalar = 100;
  float driftVelScalar = 0.1;
  
  float health = 100;
  
  float distance;
  
  boolean dashing = false;
  
  boolean alive = true;


  //movement stuff
  float birth;
  float dashInterval = 5000; //set toa random to increase difficulty;
  float dashTime = 100;
  float lastDash;

  float lastFired;
  float fireDelay;
  
  

  Enemy_dash(float x, float y) { //called when class instance initialized
    pos.x = x; //set the position vector values 
    pos.y = y;
    
    lockOn();

    birth = millis(); //set birth value to current milliseconds after game launch;
    lastDash = 0;
    dashInterval += (random(0,500)*random(-1,1));
  }


  void update() {
    lockOn();
    
    if(dashing){
     PVector tPos = pos.get();
     PVector tTar = dashTarget.get();
     
     tTar.sub(tPos);
     distance = tTar.mag();
     
     if(distance < 100 || millis()-lastDash > dashTime){
         
      dashing = false; 
     }
    }
    
    if(keyPressed && key == 't'){
     lockOn(); 
     fire(5);
    }
    wallCheck();

    if (millis() - lastDash > dashInterval) { //check if it's been long enough to dash again. maybe add some random variance/chance to make less predicatbel.?
      fire(5);
      dash();
      lockOn();
      lastDash = millis();
    }
    if(dashing){
      pos.add(dashVel);
    }else{
     pos.add(vel); 
    }
    
    if(alive){
    display();
    }
  }
  
  void dash() {
    dashing = true;
    //when dashing, choose random spot that isn't too close to player, or dash at player and inflict damage.
    float newX = random(0,width);
    float newY = random(0,height);
    
    PVector target = new PVector(newX, newY);
    PVector thisPos = pos.get();
    
    thisPos.sub(target);
    thisPos.normalize();
    thisPos.mult(dashVelScalar);
    thisPos.rotate(PI);
    dashVel = thisPos;
    
  }
  void lockOn(){

   PVector shipPos = new PVector();
   shipPos = s1.pos.get();
   PVector thisPos = new PVector();
   thisPos = pos.get();
   
   thisPos.sub(shipPos);
   thisPos.normalize();
   thisPos.mult(driftVelScalar);
   thisPos.rotate(PI + random(0,QUARTER_PI)*random(-1,1));
   
   vel = thisPos;
  }

  void fire(float count) {
   for(int i =0; i< count; i++){
    PVector tPos = pos.get();
    PVector shipPos = s1.pos.get();
    tPos.sub(shipPos);
    //bullets.add(new Bullet(pos.x, pos.y, tPos.heading()-PI+QUARTER_PI+PI+(HALF_PI/2)));
    
   }
   homings.add(new Homing(pos.x, pos.y));
  }
  void display() {

    noStroke();
    fill(255,0,0);
    rect(pos.x, pos.y, 20, 20);
    fill(255);
    rect(pos.x, pos.y, 20,map(health,0,100,0,20));
}

void hit(String type){
if(type == "bullet"){
 health -= 25; 
}else if(type == "missle"){
  health -= 50;
}

if(health <= 0){
 explosions.add(new Explosion(pos.x, pos.y));
 alive = false;
} 
}

  void wallCheck() {
    if (pos.x < 0 || pos.x > width) {
      vel.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      vel.y *= -1;
    }
  }
}*/