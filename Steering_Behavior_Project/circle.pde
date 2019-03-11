
class Circle {

  // A Path is line between two points (PVector objects)
  PVector position;
  // A path has a radius, i.e how far is it ok for the boid to wander off
  float r;

  Circle (PVector x, float r_) {
    // Arbitrary radius of 20
    position = x;
    r = r_;
  }
  PVector attract(People p){
   
    PVector force = PVector.sub(position,p.position);
    force.normalize();
    force.mult(0.05);
    return force;
   }
  // Draw the path
  void display() {
    ellipse(position.x, position.y, r, r);
    noFill();
  }
}
