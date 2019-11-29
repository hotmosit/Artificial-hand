class Apple {
  /**
   class for object on hand. 
   by adding stuff on hand, it can simulate artifical hand movement and processing movement
   this stuff is a DEMO(only sphere object)
   **/

  int xcor, ycor, zcor;
  int radius;


  Apple(int x, int y, int z, int rad) {
    // initialize position of the apple 
    this.xcor = x;
    this.ycor = y;
    this.zcor = z;
    // initialize apple radius
    this.radius = rad;
  }
  
  float j1Distance(Finger f) {    // return distance between apple center and finger joint1
    return dist(xcor, ycor, zcor, f.getJ1X(), f.getJ1Y(), f.getJ1Z());
  }

  float tDistance(Finger f) {      // return distance between apple center and finger tip.
    return dist(xcor, ycor, zcor, f.getTX(), f.getTY(), f.getTZ());
  }

  boolean tCollision(Finger finger) {     // when finger tip touches apple, return finger.setCollision as true
    if (tDistance(finger) < radius+10) {
      finger.setCollision(true);
      
      return true;
    } else {
      return false;
    }
  }

  boolean j1Collision(Finger finger) {    // when finger joint1 touches apple, return finger.setCollision as true
    if (j1Distance(finger) < radius + 5) {
      finger.setCollision(true);
      return true;
    } else {
      return false;
    }
  }

  void stopMov(Finger f, Serial s) {    // when finger.setCollsion is true, this methode stops finger movement  
    
    if ( s.available() > 0) {           // uses available() to divide operation when serial communication is ongoing or not. 
      if (j1Collision(f)) {       
        f.setFlag(true);
      }
      if (tCollision(f)) {   
        f.setFlag(false);   
      }
    } else {
      if (j1Collision(f)) {
        f.setActivate(false);
        f.setFlag(true);
      }
      if (tCollision(f)) {
        f.setActivate(false);
        f.setFlag(false);
      }
    }

    
  }


  void display() {
    pushMatrix();
    noStroke();
    fill(200, 80, 0);
    translate(xcor, ycor, zcor);  
    sphere(radius);
    popMatrix();
  }
}
