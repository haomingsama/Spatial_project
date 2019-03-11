class Pigeon {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float wandertheta;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  Pigeon(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    position = new PVector(x,y);
    r = 6;
    wandertheta = 0;
    maxspeed = 3;
    maxforce = 1;
    
  }

  void run() {
    update();
    borders();
    display();
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void wander() {
    float wanderR = 25;         // Radius for our "wander circle"
    float wanderD = 80;         // Distance for our "wander circle"
    float change = 0.09;
    wandertheta += random(-change,change);     // Randomly change wander theta

    // Now we have to calculate the new position to steer towards on the wander circle
    PVector circlepos = velocity.get();    // Start with velocity
    circlepos.normalize();            // Normalize to get heading
    circlepos.mult(wanderD);          // Multiply by distance
    circlepos.add(position);               // Make it relative to boid's position

    float h = velocity.heading2D();        // We need to know the heading to offset wandertheta

    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h),wanderR*sin(wandertheta+h));
    PVector target = PVector.add(circlepos,circleOffSet);
    seek(target);

    // Render wandering circle, etc.
    
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }


  void stop(PVector target) {
    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target
    float d = desired.mag();
    // Scale with arbitrary damping within 100 pixels
    if (d < 30) {
      velocity.mult(0);
    } 
  }
    
  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target) {
    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

    applyForce(steer);
  }
  void separate (ArrayList<People> people) {
    float desiredseparation = r*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (People other : people) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      // Our desired vector is moving away maximum speed
      sum.setMag(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }
void arrive(PVector target) {
    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target
    float d = desired.mag();
    // Scale with arbitrary damping within 100 pixels
    if (d < 100) {
      float m = map(d,0,100,0,maxspeed);
      desired.setMag(m);
    } else {
      desired.setMag(maxspeed);
    }
}


  void display() {
     // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    fill(127);
    stroke(0);
    pushMatrix();
    translate(position.x,position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2/6);
    vertex(-r/6, r*2/6);
    vertex(r/6, r*2/6);
    endShape();
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
}
