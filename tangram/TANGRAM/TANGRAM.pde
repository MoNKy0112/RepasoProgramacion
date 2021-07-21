Shape[] shapes;
boolean drawProbl = false;
int screenState=0, varScSt=0;


//menu juego=0,editor=1,libre=2,salir=3
//int fr=0;

void setup() {
  size(800, 800);
  shapes = new Shape[7];
  /*for (int i=0; i<figuras.length-1; i++) {
   figuras[i] = i < 4 ? new  CUADRADO() : new TRIANGULO();
   }*/
  shapes[0] = new Triangle(0, 0, 100, 100, 200, 0);
  shapes[1] = new Triangle(0, 0, 100, 100, 200, 0);
  shapes[2] = new Triangle(0, 0, 100, 100, 0, 100);
  shapes[3] = new Triangle(0, 0, 50, 50, 0, 100);
  shapes[4] = new Triangle(0, 0, 50, 50, 0, 100);
  shapes[5] = new Rect(70, 70);
  shapes[6] = new Quad(0, 0, 100, 0, 150, -50, 50, -50);
  /*for(int i=0;i<figuras.length;i++){
   figuras[i].setColor(color(0));
   }*/
}

void draw() {
  background(255); 
  fill(0);
  text(varScSt+1, 50, 50);
  switch(screenState) {
  case 0: //MENU
    {
      menu();
      break;
    }
  case 1: //JUGAR
    {
      if (drawProbl) printProb();
      //dibuja las figuras
      for (Shape fig : shapes) {
        fig.drawFig();
      }
      //condicional para cuando el usuario ya gano
      if (win() && drawProbl==true) {
        //vuelve al menu
        screenState=varScSt=0;
        drawProbl=false;
        //cambia de posicion las figuras aleatoriamente de nuevo
        for (Shape fig : shapes) {
          fig.setPos(random(100, width-100), random(100, height-100));
        }
      }
      break;
    }
  case 2: //CREAR
    {
      //dibuja las figuras
      for (Shape fig : shapes) {
        fig.drawFig();
      }
      break;
    }
  case 3:
    {
      exit();  
      break;
    }
  default:
    println("Error");
    break;
  }
}

void mouseClicked() {
  //seleccion de figura
  loadPixels();
  for (Shape fig : shapes)
    fig.selec(mouseX, mouseY);
}

void mouseDragged() {
  //movimiento por mouse
  for (Shape fig : shapes)
    if(mouseButton==LEFT && fig.getSelected())
      fig.move(mouseX-pmouseX, mouseY-pmouseY);
}

void mouseReleased() {
  //ajuste de posicion
  for (Shape fig : shapes)
    fig.adjust(5);
}

void keyPressed() {

  //movimiento de opciones del menu
  if (screenState==0) {     
    if (keyCode == DOWN) varScSt++;
    else if (keyCode == UP) varScSt--;

    if (varScSt>2)varScSt=0;
    if (varScSt<0)varScSt=2;

    if (key==ENTER) {
      screenState=varScSt+1;
    }
  } else {
    if (key == BACKSPACE) {
      screenState=varScSt=0;
    }
  }
  //movimientos por flechas
  if (screenState!=0) {
    for (Shape fig : shapes) {
      fig.scal(key,0.1);
      if (fig.getSelected()) {
        //fig.modif();
        fig.rotat(key,PI/4);
        switch(keyCode){
          case LEFT:fig.move(-5,0);break;
          case RIGHT:fig.move(5,0);break;
          case DOWN:fig.move(0,5);break;
          case UP:fig.move(0,-5);break;
        }
      }
    }
  }
  //guardar problema (solo en modo crear)
  if ((key=='g' || key=='G') && screenState==2) {
    guardarProb();
  }
  //dibujar problema (solo en modo jugar)
  if ((key=='t' || key=='T') && screenState==1) {
    drawProbl = drawProbl ? false: true;
  }
}
//FUNCION guardar problema
void guardarProb() {
  background(255);

  for (Shape fig : shapes) {
    fig.drawFig();
  }
  byte[] a ={};
  loadPixels();
  a = byte(pixels);
  saveBytes("level_1.txt", a);
  println("guardado");
  //cambia de posicion las figuras aleatoriamente de nuevo
  for (Shape fig : shapes) {
    fig.setPos(random(100, width-100), random(100, height-100));
  }
  //vuelve al menu
  screenState=varScSt=0;
}
//FUNCION dibujar problema
void printProb() {
  byte[] a = loadBytes("level_1.txt");
  loadPixels();
  for (int i=0; i<a.length; i++) {
    pixels[i] = color(a[i]);
  }
  for (int i=0; i<a.length; i++) {
    if (pixels[i] != color(255)) pixels[i] = color(0);
  }
  updatePixels();
  //println("pixeles cargados");
}
//FUNCION evaluacion de solucion
boolean win() {
  loadPixels();
  for (int i=0; i<width*height; i++) {
    if (pixels[i] == color(0)) return false;
  }
  println("completado");
  return true;
}
//FUNCION visual menu
void menu() {
  String[] menu = {"1 - JUGAR", "2 - CREAR", "3 - SALIR"};
  textAlign(CENTER);
  textSize(20);
  for (int i=0; i<menu.length; i++) {
    fill(0);
    if (varScSt==i) {
      fill(200, 0, 0);
    }
    text(menu[i], width/2, (height/2)-100+(i*100));
  }
}
