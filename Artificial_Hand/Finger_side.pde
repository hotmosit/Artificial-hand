/*
 * Tab for FingerSide class. This class implements Finger 
 * This class is for drawing side view of finger.
*/

class FingerSide implements Finger {

  float len1;      // length between fingerStart - fingerJoint_1
  float len2;      // length between fingerJoint_1 - fingerJoint_2
  float len3;      // length between fingerJoint_2 - fingerTip

  // variables(point) for start of the finger. 
  float start_x;   
  float start_y;
  float start_z;

  // variables for finger joints
  float joint_1_x;
  float joint_1_y;
  float joint_1_z;

  float joint_2_x;
  float joint_2_y;
  float joint_2_z;

  float tip_x;
  float tip_y;
  float tip_z;

  // variables for angles
  float angle1;
  float angle2;
  float angle3;
  final int angleMov = 1;

  boolean activate = false;
  
  boolean flag = false;
  
  boolean collision = false;

  FingerSide(float fingerStartX, float fingerStartY, float fingerStartZ, float len ) {
    // set length
    this.len1 = len;
    this.len2 = len * 4/5;
    this.len3 = len * 4/5;   
    // set start point
    this.start_x = fingerStartX;
    this.start_y = fingerStartY;
    this.start_z = fingerStartZ;
    // set joint X cor
    this.joint_1_x = start_x + len1;
    this.joint_2_x = joint_1_x + len2;
    this.tip_x = joint_2_x + len3;
    // set joint Y cor
    this.joint_1_y = fingerStartY;
    this.joint_2_y = fingerStartY;
    this.tip_y = fingerStartY;
     // set joint Z cor
    this.joint_1_z = fingerStartZ;
    this.joint_2_z = fingerStartZ;
    this.tip_z = fingerStartZ;
    // set angles
    this.angle1 = 0;
    this.angle2 = 0;
    this.angle3 = 0;
  }
  
  // getter methods for apple
  @Override
  float getJ1X(){ return joint_1_x; }
  @Override
  float getJ1Y(){ return joint_1_y; }
  @Override
  float getJ1Z(){ return joint_1_z; }
  
  @Override
  float getTX(){ return tip_x; }
  @Override
  float getTY(){ return tip_y; }
  @Override
  float getTZ(){ return tip_z; }
  
  @Override
  boolean getActivate(){ return activate; }
  @Override
  void setActivate(boolean activ){ activate = activ; }
  @Override
  void setFlag(boolean flag){ this.flag = flag; }
  @Override
  void setCollision(boolean col){ this.collision = col; }
  @Override
  boolean getCollision(){ return collision; }
  
  /*code blocks For grab movements
   * if fingerJoint_1 moves, it moves maximum angle PI/2, other joints moving angles has connection(?)  
   * THIS IS PROTOTYPE OF MOVEMENT, NEED MORE FIX
   */
  @Override
  float j1gm(Button grab, int angle, Serial s) {
    pushMatrix();
   
    if ((grab.activate == true && angle1 < PI/(-(angle)+7) && angle1 > -0.1 && activate == true)
        || (s.available() > 0 && angle1 < radians(angle * 1/2 ) && angle1 > -0.1 && collision == false)) {
      angle1 += radians(angleMov)*0.25;
      joint_1_x = start_x + (len1 * cos(-angle1));
      joint_1_y = start_y + (len1 * sin(-angle1));
    }
    popMatrix();
    return angle1;
  }
  @Override
  float j2gm(Button grab, int angle, Serial s) {
    pushMatrix();

    if ( (j1gm(grab, angle, s) > 0 && angle2 < angle1*2.1 && angle2 > -0.1)
          || (flag == true && angle2 < angle1*4.2 )) {
      angle2 += radians(angleMov)*1 ;

      joint_2_x = joint_1_x + (len2 * cos(-angle2));
      joint_2_y = joint_1_y + (len2 * sin(-angle2));
    }

    popMatrix();
    return angle2;
  }

 @Override
 void tgm(Button grab, int angle, Serial s) {
    pushMatrix();

    if ( j2gm(grab, angle, s) > 0 && angle3 < angle2* 3/2 && angle3 > -0.1) {
      angle3 += radians(angleMov)*2.3;

      tip_x = joint_2_x + (len3 * cos(-angle3));
      tip_y = joint_2_y + (len3 * sin(-angle3));
    }

    popMatrix();
   
  }

  /* code blocks for release movement.
   * if release == 1 and mouse released, than start release
   * THIS IS PROTOTYPE OF MOVEMENT, NEED MORE FIX 
   */
  @Override
  void j1rm(Button release) {
    pushMatrix();
    if ( release.activate == true && angle1 > 0) {

      angle1 -= radians(angleMov);
      joint_1_x = start_x + (len1 * cos(-angle1));
      joint_1_y = start_y + (len1 * sin(-angle1));
    }
    popMatrix();
  }
  @Override
  void j2rm(Button release) {
    pushMatrix();
    if (release.activate == true && angle2 > 0 ) {
      angle2 -= radians(angleMov) * 1.5;
      joint_2_x = joint_1_x + (len2 * cos(-angle2));
      joint_2_y = joint_1_y + (len2 * sin(-angle2));
    }
    popMatrix();
  }
  @Override
  void trm(Button release) {
    pushMatrix();
    if (release.activate == true && angle3 > 0) {
      angle3 -= radians(angleMov)*2.3;

      tip_x = joint_2_x + (len3 * cos(-angle3));
      tip_y = joint_2_y + (len3 * sin(-angle3));
    }
    popMatrix();
  }
  @Override
  void fingerDraw() {
     pushMatrix();
    stroke(100, 200);
    strokeWeight(5);
    // finger line

    line(joint_1_x, joint_1_y, joint_1_z ,start_x, start_y, start_z);
    line(joint_2_x, joint_2_y, joint_2_z ,joint_1_x, joint_1_y, joint_1_z);  
    line(tip_x, tip_y, tip_z, joint_2_x, joint_2_y, joint_2_z);

    /* code for finger joints */
    ellipseMode(RADIUS);
    stroke(0);
    strokeWeight(1);
    // for finger start
    fill(255, 50);
    
    pushMatrix();
    translate(start_x, start_y, start_z);
    ellipse(0, 0, 10, 10);
    popMatrix();
    
    // for finger joints
    fill(0);
    pushMatrix();
    translate(joint_1_x, joint_1_y, joint_1_z);
    ellipse(0, 0, 4, 4);
    popMatrix();
    
    pushMatrix();
    translate(joint_2_x, joint_2_y, joint_2_z);
    ellipse(0, 0, 4, 4);
    popMatrix();
    
    pushMatrix();
    translate(tip_x, tip_y, tip_z);
    ellipse(0,0 , 4, 4);
    popMatrix();
    
    popMatrix();
   
  }
  @Override
  void display(Button grab, Button release, int angle, Serial s ) {
    fingerDraw();
    j1gm(grab, angle, s);
    j2gm(grab, angle, s);
    tgm(grab, angle, s);

    j1rm(release);
    j2rm(release);
    trm(release);
  }
}
