/** 
 * This file is part of the BrailleBox Processing project
 *
 * Copyright (C) 2015 Ahmed Mansour <hamada@openmailbox.org>
 * 
 
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

/**
 * Braille to pin mapping diagram:
 *PIN_1_0-o o-PIN_1_3
 *PIN_2_1-o o-PIN_1_4
 *PIN_2_2-o o-PIN_1_5
 *
 */

import rocketuc.processing.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;

// our instance of the ROCKETuC API
ROCKETuC r;
char letter = 'b';
int wait = 200;

/**
 * setup function called by processing on startup
 */
void setup() {  
  size(256, 256);
  // Create the font
  textFont(createFont("Georgia", 36));
  
  try {

  minim = new Minim (this);

//  player = minim.loadFile ("11.wav");

  // if a file doesn't exist, loadSample will return null
 // if ( player == null ) println("Didn't find wav file!");

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
      delay(wait);
            break;
     case 'c' :
          
         r.digitalWrite(ROCKETuC.PIN_1_0, ROCKETuC.TOGGLE);
         r.digitalWrite(ROCKETuC.PIN_1_3, ROCKETuC.TOGGLE);
        
      delay(wait);
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
    //it's weird but you have to rewind a file to play it
  //  player.rewind();
 //   player.play ();
    // Write the letter to the console for debugging
    println(key);
  }
}

//stop is called when you hit stop on processing. Just leave this here
void stop()
{
//  player.close();
//  minim.stop();
  resetKey();
  super.stop();
}
