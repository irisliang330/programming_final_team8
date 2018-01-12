class Bird{
  PImage bird0, bird1;
  boolean isAlive;
  float x, y;
  float w = ITEM_SIZE;
  float h = ITEM_SIZE;
  float speed = random(1,2.5), AngrySpeed = 3;
  float AngryBirdX, AngryBirdY;
  boolean isAngry = false;
  

  void display(){
    if(isAlive == true){      
      image(bird0, x, y);
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
    if(isAngry == true){
      image(bird1, AngryBirdX, AngryBirdY);
    }
  }
  
  void update(){
    if(isAlive == true){
      x -= speed;
    }
    if(isAngry == true){
      AngryBirdX -= AngrySpeed;
      AngryBirdY -= AngrySpeed;
    }
  }
  
  void checkCollision(Deer deer){
     if(isHit(x, y, w, h, deer.x, deer.y+70, deer.w, h)){
       AngryBirdX = this.x;
       AngryBirdY = this.y;
       giftHealth--;
       x = y = -1000;
       isAlive = false;
       isAngry = true;
       //birdSound.trigger();
       deer.hurt();
     }
  }
  
  void renew(){
    x=880+floor(random(6))*60;
    y=110+floor(random(3))*60;
    isAlive=true;
  }

  Bird(float x, float y){
    bird0 = loadImage("img/bird0.png");
    bird1 = loadImage("img/bird1.png");
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}