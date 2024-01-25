//subclass of bullet, bullet from basic and boss enemies
class EnemyBullet extends Bullet{

  PImage img; //bullet image
  
  EnemyBullet(PVector pos, PVector vel){
    super(pos, vel);
    isAlive = true;
    dim = new PVector(25, 25);
    img = loadImage("enemybullet.png");
  }
  
//collision with player
  void hitPlay(Player p , ArrayList<EnemyBullet> eBullets){
    if(abs(pos.x - p.pos.x) < dim.x/2 + p.img.width/2 && abs(pos.y - p.pos.y) < dim.y/2 + p.img.height/2){
     p.health--;
     playSound(PLAYER_HIT);
     eBullets.remove(this);
    }
  }
  
//draw
  void drawBullet(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0, 0);
    popMatrix();
  }
}
