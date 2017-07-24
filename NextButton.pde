class NextButton {
  float x, y;
  float w, h;
  boolean flag;

  NextButton(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }

  void display() {
    rectMode(CENTER);
    if (isClicked()) {
      if (flag) {
        fill(200);
      } else {
        fill(255);
      }
      flag = false;
    } else {
      flag=true;
      fill(255);
    }
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    textSize(15);
    fill(0);
    text("EVOLUTION", x, y);
  }

  boolean isClicked() {
    if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) return true;
    else return false;
  }
}

