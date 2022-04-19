class button {
  // position variables
  int x;
  int y;

// variables for bounds
  int topBound;
  int bottomBound;
  int leftBound;
  int rightBound;

// variables for size and images
  PImage image;
  PImage image2;
  PImage displayImage;
  int bWidth;
  int bHeight;

// takes in two images, x and y positions, and sizes
  button(PImage tempImage, PImage tempImage2, int xTemp, int yTemp, int w, int h) {
    x = xTemp;
    y = yTemp;

    displayImage = image;
    image = tempImage;
    image2 = tempImage2;
    bWidth = w;
    bHeight = h;
  }

// renders the button
  void render() {
    if (isPressed()) {
      displayImage = image2;
    } else {
      displayImage = image;
    }

    imageMode(CENTER);
    image(displayImage, x, y, bWidth, bHeight);

    topBound = y - bHeight/2;
    bottomBound = y + bHeight/2;
    leftBound = x - bWidth/2;
    rightBound = x + bWidth/2;
  }

  // function to check if a value is in between two other values -- 3 inputs: checked val, first point, second point
  boolean isBetween(int value, int valOne, int valTwo) {
    return(value > valOne && value < valTwo);
  }

// function that checks when the button is pressed
  boolean isPressed() {
    return(isBetween(mouseX, leftBound, rightBound) && isBetween(mouseY, topBound, bottomBound));
  }
}
