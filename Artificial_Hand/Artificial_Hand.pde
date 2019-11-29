/* 
 * Artifical Hand( main ) for project CPH(Complemented Prosthetic Hand)
 * Made by - Team. GROW_I.C.I
 * This tab is for setup() and draw()  
 * This tab uses Arduino libraries for serial communication. 
 */

import processing.serial.*;
import cc.arduino.*;

// variables for arduino serial communication
Serial myPort;
String myString = null;
int tmpAngle1;
int tmpAngle2;
int tmpAngle3;
int tmpAngle4;
int tmpAngle5;
int[] tmpAngles = {tmpAngle1, tmpAngle2, tmpAngle3, tmpAngle4, tmpAngle5};

Arduino arduino;


// variables for hand draw (** side view **)
FingerSide finger1;
FingerSide finger2;
FingerSide finger3;
FingerSide finger4;
ThumbSide finger5;
Finger[] fingerSideArr;


//variables for had draw ( ** up view **)
FingerUp uFinger1;
FingerUp uFinger2;
FingerUp uFinger3;
FingerUp uFinger4;
ThumbUp uFinger5;
Finger[] uFingerArr;

// variables for apple 
Apple apple1;
Apple apple2;
Button apple;
Range appleRange;

// array of finger name
String[] fingerName = {"pinky", "Ring Finger", "Middle Finger", "Index Finger", "Thumb"};

// variables for wrist
Wrist wrist;  // wrist for side view
Wrist uWrist; // wrist for up view

// arrays for button 
Button[] angleButton;
Button[] grabRe;

// array for finger force range
Range angleRange[];

// range for grab and release 
Range grRange;    // range for grab and release

// set fingers grab angle. 
//This variable is for storing button return value 
final int DEFAULT = 9;
int f1Angle, f2Angle, f3Angle, f4Angle, f5Angle;
int[] angles = {f1Angle, f2Angle, f3Angle, f4Angle, f5Angle};


void setup()
{
  // set portName and generate myPort instance.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
 
  size(1000, 800, P3D);
  
  
  
  // setup for finger and wrist(** side view **) 
  fingerSideArr = new Finger[5];
  
  fingerSideArr[0] = finger1 =  new FingerSide(300, 600, -40, 45);   // pinky
  fingerSideArr[1] = finger2 =  new FingerSide(300, 600, 0, 50);     // ring finger 
  fingerSideArr[2] = finger3 = new FingerSide(300, 600, 40, 60);    // middle finger
  fingerSideArr[3] = finger4 =  new FingerSide(300, 600, 80, 50);    // indexfinger
  fingerSideArr[4] = finger5 = new ThumbSide(200, 600, 80, 20);     // thumb

  wrist = new Wrist(150, 600, 40, finger1, finger2, finger3, finger4, finger5);

  // setup for finger and wrist(** up view**)
  uFingerArr = new Finger[5];

  uFingerArr[0] = uFinger1 = new FingerUp(300, 150, 0, 45);
  uFingerArr[1] = uFinger2 = new FingerUp(300, 190, 0, 50);
  uFingerArr[2] = uFinger3 = new FingerUp(300, 230, 0, 60);
  uFingerArr[3] = uFinger4 = new FingerUp(300, 270, 0, 50);
  uFingerArr[4] = uFinger5 = new ThumbUp(200, 270, 0, 20);

  uWrist = new Wrist(150, 230, 0, uFinger1, uFinger2, uFinger3, uFinger4, uFinger5);

  // setup for button 
  angleButton = new Button[25];
  grabRe = new Button[2];

  // setup  for grab and release range
  grRange = new Range(600, 400, 270, 30);

  // set up for range for finger force
  angleRange = new Range[5];

  for (int i = 0; i < 5; i++) {
    angleRange[i] = new Range(700, 100 + 60*i, 150, 30);
  }
  
  // force button detail setting
  for (int a = 0; a < 5; a++) {    
    for (int b = 0; b< 5; b++) {
      angleButton[b + (a*5)] = new Button(700 + 30*b, 100 + 60*a, 30, 30, b+1, b+1 + "");
    }
  }
  
  // setup for grab release button 
  grabRe[0] = new Button(600, 400, 120, 30, "GRAB");
  grabRe[1] = new Button(720, 400, 150, 30, "RELEASE");

  // setup angle variable
  f1Angle = f2Angle = f3Angle = f4Angle = f5Angle = DEFAULT;

  // set apple
  apple1 = new Apple(280, 520, 40, 80);
  apple2 = new Apple(280, 230, 80, 80);
  apple = new Button( 660, 500, 120, 30, "Apple");
  appleRange = new Range( 660, 500, 120, 30);
}

void draw() {
  background(255);

  // hand display (**side view**)
  finger1.display(grabRe[0], grabRe[1], f1Angle, myPort);
  finger2.display(grabRe[0], grabRe[1], f2Angle, myPort);
  finger3.display(grabRe[0], grabRe[1], f3Angle, myPort); 
  finger4.display(grabRe[0], grabRe[1], f4Angle, myPort);
  finger5.display(grabRe[0], grabRe[1], f5Angle, myPort);
  wrist.display();

  // hand display (** up view **)
  uFinger1.display(grabRe[0], grabRe[1], f1Angle, myPort);
  uFinger2.display(grabRe[0], grabRe[1], f2Angle, myPort);
  uFinger3.display(grabRe[0], grabRe[1], f3Angle, myPort);
  uFinger4.display(grabRe[0], grabRe[1], f4Angle, myPort);
  uFinger5.display(grabRe[0], grabRe[1], f5Angle, myPort);
  uWrist.display();
  
  // view finger name text
  drawText();

  // button display code blocks
  for (int i = 0; i < angleButton.length; i++) {
    angleButton[i].display(15);
  }

  for (int i = 0; i < 2; i++) {
    grabRe[i].display(20);
  }
  
  // apple set
  apple.display(20);
  appleRange.display();

  // finger name    
  for (int i = 0; i < fingerName.length; i++) {
    textSize(13);
    text(fingerName[i], 600, 120 + 60*i);
  }
  
  
  // display() methode for angle range and grRange.
  for (int i = 0; i < angleRange.length; i++) {
    angleRange[i].display();
  }

  grRange.display();

  // set condition to make all angle 'DEFAULT' when release button is pressed
  if (grabRe[1].activate == true && grabRe[1].rectOver == true) {
    for (int i = 0; i < angleButton.length; i++) {
      if ( angleButton[i].activate == true) {
        angleButton[i].activate = false;
      }
    }
  }

  if ( finger1.angle3 < 0.001 && finger2.angle3 < 0.001 && finger3.angle3 < 0.001 && 
    finger4.angle3 < 0.001 && finger5.angle3 < 0.001) {
    grabRe[1].activate =false;
  }

  // codes for connection with button and finger angle setting
  angleSetter();

  /****************** codes for apple ************************/
  // button operation code
  if (apple.activate == true) {
    apple1.display();
    apple2.display();
  
  // code for collision
    for ( int a = 0; a < 5; a++) {        
      apple1.stopMov(fingerSideArr[a], myPort);
      apple2.stopMov(uFingerArr[a], myPort);
    }
  }
  if( finger1.getCollision() == true) {
    myPort.clear();
    myPort.write('c');
    myPort.write('1');
  }
  if( finger2.getCollision() == true) {
    myPort.clear();
    myPort.write('c');
    myPort.write('2');
  }
  if( finger3.getCollision() == true) {
    myPort.clear();
    myPort.write('c');
    myPort.write('3');
  }
  if( finger4.getCollision() == true) {
    myPort.clear();
    myPort.write('c');
    myPort.write('4');
  }
  if( finger5.getCollision() == true) {
    myPort.clear();
    myPort.write('c');
    myPort.write('5');
  }
  


  //********************* debug section *********************//
  for (int a = 0; a < 5; a++) {
    for (int b = 0; b < 5; b++) {
      if ( b != 4) { 
        print(" button " + "" + ((b+1) +(5*a)) +" : " + angleButton[b + (5*a)].activate);
      } else {
        println(" button " + "" + ((b+1) +(5*a)) +" : " + angleButton[b + (5*a)].activate);
      }
    }
  }

  println(" Grab : " + grabRe[0].activate);
  println(" Release : " + grabRe[1].activate);
  println(" Apple : " + apple.activate);
}
// end of draw()



// code block for finger name text
void drawText() {


  String finger1 = "Pinky";
  String finger2 = "Ring Finger";
  String finger3 = "Middle Finger";
  String finger4 = "Index Finger";
  String finger5 = "Thumb";

  pushMatrix();
  textLocation(this.finger1, finger1);
  textLocation(this.finger2, finger2);
  textLocation(this.finger3, finger3);
  textLocation(this.finger4, finger4);
  textLocation(this.finger5, finger5);

  textLocation(this.uFinger1, finger1);
  textLocation(this.uFinger2, finger2);
  textLocation(this.uFinger3, finger3);
  textLocation(this.uFinger4, finger4);
  textLocation(this.uFinger5, finger5);
  popMatrix();
}

// code blocks  for finger(thumb) name movement 
void textLocation(Finger finger, String text) {

  int len = 15;
  float x = finger.getTX() + len * (cos(PI/6));
  float y = finger.getTY() + len * (sin(PI/6));
  float z = finger.getTZ();

  textSize(12);
  text(text, x, y, z);
}

// code block for mousePressed() methode. 
// when mouse is pressed and range boolean is true, buttons, which is in range, will activate.
void mousePressed() {

  for (int a = 0; a< 5; a++) {
    if (angleRange[a].onRange == true) {
      for (int b = a*5; b < (a+1)*5; b++) {
        if (getRectOver(angleButton[b])) {
          angleButton[b].activate = true;
        } else {
          angleButton[b].activate = false;
        }
      }
    }
  }

  if (grRange.onRange == true) {
    for (int i = 0; i < grabRe.length; i++) {
      if (getRectOver(grabRe[i])) {
        grabRe[i].activate = true;
      } else {
        grabRe[i].activate = false;
      }
    }
  }

  if (appleRange.onRange == true) {
    if (getRectOver(apple) && apple.activate == false) {
      apple.activate = true;
    } else {
      apple.activate = false;
    }
  }
}

// getter for rectOver value 
boolean getRectOver (Button button) {
  return button.rectOver;
}

// methode for finger move angle set
void angleSetter() {
  for ( int a = 0; a < 5; a++) {
    if ( a == 0) {
      for ( int b = 0; b < 5; b++) {
        if (angleButton[b + (a*5)].activate == true) {
          f1Angle = angleButton[b + (a*5)].angle;
          finger1.activate = true;
          uFinger1.activate = true;
        }
      }
    } 
    if ( a == 1) {
      for ( int b = 0; b < 5; b++) {
        if (angleButton[b + (a*5)].activate == true) {
          f2Angle = angleButton[b + (a*5)].angle;
          finger2.activate = true;
          uFinger2.activate = true;
        }
      }
    }
    if ( a == 2) {
      for ( int b = 0; b < 5; b++) {
        if (angleButton[b + (a*5)].activate == true) {
          f3Angle = angleButton[b + (a*5)].angle;
          finger3.activate = true;
          uFinger3.activate = true;
        }
      }
    }
    if ( a == 3) {
      for ( int b = 0; b < 5; b++) {
        if (angleButton[b + (a*5)].activate == true) {
          f4Angle = angleButton[b + (a*5)].angle;
          finger4.activate = true;
          uFinger4.activate = true;
        }
      }
    }
    if ( a == 4) {
      for ( int b = 0; b < 5; b++) {
        if (angleButton[b + (a*5)].activate == true) {
          f5Angle = angleButton[b + (a*5)].angle;
          finger5.activate = true;
          uFinger5.activate = true;
        }
      }
    }
    //   
    if (grabRe[1].activate == true) {
      f1Angle = f2Angle = f3Angle = f4Angle = f5Angle = DEFAULT;
    }
  }
}

// serial event methode for arduino serial communication. 
// This methode handles changes of finger angles  
void serialEvent(Serial p) {
  try {
    myString = p.readStringUntil('.');
    if (myString != null) {
      String[] list = split(myString, ',');
      f5Angle  = 180 - int(list[0]);   // thumb
      f4Angle  = 180 - int(list[1]);   // ring finger       
      f3Angle  = 180 - int(list[2]);   // middle finger
      f2Angle  = 180 - int(list[3]);   // index finger 
      f1Angle  = 180 - int(list[4].replace(".", "")); // pinky
    }
  } 
  catch(Exception e) {
  }



  println("***************************");
  print("finger1 : "  + f5Angle);
  print(" finger2 : " +  f4Angle);
  print(" finger3 : " +  f3Angle);
  print(" finger4 : " +  f2Angle);
  println(" finger5 : " +  f1Angle);
}
