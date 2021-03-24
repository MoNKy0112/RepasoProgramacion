void setup(){

  size(700,700);
  
}

float grad=180,rad = 15;
int sizes=5;


void draw(){
  background(255);
  fill(0,0,180);
  text("lados ="+sizes,15,20);
  text("radio ="+rad,15,40);
  translate(mouseX,mouseY);
  rotate(grad);
  fill(180,0,0);
  polygon(sizes,rad);
  
  
  
  if(keyPressed){
    if(key == 'q' || key=='Q'){
      grad -= 0.1;
    }
    else if(key == 'e' || key=='E'){
      grad += 0.1;
    }  
    if(key=='+'){
      rad += 0.1;
    }else if(key=='-'){
      rad -= 0.1;
    }
  }
  
  
}

void mousePressed(){
  if(sizes > 3){
    if(mouseButton == RIGHT){
      sizes -= 1;
    }
  }
    if(mouseButton == LEFT){
      sizes += 1;
    }
}



void polygon(int sideCount, float rad){
  float t =0.0 ,x,y;
  
  beginShape();
  
  for(int i=0;i<sideCount;i++){
    x = cos(t) * rad;
    y = sin(t) * rad;
    vertex(x,y);
    t += TWO_PI/sideCount;
  }
  
  endShape(CLOSE);
}
