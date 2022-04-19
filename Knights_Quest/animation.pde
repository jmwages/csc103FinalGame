class animation {
  // creates an image array and variable
  PImage[] imgs;
  PImage displayImg;
  
  // variables for controlling animation
  int imgNum;
  int index;

// variables for the timer
  float startTime;
  float endTime;
  float interval;

// variables for the position and size
  float xPos;
  float yPos;
  float size;

// controls when the animation is running
  boolean isAnimating = false;

// takes in an array of images and a speed
  animation(PImage[] other, float speed) {
    imgs = other;
    imgNum = 0;
    interval = speed;

    index = other.length;
    startTime = millis();
  }

// takes in x and y positions and a size
  void display(float x, float y, float s) {
    index = imgs.length;
    PImage displayImg = imgs[imgNum];
    size = s;
    endTime = millis();

// when the boolean is true the animation is updated every time the timer goes off, when it is not the image is set to the first in the array
    if (isAnimating) {
      image(displayImg, x, y);
      if (endTime - startTime >= interval) {
        update();
        startTime = endTime;
      }
    } else {
      imgNum = 0;
      image(imgs[0], x, y);
      if (endTime - startTime >= interval) {
        startTime = endTime;
      }
    }
  }

// switches to the next image until the end of the array is reached, when that happens the variable is set back to 0
  void update() {
    if (imgNum < index-1) {
      imgNum++;
    } else {
      imgNum = 0;
    }
  }
}
