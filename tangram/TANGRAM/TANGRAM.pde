Shape[] shapes;
Shape[] levels;
boolean drawProbl = true, saveProblem = false, autoAdjust=true;
//screenState consta de: Menu(0),Jugar(1),Crear(2),Salir(3),seleccionarNivel(4)
int screenState=0, varScSt=0;
//nivel actual
int level=0, varLevel=0;
//imagen problema
PImage problem;
//menu juego=0,editor=1,libre=2,salir=3
//int fr=0;

//----CONTROLES-----//
/*
MENU PRINCIPAL: FLECHAS ARRIBA y ABAJO(MOVER), ENTER(SELECCIONAR MODO) 
MENU NIVELES: FLECHAS IZQ. y DER.(MOVER) , BARRA ESP.(SELECCIONAR NIVEL)
JUEGO:CLICK (SELECCIONAR FIGURA), ARRASTRAR MOUSE ó FLECHAS (MOVER),"Q" y "E" (GIRAR)
"+" y "-" (CAMBIAR ESCALA DE FIGURAS), "A" (AJUSTE MANUAL), SHIFT (ACTIVA-DESACTIVA AJUSTE AUTOMATICO)
"T" (MOSTRAR-ESCONDER PROBLEMA), "G" (GUARDAR PROBLEMA) solo en modo crear
BACKSPACE (VOLVER AL MENU PRINCIPAL)
*/

void setup() {

  size(800, 800);
  //------Colores de figuras-----//
  color[] shapesColors= new color[7];
  //-----------Niveles-----------//
  levels= new Shape[10];
  for (int i=0; i<levels.length; i++) {
    levels[i]=new Term(str(i+1), 1, 1);
  }
  //-----------Figuras----------//
  shapes = new Shape[7];
  shapes[0] = new Triangle(0, 0, 100, 100, 200, 0);
  shapes[1] = new Triangle(0, 0, 100, 100, 200, 0);
  shapes[2] = new Triangle(0, 0, 100, 100, 0, 100);
  shapes[3] = new Triangle(0, 0, 50, 50, 0, 100);
  shapes[4] = new Triangle(0, 0, 50, 50, 0, 100);
  shapes[5] = new Rect(70, 70);
  shapes[6] = new Quad(0, 0, 100, 0, 50, -50, -50, -50);
  //Escala de las figuras segun tamaño de ventana
  for (Shape fig : shapes) {
    fig.setScale(float(width)/float(800), float(height)/float(800));
  }
  //Colores de figuras aleatorios siempre distintos
  for (int i=0; i<shapes.length; i++) {
    color varCol=color(random(5, 255), random(5, 255), random(5, 255));
    for (int j=0; j<i; j++) {
      if (varCol==shapesColors[j]) {
        varCol=color(random(5, 255), random(5, 255), random(5, 255));
        j=-1;
      }
    }
    shapes[i].setColor(varCol);
    shapesColors[i]=varCol;
  }
}

void draw() {
  background(255); 
  fill(0);
  //text(varScSt+1, 50, 50);
  //carga el nivel en imagen
  if (level!=0 && !saveProblem) {
    try {
      problem = loadImage("level_"+str(level)+".jpg");
      problem.resize(width, height);
    }
    catch(Exception e) {
      println("El nivel "+level+" no existe");
      level=varLevel=0;
      problem = null;
    }
    if (problem==null)screenState=0;
    ;
  }
  switch(screenState) {
  case 0: //MENU
    {
      menu();
      break;
    }
  case 1: //JUGAR
    {
      if (level==0) {
        screenState=4;
        break;
      }
      //image(problem,0,0);
      if (drawProbl) {
        //muestra el nivel-problema
        image(problem, 0, 0);
      }
      //dibuja las figuras
      for (Shape fig : shapes) {
        fig.drawFig();
      }
      //condicional para cuando el usuario ya gano
      if (win() && drawProbl==true) {
        //vuelve al menu
        println("complete");
        screenState=varScSt=0;
        drawProbl=false;
        //cambia de posicion las figuras aleatoriamente de nuevo
        for (Shape fig : shapes) {
          fig.setPosition(random(100, width-100), random(100, height-100));
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
      //salir del juego
      exit();
      break;
    }
  case 4:
    {
      // distribuye segun el tamaño 

      levelSelector(levels);

      if (level != 0) {
        if (saveProblem)saveProb();
        else {
          screenState=1;
        }
      }

      break;
    }
  default:
    println("Error");
    break;
  }
}

void mouseClicked() {
  //seleccion de figura
  for (Shape fig : shapes)
    fig.selec(mouseX, mouseY);
}

void mouseDragged() {
  //movimiento por mouse
  for (Shape fig : shapes)
    if (mouseButton==LEFT && fig.getSelected())
      fig.move(mouseX-pmouseX, mouseY-pmouseY);
}

void mouseReleased() {
  //ajuste de posicion automtico
  if (autoAdjust) {
    for (Shape fig : shapes)
      fig.adjust(5);
  }
}

void keyPressed() {
  //ajuste de posicion manual
  if (key=='a' || key=='A') {
    for (Shape fig : shapes)
      fig.adjust(5);
  }
  //habilita-deshabilita el ajustte automatico
  if (keyCode==SHIFT)autoAdjust = autoAdjust ? false:true;

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
      level=varLevel=0;
      saveProblem=false;
    }
  }
  //menu de niveles
  if (screenState==4) {
    if (keyCode == RIGHT) varLevel++;
    else if (keyCode == LEFT) varLevel--;

    if (varLevel>levels.length-1)varLevel=0;
    if (varLevel<0)varLevel=levels.length-1;

    if (keyCode==32) {
      level=varLevel+1;
    }
  }
  //movimientos por flechas
  if (screenState!=0) {
    for (Shape fig : shapes) {
      fig.scal(key, 0.1);
      if (fig.getSelected()) {
        //fig.modif();
        fig.rotat(key, PI/4);
        switch(keyCode) {
        case LEFT:
          fig.move(-5, 0);
          break;
        case RIGHT:
          fig.move(5, 0);
          break;
        case DOWN:
          fig.move(0, 5);
          break;
        case UP:
          fig.move(0, -5);
          break;
        }
      }
    }
  }
  //guardar problema (solo en modo crear)
  if ((key=='g' || key=='G') && screenState==2) {
    screenState=4;
    saveProblem=true;
  }
  //dibujar problema (solo en modo jugar)
  if ((key=='t' || key=='T') && screenState==1) {
    drawProbl = drawProbl ? false: true;
  }
}
//FUNCION guardar problema----------------warning
void saveProb() {
  background(255);

  for (Shape fig : shapes) {
    fig.drawFig();
  }
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    if (pixels[i]!=color(255))pixels[i]=color(0);
  }
  updatePixels();
  save("level_"+str(level)+".jpg");
  println("guardado");
  //cambia de posicion las figuras aleatoriamente de nuevo
  for (Shape fig : shapes) {
    fig.setPosition(random(100, width-100), random(100, height-100));
  }
  //vuelve al menu
  screenState=varScSt=level=0;
  saveProblem=false;
}
//FUNCION evaluacion de solucion
boolean win() {
  int a=0;
  loadPixels();
  for (int i=0; i<width*height; i++) {
    if (pixels[i] == color(0)) a += 1;
  }
  if (a>200)return false;
  else {
    //println("completado");
    return true;
  }
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

void levelSelector(Shape[] levels) {
  //distribucion de niveles en filas y columnas segun dimensiones de pantalla
  int filas=((height-100)/100);
  int columnas=((width-100)/100);

  //ajuste de posiciopn y color de nivelesen su respectivo menu
  for (int i=0; i<levels.length; i++) {
    if (varLevel==i) {
      levels[i].setColor(color(200, 0, 0));
    } else {
      levels[i].setColor(color(0, 0, 200));
    }
    levels[i].setPosition(width-(100*columnas*((i/columnas)+1))+(100*i), height-(100*filas)+(100*(i/columnas)));
  }

  //despliegue de numero de niveles
  for (Shape level : levels) {
    level.drawFig();
  }
}
