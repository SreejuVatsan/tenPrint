class FontAgent {
  PVector loc;

  FontAgent(PVector l) {
    loc = l.get();
  }

  void display() {
    strokeWeight(random(0.1, 1.5));
    float len = random(0, 5);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(random(0, TWO_PI));
    line(-len, -len, len, len);
    popMatrix();
  }
} 

