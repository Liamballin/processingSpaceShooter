//
//    
// 
//
//
//
//
//


//global score variables.
int score = 0;
int enemyPoints = 486;
int enemyPointsMissle = 638;

int gameState = 0;

Ship s1;


void setup() {
  //size(1000,1000);
  fullScreen();
  s1 = new Ship(20, 500);
  cursor(CROSS);
}



void draw() {
  //I use the draw call to check what state the game is in. Depending on that, It will defer to the specific secondary draw function.
  if (gameState == 1) {
    drawGame();
  } else if (gameState == 2) {
    drawGameOver();
  } else if (gameState == 0) {
    drawGameStart();
  }
}




void drawGameStart() {
  background(0);
  strokeWeight(1);
  grid(200, 10, 50, 20);
  textSize(100);
  textAlign(CENTER);
  text("Click to start", width/2, height/2);
  textSize(40);

  text("W,A,S,D to move", width/2, height/2+100);
  text("Left click to fire, Right click missiles", width/2, height/2+150);

  if (mousePressed) {
    gameState = 1;
  }
}

void drawGameOver() {
  background(0);
  strokeWeight(1);
  grid(200, 10, 50, 20);

  textSize(50);
  textAlign(CENTER);
  text("Game Over", width/2, height/2);
  textSize(25);
  text("Score: "+score, width/2, height/2+150);
}

void drawGame() {
  
  //the draw list order is intentional and makes sure that elements are drawn in the correct order, with the background and grid first, 
  //the all the game objects that are moving on top of that.
  //last are the GUI elements that sit on top of the screen.
  background(0);
  strokeWeight(1);
  //  for(bgTile t : tiles){
  //t.update(); 
  //  }
  grid(200, 10, 50, 20);
  waveControl();

  //updates all the instances in all arrayLists.
  for (Bullet b : bullets) {
    b.update();
  }
  for (Bomb b : bombs) {
    b.update();
  }
  for (Missle m : missles) {
    m.update();
  }
  for (Explosion e : explosions) {
    e.update();
  }
  for (Enemy_dash e : enemies) {
    e.update();
  }
  for (Homing h : homings) {
    h.update();
  }

  //more updates and checks to run every frame
  s1.update();
  collisionCheck();
  updateGui();
  bulletCheck();
  checkMissles();
  checkExplosions();
  checkHoming();
  checkEnemies();
}


//Create the array lists 

ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Missle> missles = new ArrayList<Missle>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
ArrayList<bgTile> tiles = new ArrayList<bgTile>();
ArrayList<Enemy_dash> enemies = new ArrayList<Enemy_dash>();
ArrayList<Homing> homings = new ArrayList<Homing>();