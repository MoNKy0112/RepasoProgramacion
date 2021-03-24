
int[] proxpixels = new int[width*height];
boolean ini =true;

void setup() {
  size(100, 100);
  background(0);
}

void draw() {
  //noLoop();
  println("-----");
  loadPixels();
  if (ini ==true) {
    pixels[80+(width*8)] = color(255);
    pixels[80+(width*8)-1] = color(255);
    pixels[80+(width*9)] = color(255);
    pixels[80+(width*9)+1] = color(255);
    pixels[80+(width*10)] = color(255);
    ini=false;
  }

  for (int i=0; i<width*height; i++) {
    if (pixels[i]==color(255)) {
      println(i);
    }
  }


  pixelExtend();
  for (int i=0; i<width*height; i++) {
    if (proxpixels[i]==color(255)) {
      println(i);
    }
    pixels[i] = proxpixels[i];
  }
  updatePixels();
}

void pixelExtend() {
  //println(height,width);
  for (int i=width+1; i < width*(height-1); i++) {
    if ((i+1) % width != 0 && i % width != 0) {
      if (pixels[i] == color(0)) {
        if (neighbourcell(i) == 3) { 
          //println("is now alive");
          proxpixels[i] = color(255);
        } else {
          proxpixels[i] = color(0);
        }
      }
      if (pixels[i] == color(255)) {
        if (neighbourcell(i) == 2 ||neighbourcell(i) == 3) {
          //println("is now alive");
          proxpixels[i] = color(255);
        } else {
          proxpixels[i] = color(0);
        }
      }
    }
  }
}

int neighbourcell(int i) {
  int nb=0;
  if (color(255) == pixels[i+1]) {//derecha → 
    //println("d");
    nb += 1;
  }
  if (color(255) == pixels[i-1]) {//izquierda ←
    //println("i");
    nb += 1;
  }
  if (color(255) == pixels[i+width]) {//abajo ↓
    //println("a");
    nb += 1;
  }
  if (color(255) == pixels[i-width]) {//arriba ↑
    //println("u");
    nb += 1;
  }
  if (color(255) == pixels[i-width+1]) {//derecha-arriba →↑
    //println("du");
    nb += 1;
  }
  if (color(255) == pixels[i-width-1]) {//izquierda-arriba ←↑
    //println("iu");        
    nb += 1;
  }
  if (color(255) == pixels[i+width+1]) {//derecha-abajo →↓
    //println("da");
    nb += 1;
  }
  if (color(255) == pixels[i+width-1]) {//izquierda-abajo ←↓
    //println("ia");
    nb += 1;
  }
  //println(nb);
  return nb;
}
