//an unused object, would have lit up each background tile as the player passed over it.
//

class bgTile {
  float x, y;
  float clr = 0;
  boolean hit = false;
  float size = 50;

  bgTile(float x1, float y1) {
    x = x1;
    y = y1;
  }

  void update() {
    if (mouseX > x && mouseX < x+size && mouseY > y && mouseY < y+size ) {
      hit = true; 
      
      clr = 100;
      
    }
    if(hit){
     clr -= 10;
    }
    if(clr <= 0){
     hit = false; 
    }
    fill(clr);
    noStroke();
    rect(x,y,size,size);
  }
}

void tileGen() {
  float size = 50;
 float sizeX = width/size+1;
 float sizeY = height/size+1;
  for (int x = 0; x < sizeX; x ++) {
    for (int y = 0; y < sizeY; y ++) {
      tiles.add(new bgTile(x*size, y*size));
    }
  }
}