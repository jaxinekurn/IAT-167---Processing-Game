//class for basic enemy to appear, shoot, die
class BasicEnemy extends Character{

  int timeDeath = 30;  //countown for disappearing
  boolean isDead; //check if enemy is dead or alive
  int dmg = 1; //the damage of enemy bullet
  PImage[] activeFrames; //store active frames
  int currFrame = 0; //current active frame
  int animRate = 3; //how often animation should change
  
  ArrayList<EnemyBullet> eBullets = new ArrayList<EnemyBullet>();
  ArrayList<Brick> bricks = new ArrayList<Brick>();
  
  BasicEnemy(PVector pos, PVector vel){
    super(pos, vel);
    dim = new PVector(50, 50);
    cWidth = 50;
    health = 1;
    activeFrames = regBE;
    img = loadImage("basicenemy_0.png");
  }

// updating charater  
  void update(){
    super.update();
    drawMe();
    checkBullets();
    fire();
    updateFrame();
  } 

//moving character  
  void moveCharacter(){
    if(isDead){
      timeDeath -= 3;
      explode();
        if(timeDeath == 0){
          bEnemies.remove(this);
        }
    }
    if(!isDead) drawMe();
  }

// check if enemy is shot by player  
  void hit(){
    health -= 1;
    playSound(ENEMY_HIT);
    if(health == 0) isDead = true;
  }
  
//remove enemy if dead 
  void killed(){
    bEnemies.remove(this);
  }

  
// to shoot  
  void fire(){
    if(state == LEVEL_ONE || state == LEVEL_TWO){
    if(frameCount % 35 == 0){
      eBullets.add(new EnemyBullet(new PVector(pos.x+12, pos.y+30), new PVector(0,15)));
      playSound(ENEMY_SHOOT);
    }
    if(frameCount % 35 == 0){
      eBullets.add(new EnemyBullet(new PVector(pos.x+12, pos.y-30), new PVector(0,-15)));
    }
    if(frameCount % 35 == 0){
      eBullets.add(new EnemyBullet(new PVector(pos.x+30, pos.y+15), new PVector(15,0)));
    }
    if(frameCount % 35 == 0){
      eBullets.add(new EnemyBullet(new PVector(pos.x, pos.y+15), new PVector(-15,0)));  
    }
    }
    if(state == LEVEL_THREE){
      if(frameCount % 25 == 0){
        eBullets.add(new EnemyBullet(new PVector(pos.x+12, pos.y+30), new PVector(0,15)));
        playSound(ENEMY_SHOOT);
      }
      if(frameCount % 25 == 0) eBullets.add(new EnemyBullet(new PVector(pos.x+12, pos.y-30), new PVector(0,-15)));
      if(frameCount % 25 == 0) eBullets.add(new EnemyBullet(new PVector(pos.x+30, pos.y+15), new PVector(15,0)));
      if(frameCount % 25 == 0) eBullets.add(new EnemyBullet(new PVector(pos.x, pos.y+15), new PVector(-15,0)));  
    }
  }

//check bullet collision  
  void checkBullets(){
    for(int i = 0; i < eBullets.size(); i++){
      EnemyBullet eb = eBullets.get(i);
      eb.update();
      eb.drawBullet();
      eb.hitPlay(user, eBullets);
      if(!eb.isAlive) eBullets.remove(eb);
      if(state == LEVEL_ONE){
      for(int j = 0; j < gw.bricks.size(); j++){
        Brick br = gw.bricks.get(j);
        if(eb.hitBrick(br)) eBullets.remove(eb);
      }}
      if(state == LEVEL_TWO){
      for(int l = 0; l < gw2.bricks.size(); l++){
        Brick br2 = gw2.bricks.get(l);
        if(eb.hitBrick(br2)) eBullets.remove(eb);
      }}
      if(state == LEVEL_THREE){
      for(int m = 0; m < gw3.bricks.size(); m++){
        Brick br3 = gw3.bricks.get(m);
        if(eb.hitBrick(br3)) eBullets.remove(eb);
      }}
    }
  }
  
//frame update for animation
  void updateFrame() {
    if(frameCount % animRate == 0){
      if(currFrame + 1 < activeFrames.length) currFrame += 1;
      else currFrame = 0;
      
      //currFrame = (currFrame + 1) % activeFrames.length
    }
    img = activeFrames[currFrame];
  }  

  
//animation when dead  
  void explode(){
    currFrame = 0;
    activeFrames = beDead;
  }
 
//draw  
  void drawMe(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0, 0);
    popMatrix();
  }

}
