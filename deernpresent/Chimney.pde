class Chimney {
  PImage showHouse;
  PImage house0, house1, house2, house3;
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

  void display() {

    for (int i = 0; i <100; i++) {

      switch(houses[(pointer + i) % 100]) {  
      case 0:  
        showHouse =  house0;  
        houseW = 200;  
        houseH = 190; 
        break;
      case 1:  
        showHouse =  house1;  
        houseW = 200;  
        houseH = 240; 
        break;
      case 2:  
        showHouse =  house2;  
        houseW = 200;  
        houseH = 190; 
        break;  
      case 3:  
        showHouse =  house3;  
        houseW = 200;  
        houseH = 140; 
        break;
      }      

      if (showHouse != null) {

        float houseX = 200 * (i+1) - houseW - headX;
        chimneyX = houseX+30;
        chimneyY = 640-houseH-80;
        image(showHouse, houseX, height - houseH, houseW, houseH);
        for (int j=0; j<giftCounter; j++) {
          if (isHit(drop[j].x, drop[j].y, 30, 60, chimneyX, chimneyY, 0, 0)) {
            score ++;
            drop[j].receive();
            hoho.trigger();
          }
        }
      }
    }

    headX = (headX + gameSpeed) % 200;     
    if (headX == 0) {
      pointer = (pointer+1)%100;
    }
  }  

  Chimney() {
    house0 = loadImage("img/house0.png");
    house1 = loadImage("img/house1.png");
    house2 = loadImage("img/house2.png");
    house3 = loadImage("img/house3.png");
    for (int i=0; i<houses.length; i++) {
      houses[i] = floor(random(4));
    }
    pointer=0;
    headX=0;
  }
}