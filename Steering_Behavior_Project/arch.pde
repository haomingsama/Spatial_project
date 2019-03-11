class Arch {

  // A Path is line between two points (PVector objects)
  PVector position;
  PVector position2;
  // A path has a radius, i.e how far is it ok for the boid to wander off
  float c;
  float d;
  Arch () {
    // Arbitrary radius of 20
    position = new PVector(width/2-100,height/2-350);
    position2 = new PVector(width/2-10,height/2-320);
    c = 200;
    d = 70;
  }


PVector attract(People p){
   
    PVector force = PVector.sub(position,p.position);
    force.normalize();
    force.mult(0.05);
    return force;
   }
PVector attract1(Pigeon pn){
   
    PVector force1 = PVector.sub(position2,pn.position);
    force1.normalize();
    force1.mult(1);
    return force1;
   }
  // Draw the path
  void display() {
    noFill();
    rect(position.x,position.y,c,d);
    
  }
}
