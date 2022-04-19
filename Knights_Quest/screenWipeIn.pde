class screenWipeIn {
  // variables for position and size
  int w;
  int h;
  int x;
  int y;

// sets the initial position and size
  screenWipeIn() {
    x = width/2;
    y = height/2;
    w = width;
    h = height;
  }

// renders the transition until the height has gone below 0
  void render() {
    if (w>0) {
    rectMode(CENTER);
    fill(0);
    rect(x, y, w, h);
    }
  }

// shrinks the square
  void shrink() {
    if (h > 0) {
      w = w-50;
      h = h-34;
    }
  }
  
  // says when the transition is finished
  boolean finished() {
   return(h < 0); 
  }
}
