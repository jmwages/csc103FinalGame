class player {
  animation standingR;
  animation standingL;
  animation walkingR;
  animation walkingL;

  // variables for position and size
  int x;
  int y;
  int s;

  // variables for speed, movement control, and to show which way the player is facing
  int speed;
  boolean movingL;
  boolean movingR;
  boolean facingR;
  boolean facingL;

  boolean collision;

  // variables to control juming
  int peakY;
  int jumpHeight;
  boolean isJumping;
  boolean isFalling;
  int maxJumpSpeed;
  int jumpSpeed;
  int maxFallSpeed;
  int fallSpeed;

  // variables for bounds
  int rightBound;
  int leftBound;
  int topBound;
  int bottomBound;
  int attackBound;

  // variables to control bounce back when player is hit
  int bounceBound;
  boolean bounceOff = true;

  // variables to control health
  int health;
  int maxHealth;
  color healthColor;

  boolean canAttack;

  animation currentAnimation;


  player() {
    standingR = new animation(standingRight, 200);

    standingL = new animation(standingleft, 200);

    walkingR = new animation(walkingRight, 50);

    walkingL = new animation(walkingLeft, 50);

    // assigns values to position, size and speed variables
    x = 1000;
    y = height/2;
    s = 180;
    speed = 10;

    // sets the initial ground level to the bottom of the screen, the jump height to 250, and the max y that the jump can hit to the ground level minus the jump height
    //groundLevel = height;
    jumpHeight = 450;
    peakY = bottomBound - jumpHeight;

    // assigns values to the jump and fall speed variables
    maxJumpSpeed = 16;
    jumpSpeed = 4;
    maxFallSpeed = 16;
    fallSpeed = 4;

    // assigns values to the health variables
    health = 180;
    maxHealth = 180;

    // sets the player to right facing initially
    facingR = true;
    facingL = false;

    canAttack = true;

    isFalling = true;

// sets initial animation
    currentAnimation = standingR;
  }

  // function for rendering the player
  void render() {
    fill(100, 0, 200);
    stroke(0);
    strokeWeight(1);
    imageMode(CORNER);
    currentAnimation.display(x, y, s);
  }

  // function for moving the player
  void movement() {
    // moves the player left/right depending on what boolean is true and only if it is not colliding with a platform
    if (movingR && rightBound < width) {
      x = x + speed;
      currentAnimation.isAnimating = true;
      currentAnimation = walkingR;
    }

    if (movingL && leftBound > 0) {
      x = x - speed;
      currentAnimation.isAnimating = true;
      currentAnimation = walkingL;
    }
  }

// function for jumping
  void jump() {
    if (isJumping && !isFalling) {
      fallSpeed = 4;
      if (jumpSpeed < maxJumpSpeed) {
        jumpSpeed += 2;
      }
      y = y - jumpSpeed;
      currentAnimation.isAnimating = false;
    }
  }

// function for when the player has reached the peak of the jump
  void reachedTopOfJump() {
    if (bottomBound < peakY) {
      jumpSpeed = 4;
      isFalling = true;
      isJumping = false;
    }
  }

// function for falling
  void fall() {
    if (!isJumping && isFalling) {
      if (fallSpeed < maxFallSpeed) {
        fallSpeed += 1;
      }
      y = y + fallSpeed;
    }
  }

// function for when the player has landed
  void land() {
    if (bottomBound >= height - 30) {
      isFalling = false;
      if (!isJumping) {
        y = height-30 - s;
        currentAnimation.isAnimating = true;
      }
      peakY = bottomBound - jumpHeight;
    }
  }

// function to detect when the player walks off a platform
  void fallOffPlatform(platform[] other) {
    if (!isJumping && bottomBound < height -30) {
      boolean onPlatform = false;
      for (platform plat : other) {
        if (bottomBound > plat.topBound && plat.bottomBound > topBound && rightBound > plat.leftBound && leftBound < plat.rightBound) {
          onPlatform = true;
          currentAnimation.isAnimating = true;
        }
      }

      if (!onPlatform) {
        isFalling = true;
      }
    }
  }

  // function for updating the bounds
  void updateBounds() {
    rightBound = x + s;
    leftBound = x;
    topBound = y;
    bottomBound = y + s;

    // changes which way the player attacks based on which way it is facing
    if (facingR) {
      attackBound = rightBound + 100;
    }
    if (facingL) {
      attackBound = leftBound - 100;
    }
  }

  // function for rendering the health above the player
  void renderHealth() {
    if (health > maxHealth/2) {
      healthColor = color(0, 200, 0);
    } else if (health > maxHealth/3) {
      healthColor = color(255, 255, 0);
    } else {
      healthColor = color(255, 0, 0);
    }

    stroke(healthColor);
    strokeWeight(6);
    strokeCap(ROUND);
    if (health < maxHealth) {
      line(x, y-10, map(health, 0, maxHealth, x, x+s), y-10);
    }
  }

  // checks where the enemy is relative to the player
  boolean enemyToLeft(enemy other) {
    return(x + (s/2) > other.x + (other.s/2));
  }

  // checks if the player has collided with an enemy
  boolean enemyCollision(enemy other) {
    return(other.bottomBound > topBound && bottomBound > other.topBound && other.rightBound > leftBound && other.leftBound < rightBound);
  }
}
