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
gameInit gameInit;
PrintWriter finishTime;
boolean inputArray[] = new boolean [7]; //go look in keyPressed it makes sense lol
ArrayList<platform> platformList = new ArrayList<platform>();
ArrayList<wallSpikes> spikeList = new ArrayList<wallSpikes>();
boolean lowResMode = false;
boolean leftLockOut = false;
boolean rightLockOut = false;
boolean menuLockOut = false;
int deathType = 0; //0 = not dead, 1 = spike death, 2 = win
int tries = 0;
int timeStamp = -1;

void settings() {
  if (lowResMode) {
    size(500, 700);
  } else {
    size(500, 1000);
  }
}

void setup() {
  gameInit = new gameInit();
  gameInit.firstSetup();
  bgMusic = new SoundFile(this, "bgCLP.wav");      //incidental
  bgMusic.amp(0.05); //default 0.05                   //incidental
}

void draw() {
  switch(gameInit.gameState) {
  case 0: //menu
    gameInit.menuLoop();
    break;

  case 1: // game ing
    if (deathType == 0) {
      if (!gameInit.gameSetup) {
        gameInit.gameSetup();
        gameInit.gameSetup = true;
      }
      if (gameInit.freezeTime) {
        if (timeStamp == -1) {
          timeStamp = millis();
        }
        
        if (millis() > timeStamp + 3000) {
          gameInit.freezeTime = false;
        } else {
          gameInit.freezeLoop();
        }
      } else {
        gameInit.gameLoop();
      }
      break;
    } else {
      gameInit.endSplash();
      break;
    }
    
  case 2: //paused !!!
    gameInit.pauseLoop();
    break;
  }
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
  if (keyCode == 10) {
    inputArray[4] = true;
  }
  if (keyCode == DOWN) {
    inputArray[5] = true;
  }
  if (key == 'p' || key == 'P') {
    inputArray[6] = true;
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
  if (keyCode == 10) {
    inputArray[4] = false;
  }
  if (keyCode == DOWN) {
    inputArray[5] = false;
  }
  if (key == 'p' || key == 'P') {
    inputArray[6] = false;
  }
}

void globalText (int size) {
  fill(255);
  textFont(cSansMS);
  textSize(size);
  textAlign(TOP);
}
