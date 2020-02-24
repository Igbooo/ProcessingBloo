class collision { //this is where we detect wether a passed in player object is colliding with a obstacle
  player currentPlayer;

  collision(player currentPlayer) {
    this.currentPlayer = currentPlayer;
  }

  void logic() {
    int collided;
    int collidedPlt = -1;
    int bonkPlt = -1;
    int leftCollPlt = -1;
    int rightCollPlt = -1;

    //Ceiling
    for (int i = 0; i < platformList.size(); i++) {
      collided = ceilingCollide(i);
      if (collided != -1) {
        bonkPlt = collided;
      }
    }
    if (bonkPlt != -1) {
      bonkLogic();
    }
    //left wall
    for (int i = 0; i < platformList.size(); i++) {
      collided = leftWallCollide(i);
      if (collided != -1) {
        leftCollPlt = collided;
      }
    }
    if (leftCollPlt != -1) {
      wallCollLogic(2);
    } else {
      rightLockOut = false;
      //right wall
      for (int i = 0; i < platformList.size(); i++) {
        collided = rightWallCollide(i);
        if (collided != -1) {
          rightCollPlt = collided;
        }
      }
      if (rightCollPlt != -1) {
        wallCollLogic(1);
      } else { 
        leftLockOut = false;
      }
    }

    //floor
    for (int i = 0; i < platformList.size(); i++) {
      collided = collide(i);
      if (collided != -1) {
        collidedPlt = collided;
      }
    }
    if (collidedPlt == -1) {
      airLogic();
    } else {
      collideLogic(collidedPlt);
    }

    //Spikes 
    for (int i = 0; i < spikeList.size(); i++) {
      spikesCollide(i);
    }
  }

  int collide(int i) { //checks for plat collision, 
    platform currentPlt = platformList.get(i);
    if ((currentPlayer.x + 50) > currentPlt.x && 
      (currentPlayer.x+12) < currentPlt.x + currentPlt.pltWidth && 
      (currentPlayer.y + 57) > currentPlt.y && 
      (currentPlayer.y + 57) < currentPlt.y + currentPlt.pltHeight) { 
      { 
        return i;
      }
    } else { //collision false
      return -1;
    }
  }

  int ceilingCollide(int i) {
    platform currentPlt = platformList.get(i);
    if ((currentPlayer.x + 50) > currentPlt.x && 
      (currentPlayer.x+12) < currentPlt.x + currentPlt.pltWidth && 
      currentPlayer.y + 7 > currentPlt.y + currentPlt.pltHeight - 10 &&
      currentPlayer.y + 7 < currentPlt.y + currentPlt.pltHeight) 
    { //if head hits ceiling
      return i;
    } else {
      return -1;
    }
  }

  int leftWallCollide(int i) {
    platform currentPlt = platformList.get(i);
    if (currentPlayer.y + 55 > currentPlt.y &&
      currentPlayer.y + 7 < currentPlt.y + currentPlt.pltHeight &&
      currentPlayer.x + 50 < currentPlt.x + 10 &&
      currentPlayer.x + 50 > currentPlt.x) {
      return i;
    } else {
      return -1;
    }
  }

  int rightWallCollide(int i) {
    platform currentPlt = platformList.get(i);
    if (currentPlayer.y + 55 > currentPlt.y &&
      currentPlayer.y + 7 < currentPlt.y + currentPlt.pltHeight &&
      currentPlayer.x + 12 > currentPlt.x + currentPlt.pltWidth - 10 &&
      currentPlayer.x + 12 < currentPlt.x + currentPlt.pltWidth) {
      return i;
    } else {
      return -1;
    }
  }

  void spikesCollide(int i) {
    wallSpikes currentSpikes = spikeList.get(i);
    if (currentPlayer.y + 55 > currentSpikes.y &&
      currentPlayer.y + 7 < currentSpikes.y + currentSpikes.spikeHeight) {
      if (currentPlayer.x + 12 > currentSpikes.x && currentPlayer.x + 12 < currentSpikes.x + currentSpikes.spikeWidth) { //hit right side
        if (currentSpikes.dir == 1) {
          wallCollLogic(currentSpikes.dir);
        } else if (currentSpikes.dir == 2) {
          spikeBladeCollide();
        }
      } else if (currentPlayer.x + 50 < currentSpikes.x + 10 && currentPlayer.x + 50 > currentSpikes.x) { //hit left side
        if (currentSpikes.dir == 1) {
          spikeBladeCollide();
        } else if (currentSpikes.dir == 2) {
          wallCollLogic(currentSpikes.dir);
        }
      }
    } else {
      ;
    }
  }

  void spikeBladeCollide(){
    deathType = 1;
  }

  void bonkLogic() {
    if (currentPlayer.fallSpeed < 0) {
      currentPlayer.fallSpeed = 0;
      currentPlayer.y += 3 ;
    }
  }

  void collideLogic(int pltLocation) {
    platform currentPlt = platformList.get(pltLocation);
    currentPlayer.y = currentPlt.y - 55; //snap to plat
    currentPlayer.airState = 1; // mark player as grounded
    currentPlayer.jump = false; // enable jump input
  }

  void wallCollLogic(int side) {//1 = left, 2 = right
    if (side == 1){
      leftLockOut = true;
    } else if (side == 2){
      rightLockOut = true;
    }
  }

  void airLogic() {
    currentPlayer.airState = 0; //mark player as airborne
    currentPlayer.jump = true; //disable jump input
  }

  void topGameEndTrigger() {
    if (currentPlayer.y + 50 > height - 75) {
      deathType = 2;
    } else if (currentPlayer.y < -12) {
      deathType = 1;
    }
  }

  void collide() {
    logic();
    topGameEndTrigger();
  }
}
