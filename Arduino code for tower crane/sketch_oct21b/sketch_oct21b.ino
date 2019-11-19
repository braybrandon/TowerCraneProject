#include <SoftwareSerial.h>
#include <Servo.h>
#include <Stepper.h>

#define LED_PIN 13

Servo myServo;
Stepper stepper(200, 2, 3, 4, 5);

// Connect HM10      Arduino Uno
//     Pin 1/TXD          Pin 7
//     Pin 2/RXD          Pin 8
//Bluetooth initialization
SoftwareSerial mySerial(7, 8); // RX, TX  

void setup() {  

  Serial.begin(9600);
  mySerial.begin(9600);
  myServo.attach(9);
  myServo.write(90);
  stepper.setSpeed(60);
  pinMode(10, OUTPUT);
  digitalWrite(10, HIGH);
  stepper.step(200);
}

void rotateServo(int initialPos, int finalPos) {
  if (initialPos > finalPos) {
    for (int i = initialPos; i > finalPos ; i--)
    {
      myServo.write(i);
      delay(50);
    }
  }
  else
  {
     for (int i = initialPos; i < finalPos ; i++)
    {
      myServo.write(i);
      delay(50);
    }
  }
}

void loop() {  

  uint8_t c;
  
  if (mySerial.available()) {

    c = mySerial.read();  

    Serial.println("Got input:");
    Serial.println(c);
    switch (c) {
    case 48:
      rotateServo(90, 180);
      rotateServo(180, 90);
      break;

    case 49:
       rotateServo(90, 0);
       rotateServo(0, 90);
       break;
    case 50:
      stepper.step(24000);
      delay(100);
      break;
    case 51:
      stepper.step(-24000);
      delay(100);
      break;
    case 52:
      digitalWrite(10, HIGH);
      break;
    case 53:
      digitalWrite(10, LOW);
      break;
    default:
      mySerial.write("R");
      Serial.println("begin");
      rotateServo(90, 0);
      delay(50);
      mySerial.write("D");
      stepper.step(1048);
      delay(50);
      mySerial.write("M");
      digitalWrite(10, HIGH);
      delay(50);
      mySerial.write("U");
      stepper.step(-1048);
      delay(50);
      mySerial.write("L");
      rotateServo(0, 90);
      delay(50);
      mySerial.write("D");
      stepper.step(1048);
      delay(50);
      mySerial.write("hello");
      digitalWrite(10, LOW);
      Serial.println("end");
      delay(50);
      mySerial.write("C");
      break;
    }
      

  }

}
