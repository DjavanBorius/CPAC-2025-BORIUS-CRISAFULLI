float compute_energy(float[] spectrum) {    
  
  float energy = 0;
  for(int i=0; i<bands; i++)
  {
    energy += pow(spectrum[i],2);
  }
  
  return energy;
}

float compute_sum_of_spectrum(float[] spectrum)
{
  
  float sum_of_s = 0;
  for(int i=0; i<bands; i++)
  {
    sum_of_s += spectrum[i];
  }
  
  return sum_of_s;
}

float compute_centroid(float[] spectrum, float sum_of_spectrum, float[] freqs){
  
  float centroid = 0;
  for(int i=0; i<bands; i++)
  {
    centroid += freqs[i]*spectrum[i]; 
  }
    
  return centroid/(sum_of_spectrum+0.00001);
}

float compute_spread(float[] spectrum, float sum_of_spectrum, float[] freqs, float centroid){
  
  float spread = 0;
  for(int i=0; i<bands; i++)
  {
    spread += pow(freqs[i]-centroid,2)*spectrum[i]; 
  }
  
  return spread/(sum_of_spectrum+0.00001);
}

float compute_entropy(float[] spectrum){
  
  float entropy = 0;
  for(int i=0; i<bands; i++)
  {
    entropy += abs(log(spectrum[i])*spectrum[i]); 
  }
  entropy = entropy/log(bands);
  return entropy;
}

float compute_flatness(float[] spectrum, float sum_of_s){
  
  float flatness = 0;
  for(int i=0; i<bands; i++)
  {
    flatness *= abs(spectrum[i]); 
  }
  
  return abs(bands*pow(flatness,1/bands)/(sum_of_s+0.00001));
}


float compute_drop(float[] spectrum, float sum_of_s){
  
  float drop = 0;
  for(int i=0; i<bands/4; i++)
  {
    drop += pow(spectrum[i],2); 
  }

  return abs(drop/(sum_of_s+0.00001));
}

class AgentFeature { 
  float[] spectrum = new float[bands];
  
  float[] freqs = new float[bands];
  float sum_of_bands;
  float centroid;
  float spread;
  float energy;
  float entropy;
  float flatness;
  float drop;
  
  AgentFeature(float sampleRate){    
    this.spectrum = Spectrum;
    for(int i=0; i<bands; i++)
    {
      this.freqs[i] = i*sampleRate/(2*bands);
    }  
    this.centroid=0;
    this.spread=0;
    this.sum_of_bands = 0;
    this.entropy=0;
    this.energy=0;
    this.flatness=0;
    this.drop=0;
  }

  void reasoning(float[] Spectrum){
     this.spectrum = Spectrum;
     
     float sum_of_s = compute_sum_of_spectrum(this.spectrum);
     float energy = compute_energy(this.spectrum);
     float centroid = compute_centroid(this.spectrum, sum_of_s, this.freqs);
     float flatness = compute_flatness(this.spectrum, sum_of_s);
     float spread = compute_spread(this.spectrum, sum_of_s, this.freqs, this.centroid);                                  
     float entropy = compute_entropy(this.spectrum);     
     float drop = compute_drop(this.spectrum, sum_of_s);
     //println("energy : " + energy*100 + " drop : " + drop*100 + " entropy : " + entropy);
     
     this.energy = energy;
     this.centroid = centroid;    
     this.flatness = flatness;
     this.spread = spread;
     this.entropy = entropy;
     this.drop = drop;}   
} 
