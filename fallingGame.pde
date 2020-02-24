//BE CAREFUL, THERE IS SOUND (if you have the processing.sound library)
//notes at the bottom of this file, If marking please read the 'READ ME please.txt' file and the notes at the bottom if this file

import processing.sound.*;

SoundFile bgMusic;
PFont cSansMS;
PImage background;
PImage backgroundLowRes;
player blue;
collision blueCollision;
timer Timer;
obstacleInit obstacleInit;
PrintWriter finishTime;
boolean inputArray[] = new boolean [4]; // 0=LEFT, 1=RIGHT, 2=JUMP 3=RESTART
ArrayList<platform> platformList = new ArrayList<platform>();
ArrayList<wallSpikes> spikeList = new ArrayList<wallSpikes>();
//boolean gameEndTrigger = false;
boolean lowResMode = false;
boolean leftLockOut = false;
boolean rightLockOut = false;
int deathType = 0; //0 = not dead, 1 = spike death, 2 = win
int tries = 0;


void settings() {
  if (lowResMode) {
    size(500, 700);
  } else {
    size(500, 1000);
  }
}

void setup() {
  background = loadImage("altBG.png");
  backgroundLowRes = loadImage("altBGLowRes.png");
  bgMusic = new SoundFile(this, "bgCLP.wav");
  bgMusic.amp(0); //default 0.05
  bgMusic.loop();
  cSansMS = createFont("comic.ttf", 32);
  PImage icon = loadImage("icon1.png");
  surface.setIcon(icon);
  surface.setTitle("Bloo");
  blue = new player();
  obstacleInit = new obstacleInit();
  blueCollision = new collision(blue);
  Timer = new timer(25, height - 25);
  Timer.loadHiScore();
  obstacleInit.platformInit();
  obstacleInit.spikeInit();
}

void draw() {
  if (deathType == 0) {
    if (lowResMode) {
      background(backgroundLowRes);
    } else {
      background(background);
    }
    blueCollision.collide(); //sick name btw
    obstacleInit.platDisplay();
    obstacleInit.spikeDisplay();
    obstacleInit.platTopCheck();
    Timer.render();
    blue.render();
  } else {
    endSplash();
  }
}

void endSplash() {
  if (!Timer.endRan) {
    Timer.end();
  }
  bgMusic.stop();
  if (deathType == 1) {
    fill(255, 0, 0);
    rect(-10, height / 2 - 55, width + 20, 190);
    globalText(52);
    textAlign(CENTER, TOP);
    text("Game over\n'R' to restart", 0, height / 2 - 55, width, 190);
  } 
  else if (deathType == 2) {
    fill(0, 200, 0);
    rect(-10, height / 2 - 55, width + 20, 190);
    globalText(52);
    textAlign(CENTER, TOP);
    text("You win! \n'R' to restart", 0, height / 2 - 55, width, 190);
  }

  if (inputArray[3]) {
    restart();
  }
}

void restart() {
  Timer.endRan = false;
  tries += 1;
  bgMusic.loop();
  obstacleInit.platformRedraw();
  obstacleInit.spikeRedraw();
  deathType = 0;
  blue.defXY();
  Timer.millisReset();
  Timer.loadHiScore();
}

void keyPressed() {
  if (keyCode == LEFT) {
    inputArray[0] = true;
  }
  if (keyCode == RIGHT) {
    inputArray[1] = true;
  }
  if (key == 32 || keyCode == UP) {
    inputArray[2] = true;
  }
  if (key == 'r' || key == 'R') {
    inputArray[3] = true;
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    inputArray[0] = false;
  }
  if (keyCode == RIGHT) {
    inputArray[1] = false;
  }
  if (key == 32 || keyCode == UP) {
    inputArray[2] = false;
  }
  if (key == 'r' || key == 'R') {
    inputArray[3] = false;
  }
}

void globalText (int size) {
  fill(255);
  textFont(cSansMS);
  textSize(size);
  textAlign(TOP);
}
