int collected = 0;
class plant
{
  float plantX;
  float plantY;
  float plantsize = 15;
  boolean active;
  plant(float xpos, float ypos)
  {
    plantX = xpos;
    plantY = ypos;
    active = true;
  }
  void update()
  {
    if (active == true)
    {
      fill (237, 237, 81);
      strokeWeight(2);
      circle(plantX, plantY, plantsize);
      if (dist(x + squaresize / 2, y + squaresize / 2, plantX, plantY) <= (squaresize / 2 + plantsize / 2) 
      ) 
      {
        collect();
      }
    }
  }
  void collect()
  {
    collected++;
    active = false;
    if (collected % offsetdivider1 <= 1 && collected != 1)
    {
      planttextoffset = planttextoffset + 24;
      offsetdivider1 = offsetdivider1 * 10;
    }
    plantSFX.amp(1.0);
    plantSFX.play();
    randoscare = int(random(0, 600));
    if (randoscare == 3)
    {
      scary.play();
    }
    }
  }
