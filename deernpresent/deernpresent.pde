PImage cover, lose, win, onetwo, twothree; 
PImage bg, city;
PImage gift3;
PImage track;
PFont font;
import ddf.minim.*;
boolean gift_isAlive = true;
import processing.video.*;

final int GAME_START = 0 , OPENING_MOTION = 1, LEVEL1= 2, LEVEL2 =  3, LEVEL3 = 4, GAME_WIN = 5, GAME_LOSE = 6, ONE_TWO=7, TWO_THREE=8 ;
int gameState = 1;
final int ITEM_SIZE = 60;
int giftHealth = 20;
int score = 0;
int []houses = new int [100];

final int GAME_INIT_TIMER = 5400;
int gameTimer = GAME_INIT_TIMER;

Bird birds;
Gift gifts;
Fog fogs;
Deer deer;
Chimney chimney;
Fire fire;
Drop drop[] = new Drop[100];
int giftCounter;
Movie movie;
Minim minim;
AudioPlayer title;
AudioSample bgm,  gameoverSound, ttm, gameWinSound,hoho, birdSound, rain,  giftBurnSound,  startSound, giftDropSound, giftEatSound, levelPassSound;



boolean upState = false;
boolean leftState = false;
boolean rightState = false;
boolean downState = false;

void setup(){
  size(880, 640);
  frameRate(60);
  bg = loadImage("img/bg.png");
  city = loadImage("img/city.png");
  gift3 = loadImage("img/gift3.png");
  track = loadImage("img/track.png");
  cover = loadImage("img/cover.png");
  lose = loadImage("img/lose.png");
  win = loadImage("img/win.png");
  onetwo = loadImage("img/onetwo.png");
  twothree = loadImage("img/twothree.png");
  
  font = createFont("font/font.otf", 50);
  textFont(font);
  
 
 
  initGame();
  minim= new Minim(this);
  title = minim.loadFile("sound/title.mp3",128);
  bgm = minim.loadSample("sound/bgm.mp3",128);
  birdSound = minim.loadSample("sound/bird.wav" ,128);
  rain = minim.loadSample("sound/cloud.wav",128);
  gameoverSound = minim.loadSample("sound/gameover.mp3"); 
  giftBurnSound = minim.loadSample("sound/giftburn.wav",128);
  giftDropSound= minim.loadSample("sound/giftdrop.wav",128);
  giftEatSound = minim.loadSample("sound/gifteat.wav",128);
  levelPassSound = minim.loadSample("sound/passlevel.wav",128);
//  startSound = minim.loadSample("sound/start.wav",256); 
  gameWinSound = minim.loadSample("sound/win.mp3",128);
  hoho = minim.loadSample("sound/hohoho.mp3", 128);
  title.play();
  title.loop();
  
   movie = new Movie(this,"opening.mov");
   movie.play();
  
  
}

void movieEvent(Movie movie){
  movie.read();
}

void initGame(){
  gameTimer = GAME_INIT_TIMER;

    int bx = floor(random(12));
    int by = floor(random(3));
    int fx = floor(random(12));
    int fy = floor(random(3));
    int p1x = floor(random(12));
    int p1y = floor(random(3));
    int p2x = floor(random(12));
    int p2y = floor(random(3));
while(bx == fx && by==fy || bx == p1x && by == p1y || bx == p2x &&  by == p2y || fx == p1x && fy == p1y || fx == p2x && fy == p2y || p1x == p2x && p1y == p2y){
        bx = floor(random(12));
        by = floor(random(3));
        fx = floor(random(12));
        fy = floor(random(3));
        p1x = floor(random(12));
        p1y = floor(random(3));
        p2x = floor(random(12));
        p2y= floor(random(3));
} 
    gifts = new Gift(400+p1x*60, 110+p1y*60);
    birds = new Bird(400+bx*60, 110+by*60);
    fogs= new Fog(400+fx*60, 110+fy*60);
    deer = new Deer();
    for(int i=0; i<8; i++){
      chimney = new Chimney(houses,2);
    }
    for(int i=0; i<8; i++){
      fire = new Fire(houses,2);
    }
}

void draw(){
 
  switch(gameState){
    
    case OPENING_MOTION:
    //ae
    image(movie,0,0);
    
   if(frameCount >396){
      if(isMouseHit(375, 557.5, 130, 35)) {
        if(mousePressed){
          gameState = LEVEL1;
          title.pause();
          bgm.trigger();
          mousePressed = false;
        }
      }
    }
   
    break;
    
    case LEVEL1 :
    //bg,
    image(bg,0,0);
    image(city,0,450);
    image(track,0,110);
    
     //score
    textAlign(LEFT,TOP);
    fill(255);
    text("SCORE"+" "+":"+" "+score,690,20);
   //drop 
       for(int i = 0; i<giftCounter; i++){
       drop[i].falling();
       drop[i].display();
       
  }

    //chimney(class)(mountain like)
    chimney.display();
    //chimney.checkCollision(gifts);

    //objects
    gifts.update();
    gifts.display();
    gifts.checkCollision(deer);
    birds.update();
    birds.display();
    birds.checkCollision(deer);
   //renew items
    if(gifts.x<-60 || isHit(gifts.x, gifts.y, 60, 60, deer.x, deer.y+70, deer.w, 60))gifts.renew();
    if(birds.x<-60 || isHit(birds.x, birds.y, 60, 60, deer.x, deer.y+70, deer.w, 60))birds.renew();
       
    //deer
    deer.display();
    deer.update();
    
    // Time UI
    textAlign(LEFT, TOP);
    String timeString = convertFrameToTimeString(gameTimer);
    //fill(0, 120);
    //text(timeString, 20, 20);
    fill(255);
    text(timeString, 20, 20);

    gameTimer --;
    if(gameTimer <= 0) gameState = GAME_LOSE;
    
    //score
   if(score>=15) {
      gameState = ONE_TWO;
      bgm.stop();
      levelPassSound.trigger();
    }
    if(giftHealth<=0 && score<15) {
      gameState= GAME_LOSE;
      bgm.stop();
      gameoverSound.trigger();
      
     }

    break;
    case ONE_TWO:
    image(onetwo,0,0,880,640);
    if(isMouseHit(375, 503, 130, 35)) {
      if(mousePressed){
    
        bgm.trigger();
        giftHealth = 20;
        score = 0;
        giftCounter=0;
        initGame();
         gameState = LEVEL2;
         mousePressed = false;
      }
    } 
    break;

    
    case LEVEL2 :
 
    //bg,
    image(bg,0,0);
    image(city,0,450);
    image(track,0,110);
//  DROP
  for(int i = 0; i<giftCounter; i++){
       drop[i].falling();
       drop[i].display();
       
    }

       
    //chimney(class)(mountain like),
    chimney.display();
    //chimney.checkCollision(gifts);
    //score
    textAlign(LEFT,TOP);
    fill(255);
    text("SCORE"+" "+":"+" "+score,690,20);

    //objects
    gifts.update();
    gifts.display();
    gifts.checkCollision(deer);
    birds.update();
    birds.display();
    birds.checkCollision(deer);
    fogs.update();
    fogs.display();
    fogs.checkCollision(deer);
//renew items
    if(gifts.x<-60 || isHit(gifts.x, gifts.y, 60, 60, deer.x, deer.y+70, deer.w, 60) ){
      gifts.renew();
    }
   if(birds.x<-60 || isHit(birds.x, birds.y, 60, 60, deer.x, deer.y+70, deer.w, 60)){
      birds.renew();
   }
  if(fogs.x<-60 || isHit(fogs.x, fogs.y, 60, 60, deer.x, deer.y+70, deer.w, 60))fogs.renew();
   
    
    //deer
    deer.display();
    deer.update();
    //fog display
    fogs.fogDisplay();
    
    // Time UI
    textAlign(LEFT, TOP);
    timeString = convertFrameToTimeString(gameTimer);
    //fill(0, 120);
    //text(timeString, 20, 20);
    fill(255);
    text(timeString, 20, 20);

    gameTimer --;
    if(gameTimer <= 0) gameState = GAME_LOSE;
    
    //score
      if(score>15)  {
    gameState = TWO_THREE;
    bgm.stop();
    levelPassSound.trigger();
    }
    if(giftHealth<=0 && score<15) {
      gameState= GAME_LOSE;
      bgm.stop();
      gameoverSound.trigger();
     }

    break;
    case TWO_THREE:
    image(twothree,0,0,880,640);
    if(isMouseHit(375, 503, 130, 35)) {
      if(mousePressed){
        gameState = LEVEL3;
        giftHealth = 20;
        score = 0;
        initGame();
        bgm.trigger();
        giftCounter=0;
        mousePressed = false;
      }
    }
    
    break;

    
    case LEVEL3 :
    
    //bg,
    image(bg,0,0);
    image(city,0,450);
    image(track,0,110);
    
    //  DROP
    for(int i = 0; i<giftCounter; i++){
       drop[i].falling();
       drop[i].display();      
    }
        
    //chimney(class)(mountian),
    fire.fireDisplay();
    
    //score
    textAlign(LEFT,TOP);
    fill(255);
    text("SCORE"+" "+":"+" "+score,690,20);

    //objects
    gifts.update();
    gifts.display();
    gifts.checkCollision(deer);
    birds.update();
    birds.display();
    birds.checkCollision(deer);
    fogs.update();
    fogs.display();
    fogs.checkCollision(deer);
   //renew items
    if(gifts.x<-60 || isHit(gifts.x, gifts.y, 60, 60, deer.x, deer.y+70, deer.w, 60))gifts.renew();
    if(birds.x<-60 || isHit(birds.x, birds.y, 60, 60, deer.x, deer.y+70, deer.w, 60))birds.renew();
    if(fogs.x<-60 || isHit(fogs.x, fogs.y, 60, 60, deer.x, deer.y+70, deer.w, 60))fogs.renew();
        
    //deer
    deer.display();
    deer.update();
    //fog display
    fogs.fogDisplay();
    
    // Time UI
    textAlign(LEFT, TOP);
    timeString = convertFrameToTimeString(gameTimer);
    //fill(0, 120);
    //text(timeString, 20, 20);
    fill(255);
    text(timeString, 20, 20);

    gameTimer --;
    if(gameTimer <= 0) gameState = GAME_LOSE;
    
    //score
     if(score>=15){ 
      gameState = GAME_WIN;
      bgm.stop();
      gameWinSound.trigger();
      }
    if(giftHealth<=0 && score<15) {
      gameState= GAME_LOSE;
      bgm.stop();
      gameoverSound.trigger();
     }
    
    
    //firechimney
    break;
    
     case GAME_WIN :
     
    image (win, 0,0,880,640);
    if(isMouseHit(375, 503, 130, 35)) {
      if(mousePressed){
        gameState = GAME_START;
        gameWinSound.stop();
        mousePressed = false;
         giftHealth = 20;
        score = 0;
        initGame();
        giftCounter = 0;
        title.play();
        title.loop();
      }
    }

    break;
    
    case GAME_LOSE :
    
  image (lose, 0,0,880,640);
  if(isMouseHit(375, 503, 130, 35)) {
    if(mousePressed){
        gameState = LEVEL1;
        //gameoverSound.stop();
        for(int i = 0; i<giftCounter; i++){
          drop[i].nomove();
        }
        initGame();
        giftHealth = 20;
        score=0;
        
        bgm.trigger();
        mousePressed = false;
     }
  }
    break;
    
  }//gamestate
}// draw



boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh){
  if (ay+ah>by && ax+aw>bx && ay<by+bh && ax<bx+bw){
  return true;
}
  return false;                
}

boolean isMouseHit(float bx, float by, float bw, float bh){
  return  mouseX > bx && 
        mouseX < bx + bw && 
        mouseY > by && 
        mouseY < by + bh;
}

String convertFrameToTimeString(int frames){
  String result = "";
  float totalSeconds = float(frames) / 60;
  result += nf(floor(totalSeconds/60), 2);
  result += " "+":"+" ";
  result += nf(floor(totalSeconds%60), 2);
  return result;
}

void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case UP:
      upState = true;
      break;
      case LEFT:
      leftState = true;
      break;
      case RIGHT:
      rightState = true;
      break;
      case DOWN:
      downState = true;
      break;
    }
  } else{
    if(key == ' '){
     drop[giftCounter++] = new Drop();

    }
  }
if(key ==  'a' ){
 score ++;
  }
}

void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case UP:
      upState = false;
      break;
      case LEFT:
      leftState = false;
      break;
      case RIGHT:
      rightState = false;
      break;
      case DOWN:
      downState = false;
      break;
      
    }
  }
}



