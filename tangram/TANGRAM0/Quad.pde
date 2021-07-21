class Quad extends Shape {
  float[] vertX, vertY;

  Quad() {
    setVertX(25, 125, 100, 0);
    setVertY(0, 0, 50, 50);
  }

  Quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    setVertX(x1, x2, x3, x4);
    setVertY(y1, y2, y3, y4);
  } 
  
  @Override
  void aspect() {
    quad(vertX[0], vertY[0], vertX[1], vertY[1], vertX[2], vertY[2],vertX[3], vertY[3]);
  }

  void setVertX(float x1, float x2, float x3,float x4) {
    float[] var = {x1, x2, x3, x4};
    this.vertX = var;
  }

  float[] getVertX() {
    return this.vertX;
  }

  void setVertY(float y1, float y2, float y3,float y4) {
    float[] var = {y1, y2, y3, y4};
    this.vertY = var;
  }

  float[] getVertY() {
    return this.vertY;
  }
}
