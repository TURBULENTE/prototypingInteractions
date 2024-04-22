/*---------------------------------------------------------------------------------------------

  Open Sound Control (OSC) library for the ESP8266/ESP32

  Example for sending messages from the ESP8266/ESP32 to a remote computer
  The example is sending "hello, osc." to the address "/test".

  This example code is in the public domain.

--------------------------------------------------------------------------------------------- */

/*
 OSC Library documentation: https://github.com/CNMAT/OSC/tree/master
 This example has been adapted by Citlali Hernández, for MDEF Class 2024, Barcelona.
*/


#if defined(ESP8266)
#include <ESP8266WiFi.h>
#else
#include <WiFi.h>
#endif
#include <WiFiUdp.h>
#include <OSCMessage.h>

const int sensorPin = 7;
float sensorValue;
float mapValue;


char ssid[] = "xxxx";              // your network SSID (name)
char pass[] = "xxxx";  // your network password

WiFiUDP Udp;  // A UDP instance to let us send and receive packets over UDP
//192.168.1.137
//const IPAddress outIp(10,40,10,105);        // remote IP of your computer
const IPAddress outIp(192, 168, 1, 147);
const unsigned int outPort = 9999;    // remote port to receive OSC ()
const unsigned int localPort = 8888;  // local port to listen for OSC packets (actually not used for sending)

void setup() {
  Serial.begin(115200);

  // Connect to WiFi network
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, pass);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");

  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  Serial.println("Starting UDP");
  Udp.begin(localPort);
  Serial.print("Local port: ");
#ifdef ESP32
  Serial.println(localPort);
#else
  Serial.println(Udp.localPort());
#endif
}

void loop() {

  presSensor();
  sendingOSC();
}


void sendingOSC() {
  OSCMessage msg("/test");  // The ID of the OSC Message
  // msg.add("hello, osc!"); // Test hello message
  msg.add(mapValue); // Send sensor value
  Udp.beginPacket(outIp, outPort);
  msg.send(Udp);
  Udp.endPacket();
  msg.empty();
  delay(150);  //500 works ok
}

void presSensor() {
  sensorValue = analogRead(sensorPin);
  mapValue = (map(sensorValue, 100, 4000, 0, 1000) / 1000.0);
  mapValue = constrain(mapValue, 0, 1);
  Serial.println(mapValue);
}
