//bullets from player
class Bullet {

  PVector pos, vel, dim;
  boolean isAlive; //check if bullet hasn't collided yet
  PImage img; //bullet image

  Bullet(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    isAlive = true;
    dim = new PVector(25, 25);
    img = loadImage("playerbullet.png");
  }

  void update() {
    move();
  }

  void move() {
    pos.add(vel);
  }

//collision with walls
  void handleWalls() {
    if (abs(pos.x - width/2) > width/2 || abs (pos.y - height/2) > height/2) isAlive = false;
  }

//collision with bricks
  boolean hitBrick(Brick r2) {
    float xDistance = (pos.x + dim.x/2) - (r2.pos.x +r2.w/2);
    float yDistance= (pos.y +dim.y/2) - (r2.pos.y +r2.h/2);
    float halfWidths = (dim.x/2) + (r2.w/2);
    float halfHeights = (dim.y/2) + (r2.h/2);


    if (abs(xDistance)<halfWidths) {
      if (abs(yDistance) < halfHeights) {
        return true;
      }
    }
    return false;
  }

//collision with basic enemy
  void hit(BasicEnemy c) {
    if (abs(pos.x - c.pos.x) < dim.x/2 + c.dim.x/2 && abs(pos.y - c.pos.y) < dim.y/2 + c.dim.y/2) {
      c.hit();
      isAlive = false;
    }
  } 

//collision with boss enemy 
  void hitBoss(BossEnemy e){
    if(abs(pos.x - e.pos.x) < dim.x/2 + e.dim.x/2 && abs(pos.y - e.pos.y) < dim.y/2 + e.dim.y/2){
      e.hit();
      isAlive = false;
    }
  }   

//draw
  void drawBullet() {
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0, 0);
    popMatrix();
  }
}
