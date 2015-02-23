import processing.video.*;

Capture video;
PImage img; 

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
}

void draw() {
  
  if (!video.available()){return;}
  
  video.read();
  video.loadPixels(); 

  float okDistance = 40; 

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
      lastColor=currentColor;
      
      

      float dr = abs(r1-r2);
      float dg = abs(g1-g2);
      float db = abs(b1-b2);
      
      if(dr>okDistance || dg>okDistance || db>okDistance){
        video.pixels[loc]=red;
      }  
    }
  }
 
    video.updatePixels();
    image(video,0,0);   
}
