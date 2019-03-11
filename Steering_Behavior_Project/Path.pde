
class Path {

  // A Path is line between two points (PVector objects)
  PVector start;
  PVector end;
  // A path has a radius, i.e how far is it ok for the boid to wander off
  float radius;

  Path(int x, PVector startpoint, PVector endpoint) {
    // Arbitrary radius of 20
    radius = x;
    start = startpoint;
    end = endpoint;
  }

  // Draw the path
  void display() {

    strokeWeight(radius*6);
    stroke(0,100);
    line(start.x,start.y,end.x,end.y);

    strokeWeight(1);
    stroke(0);
    line(start.x,start.y,end.x,end.y);
  }
}
