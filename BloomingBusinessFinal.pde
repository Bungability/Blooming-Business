import processing.sound.*;
//Square Variables
int squaresize = 30;
int x = 935;
int y = 550;
int dx = 0;
int dy = 0;
int speed = 5;
//Variables for barriers
int w = 20;
int h = 20;
//Plant Variables
int plantcount = 10;
float randomx;
float randomy;
//Trap Variables
int crowcount = 15;
float xPos;
float yPos;
//Text Offset Variables
int planttextoffset = 300;
int scoretextoffset = 275;
float offsetdivider1 = 10;
float offsetdivider2 = 10;
//Setup Variables
int score = 0;
PFont f;
int health = 2;
PImage heart;
PImage scare;
int count;
float randolol = int(random(1, 100));
float randoscare;
boolean inSand = false;
int stage = 0;

SoundFile plantSFX;
SoundFile bgmusic;
SoundFile scoreSFX;
SoundFile sandSFX;
SoundFile bam;
SoundFile scary;
plant[] plants = new plant[30];
barrier[] barriers = new barrier[1];
obstacle[] crows = new obstacle[crowcount];
import g4p_controls.*;
PImage bg;
PImage bg1;
PImage win;
PImage loss;
PImage loading;
GImageButton myButton;
String[] files;
float startTime;
float timeElapsed;
int num = 0;
int can = 0;

void setup()
{
  size(1920, 1080);
    loading = (loadImage("Loading.png"));
  bg = (loadImage("Blooming Business BG.png"));
  win = (loadImage("You Win.png"));
  files = new String [ ] { "Start Button Up.png", "Start Button Over.png", "Start Button Over.png" };
  myButton = new GImageButton(this, width/2 - 550, height/2 - 450, files);
  background(79, 121, 66);
  heart = (loadImage("heart.png"));
  scare = (loadImage("chica.png"));
  scary = new SoundFile(this, "scarysound.mp3");
  plantSFX = new SoundFile(this, "collect.wav");
  bgmusic = new SoundFile(this, "bgmusic.mp3");
  scoreSFX = new SoundFile(this, "score.mp3");
  bam = new SoundFile(this, "explode.mp3");
  f = createFont ("ROTO Ranti.otf", 60);
  textFont(f);
  createPlants();
  createCrows();
  createBarriers();
  bgmusic.amp(1.0);
  bgmusic.play();
}


void draw()
{
image(loading, 0, 0);
 
  if (stage == 0) {
    background(bg);
  }
  if (stage == 1) {
    if (num == 0) {
      windowResize(1800, 1000);
      plantSFX = new SoundFile(this, "/u/horns450/Downloads/341695__projectsu012__coins-1.wav");
      sandSFX = new SoundFile(this, "/u/horns450/sketchbook/sketch_230622b/SF-footsteps_sand_wet2.mp3");
      sandSFX.amp(.3);
      bgmusic.loop();
      num += 1;
    }
    
  background(79, 121, 66);
  
  for(barrier b : barriers)
  {
    b.update();
  }
  scenery();
  for(obstacle o : crows)
  {
    o.update();
  }
  checkCollisions();
  x += dx;
  y += dy;
  coinsandcharacter();
  checkSell();
  startg();
  lives();
  easteregg();
}}

void coinsandcharacter()
{
  fill(255);
  stroke(198, 175, 88);
  textSize(60);
  text("Plants: " + collected, width - planttextoffset, 55);
  text("Score: " + score, width - scoretextoffset, 115);
    for (plant p : plants)
    {
      p.update();
    }
  checkWrap();
  fill(255);
  strokeWeight(4);
  square(x, y, squaresize);
}

void checkWrap()
{
  if (x > width - squaresize || x < -2)
  {
    x = x - dx;
  }
  if (y > height - squaresize || y < -2)
  {
    y = y - dy;
  }
  if (x + dx > 1325 && y < 500)
  {
    x = x - dx;
  }
  if (y + dy < 495 && x > 1320)
  {
    y = y - dy;
  }
  if (x + dx > 1325 && y > 875)
  {
    x = x - dx;
  }
  if (y + dy > 875 && x > 1325)
  {
    y = y - dy;
  }
 return;
}

void keyPressed()
{
  if (key == CODED && keyCode == UP)
  {
    dy = -speed;
  }
  if (key == CODED && keyCode == DOWN)
  {
    dy = speed;
  }
  if (key == CODED && keyCode == LEFT)
  {
    dx = -speed;
  }
  if (key == CODED && keyCode == RIGHT)
  {
    dx = speed;
  }
}

void keyReleased()
{
  if (key == CODED && keyCode == UP)
  {
    dy = 0;
  }
  if (key == CODED && keyCode == DOWN)
  {
    dy = 0;
  }
  if (key == CODED && keyCode == LEFT)
  {
    dx = 0;
  }
  if (key == CODED && keyCode == RIGHT)
  {
    dx = 0;
  }
}

void createPlants()
{
  for (int i = 0; i < 30; i++)
  {
    randomx = random(100 , width - 100);
    randomy = random(100, height - 100);
    if (randomx > 1300)
    {
      randomy = random(500,900);
    }
    if (randomx > 600 && randomx < 1250 && randomy > 200 && randomy < 700)
    {
      float pickone = random (0, 2);
      if (pickone <= 1)
      {
        randomy = random(50, 200);
      }
      else
      {
        randomy = random(700, 950);
      }
    } //<>//
      plants[i] = new plant(randomx, randomy);
  }
}

void createBarriers()
{
  
  barriers[0] = new barrier(950,340,600,300);
}

void checkCollisions()
{
  for(barrier b : barriers)
  {
    if(x+dx-w/2 < b.barrX+b.barrW/2
      && x+dx+w/2 > b.barrX-b.barrW/2 && y-h/2<b.barrY+b.barrH/2
      && y+h/2 > b.barrY-b.barrH/2){
      dx = 0;
  }
  
  if(x-w/2 < b.barrX+b.barrW/2 && x+w/2 > b.barrX-b.barrW/2
     && y + dy -h/2<b.barrY+b.barrH/2
     && y + dy +h/2 > b.barrY-b.barrH/2){
     dy = 0;
  }
  }
}

void checkSell()
{
  if (x >= 750 - squaresize && x <= 1175 && y >= 520 + squaresize && y <= 595 && collected != 0)
  {
    score = score + collected * 10;
    collected = 0;
    planttextoffset = 300;
    scoreSFX.play();
  }
    if(score / offsetdivider2 >= 1 && score / offsetdivider2 != 0)
    {
      scoretextoffset = scoretextoffset + 30;
      offsetdivider2 = offsetdivider2 * 10;
   }
   if (score == 300)
   {
     text("The farmer says, 'Well done, my child.'", 360, 700);
   }
 }

void startg()
{
  if (x == 935 && y == 550 && count == 0)
  {
    instructions();
  }
  else if (x == 935 && y == 550 && count == 1)
  {
    description();
  }
}

void mouseClicked()
{
  count++;
}
void lives()
{
  
  if(health == 3){
    //display heart graphic
    image(heart, -450, -475);
    image(heart, -350, -475);
    image(heart, -250, -475);
  }
  else if (health == 2){
    image(heart, -450, -475);
    image(heart, -350, -475);
  }
  else if (health == 1){
    image(heart, -450, -475);
  }
  else if (score != 300)
  {
    fill(165);
    strokeWeight(0);
    background(255);
    text("            GAME OVER!!\n The farmer is dissapointed.",450, 500);
    bgmusic.stop();
  }
  if (randolol ==99 && collected == 5)
  {
    fill(165);
    strokeWeight(0);
    background(255);
    bam.play();
    text("                GAME OVER!!\n The farmer was scared by your squareness\n and shot you on sight :(", 250, 500);
    bgmusic.stop();
  }
  else if (score == 300 && health == 0)
  {
    fill(165);
    strokeWeight(0);
    background(255);
    text("                GAME OVER!!\n You died after you won? That's sad.", 330, 500);
    bgmusic.stop();
  }
  if (score == 300) 
  {
      windowResize(1920, 1080);
      image(win, 900, 0);
  }
}

void createCrows()
{
  for (int i = 0; i < crowcount; i++)
  {
    xPos = random(0 , width);
    yPos = random(0, height);
    if (xPos > 1300)
      {
        yPos = random(500,900);
      }
      if (xPos > 600 && xPos < 1250 && yPos > 200 && yPos < 500)
      {
        float pick = random (0, 2);
        if (pick <= 1)
        {
          yPos = random(0, 200);
        }
        else
        {
          yPos = random(500, 1000);
        }
      }
     crows[i] = new obstacle(xPos,yPos); 
  }
}

void description()
{
  fill(234, 221, 202);
  rect(80, 600, width-160, 340);
  
  image(heart, -250, 230);
  textSize(40);
  fill(0);
  text("Hearts represent your number of lives left. \n  But be cafeful! Traps look a lot like coins.", 450, 750);
  
  textSize(25);
  text("click anywhere to continue", 1300, 920);

}

void instructions()
{
  fill(234, 221, 202);
  rect(80, 600, width-160, 340);
  //up
  stroke(0);
  rect(200, 700, 50, 50);
  
  fill(0);
  triangle(215, 725, 225, 705, 235, 725);
  rect(224, 725, 2, 20);
  
  //down
  fill(234, 221, 202);
  rect(200, 760, 50, 50);
  
  fill(0);
  triangle(215, 785, 225, 805, 235, 785);
  rect(224, 765, 2, 20);
  
  //left
  fill(234, 221, 202);
  rect(140, 760, 50, 50);
  
  fill(0);
  triangle(145, 785, 155, 765, 155, 805);
  rect(150, 785, 30, 3); 
 
  //right
  fill(234, 221, 202);
  rect(260, 760, 50, 50);

  fill(0);
  triangle(305, 785, 290, 765, 290, 805);
  rect(270, 785, 30, 3); 
  
  textSize(25);
  text("control using the \n arrow keys.", 120, 860); 
  
  textSize(40);
  text("collect all the coins the farmer dropped!", 450, 800);
  
  textSize(25);
  text("click anywhere to continue", 1300, 920);
}


void scenery()
{

  //water
  fill(0, 142, 204);
  stroke(0, 142, 204);
  rect(1300, 0, width-1300, 500);
 
  fill(0, 142, 204);
  stroke(0, 142, 204);
  rect(1300, 900, width-1300, 100);
  
  //path
  int tempx = width/3;
  fill(227, 150, 62);
  stroke(227, 150, 62);
  rect(tempx, 0,tempx + 150, height);

  fill(227, 150, 62);
  stroke(227, 150, 62);
  rect(1300, 500, width-1300, 400);
  
  fill(227, 150, 62);
  stroke(227, 150, 62);
  rect(tempx-300, 400, 500, 600);
  
  fill(227, 150, 62);
  stroke(227, 150, 62);
  rect(tempx-500, 700, 200, 300);

  //merchant house
  

  
  //planks of the house
  int y = height/2 - 200;
  int count = 10;
  
//fence
  fill(227, 150, 62);
  stroke(139, 64, 0);
  rect(650,190, 600, 300);    
  
  for (int i = 0; i < count; count--)
  {
  fill(184, 160, 109);
  strokeWeight(3);
  stroke(139, 64, 0);
  rect(700, y+20*count, 500, 20);
  }
  
  //roof
  fill(160, 82, 45);
  strokeWeight(6);
  stroke(128, 70, 27);
  triangle(650, height/2 - 170, 1250, height/2- 170, 950, height/2- 300);
  
  //plant beds
  fill(150, 105, 25);
  rect(400, tempx-40, 200, 325);
  
   rect(675, tempx+30, 500, 310);

   rect(1250, tempx-40, 200, 325);
   
  //window
  
  fill(255);
  rect(800, height/2 - 140, 290, 110);

  
  //merchant
  fill(193, 154, 107);
  rect(920, height/2-90, 60, 60);
  
  fill(100, 149, 237);
  stroke(96, 130, 182);
  rect(920, height/2-90, 60, 30);
  
  fill(100, 149, 237);
  stroke(96, 130, 182);
  rect(930, height/2-90, 40, 58);
  
  fill(193, 154, 107);
  stroke(139, 64, 0);
  circle(950, height/2 - 100, 35);
  
  fill(244, 187, 68);
  stroke(218, 165, 32);
  circle(950, height/2-115, 30);
  
  stroke(255, 0, 0);
  ellipse(950, height/2-107, 50, 10);
  
  stroke(218, 165, 32);
  ellipse(950, height/2-105, 50, 10);
  
  //sell zone
  stroke(196, 122, 57);
  strokeWeight(5);
  fill(227, 150, 62);
  rect(750, 520, 400, 75);

}

void easteregg()
{
  if(randoscare == 3)
  {
    image(scare, 0, -600);
    bgmusic.stop();
  }
}
void sand() {
  if ((x >= (width/3) && y >= 0) || (x >= 1300 && y >= 500) || (x >= (width/3)-300 && y >= 400) || (x >= (width/3)-500 && y >= 700)) {
    inSand = true;
  } else {
    inSand = false;
    sandSFX.stop();
  }
  if (inSand && !sandSFX.isPlaying()) {
    sandSFX.play();
  }
}

void handleButtonEvents(GImageButton button, GEvent event) {
  if (button == myButton) {

    myButton.dispose();
    myButton = null;
    //startScreen = false;
    stage = 1;

  }
}
