abstract class Shape {
  color col, strokeCol;
  float angle, scale;
  float[] pos = new float[2];
  boolean selected = false;

  Shape() {
    //this(random(width), random(height),
    //random(PI), random(1.5),
    //color(random(5, 255), random(5, 255), random(5, 255)));
    setPos(random(100, width-100), random(100, height-100));
    setAngle(0);
    setScale(1);
    setColor(color(random(5, 255), random(5, 255), random(5, 255)));
    setStrokeColor(color(random(5, 255), random(5, 255), random(5, 255)));
  }

  Shape(float x, float y, float ang, float sc, color col, color strCol) {
    setPos(x, y);
    setAngle(ang);
    setScale(sc);
    setColor(col);
    setColor(strCol);
  }

  void drawFig() {
    push();
    //if (selected) data(); 
    if (selected) fill(100); 
    else fill(this.col);
    stroke(this.strokeCol);
    translate(this.pos[0], this.pos[1]);
    rotate(this.angle);
    scale(this.scale, this.scale);
    aspect();
    pop();
  }

  abstract void aspect();

  /*void modif() {
    if ((key=='q'||key=='Q') && selected) {  
      this.angle-=PI/4;
    }
    if ((key=='e'||key=='E') && selected) {
      this.angle+=PI/4;
    }
    if (keyCode==UP && selected) {
      this.pos[1]-=5;
    }
    if (keyCode==DOWN && selected) {
      this.pos[1]+=5;
    }
    if (keyCode==RIGHT && selected) {
      this.pos[0]+=5;
    }
    if (keyCode==LEFT && selected) {
      this.pos[0]-=5;
    }
    if (key=='+') {
      this.scale+=0.1;
    }
    if (key=='-') {
      this.scale-=0.1;
    }
  }*/
  //FUNCION seleccion de objeto "CONTAINS"(coordenada X, coordenada Y)
  void selec(int X, int Y) {
    if (color(pixels[Y*width+X])==color(col)) {
      selected = true;
    } else {
      selected = false;
    }
  }
  //FUNCION movimiento (movimiento en X, movimiento en Y)
  void move(int X, int Y) {
    this.pos[0]+=X;
    this.pos[1]+=Y;
  }
  //Funcion giro de objeto(letra presionada,radio )
  void rotat(char k, float rad) {
    if (k=='q'||k=='Q') {  
      this.angle-=rad;
    }
    if (k=='e'||k=='E') {
      this.angle+=rad;
    }
  }
  //FUNCION escalar figuras (letra presionada,tamaño de escala)
  void scal(char k, float size) {
    if (k=='+') {
      this.scale+=size;
    }
    if (k=='-') {
      this.scale-=size;
    }
  }
  //FUNCION reajuste de posición(tamaño de ajuste)
  void adjust(int adj) {
    pos[0]=pos[0]-(pos[0]%adj);
    pos[1]=pos[1]-(pos[1]%adj);
  }

  /*void data(){
   fill(0);
   text(this.scale,10,10);
   }*/

  //setters
  void setPos(float x, float y) {
    this.pos[0] = x;
    this.pos[1] = y;
  }
  void setAngle(float a) {
    this.angle = a;
  }
  void setScale(float s) {
    this.scale = s;
  }
  void setColor(color c) {
    this.col = c;
  }
  void setStrokeColor(color c) {
    this.strokeCol = c;
  }
  void setSelected(boolean sel) {
    this.selected = sel;
  }
  //getters
  float[] getPos() {
    return this.pos;
  }
  float getAngle() {
    return this.angle;
  }
  float getScale() {
    return this.scale;
  }
  color getColor() {
    return this.col;
  }
  color getStrokeColor() {
    return this.strokeCol;
  }
  boolean getSelected() {
    return this.selected;
  }
}
