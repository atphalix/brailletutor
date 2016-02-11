/*
Copyright Ahmed Mansour 2016

 Turn on/off digital pins 6 (P1_4)
 Turn on/off digital pins 7 (P1_5)

 */

void setup() {
  // initialize the digital pin as an output.
  pinMode(6, OUTPUT); 
  // initialize the digital pin as an output.
  pinMode(7, OUTPUT); 
}

void loop() {

  digitalWrite(6, HIGH);
  digitalWrite(7, HIGH);
  delay(200);
  
  digitalWrite(6, LOW); 
  digitalWrite(7, LOW);
  delay(200);

}
