// Function to apply a fading effect to the canvas
void applyFading() {
  canvas.beginDraw();
  canvas.noStroke();
  canvas.fill(0, 10);  // Black with low opacity for gradual fade
  if(beat.isBeat()) {
    float Hue = map(feat.energy, 0, 50, 20, 350);
    canvas.fill(color(Hue,255,255), 25);
  }
  canvas.rect(0, 0, width, height);
  canvas.endDraw();
}

// Splat class to manage individual splatters
class Splat {  
  float x, y, newcolor;
  int rad = 30;
  PGraphics splatGraphic;
  int creationTime;

  Splat(float x, float y, float newcolor) {
    this.x = x;
    this.y = y;
    this.newcolor = newcolor;
    creationTime = millis();  // Store the creation time
    
    // Create the splatter graphic
    splatGraphic = createGraphics(200, 200);
    createSplatter();
  }

  void createSplatter() {
    splatGraphic.beginDraw();
    splatGraphic.colorMode(HSB, 360, 100, 100);
    //float Hue = map(feat.energy, 0, 50, 20, 350);
    splatGraphic.fill(newcolor, 100, 100); // Random hue
    splatGraphic.noStroke();
    
    for (float i = 3; i < 29; i += 0.35) {
      float angle = random(0, TWO_PI);
      float splatX = 100 + cos(angle) * 2 * i;  // Center at (100, 100)
      float splatY = 100 + sin(angle) * 3 * i;
      splatGraphic.ellipse(splatX, splatY, rad - i, rad - i + 1.8);
    }
    splatGraphic.endDraw();
  }

  void display() {
    canvas.beginDraw();
    canvas.imageMode(CENTER);
    canvas.image(splatGraphic, x, y);
    canvas.endDraw();
  }

  // Check if the splatter should disappear after 1 seconds
  boolean isExpired() {
    return millis() - creationTime > 1000;  // 1000 ms = 1 seconds
  }
}
