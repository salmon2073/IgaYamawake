void displayLine() {
  stroke(0);
  strokeWeight(1);
  line(0, height-MARGIN_BOTTOM, width, height-MARGIN_BOTTOM);
}

void evolution() {
  println("evolution!");
  iga.calcNextGeneration(deck.showValues());
  deck = new Deck(iga.getGenes());
}

String geneToString(int[] g) {
  String s = "" + g[0];
  for (int t=1; t<g.length; t++) {
    s += "" + g[t];
  }
  return s;
}

float sum(float[] v) {
  float n = 0;
  for (int i=0; i<v.length; i++) {
    n += v[i];
  }
  return n;
}

void displayVector() {
  image(right, width - 80, height/2-50, 50, 50);
  image(left, 30, height/2-50, 50, 50);
}
