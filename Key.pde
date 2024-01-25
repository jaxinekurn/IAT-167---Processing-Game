//key to obtain in order to open treasure chest
class Key extends KeyItem{

  PImage[] activeFrames;
  int currFrame = 0;
  int animRate = 6;  
  
    Key(PVector pos){
      super(pos);
      dim = new PVector(75, 75);
      activeFrames = shinyKey;
      img = loadImage("key.png");
    }

    
    //if obtained can open chest
    void update(){
      updateFrame();
      if(keyObtained()){
        user.keyNum++;
        playSound(KEYS);
        bKey.remove(this);
      }
      if(!keyObtained()){
        drawItem();
      }
    }
    
    //collision with player
    boolean keyObtained(){
      return abs(pos.x - user.pos.x) < dim.x/2 + user.img.width/2 
        && abs(pos.y - user.pos.y) < dim.y/2 + user.img.height/2;
    }
    
    //key animation
    void updateFrame() {
      if(frameCount % animRate == 0){
        if(currFrame + 1 < activeFrames.length) currFrame += 1;
        else currFrame = 0;
        
        //currFrame = (currFrame + 1) % activeFrames.length
      }
      img = activeFrames[currFrame];
    }
    
    //draw
    void drawItem(){
      img = activeFrames[currFrame];
      pushMatrix();
      translate(pos.x, pos.y);
      scale(0.8, 0.8);
      image(img, 0, 0);
      popMatrix();
    }

}
