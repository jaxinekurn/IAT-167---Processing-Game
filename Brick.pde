//draw the brick for the background
class Brick {
    PVector pos, totDiff;
    PImage img;
    int w, h;
    
    Brick(PVector pos) {
        this.pos = pos;
        w = 100;
        h = 100;
        img = loadImage("brick.png");
    }


    
    void drawMe() {
      pushMatrix();
      translate(pos.x, pos.y);
      image(img, 0, 0);
      popMatrix();
    }
}
