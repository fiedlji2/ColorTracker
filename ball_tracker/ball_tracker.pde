import processing.video.*;

Capture video;
PImage img; 

color trackColor;
color lastColor; 
color black;
color red;

void setup() {
  size(320,240);
  video = new Capture(this,width,height);
  video.start();

  red=color(255,0,0);
  black=color(0,0,0);
  lastColor=black;
  trackColor=-2637268;
}

void draw() {
  if (!video.available()){return;}
  float posX=0;
  float posY=0;
  int okPoints=0;  
  
  video.read();
  video.loadPixels(); 

  float okDistance = 17; 
  float scDist = 40;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(lastColor);
      float g2 = green(lastColor);
      float b2 = blue(lastColor);
      float r3 = red(trackColor);
      float g3 = green(trackColor);
      float b3 = blue(trackColor);      
      lastColor=currentColor;

      float dr = abs(r1-r2);
      float dg = abs(g1-g2);
      float db = abs(b1-b2);
      
      if(dr>okDistance || dg>okDistance || db>okDistance){
        video.pixels[loc]=red;
      }  
      
      dr = abs(r1-r3);
      dg = abs(g1-g3);
      db = abs(b1-b3);
      
      if(dr<scDist && dg<scDist && db<scDist){
        video.pixels[loc]=color(0,0,255);
        okPoints++;
        posX+=x;
        posY+=y;
      }  
      
    }
  }
 
    posX/=okPoints;
    posY/=okPoints;
    video.updatePixels();
    image(video,0,0);   
    fill(0,255,0);
    ellipse(posX,posY,10,10);
    println("X: "+posX+" Y: "+posY); 
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}
