//game setting for level 1
class GameWorldOne{

  final int BRICK = 0; //brick block
  final int GRASS = 1; //grass block where characters and items are located
  
  final int TILE_SIZE = 100; //size of tiles
  
  ArrayList<Brick> bricks = new ArrayList<Brick>();
  ArrayList<Grass> grass = new ArrayList<Grass>();
  
  int[][] map = {
    //0- brick, 1-grass
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {1, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1},
  {0, 0, 0, 0, 1, 0, 0, 1, 0},
  {0, 0, 0, 0, 1, 1, 1, 1, 1},
  {0, 0, 0, 0, 1, 0, 0, 0, 0},
  {1, 1, 1, 1, 1, 1, 1, 1, 1},
  {0, 0, 0, 0, 0, 0, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0}
  };  
  
  GameWorldOne(){
    for(int i = 0; i < map.length; i++){
      for(int j = 0; j < map[i].length; j++){
        switch(map[i][j]){
          case BRICK:
            // add block to blocks
            bricks.add(new Brick(new PVector(j*TILE_SIZE, i*TILE_SIZE)));
            block = true;
            break;
          default:
            // empty tile, do nothing
            grass.add(new Grass(new PVector(j*TILE_SIZE, i*TILE_SIZE)));
            block = false;
            break;
        }
      }
    }
    bricks.add(new Brick(new PVector(3*width/2, height - TILE_SIZE/2)));
    block = true;
  }  
  
//draw  
  void drawMe(){
    for(int i = 0; i < bricks.size(); i++){
      Brick b = bricks.get(i);
      b.drawMe();
    for(int j = 0; j < grass.size(); j++){
      Grass g = grass.get(j);
      g.drawMe();
    }
    }
  }  

}
