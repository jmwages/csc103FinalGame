class cloud {
  // variables for position and speed
  float x;
  float y;
  int speed;

  cloud() {
    // randomizes the variables
    x = random(0, width);
    y = random(0, 400);
    speed = int(random(1, 4));
  }

  // renders and moves the cloud
  void render() {
    image(cloud, x, y);
    x += speed;
  }

  // when the cloud is off screen its position is reset and its speed and y value are randomized
  void wrapScreen() {
    if (x > width) {
      x = 0 - cloud.width;
      y = random(0, 600);
      speed = int(random(1, 4));
    }
  }
}
