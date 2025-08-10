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
/* Modifications for generic motor driver
by: Drew Tyre & Sasha Tenhumberg
July-August 2025
*/
char inputBuffer[32]; //save enough space for the message
int _index = 0;
bool  cmdPending   = false;
unsigned long startMs, durationMs;
int dirA, spdA, dirB, spdB;

// Clockwise and counter-clockwise definitions.
// Depending on how you wired your motors, you may need to swap.
#define FORWARD  1
#define REVERSE 0

// Motor definitions to make life easier:
#define MOTOR_A 0
#define MOTOR_B 1

// Pin Assignments //
//Default pins:
#define FORA 2 // Direction control for motor A
#define REVA 4 // Direction control for motor A
#define PWMA 3  // PWM control (speed) for motor A
#define FORB 7 // Direction control for motor B
#define REVB 8 // Direction control for motor B
#define PWMB 9 // PWM control (speed) for motor B


void setup()
{
  setupArdumoto(); // Set all pins as outputs
  Serial.begin(115200);
}

void loop()
{
  int A, B, t;

  // 1. check for new command
  while (Serial.available()) {
    char c = Serial.read();
    if (c == '\n') {
      inputBuffer[_index] = '\0';
      if (sscanf(inputBuffer, "%d,%d,%d", &A,&B,&t) == 3) {
        dirA      = (A >= 0);  spdA = abs(A);
        dirB      = (B >= 0);  spdB = abs(B);
        durationMs = (unsigned long)t * 1000;
        startMs    = millis();
        cmdPending = true;

        driveArdumoto(MOTOR_A, dirA, spdA);
        driveArdumoto(MOTOR_B, dirB, spdB);
      }
      _index = 0;
    }
    else if (_index < sizeof(inputBuffer)-1) {
      inputBuffer[_index++] = c;
    } else {
      _index = 0;
    }
  }

  // 2. if a command is active and time’s up, stop motors
  if (cmdPending && (millis() - startMs >= durationMs)) {
    stopArdumoto(MOTOR_A);
    stopArdumoto(MOTOR_B);
    cmdPending = false;
    Serial.println("Motors stopped");
  }

  // …you can do other work here (sensor polling, comms, etc.)…

}

// driveArdumoto drives 'motor' in 'dir' direction at 'spd' speed
void driveArdumoto(byte motor, byte dir, byte spd)
{
  if (motor == MOTOR_A)
  {
    if (dir == FORWARD)
    {
      digitalWrite(FORA, HIGH);
      digitalWrite(REVA, LOW);
      analogWrite(PWMA, spd);
    }
    if (dir == REVERSE)
    {
      digitalWrite(FORA, LOW);
      digitalWrite(REVA, HIGH);
      analogWrite(PWMA, spd);
    }
  }
  else if (motor == MOTOR_B)
  {
    if (dir == FORWARD)
    {
      digitalWrite(FORB, HIGH);
      digitalWrite(REVB, LOW);
      analogWrite(PWMB, spd);
    }
    if (dir == REVERSE)
    {
      digitalWrite(FORB, LOW);
      digitalWrite(REVB, HIGH);
      analogWrite(PWMB, spd);
    }
  }  
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
  pinMode(PWMA, OUTPUT); 
  pinMode(PWMB, OUTPUT);
  pinMode(FORA, OUTPUT);
  pinMode(FORB, OUTPUT);
  pinMode(REVA, OUTPUT);
  pinMode(REVB, OUTPUT);

  // Initialize all pins as low:
  digitalWrite(PWMA, LOW);
  digitalWrite(PWMB, LOW);
  digitalWrite(FORA, LOW);
  digitalWrite(REVA, LOW);
  digitalWrite(FORB, LOW);
  digitalWrite(REVB, LOW);
}
