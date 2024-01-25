// heart for additional health
class Heart extends KeyItem{

  Heart(PVector pos){
    super(pos);
    dim = new PVector(80, 80);
    img = loadImage("heart.png");
  }

//add health if collided
  void update(){
    if(hitCharacter()){ 
      user.health += 3;
      playSound(HEAL);
      heart.remove(this); 
      } 
    if(!hitCharacter()){
      drawItem();
     }
  }

//collision with character (player)
  boolean hitCharacter(){
    return abs(pos.x - user.pos.x) < dim.x/2 + user.img.width/2 && 
      abs(pos.y - user.pos.y) < dim.y/2 + user.img.height/2;
  }  

  void drawItem(){
    pushMatrix();
    translate(pos.x, pos.y);
    scale(0.7, 0.7);
    image(img, 0, 0);
    popMatrix();  
  }

}  
