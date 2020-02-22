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


    for (int i = 0; i < platformList.size(); i++) {
      collided = ceilingCollide(i);
      if (collided != -1) {
        bonkPlt = collided;
      }
    }
    if (bonkPlt != -1) {
      bonkLogic();
    }

    for (int i = 0; i < platformList.size(); i++) {
      collided = leftWallCollide(i);
      if (collided != -1) {
        leftCollPlt = collided;
      }
    }
    if (leftCollPlt != -1) {
      wallCollLogic(leftCollPlt);
    } else {
      for (int i = 0; i < platformList.size(); i++) {
        collided = rightWallCollide(i);
        if (collided != -1) {
          rightCollPlt = collided;
        }
      }
      if (rightCollPlt != -1) {
        wallCollLogic(rightCollPlt);
      } else { 
        sideLockOut = false;
      }
    }

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

  void wallCollLogic(int pltLocation) {
    platform currentPlt = platformList.get(pltLocation);
    sideLockOut = true;
  }

  void airLogic() {
    currentPlayer.airState = 0; //mark player as airborne
    currentPlayer.jump = true; //disable jump input
  }

  void gameEndTrigger() {
    if (currentPlayer.y < 0) {
      gameEndTrigger = true;
    } else {
      gameEndTrigger = false;
    }
  }

  void collide() {
    logic();
    gameEndTrigger();
  }
}
