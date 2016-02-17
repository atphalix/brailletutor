/** 
 * This file is part of the Braille Box Processing project
 *
 * Copyright (C) 2015 Ahmed Mansour <hamada@openmailbox.org>
 * 
 */

/**
 * Braille to pin mapping diagram:
 *PIN_1_0-o o-PIN_1_3
 *PIN_2_1-o o-PIN_1_4
 *PIN_2_2-o o-PIN_1_5
 *
 */

import rocketuc.processing.*;

// our instance of the ROCKETuC API
ROCKETuC r;
char letter='b';

/**
 * setup function called by processing on startup
 */
void setup() {  
  size(256, 256);
  // Create the font
  textFont(createFont("Georgia", 36));
  
  try {

    // connect to MCU
    r = new ROCKETuC(this, "/dev/ttyACM0");
    
    // configure digital output
    // PIN_1_1 and PIN_1_2 are reserved for serial UART!

    r.pinMode(ROCKETuC.PIN_1_0, ROCKETuC.OUTPUT);
    r.pinMode(ROCKETuC.PIN_2_1, ROCKETuC.OUTPUT);
    r.pinMode(ROCKETuC.PIN_2_2, ROCKETuC.OUTPUT);
    r.pinMode(ROCKETuC.PIN_1_3, ROCKETuC.OUTPUT);
    r.pinMode(ROCKETuC.PIN_1_4, ROCKETuC.OUTPUT);
    r.pinMode(ROCKETuC.PIN_1_5, ROCKETuC.OUTPUT);
    //r.digitalWrite(ROCKETuC.PIN_1_4, ROCKETuC.HIGH);
    
  }
  catch(Exception e) {
    // If something goes wrong while communication with the MCU
    // the catch block will be processed. Here the error handling
    // should be done. 
    println(e.getMessage());
	exit();
  }
}

void resetKey() {
   try {
    //turn off all pins before displaying letter
    r.digitalWrite(ROCKETuC.PIN_1_0, ROCKETuC.LOW);
    r.digitalWrite(ROCKETuC.PIN_2_1, ROCKETuC.LOW);
    r.digitalWrite(ROCKETuC.PIN_2_2, ROCKETuC.LOW);
    r.digitalWrite(ROCKETuC.PIN_1_3, ROCKETuC.LOW);
    r.digitalWrite(ROCKETuC.PIN_1_4, ROCKETuC.LOW);
    r.digitalWrite(ROCKETuC.PIN_1_5, ROCKETuC.LOW);
   }
    catch(Exception e) {
    // If something goes wrong while communication with the MCU
    // the catch block will be processed. Here the error handling
    // should be done. 
    println(e.getMessage());
  exit();
  }
}

void vibrateKey(char k) {
   try {
   switch (k) {
     case 'b' :
            // vibrate only pins that need to vibrate :-)
         r.digitalWrite(ROCKETuC.PIN_1_0, ROCKETuC.TOGGLE);
         r.digitalWrite(ROCKETuC.PIN_2_1, ROCKETuC.TOGGLE);
        // wait a little 
      delay(200);
            break;
     case 'c' :
            // vibrate only pins that need to vibrate :-)
         r.digitalWrite(ROCKETuC.PIN_1_0, ROCKETuC.TOGGLE);
         r.digitalWrite(ROCKETuC.PIN_1_3, ROCKETuC.TOGGLE);
        // wait a little 
      delay(200);
      break;
       default : 
       resetKey();
   }
   }
    catch(Exception e) {
    // If something goes wrong while communication with the MCU
    // the catch block will be processed. Here the error handling
    // should be done. 
    println(e.getMessage());
  exit();
  }
}

/**
 * draw is called cyclic from processing
 */
void draw() {
  try {
    background(0); // Set background to black

  // Draw the pressed keyboard letter to the center of the screen
  textSize(100);
  text(letter, 100, 128);
  }
  catch(Exception e) {
    // If something goes wrong while communication with the MCU
    // the catch block will be processed. Here the error handling
    // should be done. 
    println(e.getMessage());
	exit();
  }
  
}

void keyPressed() {
  // The variable "key" always contains the value 
  // of the most recent key pressed.
  if ((key >= 'A' && key <= 'z') || key == ' ') {
    letter = key;
    vibrateKey(letter);
    // Write the letter to the console for debugging
    println(key);
  }
}


