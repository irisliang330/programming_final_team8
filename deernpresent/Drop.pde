class Drop{
  float x, y,w,h;
  boolean dropping;
  float speed = 8f;
 boolean gift_isAlive = true; 
 PImage gift1;
   
   
void display(){
     
   if(dropping ==true){
   image(gift1, x+deer.w/5, y+deer.h/2+30);
   }
   }
   
  
   
   
   void falling (){  
    // dropping = true;
  if(dropping ==true){
    y +=speed;
    x += 0 ;
    if(gift_isAlive){
       giftHealth -= 1;
       gift_isAlive = false;
     }
    }
   }
   
   void receive(){
    gift_isAlive = false;
    x = y = -1000;
  }
   
   void nomove(){
    dropping=false;
  }
   
  Drop(){
  
      gift1 = loadImage("img/gift1.png");
      dropping = true;
      x = deer.x;
      y = deer.y;
      w = gift1.width;
      h = gift1.height;
  }
}