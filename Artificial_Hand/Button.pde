/*  
 *   This class is for producing buttons. 
 *   the buttons will activate when mouse is clicked in certain range    
 */

class Button {

  int rectx, recty;    // variables for button position
  int rectw, recth;        // variables for button size
  int angle;           // variable for angle
  String text;         // String variable for text in button
  boolean rectOver; 
  boolean activate;

  Button( int rectx, int recty, int rectw, int recth, int angle, String text) {
    this.rectx = rectx;
    this.recty = recty;
    this.rectw = rectw;
    this.recth = recth;
    this.angle = angle;
    this.text = text;
    this.rectOver = false;
    this.activate = false;
  }
  
  Button(int rectx, int recty, int rectw, int recth, String text){
    this.rectx = rectx;
    this.recty = recty;
    this.rectw = rectw;
    this.recth = recth;
    this.text = text;
    this.rectOver = false;
    this.activate = false;
  }
  
 // when mouse is over the button, rectOver is true.
  void update(int x, int y) {
    if (overRect(rectx, recty, rectw, recth)) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }

  // when mouse cursor is over the button, this return true.
  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX < x+width &&
        mouseY >= y && mouseY < y+height) {
      return true;
    } else {
      return false;
    }
  }

  void display(int textSize) {
    update(mouseX, mouseY);
    fill(200);
    rect(rectx, recty, rectw, recth);
    fill(0);
    textSize(textSize);
    text(text, rectx+rectw/3, recty+recth* 2/3, 0);

    
  }
}
