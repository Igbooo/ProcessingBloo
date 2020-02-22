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
boolean sideLockOut = false;
boolean gameEndTrigger = false;
boolean lowResMode = false;

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
  bgMusic.amp(0.05);
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
  if (!gameEndTrigger) {
    if (lowResMode) {
      background(backgroundLowRes);
    } else {
      background(background);
    }
    blueCollision.collide(); //sick name btw
    obstacleInit.platDisplay();
    Timer.render();
    blue.render();
    obstacleInit.spikeDisplay();
  } else if (gameEndTrigger) {
    if (!Timer.endRan) {
      Timer.end();
    }
    bgMusic.stop();
    fill(55, 55, 55);
    rect(105, height / 2 - 55, 290, 190); //backdrop for the gameover text
    globalText(52);
    text("Game over\n'R' to quit", 125, height / 2);
    if (inputArray[3]) {
      //bgMusic.loop();
      //blue.gameEndTrigger = false;
      //obstacleInit.platformRedraw();
      //blue.defXY();
      exit();
    }
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
}

//notes

  //list of issues:

    //spikes don't have hitboxes (not started)
    //spikes spawn ALWAYS when there is overlap, random needs implemented (1/2, 2/3 ?) (not started)
    
    //jumping along the side and over a platform snaps you to the floor instead of continuing up (maybe its just "movement tech" :^) )

    //entering the air without jumping allows you to buffer a jump

    //timer makes it so the game has to restart in order for the timer to reset. it also only records latest time, not high score


  //features to do next:

    //spawning platforms, having them move up, despawn off the top, stay on the ground when they move

    //levels, speeds, score when you pass a platform, osd(?), menu, PogU

    //MK ghosts :eyes:


  //list of old issues that were amusing:

    //SUMMET IS UP WITH AIRSTATE (ur dumb lol, literally one pixel)

    //"list of issues: none" KEKW
