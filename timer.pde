class timer { //the timer and high score system lives and displays here
  int ms = 0;
  int totalSeconds;
  int seconds;
  int minutes; 
  int timerX;
  int timerY;
  String hiScore [];
  boolean endRan = false;
  int totalMillis = 0;
  int[][] hiTime;
  int intLevel = int(level);

  timer(int x, int y) {
    this.timerX = x;
    this.timerY = y;
    hiScore = new String[5]; //10-18 for time
    hiTime = new int[5][3];
  }

  void loadHiScore() {
    if (hiScore[0] == null) {
      String[] lines = loadStrings("hiScore.txt");
      try {
        //text file tamper protection, it'll overwrite the file if what its looking for is too long or short
        hiScore[0] = lines[0].substring(11, 19);
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

      try {
        hiScore[1] = lines[1].substring(11, 19);
        hiScore[2] = lines[2].substring(11, 19);
        hiScore[3] = lines[3].substring(11, 19);
        hiScore[4] = lines[4].substring(11, 19);
      }
      catch (StringIndexOutOfBoundsException exception3) {
        ;
      }
      catch (ArrayIndexOutOfBoundsException exception4) {
        ;
      }
      catch (NullPointerException exception5) {
        ;
      }
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
    seconds = ((millis() - totalMillis) / 1000) - subMins;
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

    text("Level: " + intLevel, timerX + 350, timerY + 10);

    if (hiScore[intLevel] != null) {
      text("High Score: " + hiScore[intLevel], timerX + 250, timerY - 20);
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
    if (hiScore[0] != null) {
      int [] hiSplit = new int[3];
      for (int i = 0; i < 5; i++) {
        hiSplit = int(split(hiScore[i], ":"));
        hiTime[i][0] = hiSplit[0];
        hiTime[i][1] = hiSplit[1];
        hiTime[i][2] = hiSplit[2];
      }
      if (minutes < hiTime[intLevel][0]) {
        writeTime();
      } else if (minutes > hiTime[intLevel][0]) {
        ;
      } else if (minutes == hiTime[intLevel][1]) {
        if (seconds < hiTime[intLevel][1]) {
          writeTime();
        } else if (seconds > hiTime[intLevel][1]) {
          ;
        } else if (seconds == hiTime[intLevel][1]) {
          if (ms < hiTime[intLevel][2]) {
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
    if (minutes < 10) {
      if (seconds < 10) {
        if (ms < 10) {
          hiScore[intLevel] = ("0" + minutes + ":0" + seconds + ":0" + ms);
        } else {
          hiScore[intLevel] = ("0" + minutes + ":0" + seconds + ":" + ms);
        }
      } else {
        if (ms < 10) {
          hiScore[intLevel] = ("0" + minutes + ":" + seconds + ":0" + ms);
        } else {
          hiScore[intLevel] = ("0" + minutes + ":" + seconds + ":" + ms);
        }
      }
    } else {
      if (seconds < 10) {
        if (ms < 10) {
          hiScore[intLevel] = (minutes + ":0" + seconds + ":0" + ms);
        } else {
          hiScore[intLevel] = (minutes + ":0" + seconds + ":" + ms);
        }
      } else {
        if (ms < 10) {
          hiScore[intLevel] = (minutes + ":" + seconds + ":0" + ms);
        } else {
          hiScore[intLevel] = (minutes + ":" + seconds + ":" + ms); //<>//
        }
      }
    }
    writeFile();
  }

  void writeFile() {
    finishTime = createWriter("hiScore.txt");
    for (int i = 0; i < 5; i++) {
      finishTime.println("Best time: " + hiScore[i]);
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

  void render() {
    timeSet();
    displayTimer();
  }
}
