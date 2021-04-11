int cellsize = 10,fr=5;
boolean [][] cells, proxGenCells;
boolean pause=false;

void setup(){
  size(800,800);

  cells = new boolean [width/cellsize] [height/cellsize];
  proxGenCells = new boolean [width/cellsize] [height/cellsize];
  
  //patron inicial basico
  cells[10][10] = true;
  cells[11][10] = true;
  cells[11][11] = true;
  cells[12][11] = true;
  cells[11][12] = true;
  //celulas vivas aleatorias
  aleatoryCells(100,cells.length/2,cells.length,cells.length/2,cells[1].length);
  //patrones preconfigurados
  //Boat
  cells[3][3] = true;
  cells[4][3] = true;
  cells[3][4] = true;
  cells[5][4] = true;
  cells[4][5] = true;
  //Beacon
  cells[20][20] = true;
  cells[21][20] = true;
  cells[20][21] = true;
  cells[23][22] = true;
  cells[22][23] = true;
  cells[23][23] = true;
  //Glider
  cells[30][20] = true;
  cells[31][21] = true;
  cells[29][22] = true;
  cells[30][22] = true;
  cells[31][22] = true;
  //light-weight spaceship
  cells[10][45] = true;
  cells[13][45] = true;
  cells[14][46] = true;
  cells[10][47] = true;
  cells[14][47] = true;
  cells[11][48] = true;
  cells[12][48] = true;
  cells[13][48] = true;
  cells[14][48] = true;
  //comandos para iniciar el juego en pausa
  if(pause == true){
    for(int i=0;i<proxGenCells.length;i++){
      for(int j=0;j<proxGenCells[i].length;j++){
        proxGenCells[i][j] = cells[i][j];
      }
    }
  }
}

void draw(){
  frameRate(fr);
  background(0);

  for(int i=0;i<width/cellsize;i++){
    for(int j=0;j<height/cellsize;j++){ 
      if(cells[i][j]==true){
        strokeWeight(1);
        fill(255);
        square(i*cellsize,j*cellsize,cellsize);
      }
    }
  }
  
    if(pause==false){
      //Funcion extend, explicada en la linea
      extend();
    }
    
  //Cambio de generacion, las celulas de futura generacion pasan a ser de actual generacion
  //Se cambia celula por celula
  for(int i=0;i<cells.length;i++){
    for(int j=0;j<cells[i].length;j++){
      cells[i][j] = proxGenCells[i][j];
    }
  }
  
  //Muestra en pantalla frames y control para pausar y despausar
  textSize(12);
  textAlign(LEFT);
  fill(255);
  text("|| fps: "+fr+" + or - buttons to change ||",10,10);
  text("|| pause = P, ENTER or Click ||",250,10);
  if(pause == true){
    textSize(25);
    textAlign(CENTER);
    fill(250,0,0);
    text("PAUSED",width/2,height/2);
    textSize(18);
    text("Continue with ENTER or P",width/2,height/2+20);
  }
}

void keyPressed(){
  //Cambio de frames por segundo
  //AUMENTO EN 1
  if(key=='+'){
    fr+=1;
  }
  //DISMINUCION EN 1
  if(fr>1){
    if(key=='-'){
      fr-=1;
    }
  }
  //PAUSA DE JUEGO
  //Teclas: P o ENTER
  if(key == 'p' || key == 'P' || key == ENTER){
    if(pause == true){
      pause = false;
    }else{
      pause = true;
    }  
  }
}

void mousePressed(){
  //Con click izquerdo se crea manualmente celulas con vida
  if(mouseButton==LEFT){
    pause=true;
    proxGenCells[(mouseX-(mouseX%cellsize))/cellsize][(mouseY-(mouseY%cellsize))/cellsize]=true;
  }
  //Con click izquerdo se elimina manualmente celulas con vida
  if(mouseButton==RIGHT){
    pause=true;
    proxGenCells[(mouseX-(mouseX%cellsize))/cellsize][(mouseY-(mouseY%cellsize))/cellsize]=false;
  }  
}

//Funcion para determinar que celulas estaran vivas y cuales muertas
//en la siguiente generacion.
void extend(){
  for(int i=1;i<cells.length-1; i++){
    for(int j=1;j<cells[i].length-1;j++){
      if(cells[i][j] == false){
        if(neighbourcell(i,j) == 3){
          proxGenCells[i][j] = true;
        }else{
          proxGenCells[i][j] = false;
        }
      }
      if(cells[i][j] == true){
        if(neighbourcell(i,j) == 3 || neighbourcell(i,j) == 2){
          proxGenCells[i][j] = true;
        }else{
          proxGenCells[i][j] = false;
        }
      }
    }
  } 
}

//Funcion para saber la cantidad de celulas vivas vecinas
int neighbourcell(int x,int y){
  int numNeig = 0;
  if(cells[x+1][y] == true){//derecha → 
    numNeig += 1;
  }
  if(cells[x-1][y] == true){//izquierda ←
    numNeig += 1;
  }
  if(cells[x][y+1] == true){//abajo ↓
    numNeig += 1;
  }
  if(cells[x][y-1] == true){//arriba ↑
    numNeig += 1;
  }
  if(cells[x+1][y-1] == true){//derecha-arriba →↑
    numNeig += 1;
  }
  if(cells[x-1][y-1] == true){//izquierda-arriba ←↑
    numNeig += 1;
  }
  if(cells[x+1][y+1] == true){//derecha-abajo →↓
    numNeig += 1;
  }
  if(cells[x-1][y+1] == true){//izquierda-abajo ←↓
    numNeig += 1;
  } 
  return numNeig;
}

void aleatoryCells(int numCells,int minX,int maxX,int minY,int maxY){
  for(int i=0;i<numCells;i++){    
    cells[int(random(minX+1,maxX-1))][int(random(minY+1,maxY-1))] = true;
  }
}
