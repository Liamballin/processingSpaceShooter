
float bulletCollideDist = 35;

//this function checks the positions of objects and determines if they are colliding. 
//It does this by looping through, creating temporary PVectors, and then finding the magnitude.

void collisionCheck() {


  for (int bI = 0; bI < bullets.size()-1; bI++) { 
    Bullet b = bullets.get(bI);
    for (int eI = 0; eI < enemies.size(); eI++) {
      Enemy_dash e = enemies.get(eI);
      PVector en = e.pos.get();
      PVector bu = b.pos.get();

      en.sub(bu);
      if (en.mag() < bulletCollideDist) {
        if (bI < bullets.size()) {
          bullets.remove(bI);
          score += enemyPoints;
        }
        explosions.add(new Explosion(b.pos.x, b.pos.y));
        //e.hit("bullet");
        e.health -= 20;
      }
    }
  }

  for (int mI = 0; mI < missles.size(); mI ++) {
    Missle m = missles.get(mI);
    if (m.exploding) {
      for (Enemy_dash e : enemies) { 
        PVector tEn = e.pos.get();
        PVector tMi = m.pos.get();
        tEn.sub(tMi);
        if (tEn.mag() < 50) {
          e.health -= 75;
          score += enemyPointsMissle;
        }
      }
    }
  }
}
void checkEnemies() {
  //This might be paranoia or a misunderstanding on my part, but I was getting out of index errors when checking some things like this,
  //and I thought it might have been because when I removed an item from the list it messed up the indexes I was trying to access later on in the loop.
  //With this function, if the loop removes an item from the list it returns true and loops through again. If nothing is removed, it just exits.
  if (checkEnemiesLoop()) {
    checkEnemiesLoop();
  } else {
    return;
  }
}

boolean checkEnemiesLoop() {
  for (int i = 0; i < enemies.size(); i++) {
    Enemy_dash e = enemies.get(i);

    if (e.health <= 0) {
      enemies.remove(i);
      return true;
    } else if (e.pos.x > width || e.pos.x < 0) {
      enemies.remove(i);
      return true;
    } else if (e.pos.y > height || e.pos.y < 0) {
      enemies.remove(i);
      return true;
    }
  }
  return false;
}

void checkHoming() {
  if (checkHomingLoop()) {
    checkHomingLoop();
  } else {
    return;
  }
}

//this checks if homing missles have escaped the window and should be removed.


boolean checkHomingLoop() {
  for (int i = 0; i < homings.size(); i++) { 
    Homing h = homings.get(i);
    if (!h.alive) {
      homings.remove(i);
      return true;
    } else if (h.pos.x > width || h.pos.x < 0) {
      homings.remove(i);
      return true;
    } else if (h.pos.y > height || h.pos.y < 0) {
      homings.remove(i);
      return true;
    }
    //}else{
    // for(Enemy_dash e : enemies){ 
    //  PVector tEn = e.pos.get();
    //  PVector tHo = h.pos.get();
    //  tEn.sub(tHo);
    //  if(tEn.mag() < 20){
    //   e.health = -100;
    //   homings.remove(i);
    //   return true;
    //  }
    // }
    //}
  }
  return false;
}