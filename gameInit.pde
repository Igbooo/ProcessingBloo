class gameInit { //<>//

  boolean gameSetup = false;
  int currentMenuArray = 0;
  int gameState = 0; //0 = menu, 1 = game, 2 = pause
  int eMenuState = 0; //0 = moving into frame, 1 = remaining in frame, 2 = moving out of frame
  float menuRectY = 0;

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
    bgMusic.loop();                                  //on game load
    Timer = new timer(25, height - 25);              //on game load
    Timer.loadHiScore();                             //game load
    obstacleInit.platformInit();                     //game load
    obstacleInit.spikeInit();                        //game load
    Timer.millisReset();
    gameSetup = true;
  }

  void menuLoop() {
    bgMusic.stop();
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
      bgMusic.stop();
      blue.display();
      delay(250);
    }
    endMenuLoop();
  }

  void endMenuLoop() {
    //variables are initialised as blank cause stuff
    String splashText = "";
    String contText = "";
    color endMenuBg = color(0);

    switch (deathType) {
    case 1:
      splashText = "You Died!";
      contText = "Retry";
      endMenuBg = color(255, 0, 0);
      break;
    case 2:
      splashText = "You Win!";
      contText = "Next Level";
      endMenuBg = color(0, 200, 0);
      break;
    }

    switch (eMenuState) {
    case 0: //trans in
      fill(endMenuBg);
      noStroke();
      rect(0, 0, width, (int) (menuRectY));
      if (menuRectY < height - 75) {
        menuRectY += 12.5;
      } else {
        eMenuState = 1;
      }
      break;
    case 1: //disp menu
      fill(endMenuBg);
      noStroke();
      rect(0, 0, width, (int) (menuRectY));

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

      globalText(64);
      textAlign(CENTER, CENTER);
      text(splashText, 0, 0, width, 200);

      globalText(32);
      textAlign(CENTER, CENTER);
      text(contText, 0, 200, width, 250);
      text("Back To Menu", 0, 250, width, 300);
      text("Quit", 0, 300, width, 350);

      if (obstacleInit.scrollSpeed == 2.0) {
        globalText(10);
        textAlign(CENTER, CENTER);
        text("Did you know?: 2.0 is beatable! Probably...", 0, height - 200, width, height - 150);
      }

      stroke(255);
      strokeWeight(2);
      if (currentMenuArray == 0) {
        line(150, 350, 350, 350);
      } else if (currentMenuArray == 1) {
        line(125, 425, 375, 425);
      } else if (currentMenuArray == 2) {
        line(200, 500, 300, 500);
      }

      if (inputArray[4] && menuLockOut == false) {
        switch(currentMenuArray) {
        case 0:
          eMenuState = 0;
          restart();
          break;
        case 1:
          eMenuState = 0;
          gameState = 0;
          break;
        case 2:
          exit();
        }
      }
      break;
    }
  }

  void restart() {
    menuRectY = 0;
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
}
