
// Cette fonction est appelée chaque fois qu'un message OSC est reçu
void oscEvent(OscMessage msg) {
  // Afficher l'adresse et les données du message OSC
  String addr = msg.addrPattern();
  //println(addr);
  if (addr.startsWith("/6")) {
    receive = 1;
    Message = msg;
    checkpush(msg);
  }
  if (msg.checkAddrPattern("/oscControl/gridToggle")) {
      receive = 1;
      Message = msg;
      println("Message reçu depuis: " + msg.addrPattern());
      println("Données: " + msg.get(0).floatValue());
  }
  if (msg.checkAddrPattern("/accelerometer") && (Message.get(0).floatValue()==4.0)) {   
    String senderAddr = msg.netAddress().address();
    print(senderAddr);
    float x = msg.get(1).floatValue();
    float y = msg.get(0).floatValue();
    float z = msg.get(2).floatValue();
    //println("x: " + msg.get(0).floatValue()+" y: " + msg.get(1).floatValue()+" z: " + msg.get(2).floatValue());
    //println("Message reçu depuis: " + msg.addrPattern());
    if (sqrt(pow(x,2)+pow(y,2)+pow(z,2))>13) {
      // Map OSC data to canvas size
      float mappedX = map(x, -20, 20, 0, width);
      float mappedY = 0;
      float newcolor;
      if(senderAddr.equals("192.168.43.1")) {
        newcolor = 150;
      }
      else {newcolor = 270;}
 
      if(abs(y)>abs(z)){
        mappedY = map(y, -20, 20, 0, height);
      }
      else { mappedY = map(z, -20, 20, 0, height);}
      // Create and add a new splatter
      splatters.add(new Splat(mappedX, mappedY,newcolor));
    }
  }
}

void checkpush(OscMessage msg)
{
  if(msg.checkAddrPattern("/6/push1") && msg.get(0).floatValue()!=0.0){
    message = 1.0;
    println("Message reçu depuis: " + msg.addrPattern());
    println("Données: " + msg.get(0).floatValue());
  }
  if(msg.checkAddrPattern("/6/push2") && msg.get(0).floatValue()!=0.0){
    message = 2.0;
    println("Message reçu depuis: " + msg.addrPattern());
    println("Données: " + msg.get(0).floatValue());
  }if(msg.checkAddrPattern("/6/push3") && msg.get(0).floatValue()!=0.0){
    message = 3.0;
    println("Message reçu depuis: " + msg.addrPattern());
    println("Données: " + msg.get(0).floatValue());
  }if(msg.checkAddrPattern("/6/push4") && msg.get(0).floatValue()!=0.0){
    message = 4.0;
    println("Message reçu depuis: " + msg.addrPattern());
    println("Données: " + msg.get(0).floatValue());
  }if(msg.checkAddrPattern("/6/push5") && msg.get(0).floatValue()!=0.0){
    message = 5.0;
    println("Message reçu depuis: " + msg.addrPattern());
    println("Données: " + msg.get(0).floatValue());
  }
}

//sending message to touchDesigner
void SendMessage(float energy, float entropy, float drop) {
  OscMessage msg = new OscMessage("/musicvalues"); // Adresse OSC
  msg.add(energy*10); // Add the value of the energy to the message
  msg.add(entropy); //
  msg.add(drop*100);
  println("energy : " + feat.energy*100 + " drop : " + feat.drop*100 + " entropy : " + feat.entropy);
  if(feat.drop*100<17&&looper==0){ 
      msg.add(290);
      looper =0;
  } else if (looper>0) { 
      msg.add(35);
      looper -= 1;
  } else {
      msg.add(35);
      looper = 200;
  }
  //println(msg.get(0).intValue());
  oscP5.send(msg, touchDesignerAddress); // Envoyer le message  
}
