// Include the library for the L293D shield
#include <AFMotor.h>
#include "Adafruit_VL53L0X.h"

Adafruit_VL53L0X lox = Adafruit_VL53L0X();
// Create motor objects for port 1 and port 2
// The '1' and '2' correspond to the M1 and M2 terminals on the shield
AF_DCMotor motor1(1);
AF_DCMotor motor2(2);

void setup() {
  Serial.begin(115200);

  // wait until serial port opens for native USB devices
  while (! Serial) {
    delay(1);
  }

  Serial.println("Adafruit VL53L0X test.");
  if (!lox.begin()) {
    Serial.println(F("Failed to boot VL53L0X"));
    while(1);
  }
  // power
  Serial.println(F("VL53L0X API Continuous Ranging example\n\n"));

  // start continuous ranging
  lox.startRangeContinuous();
  // Set the speed to half (Range is 0 to 255)
  motor1.setSpeed(250); 
  motor2.setSpeed(250);

  delay(3000);
  // Turn on motors in FORWARD direction
  motor1.run(FORWARD);
  motor2.run(FORWARD);
  
  // Keep them running for 2 seconds (2000 milliseconds)
  delay(2000);
  
  // Stop the motors
  motor1.run(RELEASE);
  motor2.run(RELEASE);

  delay(2000);

  motor1.run(BACKWARD);
  motor2.run(BACKWARD);

  delay(2000);

  motor1.run(RELEASE);
  motor2.run(RELEASE);
}
int distance = 100;
void loop() {
  
  if (lox.isRangeComplete()) {
    Serial.print("Distance in mm: ");
    Serial.println(lox.readRange());
    distance = lox.readRange();
  }
  if (distance > 10) {
    motor1.run(FORWARD);
    motor2.run(FORWARD);
    while(distance > 10) {
      if (lox.isRangeComplete()) {
        Serial.print("Distance in mm: ");
        Serial.println(lox.readRange());
        distance = lox.readRange();
      }
    }
    
  }

  motor1.run(RELEASE);
  motor2.run(RELEASE);

  delay(500);

  motor1.run(BACKWARD);
  motor2.run(BACKWARD);

  delay(1000);

  motor1.run(FORWARD);
  motor2.run(BACKWARD);

  delay(1000);

  motor1.run(RELEASE);
  motor2.run(RELEASE);

  delay(500);

}