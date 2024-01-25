//player controls
boolean up, down, right, left;

PVector upAcc = new PVector(0, -2);      //moving up
PVector downAcc = new PVector (0, 2);    //moving down
PVector rightAcc = new PVector (2, 0);    //moving right
PVector leftAcc = new PVector (-2, 0);    //moving left

//check if key is pressed
void keyPressed(){
  if (key == CODED){
    if (keyCode == UP){
      up = true;
      user.up();
    }
    if (keyCode == DOWN){
      down = true;
      user.down();
    }
    if (keyCode == RIGHT){
      right = true;
      user.right();
    }
    if (keyCode == LEFT){
      left = true;
      user.left();
    }
  }

  
  if (keyPressed){ 
    if (key == 'w' || key == 'W'){
      user.fireUp();
      playSound(PLAYER_SHOOT);
    }
    if (key == 's' || key == 'S'){
      user.fireDown();
      playSound(PLAYER_SHOOT);
    }
    if (key == 'a' || key == 'A'){
      user.fireLeft();
      playSound(PLAYER_SHOOT);
    }
    if (key == 'd' || key == 'D'){
      user.fireRight();
      playSound(PLAYER_SHOOT);
    }
  }
}


//check if key is released
void keyReleased(){
  if (key == CODED){
    if (keyCode == UP) up = false;
    if (keyCode == DOWN) down = false;
    if (keyCode == RIGHT) right = false;
    if (keyCode == LEFT) left = false;
  }
}
