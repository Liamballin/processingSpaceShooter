//this constructs the bullet fired by the player.

class Bullet {
 PVector pos = new PVector();
 PVector vel = new PVector();
 float speed = 9;
 PVector acc = new PVector();
 
 boolean alive = true;
  
  Bullet(float x, float y, float heading){ // one of the arguments taken is the heading (where the player is aiming);
    
    
    
    pos.x = x;
    pos.y = y;
    vel = new PVector(speed, speed);
    acc = new PVector(1, 1);
    vel.rotate(heading + QUARTER_PI);
    acc.rotate(heading + QUARTER_PI);
    vel.x += (random(-1,1) * random(0,.5));
    vel.y += (random(-1,1) * random(0,.5));
  }
  
  
  void update(){
   
    //if(abs(vel.x) > 2 || abs(vel.y) > 2){
    vel.add(acc);
   pos.add(vel);
   noStroke();
   
   fill(255);
   ellipse(pos.x, pos.y, 3,3);
   // }
   // else{
    // bombs.add(new Bomb(pos.x, pos.y));
    // alive = false;
   // }
    
  }
  
  
   
}