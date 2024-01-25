//class for basic enemy to appear, shoot, die
class BossEnemy extends BasicEnemy{
  
  int timeDead = 30;  //countown for disappearing
  PImage[] activeFrames;  //store active frames
  int currFrame = 0;  //current active frame
  int animRate = 3;  //how often animation should change

  BossEnemy(PVector pos, PVector vel){
    super(pos, vel);
    dim = new PVector(50, 68);
    health = 2;
    activeFrames = regBSE;
    img = loadImage("bossenemy_0.png");
  }
  
//moving character
  void moveCharacter(){
    if(isDead){
      timeDeath -= 1;
      dead();
        if(timeDeath == 0){
          boss.remove(this);
        }
    }
    if(!isDead) drawMe();
  }  

//remove if dead
  void killed(){
    boss.remove(this);
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
  void dead(){
    currFrame = 0;
    activeFrames = bsDead;
  }  

//draw
  void drawMe(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0, 0);
    popMatrix();
  }

}
