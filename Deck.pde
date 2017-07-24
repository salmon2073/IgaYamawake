class Deck {
  ArrayList<Card> m_cards;

  Deck(ArrayList<int[]> _genes ) {
    m_cards = new ArrayList<Card>(); 
    for (int i=0; i<_genes.size (); i++) {
      m_cards.add(new Card(_genes.get(i)));
    }
  }

  float[] showValues() {
    float[] values = new float[m_cards.size()];
    for (int i=0; i<values.length; i++) {
      values[i] = (float)m_cards.get(i).showValue();
    }
    return values;
  }

  void display() {
    for (int i=0; i < m_cards.size (); i++) {
      m_cards.get(i).display();
    }
  }

  void select() {
    for (int i=m_cards.size () -1; i>=0; i--) {
      Card card = m_cards.get(i);
      if (card.hovered()) {
        card.select();
        break;
      } else { 
        card.unselect();
      }
    }
  }

  void move() {
    for (int i=0; i<m_cards.size (); i++) {
      if (m_cards.get(i).isSelected()) m_cards.get(i).move();
    }
  }

  void unselect() {
    for (int i=0; i<m_cards.size (); i++) {
      m_cards.get(i).unselect();
    }
  }
}

