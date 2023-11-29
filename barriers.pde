class barrier
{
  float barrX;
  float barrY;
  int barrW;
  int barrH;
  
  barrier(float xpos, float ypos, int w, int h){
    barrX = xpos;
    barrY = ypos;
    barrW = w;
    barrH = h;
    }
  
  void update()
  {
    //fill(79, 121, 66);
    fill(255, 0, 0);
    stroke(79, 121, 66);
    rect(barrX-barrW/2,barrY-barrH/2,barrW,barrH);
   }
}
