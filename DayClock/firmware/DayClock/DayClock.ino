#include <MCP79412RTC.h>
#include <Time.h>
#include <Wire.h>
#include <LedControl.h>
#include "chars.h"

//MCP79412RTC clock;
LedControl lc=LedControl(12,11,10,3);
boolean dst = false;

#define TICK 500      // amount of time in ms that the second : stays lit

/* we always wait a bit between updates of the display */
unsigned long delaytime=100;

void drawChar(int d, int c) {
  for (int row=0; row < MAXROW; row++) {
    lc.setRow(d, row, font[c*MAXROW+row]);
  }
}


void setup() {
  int devices=lc.getDeviceCount(); 
  //we have to init all devices in a loop
  for(int address=0;address<devices;address++) {
    /*The MAX72XX is in power-saving mode on startup*/
    lc.shutdown(address,false);
    /* Set the brightness to a medium values */
    lc.setIntensity(address, 6);
    /* and clear the display */
    lc.clearDisplay(address);
  }
  
  // Turn on RTC
  pinMode(16, OUTPUT);
  pinMode(17, OUTPUT);
  digitalWrite(17, HIGH);

  Serial.begin(9600);
  Serial.println("DayClock v1.0 Michael Shimniok www.bot-thoughts.com");
  while (1) {
    setSyncProvider(RTC.get);   //the function to get the time from the RTC
    Serial.print("RTC SYNC");
    if (timeStatus() == timeSet) break;
    Serial.println(" FAIL");   
    lc.setLed(2,0,0,true);
    delay(200);
    lc.setLed(2,0,0,false);
    delay(200);
  }
  Serial.println(" OK");    
  Serial.println();

}

int lastMin = -1;
int lastSec = -1;

void loop() {
  time_t time = now();

  if (isDST(time)) time += 3600; // add one hour

  int h = hour(time);
  int m = minute(time);

  readCommand();
    
  if (lastMin != minute(time)) {
    // Correct time for DST
    printTime(time);   
    Serial.println("Commands: set yyyy-mm-dd hh:mm:ss");
    lastMin = minute(time);
  }


  if (lastSec != second(time)) {

    if (second(time) > 20 && second(time) < 50) {
      drawDay(weekday(time));
      delay(TICK*4);
      drawMonth(month(time));
      delay(TICK*4);
      drawDate(day(time));
      delay(TICK*4);
    } else {
      drawClock(h, m, true);
      delay(TICK);
      drawClock(h, m, false);
    }
    lastSec = second(time);
    
  }
  delay(100);
}
