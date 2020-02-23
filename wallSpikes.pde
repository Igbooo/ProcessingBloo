class wallSpikes { //wall spikes are made here. like the player, they are animated, like platforms, the class is fairly empty cause the collision class exists
  int x;
  int y;
  int dir;
  int imgNo = 1;
  int spikeHeight = 86;
  int spikeWidth = 32;
  PImage [] wallSpikeLeft;
  PImage [] wallSpikeRight;

  wallSpikes(int x, int y, int dir) { //1 = left, 2 = right
    this.x = x;
    this.y = y;
    this.dir = dir;

    wallSpikeLeft = new PImage[2];
    wallSpikeLeft[0] = loadImage("wallSpikeLeft0.png");
    wallSpikeLeft[1] = loadImage("wallSpikeLeft1.png");

    wallSpikeRight = new PImage[2];
    wallSpikeRight[0] = loadImage("wallSpikeRight0.png");
    wallSpikeRight[1] = loadImage("wallSpikeRight1.png");
  }

  void displayLeft() {
    if (frameCount % 30 == 0) {
      globalSwap(wallSpikeLeft);
    } else {
      image(wallSpikeLeft[imgNo], x, y);
    }
  }

  void displayRight() {
    if (frameCount % 30 == 0) {
      globalSwap(wallSpikeRight);
    } else {
      image(wallSpikeRight[imgNo], x, y);
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

  void render() {
    if (dir == 1) {
      displayLeft();
    } else if (dir == 2) {
      displayRight();
    }
  }
}
