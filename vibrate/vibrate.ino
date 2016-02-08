/*


 Plays tones on digital pins 6 (P1_4)


 http://arduino.cc/en/Tutorial/Tone4

 */
//int frequency = 31000; // 31kHz Ultrasound
int frequency = 9000;
void setup() {

}

void loop() {

  // play a note on pin 6 for 200 ms:
  tone(6, frequency, 200);
  delay(200);


}
