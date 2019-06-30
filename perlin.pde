import processing.video.*;

Capture cam;


int seed=0;



VectorMap vectors;
ArrayList<Particle> particles = new ArrayList<Particle>();

Particle dot;

int state=0;

PVector toMap;
PImage frog;
PImage sprite;
void setup() {
  noiseSeed(seed);
  String[] cameras = Capture.list();
  
  sprite=loadImage("tiger.jpg");
  sprite.resize(width,0);
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }     
  if(cam.width > 0 && cam.height > 0){
    frog=cam.get();
    frog.resize(300,300);
  }
  
  
  size(1920,1080);
  //fullScreen();
  background(0);
  toMap=new PVector();
  
  
  
  for (int i=0; i<2000; i++)
    particles.add(new Particle(random(0, width), random(0, height)));

  vectors=new VectorMap();
  vectors.fillMap();
}



void draw() {

  
  if (cam.available() == true) {
    cam.read();
    frog=cam.get();
    frog.resize(0,1080);
    frog.filter(POSTERIZE,50);
  }

  
  if (keyPressed  && key=='e')
  {
    background(0);
    stroke(255);
    fill(255);
    vectors.drawArrows();
  }

  if (keyPressed  && key=='r')
  {
    background(0);
    stroke(255);
    fill(255);
  }


  if (keyPressed && key=='q')
  {
    background(0);
    seed++;
    noiseSeed(seed);
    vectors.fillMap();
  }



  if (keyPressed && key=='w')
  {
    vectors.offset.y--;
    vectors.fillMap();

    background(0);

    vectors.drawArrows();
  }

  if (keyPressed && key=='s')
  {
    vectors.offset.y++;
    vectors.fillMap();
    background(0);
    vectors.drawArrows();
  }

  if (keyPressed && key=='a')
  {
    vectors.offset.x--;
    vectors.fillMap();
    background(0);
    vectors.drawArrows();
  }

  if (keyPressed && key=='d')
  {
    vectors.offset.x++;
    vectors.fillMap();
    background(0);
    vectors.drawArrows();
  }


  for (int i=particles.size(); i>0; i--)
  {
    noStroke();
    fill(255, 100, 150);
    dot=particles.get(i-1);

    //problem with mapping, needs to be solved fast
    toMap.x=map(dot.position.x, 0, width, 0, vectors.mapSizeX-1);
    toMap.y=map(dot.position.y, 0, height, 0, vectors.mapSizeY-1);


    dot.velocity.x+=map(vectors.map[int(toMap.x)][int(toMap.y)][0], 0, 1, -5, 5);
    dot.velocity.y+=map(vectors.map[int(toMap.x)][int(toMap.y)][1], 0, 1, -5, 5);


    dot.Update();

    if (dot.CheckOutside()==true) {
      particles.remove(i-1);
      if (mouseX>0 && mouseX<width && mouseY>0 && mouseY<height && mousePressed)
        particles.add(new Particle(mouseX, mouseY));
      else particles.add(new Particle(random(0, width), random(0, height)));
    }
    
    
    if(state==0)
    {
      stroke(255,125,0);
      strokeWeight(0.5);
    }
    
    if(state==1)
    {
      if(cam.width > 0 && cam.height > 0){
      color c=frog.get(int(dot.position.x),int(dot.position.y));
      stroke(c);
      strokeWeight(2);
    }
    }
    
    if(state==2)
    {
      color c=sprite.get(int(dot.position.x),int(dot.position.y));
      stroke(c);
      strokeWeight(2);
    }
    
    
    
    dot.Draw();
    }
    
  fill(255);
  rect(0,0,200,80);
  fill(0);
  textSize(40);
  text("STATE++",20,50);
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  vectors.noiseScale+=e/100;
  background(0);
  vectors.fillMap();
  vectors.drawArrows();
  println(e);
}

void mousePressed() {
  if (mouseButton == LEFT && mouseX<200 && mouseY<100) {
    state++;
    if(state>2)
      state=0;
  } 
}