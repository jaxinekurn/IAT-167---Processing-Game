//treasure to collect (goal of game)
class TreasureChest extends KeyItem{

  PImage[] activeFrames;
  int currFrame = 0;
  int animRate = 5;  
  
  TreasureChest(PVector pos){
    super(pos);
    dim = new PVector(80, 70);
    activeFrames = tChest;
    img = loadImage("treasurechest_0.png");
  }
 
//gameflow (check if players have reached the chest)  
  void update(){
    if(state == LEVEL_ONE){
      if(treasureCollide() && user.keyNum == 1){
        //countdown--;
        //if(countdown > 0) chestOpen();
        //if(countdown <= 0){
          state = LEVEL_TWO;
          playSound(TREASURE_SOUND);
          clearLevel();
          user.repositionRight();
        //}
      }
      if(!treasureCollide()){
        drawItem();
      }
    }
    if(state == LEVEL_TWO){
      if(treasureCollide() && user.keyNum == 1){
        state = LEVEL_THREE;
        playSound(TREASURE_SOUND);
        clearLevel();
        user.repositionLeft();
      }
      if(!treasureCollide()){
        drawItem();
      }
    }
    if(state == LEVEL_THREE){
      //if(treasureCollide() && user.keyNum == 1){
        if(user.keyNum == 1 && user.pos.x < 100 && user.pos.y < 200){
        state = WON;
        playSound(TREASURE_SOUND);
        }
      if(!treasureCollide()){
        drawItem();
      }
    }
  }
 
//player collision with chest    
  boolean treasureCollide(){
     return abs(pos.x - user.pos.x) < dim.x/2 + user.img.width/2 
       && abs(pos.y - user.pos.y) < dim.y/2 + user.img.height/2;
  }    

//animation frames
  //void updateFrame() {
  //  if(frameCount % animRate == 0){
  //    if(currFrame + 1 < activeFrames.length) currFrame += 1;
  //    else currFrame = 0;
      
  //    //currFrame = (currFrame + 1) % activeFrames.length
  //  }
  //  img = activeFrames[currFrame];
  //}    
  
  //void chestOpen(){
  //  currFrame = 0;
  //  activeFrames = tcOpen;
  //}  
    
  void drawItem(){
      pushMatrix();
      translate(pos.x, pos.y);
      image(img, 0, 0);
      popMatrix();
  }  
}
