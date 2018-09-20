
//draws the background grid
void grid(int rows, int c, int gap, float clr){
  stroke(clr);
  
 for(int r = 0; r < rows; r += 1){
   line(0,gap*r, width, gap*r);
   line(gap*r, 0, gap*r,height);
 }
}
//deletes stray bullets to keep performance up
void bulletCheck(){
 for(int i =0;i< bullets.size();i++){
  Bullet b = bullets.get(i);
  PVector p = b.pos;
   if(p.x > width || p.x < 0 || b.alive == false){
    bullets.remove(i); 
   }else if(p.y > height || p.y < 0){
     bullets.remove(i);
   }
   
 }
}