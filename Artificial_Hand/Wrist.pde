/*
 * Tab for class Wrist.
 * This class draw wrist and clap
 * wrist and clap has no movement
 */

class Wrist {
    
  float wristX;
  float wristY;
  float wristZ;

  // variable for finger 1 
  float f1X;
  float f1Y;
  float f1Z;

  // variable for finger 2
  float f2X;
  float f2Y;
  float f2Z;

  // variable for finger 3
  float f3X;
  float f3Y;
  float f3Z;

  // variable for finger4
  float f4X;
  float f4Y;
  float f4Z;

  // variable for finger 5, this is thumb
  float f5X;
  float f5Y;
  float f5Z;


  Wrist(float wristX, float wristY, float wristZ, FingerSide f1, FingerSide f2, 
        FingerSide f3, FingerSide f4, ThumbSide f5) {    
    // set wrist value
    this.wristX = wristX;
    this.wristY = wristY;
    this.wristZ = wristZ;

    // set fingers x, y value 
    this.f1X = f1.start_x;
    this.f1Y = f1.start_y;
    this.f1Z = f1.start_z;

    this.f2X = f2.start_x;
    this.f2Y = f2.start_y;
    this.f2Z = f2.start_z;

    this.f3X = f3.start_x;
    this.f3Y = f3.start_y;
    this.f3Z = f3.start_z;

    this.f4X = f4.start_x;
    this.f4Y = f4.start_y;
    this.f4Z = f4.start_z;

    this.f5X = f5.start_x;
    this.f5Y = f5.start_y;
    this.f5Z = f5.start_z;
  }
  
  Wrist(float wristX, float wristY, float wristZ, FingerUp f1, FingerUp f2, 
        FingerUp f3, FingerUp f4, ThumbUp f5) {    
    // set wrist value
    this.wristX = wristX;
    this.wristY = wristY;
    this.wristZ = wristZ;

    // set fingers x, y value 
    this.f1X = f1.start_x;
    this.f1Y = f1.start_y;
    this.f1Z = f1.start_z;

    this.f2X = f2.start_x;
    this.f2Y = f2.start_y;
    this.f2Z = f2.start_z;

    this.f3X = f3.start_x;
    this.f3Y = f3.start_y;
    this.f3Z = f3.start_z;

    this.f4X = f4.start_x;
    this.f4Y = f4.start_y;
    this.f4Z = f4.start_z;

    this.f5X = f5.start_x;
    this.f5Y = f5.start_y;
    this.f5Z = f5.start_z;
  }
    


  void handDraw() {
    pushMatrix();
    stroke(100, 200);
    strokeWeight(5);
    // draw lines
    line(wristX, wristY, wristZ, f1X, f1Y, f1Z);
    line(wristX, wristY, wristZ, f2X, f2Y, f2Z);
    line(wristX, wristY, wristZ, f3X, f3Y, f3Z);
    line(wristX, wristY, wristZ, f4X, f4Y, f4Z);
    line(wristX, wristY, wristZ, f5X, f5Y, f5Z);
  
    // draw wrist 
    stroke(0);
    strokeWeight(1);
    fill(255, 255);
    ellipseMode(RADIUS);
    
    pushMatrix();
    translate(wristX, wristY, wristZ);
    ellipse(0, 0, 20, 20);
    popMatrix();
    
    fill(0);
    pushMatrix();
    translate(f1X, f1Y, f1Z);
    ellipse(0, 0, 4, 4);
    popMatrix();
    
    pushMatrix();
    translate(f2X, f2Y, f2Z);
    ellipse(0, 0, 4, 4);
    popMatrix();
    
    pushMatrix();
    translate(f3X, f3Y, f3Z);
    ellipse(0, 0, 4, 4);
    popMatrix();
    
    pushMatrix();
    translate(f4X, f4Y, f4Z);
    ellipse(0, 0, 4, 4);
    popMatrix();
    
    pushMatrix();
    translate(f5X, f5Y, f5Z);
    ellipse(0, 0, 4, 4);
    popMatrix();
    
    popMatrix();
}
    void display() {
      handDraw();
    }
  }
