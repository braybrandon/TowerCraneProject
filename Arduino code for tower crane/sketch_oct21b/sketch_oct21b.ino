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

void pause(uint8_t& c) {

  while(c == 55){
    checkInput(c);
  }

}

void checkInput(uint8_t& c) {

  if (mySerial.available()) {
    c = mySerial.read();
  }
  
}

void rotateServo(int initialPos, int finalPos) {
  
  uint8_t c;
  
  if (initialPos > finalPos) {
    for (int i = initialPos; i > finalPos ; i--)
    {
      checkInput(c);
      pause(c);
      myServo.write(i);
      delay(50);
    }
  }
  else
  {
     for (int i = initialPos; i < finalPos ; i++)
    {
      checkInput(c);
      pause(c);
      myServo.write(i);
      delay(50);
    }
  }
}

void lowerCrane(int limit) {

  uint8_t c;
  
  for (int i = 0; i < limit; i += 5) 
  {
    checkInput(c);
    pause(c);
    stepper.step(5);
  }
}

void raiseCrane(int limit) {

  uint8_t c;
  
  for (int i = 0; i > limit; i -= 5)
  {
    checkInput(c);
    pause(c);
    stepper.step(-5);
  }
}

void runAutomation() {
  
  mySerial.write("R");
  Serial.println("begin");
  rotateServo(90, 0);
  delay(50);
  
  mySerial.write("D");
  lowerCrane(1048);
  delay(50);
  
  mySerial.write("M");
  digitalWrite(10, HIGH);
  delay(50);
  
  mySerial.write("U");
  raiseCrane(-1048);
  delay(50);
  
  mySerial.write("L");
  rotateServo(0, 90);
  delay(50);
  
  mySerial.write("D");
  lowerCrane(1048);
  delay(50);
  
  mySerial.write("hello");
  digitalWrite(10, LOW);
  delay(50);
  
  mySerial.write("C");
}

void loop() {  

  uint8_t c;

  checkInput(c);
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
    
  case 54:
    runAutomation();
    break;
  }
    

}
