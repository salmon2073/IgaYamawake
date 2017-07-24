final int NUM = 10;
final int NODE = 5;
final int GENE_SIZE = 40;
final float CARD_WIDTH = 100;
final float CARD_HEIGHT = 100;
final float MARGIN_BOTTOM = 100;

PImage right, left;

Deck deck;
Iga iga;
NextButton nextButton;

void setup() {
  size(1200, 350);
  right = loadImage("batsu.png");
  left = loadImage("maru.png");
  iga = new Iga(GENE_SIZE, NODE, NUM);
  deck = new Deck(iga.getGenes());
  nextButton = new NextButton(width/2, height - 50, 150, 50);
}

void draw() {
  background(200);
  displayLine();
  deck.display();
  nextButton.display();
  displayVector();
}

void mousePressed() {
  if (nextButton.isClicked()) evolution();
  else deck.select();
}

void mouseDragged() {
  deck.move();
}

void mouseReleased() {
  deck.unselect();
}

void keyPressed() {
  if (key == ' ') iga.output();
}

