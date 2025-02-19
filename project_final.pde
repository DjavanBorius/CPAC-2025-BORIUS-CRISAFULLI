//IP adress phone : 192.168.43.61 wifi : 192.168.1.12
import oscP5.*;
import netP5.*;
import processing.sound.*;
import java.util.ArrayList;

//Initiate variables
OscP5 oscP5;
OscMessage Message;
OscProperties properties;
int receive;
float module;
NetAddress touchDesignerAddress;
float[][] norms;
AudioIn input;
PitchDetector pitch;
BeatDetector beat;
FFT fft;
int bands = 2048;
float[] Spectrum = new float[bands];
AgentFeature feat;
int switchgeom = 0;
int looper =0;
PGraphics canvas;
ArrayList<Splat> splatters;
///////////////////////////

void setup() {
  size(1000, 1000);
  
  // start capturing the sound from reckordbox
  input = new AudioIn(this, 0); // 0 is the default input channel
  input.start();
  input.amp(5.0); //increase the amplitude of the sound for better processing with FFT
  pitch = new PitchDetector(this);
  pitch.input(input);
  beat = new BeatDetector(this);
  beat.input(input);
  fft = new FFT(this, bands);
  fft.input(input);
  feat = new AgentFeature(22050);
    
  //Setup Chladni patterns
  plate = new Plate();
  xcols = 100;
  yrows = 100;
  F = 440;
  float[][] mode = plate.vibration_modes(plate.mode, xcols, yrows, F);
  x = linspace(0,1,xcols);
  y = linspace(0,1,yrows);
  px = new int[5000];
  py = new int[5000];
  // Create each grain with a position according the vibration mode
  for (int i = 0; i < xcols; i++) {
    for (int j = 0; j < yrows; j++) {
      // Position des points sur le plateau
      if(mode[i][j]<=-1.8){
        px[numGrains] = floor(x[i]*1000);
        py[numGrains] = floor(y[i]*1000);
        numGrains +=1;
      }
    }
  }
  grains = new Grain[numGrains];
 
  for(int i=0; i<numGrains;i++)
  {
    float diameter = random(2,5);   
    grains[i] = new Grain(px[i],py[i], diameter);
  }
  
  //setup geometric circle
  circ = new Circle[5];
  for(int i=0;i<5;i++){
    circ[i] = new Circle();
  }
  circ[1].x = -300; circ[1].y = 300; circ[2].x = 300; circ[2].y = 300; circ[3].x = 300; circ[3].y = -300; circ[4].x = -300; circ[4].y = -300;
  
  colorMode(HSB,400);
  
  // Setup interactive painting
  canvas = createGraphics(width, height);
  splatters = new ArrayList<Splat>();
  
  // Start OSC message
  oscP5 = new OscP5(this, 57120);
  properties = new OscProperties();
  receive = 0; 
  
  // Start sending OSC message on another port
  touchDesignerAddress = new NetAddress("192.168.1.12", 8000); // Port defined in TouchDesigner
}


void draw() {
  if(receive==1){
    float module = Message.get(0).floatValue(); // This value choose the module
    if (module == 1.0) {
      displayScreen1();
    } else if (module == 2.0) {
      background(0); 
      surface.setVisible(true);
      F = pitch.analyze(0.15); //find the fundamental frequency
      float[][] mode = plate.vibration_modes(plate.mode, xcols, yrows, F);
      delay(100);
      numGrains = update_grains(mode);
      display_grains(numGrains);
    } else if (module == 3.0) {
      background(0);
      surface.setVisible(true);
      feat.reasoning(fft.analyze(Spectrum));
      if(feat.drop*100>17){ 
        switchgeom = 1;
      } 
      switch(switchgeom) {
      case 0:
        drawCircle(0, 10*feat.energy, feat.entropy); 
        break;
      case 1:
        for (int i=0;i<5;i++){
            circ[i].c = random(400);
            drawCircle(i, feat.energy*0.1, feat.entropy);
        }
        looper += 1;
        if(looper>300){switchgeom = 0; looper=0;}
        break;
      }  
      } else if (module == 4.0) {
         surface.setVisible(true);
         applyFading();
         // Display the canvas
         image(canvas, 0, 0);
        // Update and display splatters
        for (int i = splatters.size() - 1; i >= 0; i--) {
          Splat s = splatters.get(i);
          if (s.isExpired()) {
            splatters.remove(i);
          } else {
            s.display();
          }
        } 
      } else if (module == 5.0) {
        surface.setVisible(false);
        delay(30); //allows to better se the effect of TouchDesigner
        feat.reasoning(fft.analyze(Spectrum));
        SendMessage(feat.energy, feat.entropy, feat.drop); //send information to TouchDesigner
      }
  } else {
    displayScreen1();
  }
}

void displayScreen1() {
  surface.setVisible(true);
  background(255, 0, 0);
  textSize(68);
  text("Wainting for the Show to start,", 75, 450);
  text(" please be patient", 250, 550);
}
