class enemy {
  // creates variables for the animations
  animation walkingR;
  animation walkingL;
  animation attackR;
  animation attackL;
  animation currentAnimation;

// creates variables for the sounds
  SoundFile eJumpSound;
  SoundFile deathSound;
  SoundFile playerHit;

  // variables for position, size, and boundaries
  float x;
  float y;
  int s;
  float topBound;
  float bottomBound;
  float rightBound;
  float leftBound;

  // variables for health
  int health;
  int maxHealth;
  color healthColor;

  // variables for speed and movement
  int speed;
  boolean movingR;
  boolean movingL;
  boolean moving;

  // variables to control jumping
  float peakY;
  float jumpHeight;
  boolean isJumping;
  boolean isFalling;
  int maxJumpSpeed;
  int jumpSpeed;
  int maxFallSpeed;
  int fallSpeed;

  // variable for whether enemy is alive
  boolean alive;

// variable that determines which enemy is created
  int enemySelect;

// variables for movement time
  int mTimeStart;
  int mTimeEnd;
  int mInterval;

// variables for attack timer and strength
  int aTimeStart;
  int aTimeEnd;
  int aInterval;
  int attackStrength;

//variables for the wizards summoning timer
  int sTimeStart;
  int sTimeEnd;
  int sInterval;
  boolean isSummoning;

  // constructor assigns values to size, postion, health variables
  enemy(int tempX, int tempY, int enemyNum) {
    // sets size and position
    s = 180;
    x = tempX;
    y = tempY;

// sets the bounds
    rightBound = x+s;
    leftBound = x;
    topBound = y;
    bottomBound = y+s;

// sets the enemytype 
    enemySelect = enemyNum;

// loads the sounds
    eJumpSound = jumpSound;
    deathSound = enemyDeath;
    deathSound.amp(.7);
    deathSound.rate(1.1);
    playerHit = enemyAttack;

    // sets the initial ground level to the bottom of the screen, the jump height to 250, and the max y that the jump can hit to the ground level minus the jump height
    //groundLevel = height;
    jumpHeight = 450;
    peakY = bottomBound - jumpHeight;

    // assigns values to the jump and fall speed variables
    maxJumpSpeed = 14;
    jumpSpeed = 4;
    maxFallSpeed = 16;
    fallSpeed = 4;

// makes the enemy alive and moving
    alive = true;
    moving = true;

// starts all the timers
    mTimeStart = millis();
    aTimeStart = millis();
    sTimeStart = millis();

// sets variables depending on which enemy is selected
    switch(enemySelect) {
    case 0: // knight

      walkingR = new animation(eWalkingRight1, 50);
      walkingL = new animation(eWalkingLeft1, 50);
      attackR = new animation(eAttackRight1, 200);
      attackL = new animation(eAttackLeft1, 200);

      mInterval = 3500;
      aInterval = 1000;
      attackStrength = 10;

      speed = 8;

      health = 60;
      maxHealth = 60;

      if (x<width/2) {
        movingR = true;
        movingL = false;
      } else {
        movingR = false;
        movingL = true;
      }
      break;
    case 1: // bull
      walkingR = new animation(eWalkingRight2, 100);
      walkingL = new animation(eWalkingLeft2, 100);
      attackR = new animation(eAttackRight2, 50);
      attackL = new animation(eAttackLeft2, 50);

      mInterval = 3500;
      aInterval = 1800;
      attackStrength = 30;

      speed = 6;

      health = 80;
      maxHealth = 80;

      if (x<width/2) {
        movingR = true;
        movingL = false;
      } else {
        movingR = false;
        movingL = true;
      }
      break;
    case 2: // wizard
      walkingR = new animation(eWalkingRight3, 150);
      walkingL = new animation(eWalkingLeft3, 150);

      mInterval = 500;
      aInterval = 2500;
      sInterval = 8000;
      attackStrength = 30;

      speed = 6;

      health = 120;
      maxHealth = 120;

      if (x<width/2) {
        currentAnimation = walkingR;
      } else {
        currentAnimation = walkingL;
      }
      break;
    case 3: // wizard skeleton
      walkingR = new animation(eWalkingRight4, 180);
      walkingL = new animation(eWalkingLeft4, 180);
      attackR = new animation(eAttackRight4, 80);
      attackL = new animation(eAttackLeft4, 80);

      mInterval = 1500;
      aInterval = 400;
      attackStrength = 5;

      speed = 8;
      moving = true;

      s = 120;

      rightBound = x+s;
      leftBound = x;
      topBound = y;
      bottomBound = y+s;

      health = 10;
      maxHealth = 10;

      if (x<width/2) {
        currentAnimation = walkingR;
      } else {
        currentAnimation = walkingL;
      }
      break;
    }
  }

  // functions to render and reset the bounds of the enemy
  void render() {
    fill(150, 0, 0);
    stroke(0);
    strokeWeight(1);
    imageMode(CORNER);
    currentAnimation.display(x, y, s);
  }

  void updateBounds() {
    rightBound = x+s;
    leftBound = x;
    topBound = y;
    bottomBound = y+s;
  }

  // function to control movement of the enemy
  void movement() {
    if (moving) {

      if (movingR) {
        currentAnimation = walkingR;
        currentAnimation.isAnimating = true;
        x = x + speed;
      } else if (movingL) {
        currentAnimation = walkingL;
        currentAnimation.isAnimating = true;
        x = x - speed;
      }

// changes the movement style depending on which enemy is selected
      switch (enemySelect) {
      case 0:
        mTimeEnd = millis();
        if (mTimeEnd - mTimeStart >= mInterval) {
          mTimeStart = mTimeEnd;
          if (x+s/2 > p.x + p.s/2) {
            movingL = true;
            movingR = false;
          } else {
            movingR = true;
            movingL = false;
          }
        }
        // allows to jump on first platform
        if (x > 480 && x < 500 && y > 900 && p.bottomBound < y && bottomBound >= height-30) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = false;
          movingR = true;
        }
        if (x > 1400 && x < 1420 && y > 900 && p.bottomBound < y && bottomBound >= height-30) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = true;
          movingR = false;
        }

        break;
      case 1:
        mTimeEnd = millis();
        if (mTimeEnd - mTimeStart >= mInterval) {
          mTimeStart = mTimeEnd;
          if (x+s/2 > p.x + p.s/2) {
            movingL = true;
            movingR = false;
          } else {
            movingR = true;
            movingL = false;
          }
        }
        // allows to jump on first platform
        if (x > 480 && x < 500 && y > 900 && p.bottomBound < y && bottomBound >= height-30) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = false;
          movingR = true;
        }
        if (x > 1400 && x < 1420 && y > 900 && p.bottomBound < y && bottomBound >= height-30) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = true;
          movingR = false;
        }
        // allows to jump on second platforms
        if (rightBound > 1300 && rightBound < 1400 && y < 900 && p.bottomBound < bottomBound && bottomBound >= 750 && !playerToLeft(p) && !isJumping && !isFalling) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = false;
          movingR = true;
        }
        if (leftBound > 600 && leftBound < 700 && y < 900 && p.bottomBound < bottomBound && bottomBound >= 750 && playerToLeft(p) && !isJumping && !isFalling) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = true;
          movingR = false;
        }
        break;
      case 2:
        //println(abs(x+s/2 - p.x+(p.s/2)));
        mTimeEnd = millis();
        currentAnimation.isAnimating = true;

        if (x+s/2 > p.x + p.s/2) {
          currentAnimation = walkingL;
        } else {
          currentAnimation = walkingR;
        }

        if (abs(x+s/2 - p.x+(p.s/2)) < 150 || playerToLeft(p) && abs(x+s/2 - p.x+(p.s/2)) < 500) {
          if (y > 400 && p.bottomBound >= topBound) {
            if (rightBound > width/2) {
              teleport.play();
              x = int(random(0, width/2));
            } else if (leftBound < width/2) {
              teleport.play();
              x = int(random(width/2, width));
            }
          }
          if (y < height/2 && p.topBound < bottomBound) {
            if (rightBound < width/2) {
              teleport.play();
              x = width - s;
            } else if (leftBound > width/2) {
              teleport.play();
              x = 0;
            }
          }
        }
        break;
      case 3:
        mTimeEnd = millis();
        if (mTimeEnd - mTimeStart >= mInterval) {
          mTimeStart = mTimeEnd;
          if (x+s/2 > p.x + p.s/2) {
            movingL = true;
            movingR = false;
          } else {
            movingR = true;
            movingL = false;
          }
        }

        // allows to jump on first platform
        if (x > 480 && x < 700 && y > 900 && p.bottomBound < y && bottomBound >= height-30) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = false;
          movingR = true;
        }
        if (x > 1200 && x < 1420 && y > 900 && p.bottomBound < y && bottomBound >= height-30) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = true;
          movingR = false;
        }
        // allows to jump on second platforms
        if (rightBound > 1300 && rightBound < 1400 && y < 900 && p.bottomBound < bottomBound && bottomBound >= 750 && !playerToLeft(p) && !isJumping && !isFalling) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = false;
          movingR = true;
        }
        if (leftBound > 600 && leftBound < 700 && y < 900 && p.bottomBound < bottomBound && bottomBound >= 750 && playerToLeft(p) && !isJumping && !isFalling) {
          playJump();
          isJumping = true;
          isFalling = false;
          movingL = true;
          movingR = false;
        }
        break;
      }
    }
  }


  // function to move enemy when it hits a wall
  void wallDetect() {
    switch (enemySelect) {
    case 0:
      if (rightBound >= width) {
        movingR = false;
        movingL = true;
      }
      if (leftBound <= 0) {
        movingR = true;
        movingL = false;
      }
      break;
    case 1:
      if (rightBound >= width) {
        movingR = false;
        movingL = true;
      }
      if (leftBound <= 0) {
        movingR = true;
        movingL = false;
      }
      break;
    case 2:
      if (rightBound > width) {
        x = width-s;
      }
      if (leftBound < 0) {
        x = 0;
      }
      break;
    case 3:
      if (rightBound >= width) {
        movingR = false;
        movingL = true;
      }
      if (leftBound <= 0) {
        movingR = true;
        movingL = false;
      }
    }
  }

  // function to render the health of the enemy
  void renderHealth() {
    if (health > maxHealth/2) {
      healthColor = color(0, 200, 0);
    } else if (health > maxHealth/3) {
      healthColor = color(255, 255, 0);
    } else {
      healthColor = color(255, 0, 0);
    }

    if (health <= 0) {
      if (enemySelect != 3) {
        score += 1;
      }
      if(enemySelect != 3) {
      deathSound.play();
      } else {
       summoning.play(); 
      }
      alive = false;
    }

    stroke(healthColor);
    strokeWeight(6);
    strokeCap(ROUND);
    if (health < maxHealth) {
      line(x, y-10, map(health, 0, maxHealth, x, x+s), y-10);
    }
  }

// function for playing the jump and hit sounds
  void playJump() {
    if (!eJumpSound.isPlaying()) {
      eJumpSound.rate(.5);
      eJumpSound.amp(.70);
      eJumpSound.play();
    }
  }

  void playerHitSound() {
    if (!playerHit.isPlaying()) {
      eJumpSound.amp(.20);
      playerHit.rate(0.75);
      playerHit.play();
    }
  }

  // boolean that says when the enemy is within attack range
  boolean attackable(player other) {
    return(other.bottomBound > topBound && bottomBound > other.topBound && other.attackBound > leftBound && other.leftBound < rightBound || other.bottomBound > topBound && bottomBound > other.topBound && other.rightBound > leftBound && other.attackBound < rightBound);
  }

  // boolean that tells the enemy where it is in relation to the player

  boolean playerToLeft(player other) {
    return(x + (s/2) > other.x + (other.s/2));
  }

  // function that reduces the health and runs the reaction for each enemy
  void hit() {
    moving = true;

    if (playerToLeft(p)) {
      x += 10;
    } else {
      x -= 10;
    }

    switch(enemySelect) {
    case 0:
      health = health - 20;

      if (playerToLeft(p)) {
        movingR = true;
        movingL = false;
      } else {
        movingR = false;
        movingL = true;
      }
      break;
    case 1:
      health = health - 20;

      if (playerToLeft(p)) {
        movingR = true;
        movingL = false;
      } else {
        movingR = false;
        movingL = true;
      }
      break;
    case 2:
      health = health - 20;
      break;
    case 3:
      health = 0;
      break;
    }
  }

// function for attacking the player, changes variables dependent on enemy type
  void attack(player other) {
    aTimeEnd = millis();
    sTimeEnd = millis();
    switch(enemySelect) {
    case 0:
      if (bottomBound > other.topBound && other.bottomBound > topBound && rightBound > other.leftBound && leftBound < other.rightBound) {
        if (playerToLeft(p) && enemySelect != 2) {
          currentAnimation = attackL;
          // currentAnimation.isAnimating = true;
        } else if (!playerToLeft(p) && enemySelect != 2) {
          currentAnimation = attackR;
          //currentAnimation.isAnimating = true;
        }

        moving = false;
        if (aTimeEnd - aTimeStart >= aInterval) {
          playerHitSound();
          aTimeStart = aTimeEnd;
          p.health -= attackStrength;
          currentAnimation.isAnimating = true;
        }
      } else {
        moving = true;
      }
      break;
    case 1:
      if (bottomBound > other.topBound && other.bottomBound > topBound && rightBound > other.leftBound && leftBound < other.rightBound) {
        if (playerToLeft(p) && enemySelect != 2) {
          currentAnimation = attackL;
          // currentAnimation.isAnimating = true;
        } else if (!playerToLeft(p) && enemySelect != 2) {
          currentAnimation = attackR;
          //currentAnimation.isAnimating = true;
        }

        moving = false;
        if (aTimeEnd - aTimeStart >= aInterval) {
          playerHitSound();
          aTimeStart = aTimeEnd;
          p.health -= attackStrength;
          currentAnimation.isAnimating = true;
        }
      } else {
        moving = true;
      }
      break;
    case 2:
      if (aTimeEnd - aTimeStart >= aInterval) {
        aTimeStart = aTimeEnd;
        if (p.bottomBound > topBound && p.topBound < bottomBound) {
          if (playerToLeft(p)) {
            spells.add(new spell(leftBound - 80, topBound + 50, 0));
          } else {
            spells.add(new spell(rightBound + 40, topBound + 50, 1));
          }
        }

        if (sTimeEnd - sTimeStart >= sInterval) {
          sTimeStart = sTimeEnd;
          isSummoning = true;
        }
      }
      break;
    case 3:
      if (bottomBound > other.topBound && other.bottomBound > topBound && rightBound > other.leftBound && leftBound < other.rightBound) {
        if (playerToLeft(p) && enemySelect != 2) {
          currentAnimation = attackL;
          // currentAnimation.isAnimating = true;
        } else if (!playerToLeft(p) && enemySelect != 2) {
          currentAnimation = attackR;
          //currentAnimation.isAnimating = true;
        }

        moving = false;
        if (aTimeEnd - aTimeStart >= aInterval) {
          playerHitSound();
          aTimeStart = aTimeEnd;
          p.health -= attackStrength;
          currentAnimation.isAnimating = true;
        }
      } else {
        moving = true;
      }
      break;
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
      // currentAnimation.isAnimating = false;
    }
  }

// function for when the jump is at its peak
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

// function for landing 
  void land() {
    if (bottomBound >= height-30) {
      isFalling = false;
      if (!isJumping) {
        y = height-30 - s;
        //currentAnimation.isAnimating = true;
      }
      peakY = bottomBound - jumpHeight;
    }
  }

// function to sense when the enemy has walked off the platform
  void fallOffPlatform(platform[] other) {
    if (!isJumping && bottomBound < height-30) {
      boolean onPlatform = false;
      for (platform plat : other) {
        if (bottomBound > plat.topBound && plat.bottomBound > topBound && rightBound > plat.leftBound && leftBound < plat.rightBound) {
          onPlatform = true;
          //currentAnimation.isAnimating = true;
        }
      }

      if (!onPlatform) {
        isFalling = true;
      }
    }
  }
}
