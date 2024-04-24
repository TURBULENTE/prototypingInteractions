
/* Simple OSC Receiver
to understand tags and messages numeric types
 Example based on OSCp5 library,
 adapted by Citlali Hernández for MDEF Class 2024
 */


// IMPORTING OSC LIBRARIES
import oscP5.*;
import netP5.*;
OscP5 oscP5; // Create an Oscp5 object and name it  "oscP5";
NetAddress myRemoteLocation; // this variable keeps the IP of our computer


float [] data ; // array to keep data from osc messages


void setup() {
  size(600, 300); // the size of our canvas
  data = new float[1]; //Defining the number of items in our array


  // Initialize the osc library, adding the port
  oscP5 = new OscP5(this, 9999);

  /*myRemoteLocation needs two parameters,
   the IP of the computer where Processing is running,
   the port number to listen */
  myRemoteLocation = new NetAddress("192.168.8.193", 9999);
}


void draw() {

  background(0);
  info();
}
/*
 Incoming OSC messages require Processing to be read
 with the oscEvent function that is specific to the library.
 Therefore this function should always be called like this
 */
void oscEvent(OscMessage theOscMessage) {
  // Print the address pattern and the typetag of the received OscMessage
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());


  //Fill the array with the incoming messages
  if (theOscMessage.addrPattern().equals("/test")) { // indicate the ID of the messages
    data[0]=theOscMessage.get(0).floatValue(); //
    // when receiving more than one message we can continue filling the array, for example:
    //data[1]=theOscMessage.get(1).floatValue();
    //data[2]=theOscMessage.get(2).floatValue();
    println("Data= " );
    println("Data 0= " + data[0]);
    //println("Data 1= " + data[1]);
    //println("Data 2= " + data[2]);
  }
}

// A function to print in the canvas the incoming data from Wekinator
void info() {
  textSize(15);
  fill(255);
  textAlign(LEFT);
  text("Data 0= " + data[0], 20, height-50);
  //text("Data 1= " + data[1], 20, height-25);
  //text("Data 2= " + data[2], 20, height-0);
}
