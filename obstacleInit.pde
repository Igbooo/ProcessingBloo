class obstacleInit { //obstacleInit calls the creation & display of platforms and wallSpikes

  void platformRedraw() {
    for (int i = platformList.size() - 1; i > -1; i--) {
      platformList.remove(i);
    }
    platformInit();
  }

  void spikeRedraw() {
    for (int i = spikeList.size() - 1; i > -1; i--) {
      spikeList.remove(i);
    }
    spikeInit();
  }

  void platformInit() { //int x, int y, int pltWidth, int pltType
    if (lowResMode) {
      int randWidth;
      int rowVertSpacing = 100;
      int lowestRowY = 550;
      int rows = (lowestRowY/rowVertSpacing)-1;
      //ground
      platformList.add(new platform(-200, 625, 900, 0));

      for (int i = 0; i <= rows; i++) {
        randWidth = int(random(60, 440));
        platformList.add(new platform(-100, lowestRowY, randWidth, 1));
        platformList.add(new platform((-100+randWidth)+100, lowestRowY, (width-randWidth)+200, 1)); 
        lowestRowY -= 100;
      }
    } else {
      int randWidth;
      int rowVertSpacing = 100;
      int lowestRowY = 825; //850 
      int rows = (lowestRowY/rowVertSpacing)-1;
      //ground
      platformList.add(new platform(-200, 925, 700, 0));

      for (int i = 0; i <= rows; i++) {
        randWidth = int(random(60, 440));
        platformList.add(new platform(-100, lowestRowY, randWidth, 1));
        platformList.add(new platform((-100+randWidth)+100, lowestRowY, (width-randWidth)+50, 1)); 
        lowestRowY -= 100;
      }
    }
  }

  void platDisplay() {
    for (int i = 0; i < platformList.size(); i++) {
      platform currentPlt = platformList.get(i);
      currentPlt.render();
    }
  }

  void spikeInit() {
    //check we can spawn a spike
    for (int i = 1; i < platformList.size() - 4; i = i +2) { //exceptions are made cause the floor is in the array list, will break when [0] is a normal platform
      int rand = int(random(1, 4));
      platform plt0 = platformList.get(i);
      platform plt1 = platformList.get(i+1);
      platform plt2 = platformList.get(i+2);
      platform plt3 = platformList.get(i+3);
      if (plt1.x < (plt2.x + plt2.pltWidth) - 50) {
        if (rand != 4) {
          spikeList.add(new wallSpikes(int(random(plt1.x, (plt2.x + plt2.pltWidth) - 35)), plt1.y - 85, 1)); //x, y, dir
        }
      } else if (plt3.x < (plt0.x + plt0.pltWidth) - 50) {
        if (rand != 4) {
          spikeList.add(new wallSpikes(int(random(plt3.x, (plt0.x + plt0.pltWidth) - 35)), plt0.y - 85, 2));
        }
      }
    }
  }

  void spikeDisplay() {
    for (int i = 0; i < spikeList.size(); i++) {
      wallSpikes currentSpike = spikeList.get(i);
      currentSpike.render();
    }
  }
}
