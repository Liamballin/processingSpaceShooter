class Missle {

  PVector pos = new PVector();
  PVector vel2 = new PVector(0, 0);
  PVector acc2 = new PVector(.002, .002);

  PVector vel1 = new PVector(.5, .5);
  PVector acc1 = new PVector(.01, .01);

  PVector target = new PVector();

  float lifeTime = 1000;
  boolean alive = true;

  boolean locked = false;
  
  boolean exploding = false;

  float stage2Scalar = 1;

  float birth;
  float changeStateTime = 250;
  
  float missleLength = 1000;

  int state = 1;

  Missle(PVector pos1, float tX, float tY, PVector velx) { // arguments are: vector of initial position(the player), target x and y, and current velocity of player
    pos.x = pos1.x;
    pos.y = pos1.y;
    //pos = pos1;
    vel1 = velx.get(); 
    target.x = tX;
    target.y = tY;
    birth = millis();
    vel1.add(random(0, 5)*random(-1, 1), random(0, 5)*random(-1, 1)); //randomise velocity for first stage
  }

  void update() {
    //this block creates two temporary vector and subtracts them to find the distance between the missle and its target.
    PVector posT = pos.get();
    posT.add(vel2);
    PVector tarT = target.get();
    posT.sub(tarT);
    float dist = posT.mag(); 
    
    //checks if the missle is on the target and should detonate
    if (dist > 50){//abs(pos.x-target.x) > 15 && abs(pos.y - target.y) > 15){//millis()-birth < lifeTime) {
         //determines what state the missle is in. states have different behaviors and velocities, but share a position vector

      if (millis() - birth < changeStateTime) {
        state = 0;
      } else {
        state = 1;
      }

      if (state == 0) { //stage one
        vel1.add(acc1);
        ///vel1.rotate(random(0,10));
        pos.add(vel1);
        fill(0, 255, 0);
      } else { //stage two
        if (!locked) { // perform a one time rotation towards the target
        //create two temp vectors for subtraction
          PVector tMissle = new PVector(pos.x, pos.y);
          PVector tTar = new PVector(target.x, target.y);
          tTar.sub(tMissle); // the vector now points towards the target, from the ship.
          tTar.normalize(); // set magnitude to 1
          tTar.mult(stage2Scalar); //currently set to one, so has no effect
          vel2 = tTar; // set second stage velocity to tTar
          acc2 = tTar.div(10); // divide by ten, not sure if this does anything.
          locked = true; //this will stop current block executing again.
          //float heading = PVector.angleBetween(pos, target);
          //vel2.rotate(tTar.heading());
        }
        vel2.add(acc2);

        vel2.limit(50);
        pos.add(vel2);
        fill(255, 0, 0);
      }

      stroke(255);

      if (state == 1) {

        strokeWeight(2);
      } else {
        strokeWeight(3);
      }
      //The line of the missle is drawn between the position and the position + velocity so that the line points in the direction the missle is moving
      PVector lineVel = new PVector(vel2.x, vel2.y);
      //normalize and multiply to have uniform length
      //program doesn't use these, should probably delete. using velocity of missle as length makes it appear faster + looks smoother
      lineVel.normalize();
      lineVel.mult(missleLength);
      
      line(pos.x, pos.y, pos.x+vel2.x, pos.y+vel2.y);
      strokeWeight(1);
    } else {
      // turning alive to false stops the missile being drawn and it will be removed by the next loop of missle check. 
      alive = false;
      explosions.add(new Explosion(pos.x+vel2.x, pos.y+vel2.y));
      exploding = true;
    }
  }
}