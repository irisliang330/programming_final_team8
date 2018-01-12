class Chimney{
    PImage showHouse;
    PImage house0,house1,house2,house3;
    float houseX;
    float houseW = 0, houseH = 0;
    float chimneyX = houseX+30;
    float chimneyY = 640 - houseH;
    final int CHIMNEY_W = 60;
    float chimneyH;
    int [] houses = new int[100];
    int pointer; 
    int headX;
    boolean isAlive = true;
    int c=4;
  
  
   void display(){
 
     for(int i = 0; i <101; i++) {
       
      switch(houses[(pointer + i) % 100]){  
        case 0:  showHouse =  house0;  houseW = 200;  houseH = 190; break;
        case 1:  showHouse =  house1;  houseW = 200;  houseH = 240; break;
        case 2:  showHouse =  house2;  houseW = 200;  houseH = 190; break;  
        case 3:  showHouse =  house3;  houseW = 200;  houseH = 140; break;
      }      
      
       if(showHouse != null){
         
         float houseX = 200 * (i+1) - houseW - headX;
         chimneyX = houseX+30;
         chimneyY = 640-houseH;
         image(showHouse, houseX, height - houseH, houseW, houseH);
         for(int j=0; j<giftCounter; j++){
           if(drop[j].x+60 > chimneyX && drop[j].x < chimneyX+60 && drop[j].y+60 > chimneyY && drop[j].y < chimneyY+80){
             
             println(houseH);
             score ++;
             //drop[i].dropping = false;
             drop[j].receive();
           }
         }
       }
     }
     
     headX = (headX + 1) % 200;     
     if(headX == 0){
       pointer = (pointer+1)%100;
     }     
}
    
   //void checkCollision(Gift gift){
   //  if(isHit(chimneyX,chimneyY,CHIMNEY_W, 400, gift.x, gift.y, gift.w, gift.h) && isAlive){
   //    score ++; 
   //    isAlive = false;
   //  }    
   
    

  Chimney(int [] outsidehouses, int headX){
    house0 = loadImage("img/house0.png");
    house1 = loadImage("img/house1.png");
    house2 = loadImage("img/house2.png");
    house3 = loadImage("img/house3.png");
    //fire = loadImage("img/fire.png");
    for(int i=0; i<houses.length; i++){
      houses[i] = floor(random(4));
    }
    pointer=0;
    headX=0;
    //this.houses = houses;
    //this.headX = headX;
  }
}