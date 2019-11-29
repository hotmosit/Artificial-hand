/*
 * Tab for interface Finger.
*/

interface Finger {

  float getJ1X();    // return joint 1 xcor 
  float getJ1Y();
  float getJ1Z();

  float getTX();     // return tip xcor 
  float getTY();
  float getTZ();
  
  boolean getActivate();
  void setActivate(boolean activ);
  void setFlag(boolean flag);
  void setCollision(boolean col);
  boolean getCollision(); 

  float j1gm(Button b, int angle, Serial s); // joint 1 grab movement
  float j2gm(Button b, int angle, Serial s); // joint 2 grab movement
  void tgm(Button b, int angle, Serial s);   // tip grab movement

  void j1rm(Button b); // joint 1 release movement
  void j2rm(Button b); // joint 2 release movement
  void trm(Button b);  // tip release movement

  void fingerDraw();
  void display(Button a, Button b, int angle, Serial s);
}
