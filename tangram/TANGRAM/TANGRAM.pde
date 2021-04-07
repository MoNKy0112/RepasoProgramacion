
void setup(){
  size(800,800);
  /*COLORES*/
  
  
  /*FIGURAS*/
  tri(0,color(0,0,180),100,200);
  tri(1,color(0,180,0),100,200);
  tri(2,color(180,0,0),100,100);
  tri(3,color(180,180,0),50,100);
  tri(4,color(180,0,180),50,100);
  sqre(5,color(0,180,180),70,70);
  paral(6,color(200,0,100),50,100,50);
  
  //FIGURA DE PRUEBA
  //fig[7] = createShape(TRIANGLE,mouseX,mouseY,100,100,0,100);
  
  //frameRate(1);
  
  for(int i=0;i<fig.length;i++){
    fig[i].setStroke(color(0,0,250)); 
  }
}

PShape [] fig = new PShape[7];
PShape [] miniFig = new PShape[7];
//PShape s;
color [] col = new color[7];
int [][] pos = new int[7][2];
float grad=0;
boolean fig_sel = true;
int selected = 0;


void draw(){
  
  background(255);
 
  //ATAJO VISUAL EN DESARROLLO
  /*for(int i=0;i<fig.length;i++){
    
    if(selected == i){
      fig[selected].setFill(color(100));
    }else{
      fig[i].setFill(color(15));
    }
    shape(miniFig[i],10+(i*10),400);
  }
  miniFig[1].scale(0.99);*/
  
  //FIGURA DE PRUEBA
  //shape(s,pos[7][0],pos[7][1]);
  
  //FIGURAS EN PANTALLA
  for(int i=0;i<fig.length;i++){
    if(fig_sel==true){
      if(selected == i){
        fig[selected].setFill(color(100));
      }else{
        fig[i].setFill(color(col[i]));
      }
    }else{
      fig[i].setFill(color(col[i]));
    }
    
    shape(fig[i],pos[i][0],pos[i][1]);    
  }
  
}

void keyPressed(){
  if(fig_sel == true){
    if(key == 'q' || key=='Q'){
      fig[selected].rotate(-PI/4);
      return;
      //rotar(fig [selected],PI/4);
    }
    else if(key == 'e' || key=='E'){
      fig[selected].rotate(PI/4);
      return;
      //rotar(fig [selected],-PI/4);
    }
  }
  
    switch(key){
     case '1': 
       fig_sel = true;
       selected = 0;
       break;
     case '2':  
       fig_sel = true;
       selected = 1;
       break;
     case '3':  
       fig_sel = true;
       selected = 2;
       break;
     case '4':  
       fig_sel = true;
       selected = 3;
       break;
     case '5':  
       fig_sel = true;
       selected = 4;
       break;
     case '6': 
       fig_sel = true;
       selected = 5;
       break;
     case '7':  
       fig_sel = true;
       selected = 6;
       break;         
     default:        
       fig_sel = false;
       return;
    }
  
    
   
}

void mousePressed(){
  if(fig_sel==true){
    if(mouseButton==RIGHT){
    //fig[selected].rotate((mouseX-pmouseX)*0.01+(mouseY-pmouseY)*0.01);
    fig[selected].rotate(PI/4);  
  }
  }
}

void mouseDragged(){
  
  if(fig_sel==true){
    if(mouseButton==LEFT){
      pos[selected][0]+=mouseX-pmouseX;
      pos[selected][1]+=mouseY-pmouseY;
    }
  }
  
  if(mouseButton==CENTER){
    for(int i=0;i<fig.length;i++){
      pos[i][0]+=mouseX-pmouseX;
      pos[i][1]+=mouseY-pmouseY;
    }
  }
}

void tri(int n_fig,color clr,int h,int base){
  
  col [n_fig] = clr;
  fig [n_fig] = createShape(TRIANGLE,0,0,h,h,0,base);
  
}

void sqre(int n_fig,color clr,int alto,int ancho){

  col [n_fig] = clr;
  fig [n_fig] = createShape(QUAD,0,0,ancho,0,ancho,alto,0,alto);
  
  
}

void paral(int n_fig,color clr,int alto,int ancho,int dif){

  col [n_fig] = clr;
  fig [n_fig] = createShape(QUAD,dif,0,dif+ancho,0,ancho,alto,0,alto);
  
}
