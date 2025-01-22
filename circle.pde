class Circle {
  float x, y, dx, dy, rot, s, c;
  // Constructor with defined parameters
  Circle(float x, float y, float dx, float dy, float s, float c) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.s = s;
    this.c = c;
  }
  // Constructor with default parameters
  Circle() {
    defaultCircle();
  }

  void drawCircle() {
    color colore = color(this.c, 255, 255);
    pushMatrix();
    translate(width/2, height/2);
    rotate(this.rot);
    noFill();
    strokeWeight(this.s);
    stroke(colore);
    ellipse(this.x, this.y, this.dx, this.dy);
    popMatrix();
  }
  void defaultCircle() {
    this.x = 0;
    this.y = 0;
    this.dx = 400;
    this.dy = 400;
    this.s = 10;
    this.c = 255;
    drawCircle();
  }
}

Circle[] circ;

//draw geometric form accordingly with the music played
void drawCircle(int nbcirc, float energy, float entropy) {
  //draw the circle
  circ[nbcirc].drawCircle();
  
  circ[nbcirc].s =  map(energy, 0, 10, 5, 20);
  circ[nbcirc].c =  map(energy, 0, 10, 20, 255);
  circ[nbcirc].dx = map(entropy, 0, 10, 200, 600);
  circ[nbcirc].dy = map(entropy, 0, 10, 200, 700); 
}
