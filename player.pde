class player { //the player lives here, including rendering, animation, movement and gravity
  int x;
  int y;
  int walkSpeed = 3;
  float fallSpeed = 0;
  float gravity = 0;
  int imgNo = 1;
  boolean jump = false;
  int airState = 0; // 0 = airborne, 1 = grounded
  boolean left = false;
  boolean right = false;
  boolean jumpLockOut = false; //lock player out of jumping until they let go of the button and then press it again


  PImage[] blueIdle;
  PImage[] blueWalkLeft;
  PImage[] blueWalkRight;
  PImage[] blueFlyLeft;
  PImage[] blueFlyRight;


  player() {
    defXY();

    blueIdle = new PImage[2]; 
    blueIdle[0] = loadImage("idle0.png"); //6 over, 8 under, 12 sides
    blueIdle[1] = loadImage("idle1.png");

    blueWalkLeft = new PImage[2];
    blueWalkLeft[0] = loadImage("walkLeft0.png");
    blueWalkLeft[1] = loadImage("walkLeft1.png");

    blueWalkRight = new PImage[2];
    blueWalkRight[0] = loadImage("walkRight0.png");
    blueWalkRight[1] = loadImage("walkRight1.png");

    blueFlyLeft = new PImage[2];
    blueFlyLeft[0] = loadImage("jumpLeft0.png");
    blueFlyLeft[1] = loadImage("jumpLeft1.png");

    blueFlyRight = new PImage[2];
    blueFlyRight[0] = loadImage("jumpRight0.png");
    blueFlyRight[1] = loadImage("jumpRight1.png");
  }

  void defXY() {
    if (lowResMode) {
      x = 205;
      y = 570;
    } else {
      x = 205;
      y = 840; //test = 140
    }
  }

  void walk() { //the input and movement function
    if (x <= -60) {
      x = 505;
    } else if (x >= 510) {
      x = -55;
    }

    for (int i = 0; i < inputArray.length; i++) {
      if (inputArray[i]) {
        if (i == 0 && leftLockOut == false) {
          x = x - walkSpeed;
          left = true;
          right = false;
        } else if (i == 1 && rightLockOut == false) {
          x = x + walkSpeed;
          right = true;
          left = false;
        } else if (i == 2 && jump == false && jumpLockOut == false) {
          airState = 0;
          jump = true;
          jumpLockOut = true;
          fallSpeed = -8;
        }
      }
    }
    if ((!inputArray[0] && !inputArray[1]) || (inputArray[0] && inputArray[1])) {
      left = false;
      right = false;
    }

    if (!inputArray[2] && airState == 1) {
      jumpLockOut = false;
    }
  }


  void display() {
    if (left && !right) {
      if (airState == 1) {
        if (frameCount % 10 == 0)
        {
          globalSwap(blueWalkLeft);
        } else {
          image(blueWalkLeft[imgNo], x, y);
        }
      } else {
        if (frameCount % 10 == 0)
        {
          globalSwap(blueFlyLeft);
        } else {
          image(blueFlyLeft[imgNo], x, y);
        }
      }
    } else if (right && !left) {
      if (airState == 1) {
        if (frameCount % 10 == 0)
        {
          globalSwap(blueWalkRight);
        } else {
          image(blueWalkRight[imgNo], x, y);
        }
      } else {
        if (frameCount % 10 == 0)
        {
          globalSwap(blueFlyRight);
        } else {
          image(blueFlyRight[imgNo], x, y);
        }
      }
    } else {
      if (frameCount % 30 == 0) {
        globalSwap(blueIdle);
      } else {
        image(blueIdle[imgNo], x, y);
      }
    }
  }

  void globalSwap(PImage[] array) {
    if (imgNo == 1) {
      imgNo = 0;
    } else if (imgNo == 0) {
      imgNo = 1;
    }
    image(array[imgNo], x, y);
  }

  void gravity() { 
    if (airState == 1) {
      fallSpeed = 0;
      gravity = 0;
    } else if (airState == 0) {
      gravity = 0.2;
      y = y + (int)(fallSpeed);
      fallSpeed = fallSpeed + gravity;
    }
  }

  void render() {
    walk();
    gravity();
    display();
  }
}
