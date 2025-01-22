// Frame length
int frameLength = 4096; 

//linspace function for the position of the plate vibration
float[] linspace(float start, float end, int num) {
    float[] vector = new float[num];
    float step = (end - start) / (num - 1);
  
    for (int i = 0; i < num; i++) {
      vector[i] = start + i * step;
    }
  
    return vector;
}

//Define a class for the thin plate
class Plate {
  float v = 0.3; // poisson factor
  float L = 1; // [m] size of the square plate
  float[][] mode;
  int T = 0; //
  //Build class thin plate
  Plate() {
    //parameters of the plate defined above  
    this.mode = new float[100][100];
  }
  
  float[][] vibration_modes(float[][] mode, int size_x, int size_y, float F) {
    
    float[] vector_x = linspace(0,L,size_x);
    float[] vector_y = linspace(0,L,size_y);
    float x1 = vector_x[5];
    float x2 = vector_x[5];
    float x3 = vector_x[95];
    float x4 = vector_x[95];
    float y1 = vector_y[5];
    float y2 = vector_y[95];
    float y3 = vector_y[5];
    float y4 = vector_y[95];
    
    for(int i=0;i<size_x;i++){
      for(int j=0;j<size_y;j++)
      {
        mode[i][j] = sin((2*PI/60)*F*(T-(1/v)*sqrt(pow(vector_x[i]-x1,2)+pow(vector_y[j]-y1,2))))+ sin((2*PI/60)*F*(T-(1/v)*sqrt(pow(vector_x[i]-x2,2)+pow(vector_y[j]-y2,2))))+sin((2*PI/60)*F*(T-(1/v)*sqrt(pow(vector_x[i]-x3,2)+pow(vector_y[j]-y3,2))))+sin((2*PI/60)*F*(T-(1/v)*sqrt(pow(vector_x[i]-x4,2)+pow(vector_y[j]-y4,2)))); 
      }
    }
    return mode;
  }  
}

// Definition of a class Grain to represent each little grain
class Grain {
  float x, y; // grain position
  float size; // grain size
  
  Grain(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
   }
}

Plate plate;
Grain[] grains; // Table to stock all the grains
int numGrains=0; // Number of grains to be generated
int xcols, yrows;
float[] x, y;
int[] px,py;
float F; //[Hz]

// Method to actualize grain's positions
int update_grains(float[][] mode) {
   float[] x_i = linspace(0,1,100);
   float[] y_i = linspace(0,1,100);
   int numGrains = 0;
   // Create each grain with a position according the mode vibration
   for (int i = 0; i < xcols; i++) {
     for (int j = 0; j < yrows; j++) {
       // Position of the grain on the table
       if(mode[i][j]<=-1.8){
          px[numGrains] = floor(x_i[i]*1000);
          py[numGrains] = floor(y_i[j]*1000);
          numGrains +=1;
         }
     } 
   }
   grains = new Grain[numGrains];
    for(int i=0; i<numGrains;i++)
    {
    float diameter = random(2,8);   
    grains[i] = new Grain(px[i],py[i], diameter);
    }
    return numGrains;
}
  
// Method to display the grains
void display_grains(int numGrains) {
  for (int i = 0; i < numGrains; i++) {
  noStroke();
  fill(255); // White color for the grains
  ellipse(grains[i].x, grains[i].y, grains[i].size, grains[i].size);   
  }
}
