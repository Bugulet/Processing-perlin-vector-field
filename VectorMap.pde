class VectorMap {
  int mapSizeX=50;
  int mapSizeY=50;
  int multiplierScale=20;
  
  int offsetX=width/mapSizeX;
  int offsetY=height/mapSizeY;
  
  float[][][] map=new float[mapSizeX][mapSizeY][2];
  
  float noiseScale = 0.01;

  float multiplier=height/multiplierScale;

  PVector offset=new PVector();
  //Constructor
  VectorMap() {
    fillMap();
    offset.x=150;
    offset.y=400;
  }

  void fillMap() {
    for (int x=0; x < mapSizeX; x++) {
      for (int y=0; y<mapSizeY; y++) {   
        map[x][y][0]=noise((x+int(offset.x))*noiseScale, (y+int(offset.y))*noiseScale);
        map[x][y][1]=noise((y+int(offset.y))*noiseScale, (x+int(offset.x))*noiseScale);
      }
    }
  }


  void drawArrows() {
    stroke(255);
    strokeWeight(1);
    multiplier=height/multiplierScale;
    for (int x=0; x < mapSizeX; x++) {
      for (int y=0; y<mapSizeY; y++) { 
        fill(155);
        stroke(255);
        strokeWeight(1);  
        line(x*offsetX, y*offsetY, x*offsetX+map(map[x][y][0], 0, 1, -offsetX, offsetX), y*offsetY+map(map[x][y][1], 0, 1, -offsetY, offsetY));
        noStroke();
        rect(x*offsetX+map(map[x][y][0], 0, 1, -offsetX, offsetX),y*offsetY+map(map[x][y][1], 0, 1, -offsetY, offsetY),3,3);
      }
    }
  }

  void drawMap() {
    multiplier=height/multiplierScale;

    for (int x=0; x < mapSizeX; x++) {
      for (int y=0; y<mapSizeY; y++) {    
        noStroke();
        fill( map(map[x][y][0], 0, 1, 0, 255), 0, map(map[x][y][1], 0, 1, 0, 255));
        rect(x*offsetX, y*offsetY, x*offsetX+map(map[x][y][0], 0, 1, -offsetX, offsetX), y*offsetY+map(map[x][y][1], 0, 1, -offsetY, offsetY));
      }
    }
  }
}