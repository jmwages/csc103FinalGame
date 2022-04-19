class platform {
  // variables for the position and size of the platform
  int x;
  int y;
  int w;
  int h;

  // variables for the bounds of the platform
  int rightBound;
  int leftBound;
  int topBound;
  int bottomBound;

  // constructor takes input for x position, y position, and width of the platform
  // height is given a preassigned value
  platform(int xPos, int yPos, int pWidth, int pHeight) {
    x = xPos;
    y = yPos;
    w = pWidth;
    h = pHeight;
  }

  // renders the platform and assigns values to its bounds
  void render() {
    fill(0, 90, 0);
    stroke(0);
    strokeWeight(1);
    //rect(x, y, w, h);
    imageMode(CENTER);
    image(grass, x, y, w, h);
    topBound = y - h/2;
    bottomBound = topBound;
    rightBound = x + w/2;
    leftBound = x - w/2;
  }

// function for sensing when the player has landed on the platform
  void landedOn(player other) {
    if (other.isFalling && topBound > other.topBound && other.bottomBound > topBound && rightBound > other.leftBound && leftBound < other.rightBound) {
      if (other.bottomBound <= topBound +40) {
        other.isFalling = false;
        other.jumpSpeed = 4;
        other.peakY = topBound - other.jumpHeight;
        if (!other.isJumping && other.bottomBound <= topBound) {
          other.y = topBound - other.s;
        }
      }
    }
  }

// function for sensing when an enemy has landed on the platform
  void enemyLandedOn(ArrayList<enemy> eTemp) {
    for (enemy other: eTemp) {
    if (other.isFalling && topBound > other.topBound && other.bottomBound > topBound && rightBound > other.leftBound && leftBound < other.rightBound) {
      if (other.bottomBound <= topBound +40) {
        other.isFalling = false;
        other.jumpSpeed = 4;
        other.peakY = topBound - other.jumpHeight;
        if (!other.isJumping) {
          other.y = topBound - other.s;
        }
      }
    }
  }
  }
}
