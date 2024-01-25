//player image, animation, collisions, etc
class Player extends Character{
  
  ArrayList <Bullet> bullets = new ArrayList<Bullet>();
  int keyNum = 0; //check if key is obtained
  PImage[] activeFrames;
  int currFrame = 0;
  int animRate = 6;
  
  Player(PVector pos, PVector vel){
    super(pos, vel);
    dim = new PVector(46, 78);
    health = 9;
    damp = 0.8;
    activeFrames = stay;
    img = loadImage("player_0.png");
  }

//check movement and animation 
  void update(){
    super.update();
    checkWalls();
    checkBricks();
    checkBullets();
    if(health == 0) state = LOST;
    updateFrame();
  }  

//move
  void moveCharacter(){
    super.moveCharacter();
    vel.mult(damp);
  }
  
//check bullet collision with enemies or brick
  void checkBullets(){
    for(int i = 0; i < bullets.size(); i++){
      Bullet bl = bullets.get(i);
      bl.update();
      bl.drawBullet();
      
      for(int j = 0; j < bEnemies.size(); j++){
        BasicEnemy b = bEnemies.get(j);
        bl.hit(b);
      }
      for(int k = 0; k < boss.size(); k++){
        BossEnemy bs = boss.get(k);
        bl.hitBoss(bs);
      }
      if(state == LEVEL_ONE){
      for(int j = 0; j < gw.bricks.size(); j++){
        Brick br = gw.bricks.get(j);
        if(bl.hitBrick(br)) bullets.remove(bl);
      }}
      if(state == LEVEL_TWO){
      for(int l = 0; l < gw2.bricks.size(); l++){
        Brick br2 = gw2.bricks.get(l);
        if(bl.hitBrick(br2)) bullets.remove(bl);
      }}
      if(state == LEVEL_THREE){
      for(int m = 0; m < gw3.bricks.size(); m++){
        Brick br3 = gw3.bricks.get(m);
        if(bl.hitBrick(br3)) bullets.remove(bl);
      }}
      if(!bl.isAlive) bullets.remove(i);
    }
  }

  //fire bullet up
  void fireUp(){
    bullets.add(new Bullet(new PVector(pos.x+10, pos.y), new PVector(0, -15)));
  }
 
  //fire bullets down
  void fireDown(){
    bullets.add(new Bullet(new PVector(pos.x+10, pos.y+35), new PVector(0, 15)));
  }
  
  //fire bullets left
  void fireLeft(){
    bullets.add(new Bullet(new PVector(pos.x, pos.y+17), new PVector(-15, 0)));
  }

  //fire bullets right
  void fireRight(){
    bullets.add(new Bullet(new PVector(pos.x, pos.y+17), new PVector(15, 0)));
  }  
  
  //collision with walls
  void checkWalls(){
    if(pos.x < img.width/60) pos.x = img.width/60;
    if(pos.x > width - img.width) pos.x = width -img.width;
    if(pos.y < img.height) pos.y = img.height;
    if(pos.y > height - img.height) pos.y = height - img.height;
  }
  
  //collision with bricks
    void collisions(Brick r2) {
    float xDistance = (pos.x + dim.x/2) - (r2.pos.x +r2.w/2);
    float yDistance= (pos.y +dim.y/2) - (r2.pos.y +r2.h/2);
    float halfWidths = (dim.x/2) + (r2.w/2);
    float halfHeights = (dim.y/2) + (r2.h/2);


    if (abs(xDistance)<halfWidths) {
      if (abs(yDistance) < halfHeights) {

        float xCollision = halfWidths - abs(xDistance);
        float yCollision = halfHeights - abs(yDistance);
        if (xCollision >= yCollision) {
          if (yDistance > 0) {
            pos.y +=yCollision; //dectection for under block
          } else {
            pos.y -= yCollision;
          }
        } else if (xCollision <= yCollision) {
          if (xDistance > 0) {
            pos.x +=xCollision;
          } else {
            pos.x -=xCollision;

          }
        }
      }
    }
  }
  
  //reposition player on new level
  void repositionRight(){
    pos.x = width-75;
    pos.y = height - 80;
  }  
  
  //reposition player on new level
  void repositionLeft(){
    pos.x = 25;
    pos.y = 910;
  }
  
  
  //collision with bricks
  void checkBricks() {
    if(state == LEVEL_ONE){
    for (int i = 0; i < gw.bricks.size(); i++) {
      Brick currBlock = gw.bricks.get(i);
      collisions(currBlock);
    }}
    if(state == LEVEL_TWO){
    for (int i = 0; i < gw2.bricks.size(); i++) {
      Brick currBlock2 = gw2.bricks.get(i);
      collisions(currBlock2);
    }}
    if(state == LEVEL_THREE){
    for (int i = 0; i < gw3.bricks.size(); i++) {
      Brick currBlock3 = gw3.bricks.get(i);
      collisions(currBlock3);
    }}
  }
  
  //animation frames
    void updateFrame() {
    if(frameCount % animRate == 0){
      if(currFrame + 1 < activeFrames.length) currFrame += 1;
      else currFrame = 0;
      
      //currFrame = (currFrame + 1) % activeFrames.length
    }
    img = activeFrames[currFrame];
  }
  
  //animation when going up
  void up(){
    currFrame = 0;
    activeFrames = flyUp;
  }
  
  //animation when going down
  void down(){
    currFrame = 0;
    activeFrames = flyDown;
  }
  
  //animation when going left
  void left(){
    currFrame = 0;
    activeFrames = flyLeft;
  }
  
  //animation when going right
  void right(){
    currFrame = 0;
    activeFrames = flyRight;
  }

  void drawCharacter(){
    pushMatrix();
    noFill();
    translate(pos.x, pos.y);
    //rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
    image(img, 0, 0);
    popMatrix();
  }

}
