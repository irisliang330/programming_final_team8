class Gift{
  PImage gift0,gift1,gift2;
  boolean isAlive;
  float x, y;
  float w = ITEM_SIZE;
  float h = ITEM_SIZE;
  float speed = random(1,2);
  
  void update(){
    x -= speed;
    if(x<-60){
      int l = floor(random(6));
      x = 880+l*60;
      if(y == 110){
        int k = floor(random(3));
        y = y + k*60;
      }
      if(y == 170){
        int k = floor(random(-1,2));
        y = y + k*60;
      }
      if(y == 230){
        int k = floor(random(3));
        y = y - k*60;
      }
    }
  }

  void display(){
    image(gift0, x, y);
  }
  
  void checkCollision(Deer deer){
     if(isHit(x, y, w, h, deer.x, deer.y+70, deer.w, h)){
       x=y=-1000;
       giftHealth ++;
       //giftEatSound.trigger();
     }
  }
  
  void renew(){
    x=880+floor(random(6))*60;
    y=110+floor(random(3))*60;
    
  }

  Gift(float x, float y){
    gift0 = loadImage("img/gift0.png");
    gift1 = loadImage("img/gift1.png");
    gift2 = loadImage("img/gift2.png");
    
    this.x = x;
    this.y = y;
  }
}