//Client - 1's (o's)

import processing.net.*;

Client myClient;
int[][] grid;
boolean itsMyTurn;
boolean win;

void setup() {
  size(300, 400);
  grid = new int[3][3];
  textAlign(CENTER, CENTER);
  textSize(50);
  itsMyTurn = false;
  win = false;
  
  myClient = new Client(this, "127.0.0.1", 1234);
}

void draw() {
  if(itsMyTurn) background(0, 255, 0);
  else background(255, 0, 0);

  //draw dividing lines
  stroke(0);
  strokeWeight(3);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);

  //draw the x's and o's
  for(int row = 0; row < 3; row++)
    for(int col = 0; col < 3; col++)
      drawXO(row, col);

  //draw mouse coords
  fill(0);
  text(mouseX + "," + mouseY, 150, 350);
  
  //receiving messages
  if (myClient.available() > 0) {
    String incoming = myClient.readString();
    int r = int(incoming.substring(0,1));
    int c = int(incoming.substring(2,3));
    grid[r][c] = 2;
    itsMyTurn = true;
  }
  
  checkWin();
}


void drawXO(int row, int col) {
  pushMatrix();
  translate(row*100, col*100);
  if (grid[row][col] == 1) {
    noFill();
    strokeWeight(3);
    ellipse(50, 50, 90, 90);
  } else if (grid[row][col] == 2) {
    strokeWeight(3);
    line (10, 10, 90, 90);
    line (90, 10, 10, 90);
  }
  popMatrix();
}


void mouseReleased() {
  //assign the clicked-on box with the current player's mark
  int row = (int)mouseX/100;
  int col = (int)mouseY/100;
  if (grid[row][col] == 0 && itsMyTurn && !win) {
    grid[row][col] = 1;
    myClient.write(row + "," + col);
    itsMyTurn = false;
  }
}

void checkWin() {
  strokeWeight(7);
  if(grid[0][0] == 1 && grid[0][1] == 1 && grid[0][2] == 1) {
    line(50, 50, 50, 250);
    win = true;
  }
  else if(grid[1][0] == 1 && grid[1][1] == 1 && grid[1][2] == 1) {
    line(150, 50, 150, 250);
    win = true;
  }
  else if(grid[2][0] == 1 && grid[2][1] == 1 && grid[2][2] == 1) {
    line(250, 50, 250, 250);
    win = true;
  }
  else if(grid[0][0] == 1 && grid[1][0] == 1 && grid[2][0] == 1) {
    line(50, 50, 250, 50);
    win = true;
  }
  else if(grid[0][1] == 1 && grid[1][1] == 1 && grid[2][1] == 1) {
    line(50, 150, 250, 150);
    win = true;
  }
  else if(grid[0][2] == 1 && grid[1][2] == 1 && grid[2][2] == 1) {
    win = true;
    line(50, 250, 250, 250);
  }
  else if(grid[0][0] == 1 && grid[1][1] == 1 && grid[2][2] == 1) {
    win = true;
    line(50, 50, 250, 250);
  }
  else if(grid[0][2] == 1 && grid[1][1] == 1 && grid[2][0] == 1) {
    win = true;
    line(50, 250, 250, 50);
  }
  else if(grid[0][0] == 2 && grid[0][1] == 2 && grid[0][2] == 2) {
    win = true;
    line(50, 50, 50, 250);
  }
  else if(grid[1][0] == 2 && grid[1][1] == 2 && grid[1][2] == 2) {
    win = true;
    line(150, 50, 150, 250);
  }
  else if(grid[2][0] == 2 && grid[2][1] == 2 && grid[2][2] == 2) {
    win = true;
    line(250, 50, 250, 250);
  }
  else if(grid[0][0] == 2 && grid[1][0] == 2 && grid[2][0] == 2) {
    win = true;
    line(50, 50, 250, 50);
  }
  else if(grid[0][1] == 2 && grid[1][1] == 2 && grid[2][1] == 2) {
    win = true;
    line(50, 150, 250, 150);
  }
  else if(grid[0][2] == 2 && grid[1][2] == 2 && grid[2][2] == 2) {
    win = true;
    line(50, 250, 250, 250);
  }
  else if(grid[0][0] == 2 && grid[1][1] == 2 && grid[2][2] == 2) {
    win = true;
    line(50, 50, 250, 250);
  }
  else if(grid[0][2] == 2 && grid[1][1] == 2 && grid[2][0] == 2) {
    win = true;
    line(50, 250, 250, 50);
  }
}
