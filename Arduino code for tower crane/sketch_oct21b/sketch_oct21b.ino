#include <SoftwareSerial.h>

#define LED_PIN 13



SoftwareSerial mySerial(7, 8); // RX, TX  

// Connect HM10      Arduino Uno

//     Pin 1/TXD          Pin 7

//     Pin 2/RXD          Pin 8



void setup() {  

  Serial.begin(9600);
  mySerial.begin(9600);

  // If the baudrate of the HM-10 module has been updated,

  // you may need to change 9600 by another value

  // Once you have found the correct baudrate,

  // you can update it using AT+BAUDx command 

  // e.g. AT+BAUD0 for 9600 bauds

  mySerial.begin(9600);
  pinMode(13, OUTPUT);
 // digitalWrite(13, HIGH);

}



void loop() {  

  uint8_t c;

  

  if (mySerial.available()) {

    c = mySerial.read();  

    Serial.println("Got input:");
    Serial.print(c);
    if (c == 48)
    

    {

      // Non-zero input means "turn on LED".

      Serial.println("off");

      digitalWrite(LED_PIN, LOW);

    }

    else if (c == 49)

    {

      // Input value zero means "turn off LED".

      Serial.println("on");

      digitalWrite(LED_PIN, HIGH);

    }
    else
    {
      Serial.println("begin");
      Serial.println("end");
      delay(10000);
      mySerial.write("hello");
    }
      

  }

}
