import controlP5.*;
ControlP5 controlP5;
Button play;

import ddf.minim.*;
Minim minim;
AudioPlayer bgMusic;
AudioPlayer playerShoot;
AudioPlayer enemyShoot;
AudioPlayer heartHeal;
AudioPlayer keySound;
AudioPlayer treasureSound;
AudioPlayer playerHit;
AudioPlayer enemyHit;

GameWorldOne gw;
GameWorldTwo gw2;
GameWorldThree gw3;
Player user;

//tile collision detection
boolean block;
PVector totDiff;

//to store location of enemies in each level
PVector L1E1, L1E2, L1E3, K1E1, T1E1, B1E1, H1E1;
PVector L2E1, L2E2, L2E3, K2E1, T2E1, B2E1, H2E1;
PVector L3E1, L3E2, L3E3, K3E1, T3E1, B3E1, H3E1;

int brickSize = 100;

//start screen timer
int timer = 200;

int state;

final String BG_MUSIC = "bg_music.wav";
final String PLAYER_SHOOT = "player_shoot.wav";
final String ENEMY_SHOOT = "enemy_shoot.wav";
final String HEAL = "heal.wav";
final String KEYS = "key_sound.wav";
final String TREASURE_SOUND = "treasure_sound.wav";
final String PLAYER_HIT = "player_hit.wav";
final String ENEMY_HIT = "enemy_hit.wav";

final int LEVEL_ONE = 0;
final int LEVEL_TWO = 1;
final int LEVEL_THREE = 2;
final int WON = 3;
final int LOST = 4;

PImage[] stay = new PImage[1];
PImage[] regBE = new PImage[1];
PImage[] regBSE = new PImage[1];
PImage[] flyRight = new PImage[2];
PImage[] flyLeft = new PImage[2];
PImage[] flyUp = new PImage[2];
PImage[] flyDown = new PImage[2];
PImage[] beDead = new PImage[10];
PImage[] bsDead = new PImage[4];
PImage[] shinyKey = new PImage[2];
PImage[] tChest = new PImage[1];
PImage[] tcOpen = new PImage[3];

ArrayList<BasicEnemy> bEnemies = new ArrayList<BasicEnemy>();
ArrayList<BossEnemy> boss = new ArrayList<BossEnemy>();
ArrayList<Key> bKey = new ArrayList<Key>();
ArrayList<TreasureChest> treasure = new ArrayList<TreasureChest>();
ArrayList<Heart> heart = new ArrayList<Heart>();

void setup(){
  size(900, 1000);
  state = LEVEL_ONE;
  fill(255);
  gw = new GameWorldOne();
  gw2 = new GameWorldTwo();
  gw3 = new GameWorldThree();
  user = new Player(new PVector(25, 910), new PVector(0, 0));
  controlP5 = new ControlP5(this);
  //user = new Player(new PVector(835, 910), new PVector(0, 0));
  for(int i = 0; i < 3; i++){
    spawnBEnemies();
  }
  for(int j = 0; j < 1; j++){
    placeKey();
  }
  for(int t = 0; t < 1; t++){
    placeTreasure();
  }
  for(int y = 0; y < 1; y++){
    spawnBoss();
  }
  for(int h = 0; h < 1; h++){
    placeHeart();
  }
  
  loadGameFrames();
  
  PFont font = loadFont("Candara-Bold-48.vlw");
  textFont(font);
  textSize(50);  
  
  play = controlP5.addButton("Restart", 0, 300, 550, 300, 100);
  play.getCaptionLabel().setFont(font);
  play.setColorLabel(color(0));
  play.setColorForeground(color(250, 0, 0)); 
  play.setColorBackground(color(255, 204, 0));
  
  minim = new Minim(this);
  bgMusic = minim.loadFile(BG_MUSIC);
  bgSound(BG_MUSIC);
  playerShoot = minim.loadFile(PLAYER_SHOOT);
  enemyShoot = minim.loadFile(ENEMY_SHOOT);
  heartHeal = minim.loadFile(HEAL);
  keySound = minim.loadFile(KEYS);
  treasureSound = minim.loadFile(TREASURE_SOUND);
  playerHit = minim.loadFile(PLAYER_HIT);
  enemyHit = minim.loadFile(ENEMY_HIT);
}

void draw(){
  switch(state){
    case(LEVEL_ONE):
      //if(set == 0){
        startScreen();
        timer--;
        if(timer <= 0) 
          gamePlay();
      //}
      //if(set > 0){
        //gamePlay();
      //}
      break;
    case(LEVEL_TWO):
      gamePlay();
      break;
    case(LEVEL_THREE):
      gamePlay();
      break;
    //case(START):
    //  gamePlay();
    //  startScreen();
    //  break;
    case(LOST):
      gameOver();
      break;
    case(WON):
      congrats();
      break;
  }
}

//game play method
void gamePlay(){
  controlP5.getController("Restart").hide();  
  if(state == LEVEL_ONE) gw.drawMe();
  if(state == LEVEL_TWO) gw2.drawMe();
  if(state == LEVEL_THREE) gw3.drawMe();
  
  textSize(50);
  text("HEALTH: " + user.health/3, 650, 70);
  
  if(state == LEVEL_ONE){
    textSize(50);
    text("LEVEL 1", 20, 70);
    pushMatrix();
    textSize(30);
    text("Collect the key", 350, 50);
    text("and open the chest!", 325, 80);
    text("Use arrow keys to move and w-a-s-d to shoot", 160, 130);
    popMatrix();
    
  }
  
  if(state == LEVEL_TWO){
    textSize(50);
    text("LEVEL 2", 20, 70);
  }
  
  if(state == LEVEL_THREE){
    textSize(50);
    text("LEVEL 3", 20, 70);
  }
  
  user.update();
  user.drawCharacter();    
  
  if (up) user.accelerate(upAcc);
  if (down) user.accelerate(downAcc);
  if (left) user.accelerate(leftAcc);
  if (right) user.accelerate(rightAcc);
  
  for(int i = 0; i < bEnemies.size(); i++){
    BasicEnemy be = bEnemies.get(i);
    be.update();
  }
  
  for(int y = 0; y < boss.size(); y++){
    BossEnemy bs = boss.get(y);
    bs.update();
  }  
  
  for(int j = 0; j < bKey.size(); j++){
    Key k = bKey.get(j);
    k.update();
  }
  
  for(int g = 0; g < treasure.size(); g++){
    TreasureChest tr = treasure.get(g);
    tr.update();
  }
  
  for(int h = 0; h < heart.size(); h++){
    Heart ht = heart.get(h);
    ht.update();
  }
}

//collision detection method
void collision(Brick b, Character c) {
    PVector diff = PVector.sub(c.pos, b.pos);
    totDiff = new PVector(abs(diff.x), abs(diff.y));
    if (block && totDiff.x < c.dim.x / 2 + b.img.width / 2 && totDiff.y < c.dim.y / 2 + b.img.height / 2) {
     c.pos.x += diff.x*0.02;
     c.pos.y += diff.y*0.02;
     c.vel.mult(0.0);
    }
  }
    
//method to clear enemies and items after each level is completed  
void clearLevel(){
  if(state == LEVEL_TWO){
  gw.bricks.clear();
  gw.grass.clear();
  bEnemies.clear();
  boss.clear();
  bKey.clear();
  treasure.clear();
  heart.clear();
  user.keyNum = 0;
  }
  if(state == LEVEL_THREE){
  gw2.bricks.clear();
  gw2.grass.clear();
  bEnemies.clear();
  boss.clear();
  bKey.clear();
  treasure.clear();
  heart.clear();
  user.keyNum = 0;
  }
  //if(state == LEVEL_TWO){
  //  gw = gw2;
  //}
  //if(state == LEVEL_THREE){
  //  gw2 = gw3;
  //}
  //user.health = 9;
  for(int i = 0; i < 3; i++){
    spawnBEnemies();
  }
  for(int j = 0; j < 1; j++){
    placeKey();
  }
  for(int t = 0; t < 1; t++){
    placeTreasure();
  }
  for(int y = 0; y < 1; y++){
    spawnBoss();
  }
  for(int h = 0; h < 1; h++){
    placeHeart();
  }
}  
  
// method to spawn basic enemies  
void spawnBEnemies(){
   L1E1 = new PVector(625, 725);
   L1E2 = new PVector(725, 325);
   L1E3 = new PVector(25, 625);
   
   L2E1 = new PVector(725, 125);
   L2E2 = new PVector(525, 925);
   L2E3 = new PVector(425, 125);
   
   L3E1 = new PVector(625, 925);
   L3E2 = new PVector(325, 525);
   L3E3 = new PVector(125, 325);
   
  if(state == LEVEL_ONE){
    bEnemies.add(new BasicEnemy(L1E1, new PVector(0, 0)));
    bEnemies.add(new BasicEnemy(L1E2, new PVector(0, 0)));
    bEnemies.add(new BasicEnemy(L1E3, new PVector(0, 0)));
  }
  if(state == LEVEL_TWO){
    bEnemies.add(new BasicEnemy(L2E1, new PVector(0, 0)));
    bEnemies.add(new BasicEnemy(L2E2, new PVector(0, 0)));
    bEnemies.add(new BasicEnemy(L2E3, new PVector(0, 0)));
  }
  if(state == LEVEL_THREE){
    bEnemies.add(new BasicEnemy(L3E1, new PVector(0, 0)));
    bEnemies.add(new BasicEnemy(L3E2, new PVector(0, 0)));
    bEnemies.add(new BasicEnemy(L3E3, new PVector(0, 0)));
  }
}

//method to spawn boss enemy
  void spawnBoss(){
    B1E1 = new PVector(25, 216);
    B2E1 = new PVector(225, 916);
    B3E1 = new PVector(125, 116);
    if(state == LEVEL_ONE){
      boss.add(new BossEnemy(B1E1, new PVector(0, 0)));
    }
    if(state == LEVEL_TWO){
      boss.add(new BossEnemy(B2E1, new PVector(0, 0)));
    }
    if(state == LEVEL_THREE){
      boss.add(new BossEnemy(B3E1, new PVector(0, 0)));
    }
  }

//method to place key
void placeKey(){
  K1E1 = new PVector(20, 120);
  K2E1 = new PVector(20, 420);
  K3E1 = new PVector(820, 920);
  if(state == LEVEL_ONE){
    bKey.add(new Key(K1E1));
  }
  if(state == LEVEL_TWO){
    bKey.add(new Key(K2E1));
  }
  if(state == LEVEL_THREE){
    bKey.add(new Key(K3E1));
  }
}


//method to place treasure chest
void placeTreasure(){
  T1E1 = new PVector(810, 115);
  T2E1 = new PVector(10, 915);
  T3E1 = new PVector(10, 115);
  if(state == LEVEL_ONE){
    treasure.add(new TreasureChest(T1E1));
  }
  if(state == LEVEL_TWO){
    treasure.add(new TreasureChest(T2E1));
  }
  if(state == LEVEL_THREE){
    treasure.add(new TreasureChest(T3E1));
  }
}
  
//method to place heart for health  
void placeHeart(){
  H1E1 = new PVector(822, 420);
  H2E1 = new PVector(322, 120);
  H3E1 = new PVector(822, 120);
  if(state == LEVEL_ONE){
    heart.add(new Heart(H1E1));
  }
  if(state == LEVEL_TWO){
    heart.add(new Heart(H2E1));
  }
  if(state == LEVEL_THREE){
    heart.add(new Heart(H3E1));
  }
}

//method to store start screen
void startScreen(){
  controlP5.getController("Restart").hide();
  pushMatrix();
  background(255);
  scale(1, 1);
  PImage img = loadImage("bgstartscreen.png");
  image(img, 0, 0);
  popMatrix();
  //if (keyPressed){ 
  //  if (key == ' ') state = LEVEL_ONE;
  //}  
}


//method to store game over screen
void gameOver(){
  controlP5.getController("Restart").show();
  pushMatrix();
  background(255);
  scale(1, 1);
  PImage img = loadImage("gameover.png");
  image(img, 0, 0);
  popMatrix();
}

//method to store winning screen
void congrats(){
  controlP5.getController("Restart").show();
  pushMatrix();
  background(255);
  scale(1, 1);
  PImage img = loadImage("congrats.png");
  image(img, 0, 0);
  popMatrix();
}

//method for game reset
void reset(){
  L1E1 = new PVector(625, 725);
  L1E2 = new PVector(725, 325);
  L1E3 = new PVector(25, 625);
  B1E1 = new PVector(25, 216);
  K1E1 = new PVector(20, 120);
  T1E1 = new PVector(810, 115);
  H1E1 = new PVector(822, 420);
  

  bEnemies.clear();
  boss.clear();
  bKey.clear();
  treasure.clear();
  heart.clear();
  user.health = 9;
  user = new Player(new PVector(25, 910), new PVector(0, 0));
  bEnemies.add(new BasicEnemy(L1E1, new PVector(0, 0)));
  bEnemies.add(new BasicEnemy(L1E2, new PVector(0, 0)));
  bEnemies.add(new BasicEnemy(L1E3, new PVector(0, 0)));
  boss.add(new BossEnemy(B1E1, new PVector(0, 0)));
  bKey.add(new Key(K1E1));
  treasure.add(new TreasureChest(T1E1));
  heart.add(new Heart(H1E1));
  state = LEVEL_ONE;
  //gw.drawMe();
}

//method to load animation frames
void loadGameFrames(){
  loadFrames(stay, "player_");
  loadFrames(flyRight, "player_right_");
  loadFrames(flyLeft, "player_left_");
  loadFrames(flyUp, "player_up_");
  loadFrames(flyDown, "player_down_");
  loadFrames(regBE, "basicenemy_");
  loadFrames(beDead, "be_explode_");
  loadFrames(regBSE, "bossenemy_");
  loadFrames(bsDead, "bse_dead_");
  loadFrames(shinyKey, "key_");
  loadFrames(tChest, "treasurechest_");
  loadFrames(tcOpen, "tc_open_");
}

//load animation frames
void loadFrames(PImage[] pi, String fname){
  for(int i = 0; i < pi.length; i++){
    PImage frame = loadImage(fname + i + ".png");
    pi[i] = frame;
  }
}

//control buttons
void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName() =="Restart") {
    reset();
    controlP5.getController("Restart").hide(); 
    gamePlay();
  }
}

void bgSound(String file){
  AudioPlayer sound = null;
  switch(file){
    case BG_MUSIC:
      sound = bgMusic;
      break;
  }
  sound.loop();
}

//sound effects
void playSound(String file){
  AudioPlayer sound = null;
  switch(file){
    //case BG_MUSIC:
    //  sound = bgMusic;
    //  break;
    case PLAYER_SHOOT:
      sound = playerShoot;
      break;
    case ENEMY_SHOOT:
      sound = enemyShoot;
      break;
    case HEAL:
      sound = heartHeal;
      break;
    case KEYS:
      sound = keySound;
      break;
    case TREASURE_SOUND:
      sound = treasureSound;
      break;
    case PLAYER_HIT:
      sound = playerHit;
      break;
    case ENEMY_HIT:
      sound = enemyHit;
      break;
  }
  sound.play(0);
}

   
