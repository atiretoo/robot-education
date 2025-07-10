    /* Ardumoto Example Sketch
  by: Jim Lindblom
  date: November 8, 2013
  license: Public domain. Please use, reuse, and modify this 
  sketch!

  Adapted to v20 hardware by: Marshall Taylor
  date: March 31, 2017

  Three useful functions are defined:
    setupArdumoto() -- Setup the Ardumoto Shield pins
    driveArdumoto([motor], [direction], [speed]) -- Drive [motor] 
      (0 for A, 1 for B) in [direction] (0 or 1) at a [speed]
      between 0 and 255. It will spin until told to stop.
    stopArdumoto([motor]) -- Stop driving [motor] (0 or 1).

  setupArdumoto() is called in the setup().
  The loop() demonstrates use of the motor driving functions.
*/

// Clockwise and counter-clockwise definitions.
// Depending on how you wired your motors, you may need to swap.
#define FORWARD  0
#define REVERSE 1
#define LEFT 2
#define RIGHT 3

// Motor definitions to make life easier:
#define MOTOR_A 0
#define MOTOR_B 1

// Pin Assignments //
//Default pins:
#define INONE 2 // Direction control for motor A
#define INTWO 3  // PWM control (speed) for motor A
#define INTHREE 4 // Direction control for motor B
#define INFOUR 11 // PWM control (speed) for motor B
int i = 0;
////Alternate pins:
//#define INONE 8 // Direction control for motor A
//#define INTWO 9 // PWM control (speed) for motor A
//#define INTHREE 7 // Direction control for motor B
//#define INFOUR 10 // PWM control (speed) for motor B


void setup()
{
  setupArdumoto(); // Set all pins as outputs
  delay(2000);
}

void loop()
{
  // // Drive motor A (and only motor A) at various speeds, then stop.
  // driveArdumoto(MOTOR_A, REVERSE, 255); // Set motor A to REVERSE at max
  // delay(1000);  // Motor A will spin as set for 1 second
  // driveArdumoto(MOTOR_A, FORWARD, 127);  // Set motor A to FORWARD at half
  // delay(1000);  // Motor A will keep trucking for 1 second 
  // stopArdumoto(MOTOR_A);  // STOP motor A 


/****** MOTOR REFERENCE *******/



  // digitalWrite(INTHREE, 0);
  // analogWrite(INFOUR, 200);
  // delay(1000);
  // digitalWrite(INTHREE, 0);
  // analogWrite(INFOUR, 0);
  
  if (i < 1)
  {
  
  drive(FORWARD, 255);
  delay(3530);
  fullStop();

  spotTurn(RIGHT);
  // delay(475); // Roughly 90 degrees
  delay(950);
  fullStop();

  drive(FORWARD, 255);
  delay(3530);
  fullStop();

  spotTurn(LEFT);
  delay(950);
  fullStop();
  i++;
  }

  // delay(1000);



  // // Drive motor B (and only motor B) at various speeds, then stop.
  // driveArdumoto(MOTOR_B, REVERSE, 255); // Set motor B to REVERSE at max
  // delay(1000);  // Motor B will spin as set for 1 second
  // driveArdumoto(MOTOR_B, FORWARD, 127);  // Set motor B to FORWARD at half
  // delay(1000);  // Motor B will keep trucking for 1 second
  // stopArdumoto(MOTOR_B);  // STOP motor B 

  // Drive both
  // driveArdumoto(MOTOR_A, FORWARD, 200);  // Motor A at 80% speed?
  // driveArdumoto(MOTOR_B, FORWARD, 200);  // Motor B at 80% speed?
  // delay(3000);  // Drive forward for three seconds
  // stopArdumoto(MOTOR_A);  // STOP motor A 
  // stopArdumoto(MOTOR_B);  // STOP motor B 

  // // Now spin in place!
  // driveArdumoto(MOTOR_A, FORWARD, 255);  // Motor A at max speed.
  // driveArdumoto(MOTOR_B, REVERSE, 255);  // Motor B at max speed.
  // delay(2000);  // spin for two seconds
  // stopArdumoto(MOTOR_A);  // STOP motor A 
  // stopArdumoto(MOTOR_B);  // STOP motor B 

  //   // Now spin in place but slower and in the opposite direction!
  // driveArdumoto(MOTOR_A, REVERSE, 127);  // Motor A at half speed?
  // driveArdumoto(MOTOR_B, FORWARD, 127);  // Motor B at half speed?
  // delay(4000);  // spin for four seconds
  // stopArdumoto(MOTOR_A);  // STOP motor A 
  // stopArdumoto(MOTOR_B);  // STOP motor B 

  // driveArdumoto(MOTOR_A, FORWARD, 127);  // Motor A at half speed?
  // driveArdumoto(MOTOR_B, REVERSE, 127);  // Motor B at half speed?
  // delay(2000);  // spin for two seconds
  // stopArdumoto(MOTOR_A);  // STOP motor A 
  // stopArdumoto(MOTOR_B);  // STOP motor B 

  //   // Drive back
  // driveArdumoto(MOTOR_A, FORWARD, 200);  // Motor A at 80% speed?
  // driveArdumoto(MOTOR_B, FORWARD, 200);  // Motor B at 80% speed?
  // delay(3000);  // Drive forward for three seconds

  // driveArdumoto(MOTOR_B, REVERSE, 255);
  // driveArdumoto(MOTOR_A, FORWARD, 255);
  // delay(3000);
  // stopArdumoto(MOTOR_A);
  // stopArdumoto(MOTOR_B);
  // stopArdumoto(MOTOR_B);
  delay(1000);
  // driveArdumoto(MOTOR_B, REVERSE, 127);
  // delay(3000);
  // stopArdumoto(MOTOR_B);
  // delay(1000);
  // driveArdumoto(MOTOR_B, REVERSE, 255);
  // delay(3000);
  // stopArdumoto(MOTOR_B);
  // delay(1000);
}

// driveArdumoto drives 'motor' in 'dir' direction at 'spd' speed
void driveArdumoto(byte motor, byte dir, byte spd)
{
  /***REFERENCE***/
  /*MOTOR B full power FORWARD
  digitalWrite(INTHREE, 0);
  analogWrite(INFOUR, 255);
  */
  /*MOTOR B full power REVERSE
  digitalWrite(INTHREE, 1);
  analogWrite(INFOUR, 0);
  */

  /*MOTOR A FORWARD
  digitalWrite(INONE, 0);
  analogWrite(INTWO, 255);
  */
  /*MOTOR A REVERSE
  digitalWrite(INONE, 1);
  analogWrite(INTWO, 0);
  */
  if (motor == MOTOR_A)
  {
    if (dir == FORWARD) 
    {
      digitalWrite(INONE, 0);
      analogWrite(INTWO, spd);
    }
    else if (dir == REVERSE) 
    {
      digitalWrite(INONE, 1);
      analogWrite(INTWO, spd);
    }
  }
  else if (motor == MOTOR_B)
  {
    if (dir == FORWARD) 
    {
      digitalWrite(INTHREE, 0);
      analogWrite(INFOUR, spd);
    }
    else if (dir == REVERSE) 
    {
      digitalWrite(INTHREE, 1);
      analogWrite(INFOUR , spd);
    }
  }  
}

void drive(byte dir, byte spd) 
{
  if (dir == REVERSE)
  {
    spd = 0;
  }
  driveArdumoto(MOTOR_A, dir, spd);
  driveArdumoto(MOTOR_B, dir, spd);
}

void spotTurn(byte dir)
{
  if (dir == LEFT)
  {
    driveArdumoto(MOTOR_A, REVERSE, 0);
    driveArdumoto(MOTOR_B, FORWARD, 255);
    
  } 
  if (dir == RIGHT)
  {
    driveArdumoto(MOTOR_A, FORWARD, 255);
    driveArdumoto(MOTOR_B, REVERSE, 0);
  }
}

void fullStop()
{
  stopArdumoto(MOTOR_A);
  stopArdumoto(MOTOR_B);
}

// stopArdumoto makes a motor stop
void stopArdumoto(byte motor)
{
  driveArdumoto(motor, 0, 0);
}

// setupArdumoto initialize all pins
void setupArdumoto()
{
  // All pins should be setup as outputs:
  pinMode(INTWO, OUTPUT); 
  pinMode(INFOUR, OUTPUT);
  pinMode(INONE, OUTPUT);
  pinMode(INTHREE, OUTPUT);

  // Initialize all pins as low:
  digitalWrite(INTWO, LOW);
  digitalWrite(INFOUR, LOW);
  digitalWrite(INONE, LOW);
  digitalWrite(INTHREE, LOW);
}
