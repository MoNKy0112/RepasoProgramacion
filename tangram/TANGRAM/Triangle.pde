class Triangle extends Shape {
  float[] VertX, VertY;

  Triangle() {
    setVertX(0, 0, 100);
    setVertY(0, 100, 100);
  }

  Triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    setVertX(x1, x2, x3);
    setVertY(y1, y2, y3);
  }

  @Override
    void aspect() {
    //if(selected)fill(100);
    //println(overTri(x[0]+pos[0],x[1]+pos[0],x[2]+pos[0],
    //y[0]+pos[1],y[1]+pos[1],y[2]+pos[1]));
    triangle(VertX[0], VertY[0], VertX[1], VertY[1], VertX[2], VertY[2]);
  }

  /*void sel() {
   float x2=((vertX[1])*cos(this.angle))-((vertY[1])*sin(this.angle));
   float x3=((vertX[2])*cos(this.angle))-((vertY[2])*sin(this.angle));
   float y2=(vertX[1])*sin(this.angle)+(vertY[1])*cos(this.angle);
   float y3=(vertX[2])*sin(this.angle)+(vertY[2])*cos(this.angle);
   
   //vertX[1]=x2;vertX[2]=x3;vertY[1]=y2;vertY[1]=y3;
   
   //fill(100);
   println("###", vertX[0]+pos[0], x2+pos[0], x3+pos[0], vertY[0]+pos[1], y2+pos[1], y3+pos[1]);
   //triangle(vertX[0]+pos[0],vertY[0]+pos[1],x2+pos[0],y2+pos[1],x3+pos[0],y3+pos[1]);
   
   if (overTri(vertX[0]+pos[0], x2+pos[0], 
   x3+pos[0], vertY[0]+pos[1], 
   y2+pos[1], y3+pos[1])) {
   selected = true;
   col = color(200, 0, 0);
   } else {
   selected=false;
   col = color(0, 0, 100);
   }
   }*/

  boolean overTri(float x1, float x2, float x3, float y1, float y2, float y3) {
    float A, A1, A2, A3, At;
    A = abs(x1*y2*1+y1*1*x3+1*x2*y3-y1*x2*1-x1*1*y3-1*y2*x3)/2;
    A1 = abs(x1*y2*1+y1*1*mouseX+1*x2*mouseY-y1*x2*1-x1*1*mouseY-1*y2*mouseX)/2;
    A2 = abs(x1*mouseY*1+y1*1*x3+1*mouseX*y3-y1*mouseX*1-x1*1*y3-1*mouseY*x3)/2;
    A3 = abs(mouseX*y2*1+mouseY*1*x3+1*x2*y3-mouseY*x2*1-mouseX*1*y3-1*y2*x3)/2;
    At = A1+A2+A3;

    if (At!=A) return false;
    else return true;
  }

  void setVertX(float x1, float x2, float x3) {
    float[] var = {x1, x2, x3};
    this.VertX = var;
  }

  float[] getVertX() {
    return this.VertX;
  }

  void setVertY(float y1, float y2, float y3) {
    float[] var = {y1, y2, y3};
    this.VertY = var;
  }

  float[] getVertY() {
    return this.VertY;
  }
}
