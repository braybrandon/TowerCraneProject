#include <SoftwareSerial.h>
#include <Servo.h>
#include <Stepper.h>

#define LED_PIN 13



Servo myServo;
Stepper stepper(200, 2, 3, 4, 5);

int pos = 90;
// Connect HM10      Arduino Uno
//     Pin 1/TXD          Pin 7
//     Pin 2/RXD          Pin 8
//Bluetooth initialization
SoftwareSerial mySerial(7, 8); // RX, TX  

void setup() {  
  // Sets the frequency for the serial port and bluetooth port
  Serial.begin(9600);
  mySerial.begin(9600);

  //ataches input 9 to the servo and centers the servo at 90 degress
  myServo.attach(9);
  myServo.write(90);

  //sets the stepper motor speed to 200
  stepper.setSpeed(200);

  //assigns pin 10 to be an output pin and sets it to high
  pinMode(10, OUTPUT);
  digitalWrite(10, HIGH);

  //initializes the stepper motor to turn it on
  stepper.step(100);
}

//function that pauses the automation function until the user inputs a value other than 55
void pause(uint8_t& c) {

  while(c == 55){
    checkInput(c);
  }

}

//Checks the user input
void checkInput(uint8_t& c) {

  if (mySerial.available()) {
    c = mySerial.read();
  }
  
}

//function that checks to see if the finalPos is greater than initial position if so rotates left else it rotates the crane right
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

//fucntion that lowers the crane by the number of units by the parameter limit. while its lowering the function checks to see if the user inputs to pause the automation
void lowerCrane(int limit) {

  uint8_t c;
  
  for (int i = 0; i < limit; i += 5) 
  {
    checkInput(c);
    pause(c);
    stepper.step(5);
  }
}

//fucntion that raises the crane by the number of units by the parameter limit. while its lowering the function checks to see if the user inputs to pause the automation

void raiseCrane(int limit) {

  uint8_t c;
  
  for (int i = 0; i > limit; i -= 5)
  {
    checkInput(c);
    pause(c);
    stepper.step(-5);
  }
}

//function that runs the automation of the crane first rotating the crane right, lowering the magnet, turns the magnet on, raises the magnet, rotates crane left
// lowers magnet, turns magnet off, raises magnet
void runAutomation() {
  
  mySerial.write("R");
  Serial.println("begin");
  rotateServo(90, 0);
  delay(50);
  
  mySerial.write("D");
  stepper.step(-9600);
  delay(50);
  
  mySerial.write("M");
  digitalWrite(10, LOW);
  delay(50);
  
  mySerial.write("U");
  stepper.step(9600);
  delay(50);
  
  mySerial.write("L");
  rotateServo(0, 90);
  delay(50);

  
  mySerial.write("D");
  stepper.step(-9600);
  delay(50);

  mySerial.write("hello");
  digitalWrite(10, HIGH);
  delay(50);

  mySerial.write("U");
  stepper.step(9600);
  delay(50);
  
  mySerial.write("C");
}

//main loop function
void loop() {  

  uint8_t c;

//checks for user input from bluetooth device
 if (mySerial.available()) {
  c = mySerial.read();
  
  Serial.println("Got input:");
  Serial.println(c);
  
  switch (c) {
    //if user input 48 rotates crane left
  case 48:
    if (pos < 180) {
      rotateServo(pos, pos + 5);
      pos += 5;
    }
    break;
//if user input is 49 rotates crane right
  case 49:
     if (pos > 0) {
      rotateServo(pos, pos - 5);
      pos -= 5;
     }
     break;
     //if user input is 50 lowers the magnet
  case 50:
    stepper.step(1000);
    delay(100);
    break;
    //if user input is 51 raises the magnet
  case 51:
    stepper.step(-1000);
    delay(100);
    break;
    //if user input is 52 turns on the magnet
  case 52:
    digitalWrite(10, LOW);
    break;
    //if user input is 53 turns magnet off
  case 53:
    digitalWrite(10, HIGH);
    break;
    //if user input is 54 runs automation
  case 54:
    runAutomation();
    break;
  }
 }
}
