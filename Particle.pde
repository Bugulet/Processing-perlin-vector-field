class Particle {
  PVector velocity=new PVector();
  PVector position=new PVector();
  PVector lastPosition=new PVector();
  
  color strokeColor=color(255,125,0);
  
  Particle(float x, float y) {
    
    position.x=x;
    position.y=y;
    velocity.x=0;
    velocity.y=0;
  }
  
  
  void VelocityCap(){
    int cap=50;
    if(velocity.x>cap)
      velocity.x=cap;
    if(velocity.x<-cap)
      velocity.x=-cap;
    if(velocity.y>cap)
      velocity.y=cap;
    if(velocity.y<-cap)
      velocity.y=-cap;
  }
  
  void Update() {
    VelocityCap();
    
    lastPosition.x=position.x;
    lastPosition.y=position.y;
    
    position.x+=velocity.x;
    position.y+=velocity.y;
  }
  
  void Draw(){
    line(lastPosition.x,lastPosition.y,position.x,position.y);
  }

  void Wrap() {

    if (position.x>width)
      position.x=0;
    if (position.x<0)
      position.x=width;
    if (position.y>height)
      position.y=0;
    if (position.y<0)
      position.y=height;
  }
  
  boolean CheckOutside(){
    if (position.x>width)
      return true;
    if (position.x<0)
      return true;
    if (position.y>height)
      return true;
    if (position.y<0)
      return true;
    return false;
  }
}