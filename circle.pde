class Circle {
  float x, y, dx, dy, rot, s, c;
  // Constructor with defined parameters
  Circle(float x, float y, float dx, float dy, float s, float c, float rot) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.s = s;
    this.c = c;
    this.rot = rot;
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
    this.rot = 0;
    drawCircle();
  }
}

Circle[] circ;

//draw geometric form accordingly with the music played
void drawCircle(int nbcirc, float energy, float flatness, float entropy) {
  //draw the circle
  circ[nbcirc].drawCircle();
  
  circ[nbcirc].s =  map(energy, 0, 10, 5, 20);
  circ[nbcirc].c =  map(energy, 0, 10, 20, 255);
  //circ.y =  map(centroid, 0, 4000, (height/2) - 100, (height/2) + 100);
  //circ.x =  map(entropy, 0, 2, (width/2) - 200, (width/2) + 200);  
  circ[nbcirc].dx = map(entropy, 0, 10, 200, 600);
  circ[nbcirc].dy = map(entropy, 0, 10, 200, 700);
  //circ.rot = map(flatness, 0, 3000, 0, PI);
  
}

float smooth_filter(float old_value, float new_value) {
  float lambda_smooth = 0.3f;
  return lambda_smooth * new_value + (1 - lambda_smooth) * old_value;
}



/*switch(switchgeom) {
      case 0:
        drawCircle(feat.centroid, feat.spread, feat.energy, feat.flatness, feat.entropy); //spread not very usefull
        looping += 1;
        if(looping>1000){switchgeom = int(random(2)); looping=0;} 
        break;
      case 1:
        drawShapes(feat.centroid, feat.energy, feat.flatness, feat.entropy);
        looping += 1;
        if(looping>1000){switchgeom = int(random(2)); looping=0;}
        break;
      }
    } */
