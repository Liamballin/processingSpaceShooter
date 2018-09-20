//the ship class
class Ship {
  PVector pos = new PVector();
  PVector vel = new PVector();

  PVector acc = new PVector();
  
   ArrayList<PVector> points = new  ArrayList<PVector>();
   float lastAdd = 0;
  float addDelay = 50;
  float trailLength = 3;
  
  

  float health = 100;
  float wallDamage = 1;
  float lastKey;

  float shield = 100;
  float shieldRecharge = .3;
  float healthRecharge = .015;

  float lastFired = 0;
  float fireDelay = 75;

  float lastMissle = 0;
  float missleDelay = 500;
  int missleCount = 5;

  float accMag = .25;
  //initializes the turning accelerations
  PVector aW = new PVector(0, -accMag);
  PVector aD = new PVector(accMag, 0);
  PVector aA = new PVector(-accMag, 0);
  PVector aS = new PVector(0, accMag);

  float mouseHeading = 0;


  Ship(float x, float y) { //initialize the isntance at specified location.
    pos.x = x;
    pos.y = y;
  }



  void update() {
      
    if(health <= 0){//test if the player is still alive.
     gameState = 2; 
    }
    
    //recharge health and sheild if necessary.
    if (shield < 100) {
      shield += shieldRecharge;
    }
    if(health < 100){
     health += healthRecharge; 
    }

      //this gets the heading of the mouse from the ship. I don't know why I have to subtract half pi, but it corrects the angle.
    PVector mouse = new PVector(mouseX, mouseY);
    PVector tpos = new PVector(pos.x, pos.y);
    mouse.sub(tpos);
    mouseHeading = mouse.heading()-HALF_PI;

    stroke(255);

    //take mouse input to fire, missle or gun depending on which mouse button was clicked.
    if (mousePressed) {
      if (mouseButton == LEFT) {
        fire();
      } else {
        missle();
      }
    }
    //a switch to test which key is pressed and move the ship. Using other methods like void KeyPressed were less effective, 
    //and I have found that this is the smoothest way to control the ship.
    //Pretty messy and a lot of commented out lines, but to turn it sets the accelleration equal to a direction and that is added to the velocity when a key is pressed.
    //
    if (keyPressed) {
      switch(key) { 
        case('w'):
        //vel.add(aW);
        acc = aW;
        lastKey = 'w';
        break;
        case('d'):
        // vel.add(aD);
        lastKey = 'd';
        acc = aD;
        break;
        case('a'):
        lastKey = 'a';
        // vel.add(aA);
        acc = aA;
        break;
        case('s'):
        lastKey = 's';
        // vel.add(aS);
        acc = aS;
        break;
        case(' '):
        println("Space");
      }
    }
    //This just detects wall collisions. Bounces back velocity and adds damage to the ship.
    if (pos.x > width || pos.x < 0) {
      vel.x *= -1; 
      damage(wallDamage);
      //health -= wallDamage;
      //screenFlash();
      //redFlash("top");
      //vel.mag();
      // acc.x *= 10;
    }
    if (pos.y > height || pos.y < 0) {
      vel.y *= -1; 
      //health -= wallDamage;
      damage(wallDamage);

      //acc.y *= 10;
    }

    //only accellerate if a direction key is pressed;
    if (keyPressed ) {
      if (key == 'a' ||key == 's' ||key == 'd' ||key == 'w') {
        vel.add(acc);
      }
    } else {

      //vel.sub(acc); 
      //vel.min(0);
    }
    //adds the velocity to the position to move the ship.
    vel.limit(10);
    pos.add(vel);


    //draws the ship. I use the velocity to colour the direction indicator line, using the map function.
    fill(#00E3FF);
    strokeWeight(5);
    float lineVal = map(abs(vel.x), 0, 10, 0, 255);
    stroke(#00E3FF,lineVal);
   // PVector aa = new PVector(vel.x, vel.y);
    //aa.normalize();
    //aa.mult(50);
    ///     line(pos.x, pos.y, pos.x+aa.x, pos.y+aa.y);
    line(pos.x, pos.y, pos.x+vel.x*2, pos.y+vel.y*2);
    trailRender();
    noStroke();
    ellipse(pos.x, pos.y, 10, 10);
  }
  
  //adds bullets into the bullet update list.
  //it gets the heading of the mouse from the ship, a variable of an angle stored in radians and updated every update call to the ship.
  //this also adds recoil, but it is very subtle because large amounts where disruptive to gameplay.
  void fire() {
    if (millis() - lastFired > fireDelay) {
      bullets.add(new Bullet(pos.x, pos.y, mouseHeading)); 
      lastFired = millis();  
      PVector recoil = new PVector(.1, .1);
      recoil.rotate(mouseHeading+PI+QUARTER_PI);
      vel.add(recoil);
    }
  }
//This method  adds a missile to the missles update list. I know I spelt 'missle' wrong, but I did it early on and decided to run with it. 
//because missiles in the game have a cooldown, this method checks to see if enough time has passed before firing another one.
  void missle() {

    if (millis() - lastMissle > missleDelay) {
      float tX = mouseX;
      float tY= mouseY;
      for (int i = 0; i<missleCount; i++) {
        missles.add(new Missle(pos, tX, tY, vel));
      }
      lastMissle = millis();
    }
  }
  //the damage method deals with all damage dealt to the ship. I used a method with the damage passed as an argument instead of just subtracting health becuase
  //the ship has a sheild and there is some logic around that. If i did this in every collision, it would get messy.
  void damage(float amount) {
    if (shield > 0) {
      shield -= 25;

      //health -= amount / 3;
    } else {
      health -= amount;
    }
    //if(shield < 0){
    //shield = 0; 
    //}
  }
  //This trail renderer method stores the last 5 (or whatever number) positions of the instance in an array list and then renders them. This gives the effect of a trail;
  //By changing the time intervals at which the positions are recorded, it changes the effect. Using a 50ms delay on the ship gives the effect of a rocket engine, while on the
  //projectiles I use no delay for a fire-y trail look.
  // I use the map() function a lot  to fade out instances at the end of the trail.
   void trailRender() {

    for (int i = 0; i< points.size(); i++) {
      PVector p = points.get(i);
      if (i+1 < points.size()) {
        PVector q = points.get(i+1);
      }
      fill(#00E3FF,map(i, 0, points.size(), 0, 255));
      float size = map(i, 0, points.size(), 1, 5);
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