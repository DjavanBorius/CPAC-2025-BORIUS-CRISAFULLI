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

// Définir une classe Grain pour représenter chaque petit grain
class Grain {
  float x, y; // Position du grain
  float size; // Taille du grain
  float speedX, speedY; // Vitesse du grain sur les axes X et Y
  
  // Constructeur de la classe Grain
  Grain(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    //Générer des vitesses aléatoires pour chaque grain
    this.speedX = random(-2, 2);
    this.speedY = random(-2, 2);
  }
}

Plate plate;
Grain[] grains; // Tableau pour stocker tous les grains
int numGrains=0; // Nombre de grains à générer
int xcols, yrows;
float[] x, y;
int[] px,py;
float F; //[Hz]

// Méthode pour mettre à jour la position du grain
int update_grains(float[][] mode) {
   float[] x_i = linspace(0,1,100);
   float[] y_i = linspace(0,1,100);
   int numGrains = 0;
   // Créer chaque grain avec une position en fonction du mode de vibration
   for (int i = 0; i < xcols; i++) {
     for (int j = 0; j < yrows; j++) {
       // Position des points sur le plateau
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
  
// Méthode pour dessiner le grain
void display_grains(int numGrains) {
  for (int i = 0; i < numGrains; i++) {
  noStroke();
  fill(255); // Couleur blanche pour les grains
  ellipse(grains[i].x, grains[i].y, grains[i].size, grains[i].size); // Dessiner un cercle à la position du grain*/  
  }
}
