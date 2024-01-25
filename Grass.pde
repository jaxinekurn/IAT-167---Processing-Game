//draw the grass for the background
class Grass {
    PVector pos;
    PImage img;
    
    Grass(PVector pos) {
        this.pos = pos;
        img = loadImage("grass.png");
    }
    
    void drawMe() {
        pushMatrix();
        translate(pos.x, pos.y);
        image(img, 0, 0);
        popMatrix();
    }
}
