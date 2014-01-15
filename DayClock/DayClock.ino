#include <MCP79412RTC.h>
#include <Time.h>
#include <Wire.h>
#include <LedControl.h>

//MCP79412RTC clock;
LedControl lc=LedControl(11,13,10,3);

#define MAXROW 8      // maximum number of LED rows

#define SUN 0
#define MON 1
#define TUE 2
#define WED 3
#define THU 4
#define FRI 5
#define SAT 6

#define LETTER_A     13
#define LETTER_D     14
#define LETTER_E     15
#define LETTER_F     16
#define LETTER_H     17
#define LETTER_I     18
#define LETTER_M     19
#define LETTER_N     20
#define LETTER_O     21
#define LETTER_R     22
#define LETTER_S     23
#define LETTER_T     24
#define LETTER_U     25
#define LETTER_W     26
#define LETTER_COLON 27

byte font[28*MAXROW] = {
                          B00001110, // 0
                          B00011111,
                          B00011011,
                          B00011011,
                          B00011011,
                          B00011011,
                          B00011111,
                          B00001110,

                          B00000011, // 1
                          B00000011,
                          B00000011,
                          B00000011,
                          B00000011,
                          B00000011,
                          B00000011,
                          B00000011,
                                                     
                          B00001110, // 2
                          B00011111,
                          B00000011,
                          B00000111,
                          B00001110,
                          B00011000,
                          B00011111,
                          B00011111,

                          B00011111, // 3
                          B00011111,
                          B00000110,
                          B00001100,
                          B00011110,
                          B00000011,
                          B00011111,
                          B00011110,

                          B00000011, // 4
                          B00001011,
                          B00011011,
                          B00011111,
                          B00011111,
                          B00000011,
                          B00000011,
                          B00000011,
                          
                          B00011111, // 5
                          B00011111,
                          B00011000,
                          B00011110,
                          B00011111,
                          B00000011,
                          B00011111,
                          B00011110,
                          
                          B00000110, // 6
                          B00001100,
                          B00011000,
                          B00011110,
                          B00011111,
                          B00011011,
                          B00011111,
                          B00001110,
                          
                          B00011111, // 7
                          B00011111,
                          B00000011,
                          B00000110,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                          
                          B00001110, // 8
                          B00011111,
                          B00011011,
                          B00001110,
                          B00011111,
                          B00011011,
                          B00011111,
                          B00001110,
                          
                          B00001110, // 9
                          B00011111,
                          B00011011,
                          B00011111,
                          B00001111,
                          B00000011,
                          B00000110,
                          B00001100,

                          B11001110, // 10
                          B11011111,
                          B11011011,
                          B11011011,
                          B11011011,
                          B11011011,
                          B11011111,
                          B11001110,
                          
                          B00011011, // 11
                          B00011011,
                          B00011011,
                          B00011011,
                          B00011011,
                          B00011011,
                          B00011011,
                          B00011011,
                          
                          B11001110, // 12
                          B11011111,
                          B11000011,
                          B11000111,
                          B11001100,
                          B11011000,
                          B11011111,
                          B11011111, 
  
                          B00011100, // A
                          B00111110,
                          B01100011,
                          B01100011,
                          B01111111,
                          B01111111,
                          B01100011,
                          B01100011,

                          B01111100, // D
                          B01111110,
                          B01100011,
                          B01100011,
                          B01100011,
                          B01100011,
                          B01111111,
                          B01111110,
                          
                          B01111111, // E
                          B01111111,
                          B01100000,
                          B01111110,
                          B01111110,
                          B01100000,
                          B01111111,
                          B01111111,
                        
                          B01111111, // F
                          B01111111,
                          B01100000,
                          B01111110,
                          B01111110,
                          B01100000,
                          B01100000,
                          B01100000,

                          B01100011, // H
                          B01100011,
                          B01100011,
                          B01111111,
                          B01111111,
                          B01100011,
                          B01100011,
                          B01100011,
                          
                          B01111110, // I
                          B01111110,
                          B00011000,
                          B00011000,
                          B00011000,
                          B00011000,
                          B01111110,
                          B01111110,                            
                          
                          B01100011, // M
                          B01110111,
                          B01111111,
                          B01101011,
                          B01100011,
                          B01100011,
                          B01100011,
                          B01100011,
                          
                          B01100011, // N
                          B01110011,
                          B01110011,
                          B01111011,
                          B01101111,
                          B01101111,
                          B01100111,
                          B01100011,
                          
                          B00011100, // O
                          B00111110,
                          B01100011,
                          B01100011,
                          B01100011,                            
                          B01100011,
                          B00111110,
                          B00011100, 

                          B01111110, // R
                          B01111111,
                          B01100011,
                          B01100011,
                          B01111110,
                          B01111100,
                          B01100110,
                          B01100011,
                        
                          B00111110, // S
                          B01111111,
                          B01100000,
                          B01111110,
                          B00111111,
                          B00000011,
                          B01111111,
                          B00111110,
                                                     
                          B01111110, // T
                          B01111110,
                          B00011000,
                          B00011000,
                          B00011000,
                          B00011000,
                          B00011000,
                          B00011000,
                        
                          B01100011, // U
                          B01100011,
                          B01100011,
                          B01100011,
                          B01100011,
                          B01100011,
                          B01111111,
                          B00111110,                         
                        
                          B01100011, // W
                          B01100011,
                          B01100011,
                          B01100011,
                          B01101011,
                          B01111111,
                          B01110111,
                          B01100011,
                         
                          B00000000, // :
                          B00000000,
                          B00000000,
                          B01000000,
                          B00000000,
                          B01000000,
                          B00000000,
                          B00000000                          
                       };

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

  Serial.begin(9600);
  while (1) {
    setSyncProvider(RTC.get);   //the function to get the time from the RTC
    Serial.print("RTC SYNC");
    if (timeStatus() == timeSet) break;
    Serial.print(" FAIL");   
    lc.setLed(2,0,0,true);
    delay(200);
    lc.setLed(2,0,0,false);
    delay(200);
  }
  Serial.println();
}

void drawDay(int day) {
  
  switch (day-1) {
    case MON :
      drawChar(0, LETTER_N);
      drawChar(1, LETTER_O);
      drawChar(2, LETTER_M);
      break;
    case TUE :
      drawChar(0, LETTER_E);
      drawChar(1, LETTER_U);
      drawChar(2, LETTER_T);
      break;
    case WED :
      drawChar(0, LETTER_D);
      drawChar(1, LETTER_E);
      drawChar(2, LETTER_W);
      break;
    case THU :
      drawChar(0, LETTER_U);
      drawChar(1, LETTER_H);
      drawChar(2, LETTER_T);
      break;
    case FRI :
      drawChar(0, LETTER_I);
      drawChar(1, LETTER_R);
      drawChar(2, LETTER_F);
      break;
    case SAT :
      drawChar(0, LETTER_T);
      drawChar(1, LETTER_A);
      drawChar(2, LETTER_S);
      break;
    case SUN :
      drawChar(0, LETTER_N);
      drawChar(1, LETTER_U);
      drawChar(2, LETTER_S);
      break;
  }
  
}

void drawClock(int hour, int minute, boolean showColon) {
  
  if (minute < 0 || minute > 59 || hour < 0 || hour > 23) 
    return;
    
  if (hour > 12) hour -= 12;

  byte *h0 = &font[MAXROW*hour];
  byte *m1 = &font[MAXROW*(minute/10)];
  byte *m0 = &font[MAXROW*(minute%10)];

  for (int row=0; row < MAXROW; row++) {
    lc.setRow(0, row, m0[row]<<2);
    if (showColon)
      lc.setRow(1, row, m1[row] | font[MAXROW*LETTER_COLON + row]);
    else 
      lc.setRow(1, row, m1[row]);
    lc.setRow(2, row, h0[row]);   
  }
}

int lastSec = -1;

void loop() {
  time_t time = now();

  if (lastSec != second(time)) {
    if (20 <= second(time) && second(time) < 30) {
      drawDay(weekday(time));
    } else {
      drawClock(hour(time), minute(time), (second(time)&1));
    }
    lastSec = second(time);
  }
  delay(100);
}
