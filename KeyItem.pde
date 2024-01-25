//superclass for key and heart
class KeyItem{

  PVector pos, dim;
  PImage img;
  
  KeyItem(PVector pos){
    this.pos = pos;
  }
  
  void update(){
    drawItem();
  }
  
  
  void drawItem(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0, 0);
    popMatrix();
  }

}
