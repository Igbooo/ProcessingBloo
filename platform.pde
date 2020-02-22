class platform { //this is where we make platforms (they're just rect's)
  int x;
  int y;
  int pltWidth;
  int pltHeight;
  color pltColor = color(55, 55, 55); //old = (255, 180, 107)

  platform(int x, int y, int pltWidth, int pltType) { //pltType: 0 = ground, 1 = plat
    this.x = x;
    this.y = y;
    this.pltWidth = pltWidth;
    if (pltType == 0) {
      pltHeight = 75;
    } else if (pltType == 1) {
      pltHeight = 15;
    }
  }

  void render() {
    strokeWeight(1);
    stroke(255);
    fill(pltColor);
    rect(x, y, pltWidth, pltHeight);
  }
  
  
}
