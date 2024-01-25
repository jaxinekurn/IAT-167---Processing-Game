//superclass of player, basic enemy, and boss enemy
class Character{

  //fields
  PVector pos, vel;
  int health;
  float w, h;
  float damp;
  float cWidth;
  PImage img;
  PVector dim;
  
  //constructor to initialize fields
  Character(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
  }
  
  void update(){
    moveCharacter();
  }

  void moveCharacter(){
    pos.add(vel);
  }
  
  void accelerate(PVector acc){
    vel.add(acc);
  }

//decrease health when something happens  
  void decreaseHealth(int dmg) {
    health = health - dmg;
  }

//character is hit with something
  boolean hitCharacter(Character c){
    return abs(pos.x - c.pos.x) < cWidth/2 + c.w/2 && 
      abs(pos.y - c.pos.y) < cWidth/2 + c.h/2;
  }
  
//draw
  void drawCharacter(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0, 0);
    popMatrix();
  }

}
