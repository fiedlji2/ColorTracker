import processing.video.*;

Capture video;

color trackColor; 
color black;
color red;

void setup() {
  size(320,240);
  video = new Capture(this,width,height);
  video.start();

  red=color(255,0,0);
  black=color(0,0,0);
  trackColor=color(217,255,100);
}

void draw() {
  float posX=0;
  float posY=0;
  int okPoints=0;
  
  if (!video.available()){return;}
  
  video.read();
  video.loadPixels(); 

  float okDistance = 50; 

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float dr = abs(r1-r2);
      float dg = abs(g1-g2);
      float db = abs(b1-b2);
      
      if(dr<okDistance && dg<okDistance && db<okDistance){
        video.pixels[loc]=red;
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
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
  println("R: "+red(trackColor)+"G: "+green(trackColor)+"B: "+blue(trackColor));
}
