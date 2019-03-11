class Food{
PVector position;
float r; // ridus


  Food(PVector v){
    
  position = v;
  r = 100;
    
    
  }

  PVector attract1(Pigeon pn){
   
    PVector force1 = PVector.sub(position,pn.position);
    force1.normalize();
    force1.mult(2);
    return force1;
   }
 
  void display() {
    fill(255,255,0);
    ellipse(position.x,position.y,10,10);
  }

}
