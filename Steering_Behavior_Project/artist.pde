class Artist{
PVector position;
float r; // ridus


  Artist(float x, float y){
    
  position = new PVector(x,y);
  r = 100;
    
    
  }

  PVector attract(People p){
   
    PVector force = PVector.sub(position,p.position);
    force.normalize();
    force.mult(0.05);
    return force;
   }
  PVector attract1(Pigeon pn){
   
    PVector force1 = PVector.sub(position,pn.position);
    force1.normalize();
    force1.mult(0.05);
    return force1;
   }
 
  void display() {
    fill(255,0,0);
    ellipse(position.x,position.y,10,10);
  }

}
