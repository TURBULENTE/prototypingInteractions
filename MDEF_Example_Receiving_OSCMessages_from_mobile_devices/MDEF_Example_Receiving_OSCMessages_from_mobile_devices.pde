
/* Receiving Body Movements using a Mobile Phone, and OSC Messages from Wekinator
 Input: Oientation from Mobile Phones  
 Output: The position of a rectangle changes
 
 This example uses:
 OSCP5 library by Andreas Schlegel
 https://sojamo.de/libraries/oscP5/
 
 Custom Wekinator trained model
 http://www.wekinator.org/ by Rebecca Fiebrink
 
 Sensor Apps:
 Android:
 1st- Download https://f-droid.org/
 2nd- Download Sensors2OSC app
 
 Apple:
 Zig Sim App
 Example by Citlali Hernández for MDEF Class 2024
 */


// IMPORTING OSC LIBRARIES
import oscP5.*;
import netP5.*;
OscP5 oscP5; // Create an Oscp5 object and name it  "oscP5";
NetAddress myRemoteLocation; // this variable keeps the IP of our computer


color miColor = color(0, 0, 0); // variable used as an output
float [] data ; // array to keep data from osc messages
float posy;


void setup() {
  size(600, 300); // the size of our canvas
  data = new float[3]; //Defining the number of items in our array


  // Initialize the osc library, adding the port
  oscP5 = new OscP5(this, 12000);

  /*myRemoteLocation needs two parameters,
   the IP of the computer where Processing is running,
   the port number to listen */
  myRemoteLocation = new NetAddress("192.168.8.193", 12000);
}


void draw() {

  background(0);
  info();


  if (data[0]<0.3) {
    posy=200;
  }
  if (data[0]>0.8 && (data[0]<1.3)) {
    posy=100;
  }
  if (data[0]>1.7 && (data[0]<2)) {
    posy=0;
  }

  noStroke();
  fill(255);
  rect(0, posy, width, height/3);
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
  if (theOscMessage.addrPattern().equals("/brazo")) { // indicate the ID of the messages
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






