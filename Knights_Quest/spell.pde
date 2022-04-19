class spell {
  // variables for position, speed, and size
  float x;
  float y;
  int speed;
  int size;

// variables for bounds
  float topBound;
  float bottomBound;
  float rightBound;
  float leftBound;
  
// boolean for whether the spell has been hit back by a player
  boolean beenHit = false;

// boolean for when the spell should be deleted
  boolean finished;

// takes in an x and y position and a number that controls the direction
  spell(float tempX, float tempY, int direction) {
    x = tempX;
    y = tempY;
    size = 40;

    beenHit = false;
    finished = false;

// moves left if the direction variable is 0 and y if it is 1
    if (direction == 0) {
      speed = -8;
    } else if (direction == 1) {
      speed = 8;
    }
    
    // plays the spell sound
    spellSound.play();
  }

// renders the spell and sets its bounds
  void render() {
    image(spellImg, x, y);

    topBound = y;
    leftBound = x;
    bottomBound = y + size;
    rightBound = x + size;
  }

// moves the spell
  void movement() {
    x = x+speed;
  }

// function for when the spell hits an enemy
  void hitPlayer() {
    if (bottomBound > p.topBound && p.bottomBound > topBound && rightBound > p.leftBound && leftBound < p.rightBound) {
      p.health -= 30;
      finished = true;
    }
  }

// function the has the spell hit the enemies if it has been hit back by the player and if it is not a skeleton
  void hitEnemy(enemy other) {
    if (bottomBound > other.topBound && other.bottomBound > topBound && rightBound > other.leftBound && leftBound < other.rightBound && beenHit) {
      if (other.enemySelect != 3) {
        other.health -= 30;
        finished = true;
      }
    }
  }

// function for when the spell has left the screen
  void outsideBounds() {
    if (rightBound < 0 || leftBound > width) {
      finished = true;
    }
  }
  
// says when the spell is in range of the players attack
  boolean inRange(player other) {
    return(other.bottomBound > topBound && bottomBound > other.topBound && other.attackBound > leftBound && other.leftBound < rightBound || other.bottomBound > topBound && bottomBound > other.topBound && other.rightBound > leftBound && other.attackBound < rightBound);
  }
}
