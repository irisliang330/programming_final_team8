class Deer{ 
 PImage deer0, deer1,sled;
 float x, y;
 float w = 100, h = 130;
 float shock_time = 60;
 Gift gifts;
 boolean gift_isAlive = true;
 float speed = 1;
 float dropY = y +130;
 PImage gift0;
 boolean isShock = false;


  
  Deer(){
    deer0 = loadImage("img/deer0.png");
    deer1 = loadImage("img/deer1.png");
    sled = loadImage("img/sled.png");
    gift0 = loadImage("img/gift0.png");

    x = 110;
    y = 100;
  }

  void update(){
    
    if(upState && y >= 50 && keyPressed == true){
      y -= 60;
      keyPressed = false;
    }
    if(downState && y <= 150 && keyPressed == true){
      y += 60;
      keyPressed = false;
    }
    if(rightState && x <= 760 && keyPressed == true){
      x += 60;
      keyPressed = false;
    }
    if(leftState && x >= 140 && keyPressed == true){
      x -= 60;
      keyPressed = false;
    }
    if(isShock == true){
      shock_time--;

      if(shock_time <= 0){
        isShock = false;
        shock_time = 60;

      }
    }
  }
  
  void hurt(){
    
      isShock = true;
        
  }
  
  void display(){
    if(isShock == false){
      image(deer1,x,y);
      image(sled,x-100,y+70);
    }
    if(isShock == true){
      image(deer0,x,y);
      image(sled,x-100,y+70);
    }
    textAlign(CENTER,TOP);
    text(giftHealth,x-50,y+45);
  }
  
  
  
  void drop(float x){
     image(gift0, x+60, dropY);
     dropY += speed;
     if(gift_isAlive){
       giftHealth -= 1;
       gift_isAlive = false;
     }
     
  }

}