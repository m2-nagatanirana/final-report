//角度設定
float angle0 =0.0;
float angle1 = 0.0;
float angle2 = 0.0;
float angle3 = -45.0;
float dif =0.01;
float angle = 0.0;
float angleDirection = 1;
float speed0 = 0.005;
float speed1 = 0.005;
float speed2 =0.02;

//土台の寸法
float px=70 ;
float py=30 ;
float pz=70 ;

float py2=100;
//土台の中心座標
float ox = 300;
float oz =300;
float oy =300;

float ox2 =200;
float oz2 =0;
float oy2 =0;


//アームの寸法
float b1=40 ;
float b2=150 ;
float b3=40;
float c1=30 ;
float c2=200 ;
float c3=30;
float d1=10 ;
float d2=150 ;
float d3=10;
float j=5;

float arm=5;
float arm1=25 ;
float arm2=20;
float arm3=5;

float px1=35;
float py1=30;
float pz1=24;



//アーム先端の座標（（0,0,0）を座標中心にしたとき）
float x= ox+ox2 ;
float y= oy-py/2 ;
float z= oz+oz2 ;


    

void setup() {
  //背景の色
 background(255);
   //背景の大きさ，色
  size(1000,1000,P3D); //background(255);
   //視点の位置
  camera(600, 300, 600, 0, 0, 0,0,1,0);
  noStroke();
}
   int isHit(float ox2, float oy2, float oz2, float px, float py, float pz,float x, float y, float z){
 if(speed0<=0 && speed1<=0 && speed2<=0 ){
 if(ox+ox2-px1/2<=x && x <=ox+ox2+px1/2){
 if(oy+oy2-py1/2<=y && oy+oy2+py1/2>=y ){
 if(oz+oz2-pz/2<=z &&  z<=oz+oz2+pz1/2 ){ 
 return 1; 
 } 
 }
 }
 }
 return 0;
}
  
  void draw(){
    //手動で動かすとき
    if(keyPressed){
    if(key == 'a'){
           angle0 = angle0 + dif;
      }
        if(key == 'z'){
           angle0 = angle0 - dif;
      }
      
    if(key == 's'){
        
      angle1 = angle1+ dif;
      }
    
     if(key == 'x'){
       
      angle1 = angle1 - dif;
    }
     if(key == 'd'){
      angle2 = angle2 + dif;
    }
     if(key == 'c'){
      angle2 = angle2 - dif;
    }
     if(keyCode==DOWN){
         camera(1000, 300, 300, -1000, 0, 0,0,1,0); 
    }
   if(keyCode==LEFT){
        camera(600, 300, 600, 0, 0, 0,0,1,0); 
    }
   if(keyCode==RIGHT){
        camera(1000, -500, 1000, 0, 500, 0,0,1,0);
    }
    }
    
 background(255);

 //逆運動学に必要なパラメータ
float C3=(pow(-x+ox,2)+pow(-z+oz,2)+pow(y-oy+b2,2)-pow(c2,2)-pow(d2,2))/(2*c2*d2);
float S3 =pow(1-pow(C3,2),0.5);
float N = d2*S3;
float M = c2+d2*C3;
float A = pow((pow(-z+oz,2)+pow(-x+ox,2)),0.5);
float B = y-oy+b2;
float ang0 = atan2(-x+ox,-z+oz);
float ang1 = atan2(M*A+N*B,N*A-M*B);
float ang2 = atan2(S3,C3);

 

  //地面
  beginShape();
  strokeWeight(5);
  fill(0,200,200);
  vertex(0, oy+py/2+60, 0);
  vertex(0, oy+py/2+60, 1000);
  vertex(1000,  oy+py/2+60, 1000);
  vertex(1000,  oy+py+60, 0);
  vertex(0,  oy+py/2+60, 0);
  endShape();
    
  //土台1
  strokeWeight(5);
  fill(150);
  translate(ox,oy,oz);
  box(px,py,pz);
  //土台2
   pushMatrix();
    translate(0,py/2+py2/2,0);
     box(2*px,py2,2*pz);
    popMatrix();//  
  //物
 pushMatrix();//
 translate(ox2,oy2,oz2);
 fill(150);
 stroke(100,100,0);
 box(px1,py1,pz1);
 popMatrix();//  
 
 //入れ物
 
 
  //座標軸
  noFill();
  strokeWeight(5);
  stroke(0); 
  box(1000);
  
  //アーム１
  strokeWeight(5);
  fill(100);
  translate(0,-py/2+j,0);
  rotateY(angle0);
  translate(0,-b2/2,0);
  box(b1,b2,b3);
  angle0 += speed0 * -angleDirection;//座標軸の回転を回転速度に回転する向き（1を正（時計回り）の向きとする）
 if(abs(angle0) >= abs(ang0)){//　回転角度がπ/3以上，または０以下のとき，
  speed0 = 0;//　回転する向きを反対にする．
  }


  //アーム２
  fill(200);
  translate(0,-b2/2+j,0);
  rotateX(angle1);
  translate(0,-c2/2,0);
  box(c1,c2,c3);
  angle1 += speed1 * angleDirection;//座標軸の回転を回転速度に回転する向き（1を正（時計回り）の向きとする）
 if(abs(angle1) >= abs(ang1)){//　回転角度がπ/3以上，または０以下のとき，
  speed1 = 0;//　回転する向きを反対にする．
  }
 
  
  //アーム３
  translate(0,-c2/2+j,0);
  rotateX(angle2);
  translate(0,-d2/2,0);
  fill(0); 
  box(d1,d2,d3);
  
  if(speed1 <= 0 && speed0 <= 0 ){  

   angle2 += speed2 * angleDirection;//座標軸の回転を回転速度に回転する向き（1を正（時計回り）の向きとする）
  if(abs(angle2) >= abs(ang2)){
  speed2 = 0;
  }
}
 
    

  
  //arm1-1
  strokeWeight(5);
 pushMatrix();//
 translate(0,-d2/2+arm/2,0);
 rotateZ(radians(-angle3));
 translate(arm1/2-arm/2,0,0);
 fill(0);
 box(arm1,arm,arm);
 
 //arm2-1
 translate(arm1/2-arm/2,-arm2/2-arm/2,0);
 fill(0);
 box(arm,arm2,arm);
 
 //arm3-1
 translate(-(arm3/2+arm/2),-arm2/2+arm/2,0);
 fill(0);
 box(arm3,arm,arm);
 popMatrix();
 
 //arm1-2
 pushMatrix();
 translate(0,-d2/2+arm/2,0);
 rotateZ(radians(angle3));
 translate(-(arm1/2-arm/2),0,0);
 fill(0);
 box(arm1,arm,arm);
 
 //arm2-2
 translate(-(arm1/2-arm/2),-arm2/2-arm/2,0);
 fill(0);
 box(arm,arm2,arm);
 
 //arm3-2
 translate((arm3/2+arm/2),-arm2/2+arm/2,0);
 fill(0);
 box(arm3,arm,arm);
 popMatrix();

 
  //値
  println(x,y,z);
  println(angle0,angle1,angle2);
  println(ox2,oy2,oz2);
   
 
 int hit = isHit(ox2, oy2,oz2, px, py,pz, x,y,z);
 if(hit == 1){
    angle3=0;
 if(keyPressed){
 if(key == 'w'){
   angle0=-2*PI/3;
   angle1=PI/2;
   angle2=PI/3;
   ox2=-sin(angle0)*(sin(angle1)*c2+sin(angle1+angle2)*d2);
   oy2=-(b2+cos(angle1)*c2+sin(angle1+angle2)*d2)+220;
   oz2=-cos(angle0)*(sin(angle1)*c2+sin(angle1+angle2)*d2);
     } 
   angle3=-45;
   oy2=-(b2+cos(angle1)*c2+sin(angle1+angle2)*d2)+280;
   }
   if(keyPressed){
 if(key == 'q'){
   angle0=-2*PI/3;
   angle1=PI/2;
   angle2=PI/3;
   ox2=-sin(angle0)*(sin(angle1)*c2+sin(angle1+angle2)*d2);
   oy2=-(b2+cos(angle1)*c2+sin(angle1+angle2)*d2)+220;
   oz2=-cos(angle0)*(sin(angle1)*c2+sin(angle1+angle2)*d2);
     } 
   angle3=-45;
   oy2=-(b2+cos(angle1)*c2+sin(angle1+angle2)*d2)+280;
   }
     
 }
    }

    
   


 

 

 
 
 
 

 
  



 

  
  


  
  
