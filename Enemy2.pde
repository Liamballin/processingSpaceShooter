//this is the enemy class constructor
//It is the second version of the enemy, and the first version is in the "EnemyClass" tab commented out.


class Enemy_dash {
  PVector pos = new PVector(250, 250);
  PVector vel = new PVector(.5, .5);
  PVector vel2 = new PVector(.5, .5);

  PVector target = new PVector();
  PVector lastPos = new PVector();
  
  float mode = 1; 
  // mode 1 is still, firing at player
  // mode 2 is moving to another position

  float moveDelay = 1500;
  float lastMove = 0;

  float health = 100;


  float arriveDistance = 10;
//this is the distance that counts as arriving at its target

  float lastFired = 0;
  float shotsTaken = 0;

  float fireDelay = 250;
  float shotsPerMove = 2;

  boolean moving;

  Enemy_dash(float x, float y) {
    pos.x = x;
    pos.y = y;
  }

  void fire() { //the enemey class can only take a certain number of shots when it is still, so this checks if it can fire. It also has a cooldown after each shot.
    if (millis() - lastFired > fireDelay) { 
      if (shotsTaken < shotsPerMove) {
        homings.add(new Homing(pos.x, pos.y));
        shotsTaken++;
        lastFired = millis();
      }
    }
  }

  void update() {
  //basic wall check
    if (pos.x < 0 || pos.x > width) {
      vel.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      vel.y *= -1;
    }



    if (mode == 1) {
      fire();
      moving = false;
      //println("Firing at " +millis());


      if (millis() - lastMove > moveDelay) {
        mode = 2;
        shotsTaken = 0;
      }
    } else if (mode == 2) { //mode 2 moving. This moves the enemy towards the target.
      if (moving) {
        vel2.add(vel);
        vel2.limit(5);
        pos.add(vel2);

        PVector tPos = pos.get();
        PVector tTar = target.get();
        tTar.sub(tPos);
        stroke(255);
        //    line(pos.x, pos.y, target.x, target.y);
        //  line(lastPos.x, lastPos.y, pos.x, pos.y);



        if (tTar.mag() < arriveDistance) {
          mode = 1; 
          moving = false;
          lastMove = millis();
          moveDelay = random(500, 3000);
          //checks if at destination and resets 'moving' switch if it has. if it has arrived, it also randomises the move delay.
        }
      } else { 
        //mode 2 but not moving - establish target to move towards.
        //one it has found a target location, the velocity is set as the current point - target point and mulitplied.
        lastPos = pos.get();
        target = new PVector(random(0, width), random(0, height));
        ellipse(target.x, target.y, 10, 10);
        PVector tPos = pos.get();
        PVector tTar = target.get();
        tTar.sub(tPos);
        tTar.normalize();
        tTar.mult(5);
        vel = tTar;
        //vel.rotate(tTar.heading());
        moving = true; //flip the moving 'switch' so that this target aquisition block won't run again until it has reached its target.
      }
    }
    
    //display the enemy.
    //There are two ellipses - one full size white one, and a secondary inner circle that represents the instance's health.
    noStroke();
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, 25, 25);
    fill(255);
    ellipse(pos.x, pos.y, map(health, 0, 100, 0, 25), map(health, 0, 100, 0, 25));
  }
}