class People {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float wandertheta;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  People(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    position = new PVector(x,y);
    r = 6;
    wandertheta = 0;
    maxspeed = 0.8;
    maxforce = 0.01;
    
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
    float change = 0.2;
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
    //if (debug) drawWanderStuff(position,circlepos,target,wanderR);
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

  void display() {
    fill(0,255,255);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0, 0, r*1.3, r*1.3);
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


// A method just to draw the circle associated with wandering
void drawWanderStuff(PVector position, PVector circle, PVector target, float rad) {
  stroke(0);
  noFill();
  ellipseMode(CENTER);
  ellipse(circle.x,circle.y,rad*2,rad*2);
  ellipse(target.x,target.y,4,4);
  line(position.x,position.y,circle.x,circle.y);
  line(circle.x,circle.y,target.x,target.y);
}
