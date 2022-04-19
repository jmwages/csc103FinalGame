class screenWipeOut {
  //  variables fo size and position
  int w;
  int h;
  int x;
  int y;

  screenWipeOut() {
    x = width/2;
    y = height/2;
    w = width/10;
    h = height/10;
  }

// resets the variables
  void reset() {
    x = width/2;
    y = height/2;
    w = width/10;
    h = height/10;
  }

// renders the transition
  void render() {
    rectMode(CENTER);
    fill(0);
    rect(x, y, w, h);
  }

// grows the square until the height is equal to the height of the screen
  void grow() {
    if (h != height) {
      w = w+400;
      h = h+240;
    }
  }
// says when the transition is finished
  boolean finished() {
    return(w >= width && h >= height);
  }
}
