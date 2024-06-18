import ddf.minim.*; 
Minim minim; 
AudioPlayer music; 
PGraphics layer1;
PImage m1;
float angle;
float anganim = 0;
color [] colArray = {
  color (255, 72, 0),
  color (219, 173, 99),
  color (219, 154, 99),
  color (219, 112, 99),
  color (219, 210, 184)
};
void setup () {
  size (1080, 800, P2D);
  layer1 = createGraphics(1080, 1080, P2D);
  imageMode(CENTER);
  m1 = loadImage ("mascaraA.png");
  minim = new Minim (this);
  music=minim.loadFile("campanas.mp3", 1024);
  music.loop ();
}
void draw () {
  anganim +=0.002;
  layer1.beginDraw();
  if ( music.position()>21690) {
    layer1.background (#B74A0B, 20);
    layer1.stroke (#F9F6E8);
  } else {
    layer1.background(#F9F6E8, 20);
    layer1.stroke (#B74A0B);
  }
  layer1.translate (width/2, width/2);
  layer1.strokeWeight (1.85);
  for ( int l=0; l<80; l++) {
    float rad = map(l, 0, 80, 0, TWO_PI);
    layer1.push();
    layer1.rotate(rad);
    layer1.line(0, 0, 1000, 0);
    layer1.pop();
  }
  layer1.endDraw();
  push();
  translate (width/2, height/2);
  rotate(anganim);
  image( layer1, 0, 0);
  pop();
  image( m1, width/2, height/2);
  translate (width/2, height/2);
  rotate (radians(angle/3));
  float l =220;
  float d=20;
  for (int a=0; a<360; a+=10) {
    stroke (#3F8982);
    strokeWeight (2);
    push();
    rotate (radians(a));
    line (l*sin(radians(angle)), 290, 370, l-d/2);
    noStroke ();
    fill (colArray[int(random(5))]);
    ellipse (l*sin(radians(angle)), 290, d/2, d/2);
    stroke (colArray[int(random(5))]);
    strokeWeight (2);
    noFill();
    ellipse (290, l, d, d);
    pop();
  }
  angle++;
  float dia =map (music.mix.level (), 0, 0.08, 30, 170);
  float x=240;
  int num= 8;
  for (float c=0; c<360; c+=90) {
    rotate (radians(c));
    push ();
    if ( music.position()>21690) {
      fill (#FC9E63, 100);
    } else {
      fill (#7CB8C9, 100);
    }
    for (int ce=0; ce<num; ce++) {
      scale (0.45);
      rotate (radians(angle));
      noStroke();
      ellipse (0, x, dia, dia);
    }
    pop();
    push();
    if ( music.position()>21690) {
      fill (#A72A9B, 100);
    } else {
      fill (#AFC67C, 100);
    }
    for (int ce=0; ce<num; ce++) {
      scale (0.45);
      rotate (-radians(angle));
      noStroke();
      ellipse (x, 0, dia, dia);
    }
    pop();
  }
}
