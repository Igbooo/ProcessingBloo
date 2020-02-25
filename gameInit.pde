class gameInit {

  boolean gameSetup = false;
  int currentMenuArray = 0;
  int gameState = 0; //0 = menu, 1 = game, 2 = pause

  void firstSetup() {
    background = loadImage("altBG.png");             //incidental
    backgroundLowRes = loadImage("altBGLowRes.png"); //incidental
    cSansMS = createFont("comic.ttf", 32);           //incidental
    PImage icon = loadImage("icon1.png");            //on program load
    surface.setIcon(icon);                           //on program load
    surface.setTitle("Bloo");                        //on program load
  }

  void gameSetup() {
    blue = new player();                             //on game load
    obstacleInit = new obstacleInit();               //on game load
    blueCollision = new collision(blue);             //on game laod
    //bgMusic.loop();                                  //on game load
    Timer = new timer(25, height - 25);              //on game load
    Timer.loadHiScore();                             //game load
    obstacleInit.platformInit();                     //game load
    obstacleInit.spikeInit();                        //game load  
    gameSetup = true;
  }

  void menuLoop() {
    if (menuLockOut == true && (!inputArray[2] && !inputArray [5] && !inputArray[4])) {
      menuLockOut = false;
    }

    if (inputArray[2] && menuLockOut == false) {
      menuLockOut = true;
      currentMenuArray -= 1;
      if (currentMenuArray == -1) {
        currentMenuArray = 2;
      }
    } else if (inputArray[5] && menuLockOut == false) {
      menuLockOut = true;
      currentMenuArray += 1;
      if (currentMenuArray == 3) {
        currentMenuArray = 0;
      }
    }

    if (lowResMode) {
      background(backgroundLowRes);
    } else {
      background(background);
    }
    globalText(64);
    textAlign(CENTER, CENTER);
    text("Bloo", 0, 0, width, 200);

    globalText(32);
    textAlign(CENTER, CENTER);
    text("Play Game", 0, 200, width, 250); 
    text("View High Scores", 0, 250, width, 300);
    text("Quit", 0, 300, width, 350);

    stroke(255);
    strokeWeight(2);
    if (currentMenuArray == 0) {
      line(150, 350, 350, 350);
    } else if (currentMenuArray == 1) {
      line(100, 425, 400, 425);
    } else if (currentMenuArray == 2) {
      line(175, 500, 325, 500);
    }

    if (inputArray[4] && menuLockOut == false) {
      switch(currentMenuArray) {
      case 0:
        if (deathType != 0) {
          restart();
        }
        gameState = 1;
        menuLockOut = true;
        break;
      case 1:
        menuLockOut = true;
        break;
      case 2:
        menuLockOut = true;
        exit();
      }
    }
  }

  void gameLoop() {
    if (lowResMode) {
      background(backgroundLowRes);
    } else {
      background(background);
    }
    blueCollision.collide(); //sick name btw
    obstacleInit.platDisplay();
    obstacleInit.spikeDisplay();
    obstacleInit.platTopCheck();
    obstacleInit.spikeTopCheck();
    Timer.render();
    blue.render();
  }

  void endSplash() {
    if (!Timer.endRan) {
      Timer.end();
    }
    //bgMusic.stop();
    if (deathType == 1) {
      fill(255, 0, 0); 
      rect(-10, height / 2 - 55, width + 20, 300);
      globalText(50);
      textAlign(CENTER, TOP);
      text("Game over\n'R' to restart\n Enter to go to menu", 0, height / 2 - 55, width, 300);
    } else if (deathType == 2) {
      fill(0, 200, 0);
      rect(-10, height / 2 - 55, width + 20, 300);
      globalText(50);
      textAlign(CENTER, TOP);
      text("You win! \n'R' to restart\n Enter to go to menu", 0, height / 2 - 55, width, 300);
    }

    if (inputArray[3]) {
      restart();
    }
    if (inputArray[4]) {
      gameState = 0;
    }
  }

  void restart() {
    Timer.endRan = false;
    tries += 1;
    //bgMusic.loop();
    obstacleInit.platformRedraw();
    obstacleInit.spikeRedraw();
    deathType = 0;
    blue.defXY();
    Timer.millisReset();
    Timer.loadHiScore();
  }
}
