// A path object (series of connected points)

Path path;
Path path2;
Path path3;
Circle smallcircle;
Circle bigcircle;
Arch arch;
ArrayList<People> people;
ArrayList<Pigeon> pigeon;
Artist artist;
Artist artist2;
Artist artist3;
ArrayList<Food> food;
boolean debug = true;



void setup() {
  size(1460, 800);
  int radius = 20;
  PVector startpoint = new PVector(0,height/2);
  PVector endpoint = new PVector(width/2-200,height/2);
  path = new Path(radius, startpoint,endpoint);
  path2 = new Path(radius, new PVector(width,height/2),new PVector(width/2+200,height/2));
  path3 = new Path(radius,new PVector(width/2,height),new PVector(width/2,height-199));
  
  smallcircle = new Circle(new PVector (width/2, height/2), 200.0);
  bigcircle = new Circle(new PVector (width/2, height/2), 400);
  
  arch = new Arch();
  
  people = new ArrayList<People>();
   for (int i = 0; i < 10; i++) {
    people.add(new People(random(width),random(height)));
  }
  pigeon = new ArrayList<Pigeon>();
   for (int i = 0; i < 170; i++) {
    pigeon.add(new Pigeon(random(width),random(height)));
  }
  food = new ArrayList<Food>();
  artist = new Artist(width/2,height/2);
  artist2=new Artist(width/2,height/4);
  artist3=new Artist(width/4,height/2);
}


void draw() {
  background(255);
  // Display the path
  arch.display();
  
  path.display();
  path2.display();
  path3.display();
  smallcircle.display();
  bigcircle.display();

  for (People v : people) {
    float d = dist(artist.position.x,artist.position.y,v.position.x,v.position.y);
    if (d >100){
      v.wander();
      v.run();} else if(20<d && d<=50){
      v.run();
      float p = random(0,1);
      if (p <=0.5){PVector force = artist.attract(v);
      v.applyForce(force);
      v.stop(artist.position);} else{
      v.wander();
      v.run();} }else {
      v.wander();
      v.run();}
    }
  for (People v : people) {
    float d = dist(artist2.position.x,artist2.position.y,v.position.x,v.position.y);
    if (d >100){
      v.wander();
      v.run();} else if(20<d && d<=100){
      v.run();
      float p = random(0,1);
      if (p <=0.5){PVector force = artist2.attract(v);
      v.applyForce(force);
      v.stop(artist2.position);} else{
      v.wander();
      v.run();} }else {
      v.wander();
      v.run();}
    }
  for (People v : people) {
    float d = dist(artist3.position.x,artist3.position.y,v.position.x,v.position.y);
    if (d >100){
      v.wander();
      v.run();} else if(20<d && d<=100){
      v.run();
      float p = random(0,1);
      if (p <=0.5){PVector force = artist3.attract(v);
      v.applyForce(force);
      v.stop(artist3.position);} else{
      v.wander();
      v.run();} }else {
      v.wander();
      v.run();}
    }
  for (People v : people) {
    float d = dist(arch.position.x,arch.position.y,v.position.x,v.position.y);
    if (d >100){
      v.wander();
      v.run();} else if(20<d && d<=100){
      v.run();
      float p = random(0,1);
      if (p <=0.5){PVector force = arch.attract(v);
      v.applyForce(force);
      v.stop(arch.position);} else{
      v.wander();
      v.run();} }else {
      v.wander();
      v.run();}
    }
  for (People v : people) {
    float d = dist(smallcircle.position.x,smallcircle.position.y,v.position.x,v.position.y);
    if (d >200){
      v.wander();
      v.run();} else if(170<d && d<=200){
      v.run();
      float p = random(0,1);
      if (p <=0.5){
      v.velocity.mult(0);
      } else{
      v.wander();
      v.run();} }else {
      v.wander();
      v.run();}
    }
  for (People v : people) {
    float d = dist(smallcircle.position.x,smallcircle.position.y,v.position.x,v.position.y);
    if (d >100){
      v.wander();
      v.run();} else if(90<d && d<=100){
      v.run();
      float p = random(0,1);
      if (p <=0.8){
      v.velocity.mult(0);
      } else{
      v.wander();
      v.run();} }else {
      v.wander();
      v.run();}
    }
  for (Pigeon pn : pigeon) {
    for (Food f : food){
      f.display();
      float d = dist(f.position.x,f.position.y,pn.position.x,pn.position.y);
    if (d >1500){
      pn.wander();
      pn.run();} else if(30<d && d<=1500){
      pn.run();
      float p = random(0,1);
      float q = random(0.9,1);
      if (p <=q){PVector force = f.attract1(pn);
      pn.applyForce(force);} else if (d<=30){
      pn.run();
      }
    
    
    }
   
      
    }
  }
  for (Pigeon pn : pigeon) {
    // Path following and separation are worked on in this function
    pn.separate(people);
    // Call the generic run method (update, borders, display, etc.)
    pn.run();
    pn.wander();
    pn.display();
    float d = dist(arch.position.x,arch.position.y,pn.position.x,pn.position.y);
    if (d >2000){
      pn.wander();
      pn.run();} else if(30<d && d<=2000){
      pn.run();
      float p = random(0,1);
      if (p <=0.9){PVector force = arch.attract1(pn);
      pn.applyForce(force);} else if (d<30){
      pn.stop(arch.position2);} }
      
  }
  artist.display();
  artist2.display();
  artist3.display();
  
}

void mousePressed() {
  food.add(new Food(new PVector(mouseX,mouseY)));
}

void mouseDragged() {
  people.add(new People(mouseX,mouseY));
}

void keyPressed() {
  food.remove(0);
}
