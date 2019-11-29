/*
 * This tab is for Range class
 * Range class is for to make sections of buttons.
 * for example, finger 1, 5 buttons at right side only operates for finger1 due to range instance.
 */


class Range {
  // set int variables for range height and width 
  int rangeW, rangeH;
  // set int variables for range x and y 
  int rangeX, rangeY;
  // boolean variable. When mouse is in range, it is set true.
  boolean onRange;


  Range(int rangeX, int rangeY, int rangeW, int rangeH) {
    this.rangeX = rangeX;
    this.rangeY = rangeY;
    this.rangeW = rangeW;
    this.rangeH = rangeH;
    onRange = false;
  }


  void update(int x, int y) {
    if (overRange(rangeX, rangeY, rangeW, rangeH)) {
      onRange = true;
    } else {
      onRange = false;
    }
  }

  boolean overRange(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
  void display(){
    update(mouseX, mouseY);
    fill(255, 0);
    rect(rangeX, rangeY, rangeW, rangeH);    
  }
}
