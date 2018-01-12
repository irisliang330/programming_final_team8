class Fog{
  PImage cloud,fog;
  boolean isAlive;
  float x, y, fsx=0, fsy=0;
  float w = ITEM_SIZE;
  float h = ITEM_SIZE;
  int FOG_FADE = 300;
  boolean isBadWeather = false;
  float speed = random(1,2.5);

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
    image(cloud, x, y);
  }
  
  void fogDisplay(){
    if(isBadWeather == true){
      image(fog, fsx, fsy);
      FOG_FADE--;
    }
    if(FOG_FADE < 0){
      isBadWeather = false;
    }
  }
  
  void checkCollision(Deer deer){
     if(isHit(x, y, w, h, deer.x, deer.y+70, deer.w, h)){
       x = y = -1000;
       isAlive = false;
       isBadWeather = true;
       deer.hurt();
       //rain.trigger();
     }
  }
  
  void renew(){
    x=880+floor(random(6))*60;
    y=110+floor(random(3))*60;
    FOG_FADE = 300;
  }

  Fog(float x, float y){
    fog = loadImage("img/fog.png");
    cloud = loadImage("img/cloud.png");
    this.x = x;
    this.y = y;
  }
}