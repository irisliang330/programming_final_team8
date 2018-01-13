class Fire {   

  PImage showHouse;
  PImage house0, house1, house2, house3, fire;
  float houseX;
  float houseW = 0, houseH = 0;
  float chimneyX = houseX+30;
  float chimneyY = 640 - houseH;
  final int CHIMNEY_W = 60;
  float chimneyH;
  int [] houses = new int [100];
  int pointer;
  int headX;
  boolean isAlive = true;
  float fireX, fireY;
  boolean fireExist;
  final int FIRE_H = 110, FIRE_W =45;

  void fireDisplay() {  
    for ( int i=0; i<100; i++) {      
      switch(houses[(pointer + i) % 100]) {  
      case 0:  
        showHouse =  house0;  
        houseW = 200;  
        houseH = 190;
        fireExist = false;
        break;
      case 1:  
        showHouse =  house1;  
        houseW = 200;  
        houseH = 240;
        fireExist = false;
        break;
      case 2:  
        showHouse =  house2;  
        houseW = 200;  
        houseH = 190;  
        fireExist = false;
        break;  
      case 3:  
        showHouse =  house3;  
        houseW = 200;  
        houseH = 140;  
        fireExist = false;
        break;
      case 4:  
        showHouse =  house0;  
        houseW = 200;  
        houseH = 190;
        fireX = 200 * (i+1) - houseW - headX +35; 
        fireY = height - houseH-110;
        fireExist = true;
        break;
      case 5:  
        showHouse =  house1;  
        houseW = 200;  
        houseH = 240;
        fireX = 200 * (i+1) - houseW - headX +50; 
        fireY = height - houseH-110;
        fireExist = true;
        break;
      case 6:  
        showHouse =  house2;  
        houseW = 200;  
        houseH = 190;
        fireX = 200 * (i+1) - houseW - headX +35; 
        fireY = height - houseH-110;
        fireExist = true;
        break;
      case 7:  
        showHouse =  house3;  
        houseW = 200;  
        houseH = 140;
        fireX = 200 * (i+1) - houseW - headX +35; 
        fireY = height - houseH-110;
        fireExist = true;
        break;
      }

      float houseX = 200 * (i+1) - houseW - headX;
      chimneyX = houseX+30;
      chimneyY = 640-houseH-80;
      image(showHouse, houseX, height - houseH, houseW, houseH);
      image(fire, fireX, fireY, FIRE_W, FIRE_H);
      for (int j=0; j<giftCounter; j++) {
        if (fireExist == false) {
          if (isHit(drop[j].x, drop[j].y, 30, 60, chimneyX, chimneyY, 0, 0)) { 
            score ++;
            drop[j].receive();
            hoho.trigger();
          }
        }
        if (fireExist == true) {
          if (isHit(drop[j].x, drop[j].y, 60, 60, chimneyX, chimneyY-FIRE_H, FIRE_W, FIRE_H)) {
            drop[j].receive();
            giftBurnSound.trigger();
          }
        }
      }
    }


    headX = (headX + 2) % 200; 
    if (headX == 0) {
      pointer = (pointer+1) % 100;
    }
  }     

  Fire() {

    house0 = loadImage("img/house0.png");
    house1 = loadImage("img/house1.png");
    house2 = loadImage("img/house2.png");
    house3 = loadImage("img/house3.png");
    fire = loadImage("img/fire.png");
    for (int i=0; i<houses.length; i++) {
      houses[i] = floor(random(8));
    }
    pointer=0;
    headX=0;
  }
}