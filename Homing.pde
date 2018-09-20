
//this is the class of object that is fired by enemies.

class Homing {
 PVector pos = new PVector();
 PVector vel = new PVector();
 PVector acc = new PVector();
 
 ArrayList<PVector> points = new  ArrayList<PVector>();
   float lastAdd = 0;
  float addDelay = 0;
  float trailLength = 5;
 
 
 float birth;
 float death = 5000;
 
 boolean alive;
 boolean exploded = false;
 
 float hitDist = 10;
 float speedScalar = 0.2;
 
 float velLimit = 50;
 
   Homing(float x, float y){
    pos.x = x;
    pos.y = y;
    alive = true;
    birth = millis();
   }
   
  
 
 void update(){
   
   
   
     if(millis() - birth < death && alive){ //tests to see if this should still be alive. These objects have a life span of 5000ms (5 seconds)
  PVector tPos = pos.get();
  PVector sPos = s1.pos.get();
  
  acc = tPos.sub(sPos);
  float dist = acc.mag(); //gets the distance between the ship and this object, also gets the heading to set as the current acceleration.
  if(dist < hitDist){ //tests if it has hit the player.
      explosions.add(new Explosion(pos.x, pos.y));
      alive = false;
      s1.damage(15);

    
  }else if(dist > 50){// && millis() - birth > 1000){
    sPos = new PVector(random(0,width),random(0,height)); 
  }
  if(millis()-birth < death - 500){
  acc.rotate(PI);
  }else{
   acc.rotate(random(10,50)); 
  }
  acc.normalize(); //sets the vector to a magnitude of 1, while retaining heading.
  acc.mult(speedScalar); //multiply by scalar for uniform speed that doesn't depend on heading.
  vel.add(acc); // add acceleration to veloctiy.
  vel.limit(velLimit); //limit velocity so there is not infinite acceleration
  pos.add(vel); //add velocity to position.
  //display the object and render a trail behond.
  noStroke();
  fill(255,0,0);
  float size = map(vel.mag(), 0,velLimit, 10,5);
  trailRender();
  ellipse(pos.x, pos.y, size,size);
  
   
   }else{ // a self destruct condition if it has been alive too long
    alive = false; 
    if(!exploded){
    explosions.add(new Explosion(pos.x, pos.y));
    
    exploded = true;
    }
 }
 }
 //renders a trail, better comment on the ShipClass constructor.
   void trailRender() {

    for (int i = 0; i< points.size(); i++) {
      PVector p = points.get(i);
      if (i+1 < points.size()) {
        PVector q = points.get(i+1);
      }
      fill(255,0,0,map(i, 0, points.size(), 0, 255));
      float size = map(i, 0, points.size(), 10, 8);
      ellipse(p.x, p.y, size, size);
    }
    if (millis() - lastAdd > addDelay) {
      points.add(new PVector(pos.x, pos.y));
      lastAdd = millis();
    }
    if (points.size()>trailLength) {
      points.remove(0);
    }
    
  }
 
 
}