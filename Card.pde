class Card {
  float m_width = CARD_WIDTH, m_height = CARD_HEIGHT;
  int x, y, lastX, lastY, value;
  boolean selected;
  int[] gene;

  Card(int[] _gene) {
    x = (int)random(x, width-m_width);
    y = (int)random(y, height-m_height-MARGIN_BOTTOM);
    value = (int)map(width - (x+m_width/2), 0, width, 0, 100);
    gene = _gene;
  }

  int showValue() {
    return value;
  }

  void display() {
    rectMode(CORNER);
    stroke(0);
    strokeWeight(1);
    fill(255, 100);
    rect(x, y, m_width, m_height);
    int myG = 0;
    float faceWidth=0, faceHeight=0, w_eyeSize=0, b_eyeSize=0;

    for (int i=0; i<gene.length/5; i++) {
      myG += gene[i] * pow(2, i);
      faceWidth += gene[gene.length/5 + i] * pow(2, i);
      faceHeight += gene[gene.length/5*2 + i] * pow(2, i);
      w_eyeSize += gene[gene.length/5*3 + i] * pow(2, i);
      b_eyeSize += gene[gene.length/5*4 + i] * pow(2, i);
    }

    faceWidth = m_width/7*4 + map(faceWidth, 0, 255, 0, m_width/7*3);
    faceHeight = m_height/7*4 + map(faceHeight, 0, 255, 0, m_height/7*3);
    w_eyeSize = 10 + map(w_eyeSize, 0, 255, 0, 30);
    b_eyeSize = w_eyeSize * ( 0.3 + map(b_eyeSize, 0, 255, 0, 0.7));

    fill(0, 130 + map(myG, 0, 255, 0, 125), 0);
    ellipse(x + m_width/2, y + m_height/2, faceWidth, faceHeight);

    fill(255);
    ellipse(x + m_width/2 - faceWidth/4, y + m_height/2 - faceHeight/4, w_eyeSize, w_eyeSize);
    ellipse(x + m_width/2 + faceWidth/4, y + m_height/2 - faceHeight/4, w_eyeSize, w_eyeSize);

    fill(0);
    ellipse(x + m_width/2 - faceWidth/4, y + m_height/2 - faceHeight/4, b_eyeSize, b_eyeSize);
    ellipse(x + m_width/2 + faceWidth/4, y + m_height/2 - faceHeight/4, b_eyeSize, b_eyeSize);

    //fill(0);
    //textSize(20);
    //text(value, x+m_width/2-20, y+m_height*2/3);
    //textSize(10);
    //text(geneToString(gene), x+m_width/2-20, y+m_height*2/3+25);
  }

  boolean hovered() {
    if (mouseX > x && mouseX < x + m_width && mouseY > y && mouseY < y + m_height ) return true;
    else return false;
  }

  void select() {
    setLastPos();
    selected = true;
    println(geneToString(gene));
  }

  void unselect() {
    selected = false;
  }

  boolean isSelected() {
    return selected;
  }

  void setLastPos() {
    lastX = mouseX;
    lastY = mouseY;
  }

  void move() {
    x += mouseX - lastX;
    y += mouseY - lastY;
    setLastPos();
    value = (int)map(width - (x+m_width/2), 0, width, 0, 100);
  }
}

