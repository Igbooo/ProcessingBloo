class timer { //the timer and high score system lives and displays here
  int ms = 0;
  int totalSeconds;
  int seconds;
  int minutes; 
  int timerX;
  int timerY;
  String hiScore; //10-18 for time
  boolean endRan = false;
  int totalMillis = 0;

  timer(int x, int y) {
    this.timerX = x;
    this.timerY = y;
  }

  void loadHiScore() {
    String[] lines = loadStrings("hiScore.txt");
    try {
      //text file tamper protection, it'll overwrite the file if what its looking for is too long or short
      hiScore = lines[0].substring(11, 19);
    } 
    catch (StringIndexOutOfBoundsException exception) {
      finishTime = createWriter("hiScore.txt");
    }
    catch (ArrayIndexOutOfBoundsException exception1) {
      finishTime = createWriter("hiScore.txt");
    }
    catch (NullPointerException exception2) {
      finishTime = createWriter("hiScore.txt");
    }
  }

  void millisReset() {
    totalMillis = totalMillis + (millis() - totalMillis);
  }

  void timeSet() { 
    totalSeconds = (millis() - totalMillis) / 1000;
    minutes = totalSeconds / 60;
    int subSecs = totalSeconds * 100;
    int subMins = minutes * 60;
    ms = ((millis() - totalMillis) / 10) - subSecs;
    seconds = ((millis() - totalMillis) / 1000) - subMins - 3;
  }

  void dispFreezeTimer() {
    if (lowResMode) {
      fill(55, 55, 55);
      rect(-10, 625, 900, 75);
    } else {
      fill(55, 55, 55);
      rect(-10, 925, 700, 75);
    } 
    
    globalText(32);
    text(str(seconds), timerX + 200, timerY);
  }

  void displayTimer() {
    if (lowResMode) {
      fill(55, 55, 55);
      rect(-10, 625, 900, 75);
    } else {
      fill(55, 55, 55);
      rect(-10, 925, 700, 75);
    }

    globalText(20);

    text("Tries: " + tries, timerX + 250, timerY + 10);

    text("Speed: " + obstacleInit.scrollSpeed, timerX + 350, timerY + 10);

    if (hiScore != null) {
      text("High Score: " + hiScore, timerX + 250, timerY - 20);
    } else {
      text("Complete a run to set a high score", timerX + 150, timerY - 20);
    }

    globalText(32);

    if (minutes < 10) {
      if (seconds < 10) {
        if (ms < 10) {
          text("0" + minutes + ":0" + seconds + ":0" + ms, timerX, timerY);
        } else {
          text("0" + minutes + ":0" + seconds + ":" + ms, timerX, timerY);
        }
      } else {
        if (ms < 10) {
          text("0" + minutes + ":" + seconds + ":0" + ms, timerX, timerY);
        } else {
          text("0" + minutes + ":" + seconds + ":" + ms, timerX, timerY);
        }
      }
    } else {
      if (seconds < 10) {
        if (ms < 10) {
          text(minutes + ":0" + seconds + ":0" + ms, timerX, timerY);
        } else {
          text(minutes + ":0" + seconds + ":" + ms, timerX, timerY);
        }
      } else {
        if (ms < 10) {
          text(minutes + ":" + seconds + ":0" + ms, timerX, timerY);
        } else {
          text(minutes + ":" + seconds + ":" + ms, timerX, timerY);
        }
      }
    }
  }

  void hiCheck() {
    ms -= 2;
    if (hiScore != null) {
      int [] hiTime = int(split(hiScore, ':'));
      if (minutes < hiTime[0]) {
        writeTime();
      } else if (minutes > hiTime[0]) {
        ;
      } else if (minutes == hiTime[0]) {
        if (seconds < hiTime[1]) {
          writeTime();
        } else if (seconds > hiTime[1]) {
          ;
        } else if (seconds == hiTime[1]) {
          if (ms < hiTime[2]) {
            writeTime();
          } else {
            ;
          }
        }
      }
    } else {
      writeTime();
    }
  }

  void writeTime() {
    finishTime = createWriter("hiScore.txt");
    if (minutes < 10) {
      if (seconds < 10) {
        if (ms < 10) {
          finishTime.println("Best time: 0" + minutes + ":0" + seconds + ":0" + ms);
        } else {
          finishTime.println("Best time: 0" + minutes + ":0" + seconds + ":" + ms);
        }
      } else {
        if (ms < 10) {
          finishTime.println("Best time: 0" + minutes + ":" + seconds + ":0" + ms);
        } else {
          finishTime.println("Best time: 0" + minutes + ":" + seconds + ":" + ms);
        }
      }
    } else {
      if (seconds < 10) {
        if (ms < 10) {
          finishTime.println("Best time: " + minutes + ":0" + seconds + ":0" + ms);
        } else {
          finishTime.println("Best time: " + minutes + ":0" + seconds + ":" + ms);
        }
      } else {
        if (ms < 10) {
          finishTime.println("Best time: " + minutes + ":" + seconds + ":0" + ms);
        } else {
          finishTime.println("Best time: " + minutes + ":" + seconds + ":" + ms);
        }
      }
    }
  }

  void end() {
    timeSet();

    if (deathType == 2) {
      hiCheck();
    }

    if (finishTime != null) {
      finishTime.flush();
      finishTime.close();
    }
    endRan = true;
  }
  
  void freezeRender() {
    timeSet();
    dispFreezeTimer();
  }

  void render() {
    timeSet();
    displayTimer();
  }
}
