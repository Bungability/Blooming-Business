class obstacle{
 float trapX;
 float trapY;
 float coolDown = 4;
 float coolTimer;
 boolean onCooldown = false;
  color startColor = color(185,10,0);
  color cooldownColor = color(45,100,100);
  float w = 20;
  float maxWidth = 20;
 
  obstacle(float xpos, float ypos){
   trapX = xpos;
   trapY = ypos;
  }
  void update(){
   fill(185,10,0);
   if(onCooldown){
     fill(lerpColor(cooldownColor,startColor,1-coolTimer/coolDown));
     w = maxWidth * (1-coolTimer/coolDown);
     coolTimer -= 1/frameRate;
     if(coolTimer <= 0){
      onCooldown = false;
     }
   }
   
   stroke (237, 237, 81);
   fill(244, 216, 68);
   strokeWeight(2);
   circle(trapX,trapY, 15);
   if(!onCooldown && (dist(x + squaresize / 2, y + squaresize / 2, trapX, trapY) <= (squaresize / 2 + 15 / 2)))
   {
     health--;
     onCooldown = true;
     coolTimer = coolDown;
     bam.play();
   }
 }
}
