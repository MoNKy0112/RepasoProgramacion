class Rect extends Shape {
  float arisBs, arisHg;

  Rect() {
    setAris(100);
    setArisBs(100);
  }

  Rect(float arisHg, float arisBs) {
      setAris(arisHg);
      setArisBs(arisBs);
  }

  @Override
    void aspect() {
    //println(contains(mouseX,mouseY));
    rect(0, 0, this.arisBs, this.arisHg);
  }

  /*boolean contains(int x, int y) {
    if (pos[0]<=x && x<=pos[0]+arisHg && pos[1]<=y && y<=pos[1]+arisBs) {
      return true;
    } else { 
      return false;
    }
  }*/

  void setAris(float x) {
    this.arisHg=x;
  }

  float getAris() {
    return arisHg;
  }

  void setArisBs(float x) {
    this.arisBs=x;
  }

  float getArisBs() {
    return arisBs;
  }
}
