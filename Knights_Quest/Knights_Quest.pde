import processing.sound.*;

// create variables to hold game sounds
SoundFile jumpSound;
SoundFile playerAttack;
SoundFile playerWalking;
SoundFile enemyDeath;
SoundFile enemyHit;
SoundFile enemyAttack;
SoundFile losingSound;
SoundFile spellSound;
SoundFile teleport;
SoundFile summoning;
SoundFile menuMusic;
SoundFile mainMusic;

// create image variables and image arrays for animations
PImage grass;
PImage cloud;
PImage background;
PImage brickWall;
PImage spellImg;
PImage startButtonImg;
PImage startButtonPressed;
PImage iButtonImage;
PImage iButtonImage2;
PImage manual;
PImage wideScroll;
PImage[] standingRight = new PImage[4];
PImage[] standingleft = new PImage[4];
PImage[] walkingRight = new PImage[8];
PImage[] walkingLeft = new PImage[8];
PImage[] attackRight = new PImage[1];
PImage[] attackLeft = new PImage[1];
PImage[] eWalkingRight1 = new PImage[7];
PImage[] eWalkingLeft1 = new PImage[7];
PImage[] eAttackRight1 = new PImage[2];
PImage[] eAttackLeft1 = new PImage[2];
PImage[] eWalkingRight2 = new PImage[8];
PImage[] eWalkingLeft2 = new PImage[8];
PImage[] eAttackRight2 = new PImage[8];
PImage[] eAttackLeft2 = new PImage[8];
PImage[] eWalkingRight3 = new PImage[4];
PImage[] eWalkingLeft3 = new PImage[4];
PImage[] eWalkingRight4 = new PImage[4];
PImage[] eWalkingLeft4 = new PImage[4];
PImage[] eAttackRight4 = new PImage[2];
PImage[] eAttackLeft4 = new PImage[2];
animation attackR;
animation attackL;

// create font variable
PFont font;

// create variables and arrays for necessary classes
player p;
platform[] platforms = new platform[3];
ArrayList<enemy> e = new ArrayList<enemy>();
ArrayList<spell> spells = new ArrayList<spell>();
cloud[] clouds = new cloud[3];
screenWipeOut wipeOut;
screenWipeIn wipeIn;

// create two buttons and some booleans to control them
button startButton;
button instructions;
boolean showInstructions = false;

// booleans for running game
boolean runWipeOut;
boolean runWipeIn;
int gameState = 0;
int level = 1;
int score;
boolean gameRunning;
boolean finishedSpawning = false;
boolean firstGame = true;
boolean gameResetting = false;



void setup() {
  // sets the size of the screen
  size(2000, 1200);

  // calls on load image function
  loadImages();

  attackR = new animation(attackRight, 200);
  attackL = new animation(attackLeft, 200);
  // loads in font file
  font = createFont("Palatino.ttf", 100);
  textFont(font);


  // creates a new player, and platforms
  p = new player();
  platforms[0] = new platform(width/2, 900, 600, 150);
  platforms[1] = new platform(0, 650, 800, 150);
  platforms[2] = new platform(width, 650, 800, 150);

  // creates buttons
  startButton = new button(startButtonImg, startButtonPressed, width/2, 3*(height/5) + 50, 600, 330);
  instructions = new button(iButtonImage, iButtonImage2, width - 80, 80, 120, 120);

  // creates transitions
  wipeOut = new screenWipeOut();
  wipeIn = new screenWipeIn();

  // fills the cloud array with cloud objects
  for (int i = 0; i < clouds.length; i++) {
    clouds[i] = new cloud();
  }

  // loads sound files to all the sound variables
  jumpSound = new SoundFile(this, "jump.wav");
  jumpSound.amp(0.5);
  enemyHit = new SoundFile(this, "enemyHit.wav");
  enemyAttack = new SoundFile(this, "enemyHit.wav");
  playerAttack = new SoundFile(this, "swoosh.wav");
  enemyDeath = new SoundFile(this, "enemyDeath2.wav");
  playerWalking = new SoundFile(this, "walking2.wav");
  playerWalking.rate(1.5);
  playerWalking.amp(1);
  losingSound = new SoundFile(this, "losingSound.wav");
  losingSound.amp(.75);
  spellSound = new SoundFile(this, "spellSound.wav");
  teleport = new SoundFile(this, "teleport.wav");
  summoning = new SoundFile(this, "summoning.wav");
  menuMusic = new SoundFile(this, "menuMusic.wav");
  menuMusic.amp(.7);
  mainMusic = new SoundFile(this, "mainMusic.wav");
  mainMusic.amp(.6);
}

void draw() {
  // switch statement for controlling the different levels of the game
  switch(level) {
  case 1:
    if (wipeIn.finished()) {
      if (!finishedSpawning) {
        e.add(new enemy(int(random(100, 1900)), 900, 0));
        score = 0;
        gameResetting = false;
        finishedSpawning = true;
      }
    }
    break;
  case 2:
    if (!finishedSpawning) {
      //e.add(new enemy(int(random(100, 1900)), 900, 0));
      e.add(new enemy(180, 400, 0));
      e.add(new enemy(width-180, 400, 0));
      finishedSpawning = true;
    }
    break;
  case 3:
    if (!finishedSpawning) {
      e.add(new enemy(int(random(100, 1900)), 900, 1));
      finishedSpawning = true;
    }
    break;
  case 4:
    if (!finishedSpawning) {
      e.add(new enemy(int(random(100, 1900)), 900, 0));
      e.add(new enemy(width-180, 400, 1));
      finishedSpawning = true;
    }
    break;
  case 5:
    if (!finishedSpawning) {
      e.add(new enemy(int(random(100, 1900)), 900, 0));
      e.add(new enemy(width-180, 400, 1));
      e.add(new enemy(180, 400, 1));
      finishedSpawning = true;
    }
    break;
  case 6:
    if (!finishedSpawning) {
      e.add(new enemy(int(random(100, 1900)), 900, 2));
      finishedSpawning = true;
    }
    break;
  case 7:
    if (!finishedSpawning) {
      e.add(new enemy(int(random(100, 1900)), 900, 2));
      e.add(new enemy(width-180, 400, 2));
      e.add(new enemy(int(random(100, 1900)), 900, 0));
      finishedSpawning = true;
    }
    break;
  case 8:
    if (!finishedSpawning) {
      e.add(new enemy(int(random(100, 1900)), 900, 2));
      e.add(new enemy(width-180, 400, 1));
      e.add(new enemy(180, 400, 1));

      finishedSpawning = true;
    }
    break;
  case 9:
    if (!finishedSpawning) {
      int chance = int(random(0, 11));
      if (chance <= 4) {
        e.add(new enemy(int(random(100, 1900)), 900, 0));
      } else if (chance > 4 && chance <= 8) {
        e.add(new enemy(width/2, 600, 1));
      } else if (chance > 8) {
        int chance2 = int(random(0, 2));
        if (chance2 == 0) {
          e.add(new enemy(width-180, 400, 2));
        } else if (chance2 == 1) {
          e.add(new enemy(int(random(100, 1900)), 900, 2));
        }
      }
      finishedSpawning = true;
    }
    break;
  }
  levelCheck();
  // switch statement for controlling the three states of the game
  switch(gameState) {
    // state zero creates the main menu screen
  case 0:
    if (!menuMusic.isPlaying()) {
      menuMusic.play();
    }
    imageMode(CORNER);
    image(brickWall, 0, 0, 2000, 1200);
    imageMode(CENTER);
    image(wideScroll, width/2, 350);
    textSize(150);
    fill(0);
    text("Knight's Quest", (width/2) - 490, 400);
    startButton.render();
    instructions.render();
    showWipeOut();
    if (showInstructions) {
      imageMode(CENTER);
      image(manual, width/2, height/2);
    }
    break;
    // case 1 creates the main game
  case 1:
    // stops menu music and plays main music
    menuMusic.stop();
    if (!mainMusic.isPlaying()) {
      mainMusic.play();
    }

    // sets the background image
    imageMode(CORNER);
    image(background, 0, 0);
    // renders the clouds
    for (int i = 0; i < clouds.length; i++) {
      clouds[i].render(); 
      clouds[i].wrapScreen();
    }

    // renders the score and level text
    fill(75);
    stroke(0);
    strokeWeight(5);
    rectMode(CORNER);
    rect(20, 20, 400, 150, 75);
    rect(width - 420, 20, 400, 150, 75);
    fill(0);
    if (level < 9) {
      textSize(90);
      text("Level: " + level, 40, 125);
    } else {
      fill(150, 0, 0);
      textSize(80);
      text("SURVIVE", 50, 122);
    }
    fill(0);
    textSize(90);
    text("Score: " + score, width - 400, 125);



    // if the player has health then call on all its necessary functions, when it dies switch to losing screen
    if (p.health > 0) {
      p.render();
      p.renderHealth();
      p.movement();
      p.jump();
      p.reachedTopOfJump();
      p.fall();
      p.land();
      p.fallOffPlatform(platforms);
      p.updateBounds();
    } else {
      losingSound.play();
      firstGame = false;
      gameState = 2;
    }


    // render the platforms
    for (int i = 0; i != platforms.length; i++) {
      platforms[i].render();
      platforms[i].landedOn(p);
      platforms[i].enemyLandedOn(e);
    }
    // shows transition if it is the first game and first level
    if (level == 1 && firstGame) {
      showWipeIn();
    }
    // calls the necessary functions for all the enemies
    for (enemy eTemp : e) {
      eTemp.movement();
      eTemp.wallDetect();
      eTemp.alive = true;
      eTemp.render();
      eTemp.renderHealth();
      eTemp.attack(p);
      eTemp.jump();
      eTemp.reachedTopOfJump();
      eTemp.fall();
      eTemp.land();
      eTemp.fallOffPlatform(platforms);
      eTemp.updateBounds();
    }
    // when an enemy has zero health delete it from the array list
    for (int i = 0; i < e.size(); i++) {
      enemy enemyCheck = e.get(i);
      if (enemyCheck.alive == false) {
        e.remove(i);
      }
    }
    // summons skeletons when a type 2 enemy (wizard) should summon them
    for (int i = 0; i < e.size(); i++) {
      enemy enemyCheck = e.get(i);
      if (enemyCheck.isSummoning) {
        summoning.play();
        e.add(new enemy(int(enemyCheck.leftBound), int(enemyCheck.y), 3));
        e.add(new enemy(int(enemyCheck.rightBound), int(enemyCheck.y), 3));
        enemyCheck.isSummoning = false;
      }
    }

    // calls all the necessary functions for the spells
    for (spell tempSpell : spells) {
      tempSpell.render();
      tempSpell.movement();
      tempSpell.hitPlayer();
      tempSpell.outsideBounds();
      for (enemy eTemp : e) {
        tempSpell.hitEnemy(eTemp);
      }
    }

    // when a spell is supposed to be removed it is removed from the array list
    for (int i = 0; i < spells.size(); i++) {
      spell spellCheck = spells.get(i);
      if (spellCheck.finished == true) {
        spells.remove(i);
      }
    }
    break;
    // case 2 creates the losing screen
  case 2:
    // stops the main music and plays the menu music after the losing sound plays
    mainMusic.stop();
    if (!menuMusic.isPlaying() && !losingSound.isPlaying()) {
      menuMusic.play();
    }
    // renders the elements of the losing screen
    imageMode(CORNER);
    image(brickWall, 0, 0, 2000, 1200);
    imageMode(CENTER);
    image(wideScroll, width/2, 400);
    textSize(90);
    fill(150, 0, 0);
    text("You Died", (width/2) - 190, 370);
    fill(0);
    text("Score: " + score, (width/2) - 160, 490);
    fill(0, 100, 150);
    text("Press Start To Play Again", (width/2) - 480, 730);
    startButton.y = 4*(height/5);
    startButton.render();
    if (mousePressed) {
      if (startButton.isPressed()) {
        firstGame = false;
        gameResetting = true;
        //score = 0;
        //level = 1;
      }
    }
    break;
  }

  if (gameResetting) {
    resetGame();
  }
}

// controls player movement and attack
void keyPressed() {
  // jump when 'w' pressed
  if (key == 'w') {
    if (!p.isFalling) {
      if (!jumpSound.isPlaying() && !p.isJumping) {
        jumpSound.rate(1);
        jumpSound.amp(1);
        jumpSound.play();
      }
      p.isJumping = true;
      p.isFalling = false;
    }
  } // move right when 'd' is pressed
  if (key == 'd') {
    if (!playerWalking.isPlaying()) {
      playerWalking.play();
    }
    p.movingR = true;
    p.facingR = true;
    p.facingL = false;
  } // move left when 'a' is pressed
  if (key == 'a') {
    if (!playerWalking.isPlaying()) {
      playerWalking.play();
    }
    p.movingL = true;
    p.facingR = false;
    p.facingL = true;
  } // attack when space is pressed
  if (key == ' ' && p.canAttack) {
    if (p.facingL) {
      p.currentAnimation = attackL;
      p.currentAnimation.isAnimating = true;
    } else {
      p.currentAnimation = attackR;
      p.currentAnimation.isAnimating = true;
    }

    if (!playerAttack.isPlaying() && !p.isJumping) {
      playerAttack.rate(1);
      playerAttack.play();
    }
    for (spell tempSpell : spells) {
      if (tempSpell.inRange(p)) {
        enemyHit.play();
        tempSpell.speed = -tempSpell.speed;
        tempSpell.beenHit = true;
      }
    }
    for (enemy eTemp : e) {
      if (eTemp.attackable(p)) {
        enemyHit.play();
        p.canAttack = false;
        eTemp.hit();
        p.currentAnimation.isAnimating = false;
      }
    }
  }

 /* // keys used for game testing
   if (key == 'l') {
   for (int i = 0; i < e.size(); i++) {
   e.remove(i);
   }
   }
   if (key == 'o') {
   gameState = 2;
   }  */
}

void keyReleased() {
  // stop moving right when 'd' is pressed
  if (key == 'd') {
    p.movingR = false;
    p.currentAnimation = p.standingR;
    playerWalking.stop();
  } // stop moving left when 'a' is pressed
  if (key == 'a') {
    p.movingL = false;
    p.currentAnimation = p.standingL;
    playerWalking.stop();
  } // has the player fall when the 'w' key is released
  if (key == 'w') {
    p.isJumping = false;
    p.isFalling = true;
  }
  if (key == ' ') {
    p.canAttack = true;
    if (p.facingL) {
      p.currentAnimation = p.standingL;
    } else {
      p.currentAnimation = p.standingR;
    }
    p.currentAnimation.isAnimating = true;
  }
}

// controls main menu button presses
void mousePressed() {
  if (startButton.isPressed() && !showInstructions) {
    if (wipeOut.finished() == false) {
      runWipeOut = true;
    }
  }
  if (instructions.isPressed() && !showInstructions) {
    showInstructions = true;
  } else if (showInstructions) {
    showInstructions = false;
  }
}

// functions for showing transitions after the main menu
void showWipeOut() {
  if (runWipeOut && !wipeOut.finished()) {
    wipeOut.render();
    wipeOut.grow();
  }
  if (wipeOut.finished()) {
    runWipeOut = false;
    wipeOut.reset();
    level = 1;
    gameState = 1;
    runWipeIn = true;
  }
}
void showWipeIn() {
  if (runWipeIn && !wipeIn.finished()) {
    wipeIn.render();
    wipeIn.shrink();
  }
  if (wipeIn.finished()) {
    level = 1;
    runWipeIn = false;
  }
}

// function for reseting the game
void resetGame() {
  println(e.size());
  if (e.size() > 0) {
    for (int i = 0; i < e.size(); i++) {
      e.remove(i);
    }
  } else {
    p.health = p.maxHealth;
    p.x = 1000;
    p.y = width/2;
    gameRunning = true;
    level = 0;
    score = 0;
    //levelCheck();
    gameState = 1;
    gameResetting = false;
  }
}

// function that checks when the level variable should be changed
void levelCheck() {
  if (level <= 8) {
    if (e.size() > 0) {
      gameRunning = true;
    } else {
      gameRunning = false;
      finishedSpawning = false;
    }

    if (!gameRunning && wipeIn.finished()) {
      level += 1;
      gameRunning = true;
    }
  } else if (level == 9) {
    if (e.size() >= 3) {
      gameRunning = true;
    } else if (!gameResetting) {
      //gameRunning = false;
      finishedSpawning = false;
    }
  }
}

// function for loading all the images and filling the image arrays
void loadImages() {
  brickWall = loadImage("titleScreen.PNG");
  background = loadImage("Background1.PNG");
  spellImg = loadImage("spell.PNG");
  grass = loadImage("Grass1.PNG");
  cloud = loadImage("cloud.PNG");
  startButtonImg = loadImage("startButton.PNG");
  startButtonPressed = loadImage("startButton2.PNG");
  manual = loadImage("manual.PNG");
  iButtonImage = loadImage("instructions.PNG");
  iButtonImage2 = loadImage("instructions2.PNG");
  wideScroll = loadImage("wideScroll.png");
  
  cloud.resize(384, 192);
  spellImg.resize(40, 40);

  for (int i = 0; i < standingRight.length; i++) {
    standingRight[i] = loadImage("standingR"+i+".png");
    standingRight[i].resize(180, 180);
  }

  for (int i = 0; i < standingleft.length; i++) {
    standingleft[i] = loadImage("standingL"+i+".png");
    standingleft[i].resize(180, 180);
  }


  for (int i = 0; i < walkingRight.length; i++) {
    walkingRight[i] = loadImage("walkingR"+i+".png");
    walkingRight[i].resize(180, 180);
  }

  for (int i = 0; i < walkingLeft.length; i++) {
    walkingLeft[i] = loadImage("walkingL"+i+".png");
    walkingLeft[i].resize(180, 180);
  }
  for (int i = 0; i < attackRight.length; i++) {
    attackRight[i] = loadImage("attackingR"+i+".png");
    attackRight[i].resize(180, 180);
  }

  for (int i = 0; i < attackLeft.length; i++) {
    attackLeft[i] = loadImage("attackingL"+i+".png");
    attackLeft[i].resize(180, 180);
  }


  for (int i = 0; i < eWalkingRight1.length; i++) {
    eWalkingRight1[i] = loadImage("enemyR"+i+".png");
    eWalkingRight1[i].resize(180, 180);
  }

  for (int i = 0; i < eWalkingLeft1.length; i++) {
    eWalkingLeft1[i] = loadImage("enemyL"+i+".png");
    eWalkingLeft1[i].resize(180, 180);
  }
  for (int i = 0; i < eAttackLeft1.length; i++) {
    eAttackLeft1[i] = loadImage("eAttack1L"+i+".png");
    eAttackLeft1[i].resize(180, 180);
  }
  for (int i = 0; i < eAttackRight1.length; i++) {
    eAttackRight1[i] = loadImage("eAttack1R"+i+".png");
    eAttackRight1[i].resize(180, 180);
  }

  for (int i = 0; i < eWalkingRight2.length; i++) {
    eWalkingRight2[i] = loadImage("bullWalkingR"+i+".PNG");
    eWalkingRight2[i].resize(180, 180);
  }

  for (int i = 0; i < eWalkingLeft2.length; i++) {
    eWalkingLeft2[i] = loadImage("bullWalkingL"+i+".PNG");
    eWalkingLeft2[i].resize(180, 180);
  }

  for (int i = 0; i < eAttackRight2.length; i++) {
    eAttackRight2[i] = loadImage("BullAttackR"+i+".PNG");
    eAttackRight2[i].resize(180, 180);
  }
  for (int i = 0; i < eAttackLeft2.length; i++) {
    eAttackLeft2[i] = loadImage("BullAttackL"+i+".PNG");
    eAttackLeft2[i].resize(180, 180);
  }

  for (int i = 0; i < eWalkingRight3.length; i++) {
    eWalkingRight3[i] = loadImage("wizardR"+i+".PNG");
    eWalkingRight3[i].resize(180, 180);
  }
  for (int i = 0; i < eWalkingLeft3.length; i++) {
    eWalkingLeft3[i] = loadImage("wizardL"+i+".PNG");
    eWalkingLeft3[i].resize(180, 180);
  }

  for (int i = 0; i < eWalkingLeft4.length; i++) {
    eWalkingLeft4[i] = loadImage("skeletonL"+i+".PNG");
    eWalkingLeft4[i].resize(120, 120);
  }
  for (int i = 0; i < eWalkingRight4.length; i++) {
    eWalkingRight4[i] = loadImage("skeletonR"+i+".PNG");
    eWalkingRight4[i].resize(120, 120);
  }
  for (int i = 0; i < eAttackLeft4.length; i++) {
    eAttackLeft4[i] = loadImage("sAttackL"+i+".PNG");
    eAttackLeft4[i].resize(120, 120);
  }
  for (int i = 0; i < eAttackRight4.length; i++) {
    eAttackRight4[i] = loadImage("sAttackL"+i+".PNG");
    eAttackRight4[i].resize(120, 120);
  }
}
