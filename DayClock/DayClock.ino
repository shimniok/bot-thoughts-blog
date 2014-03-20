#include <MCP79412RTC.h>
#include <Time.h>
#include <Wire.h>
#include <LedControl.h>

//MCP79412RTC clock;
LedControl lc=LedControl(12,11,10,3);
boolean dst = false;

#define MAXROW 8      // maximum number of LED rows

#define TICK 500      // amount of time in ms that the second : stays lit

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

                          B00000100, // 1
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                                                     
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

                          B01001110, // 10
                          B11011111,
                          B11011011,
                          B11011011,
                          B11011011,
                          B11011011,
                          B11011111,
                          B11001110,
                          
                          B00010001, // 11
                          B00110011,
                          B00110011,
                          B00110011,
                          B00110011,
                          B00110011,
                          B00110011,
                          B00110011,
                          
                          B01001110, // 12
                          B11011111,
                          B11000011,
                          B11000111,
                          B11001110,
                          B11011000,
                          B11011111,
                          B11011111, 
  
                          B00011100, // A
                          B00111110,
                          B00110110,
                          B01100011,
                          B01111111,
                          B01111111,
                          B01100011,
                          B01100011,

                          B01111100, // D
                          B01111110,
                          B01100111,
                          B01100011,
                          B01100011,
                          B01100011,
                          B01111111,
                          B01111110,
                          
                          B00111111, // E
                          B01111110,
                          B01100000,
                          B01111110,
                          B01111110,
                          B01100000,
                          B01111110,
                          B00111111,
                        
                          B00111111, // F
                          B01111110,
                          B01100000,
                          B01111110,
                          B01111100,
                          B01100000,
                          B01100000,
                          B01100000,

                          B00100001, // H
                          B01100011,
                          B01100011,
                          B01100011,
                          B01111111,
                          B01111111,
                          B01100011,
                          B01100011,
                          
                          B00111111, // I
                          B01111111,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00111111,
                          B01111111,                            
                          
                          B01000001, // M
                          B01100011,
                          B01110111,
                          B01111111,
                          B01101011,
                          B01100011,
                          B01100011,
                          B01100011,
                          
                          B01100001, // N
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

                          B00111110, // R
                          B01111111,
                          B01100011,
                          B01100011,
                          B01111110,
                          B01111100,
                          B01100110,
                          B01100011,
                        
                          B00111111, // S
                          B01111110,
                          B01100000,
                          B01111110,
                          B00111111,
                          B00000011,
                          B00111111,
                          B01111110,
                                                     
                          B00111111, // T
                          B01111111,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                          B00001100,
                        
                          B00100001, // U
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
                          B01101011,
                          B01111111,
                          B01110111,
                          B01100011,
                          B01000001,
                         
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
  
  // Turn on RTC
  DDRC |= (1<<PC3)|(1<<PC2);
  PORTC |= (1<<PC3);

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
    
  if (hour > 12) // PM in 24-hour time
    hour -= 12;
  
  if (hour == 0) // midnight
    hour = 12;

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

int lastMin = -1;
int lastSec = -1;

/* isDST
 * 
 * Based on USA DST observation as of 2013, starts
 * 2nd Sunday of March, 2:00am, stops 1st Sunday of
 * November, 2:00am.
 */
boolean isDST(time_t t) {
  boolean dst = false;
  int mo = month(t);
  int d = day(t);
  int xday = day(t)-weekday(t); 
  
  if (mo > 3 && mo < 11) {
    dst = true;
  } else if (mo == 3) {
    if (xday >= 7) {
      dst = true;
    } else if (xday >= 0) {
      if (weekday(t) > 1) {
        dst = true;
      } else if (hour(t) >= 2) {
        dst = true;
      }
    }
  } else if (mo == 11) {
    
    if (xday >= 14) {
      dst = true;
    } else if (xday >= 7) {
      if (weekday(t) > 1) {
        dst = true;
      } else if (hour(t) >= 2) {
        dst = true;
      }
    }
  }
  
  return dst;
}

void flushInput(void)
{
    do {
        delay(2);
        Serial.read();
    } while (Serial.available() > 0);
}

//Read command from the Arduino serial monitor to set the RTC.
//Case-sensitive and must be entered exactly as (24-hour clock):
//  Set yyyy-mm-dd hh:mm:ss
void readCommand()
{
    char cmd[24] = "Set yyyy-mm-dd hh:mm:ss";
    static int i;
    tmElements_t tmSet;
    time_t tSet;

    if (Serial.available() >= 23) {              //enough characters for the whole command?
        i = 0;                                   //yes, read the available characters
        while (Serial.available() > 0) {
            if (i >= sizeof(cmd) - 1) {          //more than we can enjoy
                flushInput();                    //clear out the input buffer
                Serial.print("Too long: ");
                Serial.println(cmd);
                return;
            }
            delay(2);                            //let the next character trickle in
            cmd[i++] = char(Serial.read());
        }
        cmd[i] = 0;                              //put in string terminator

        if (strncmp(cmd, "Set ", 4) == 0) {
            tmSet.Year = 1000 * (cmd[4] - '0') + 100 * (cmd[5] - '0') + 10 * (cmd[6] - '0') + cmd[7] - '0' - 1970;
            tmSet.Month = 10 * (cmd[9] - '0') + cmd[10] - '0';
            tmSet.Day = 10 * (cmd[12] - '0') + cmd[13] - '0';
            tmSet.Hour = 10 * (cmd[15] - '0') + cmd[16] - '0';
            tmSet.Minute = 10 * (cmd[18] - '0') + cmd[19] - '0';
            tmSet.Second = 10 * (cmd[21] - '0') + cmd[22] - '0';
            tSet = makeTime(tmSet);		 //convert to time_t
            // Correct for DST
            if (isDST(tSet)) {
              tmSet.Hour -= 1;
              tSet = makeTime(tmSet);		 //convert to time_t
            }
            setTime(tSet);			 //set the system time
            RTC.set(now());		         //set the rtc
            Serial.println("RTC set!");
            flushInput();                        //discard any extraneous trailing characters
        }
        else {
            Serial.print("Unknown: ");
            Serial.println(cmd);
        }
    }
}


//Print an integer in "00" format (with leading zero),
//followed by a delimiter.
//Input value assumed to be between 0 and 99.
void printI00(int val, char delim)
{
    if (val < 10) Serial.print('0');
    Serial.print(val);
    Serial.print(delim);
    return;
}

//Print time (and date) given a time_t value
void printTime(time_t t)
{
    int h = hour(t);
    if (isDST(t))
      h += 1;
    printI00(h, ':');
    printI00(minute(t), ':');
    printI00(second(t), ' ');
    Serial.print(dayShortStr(weekday(t)));
    Serial.print(' ');
    printI00(day(t), ' ');
    Serial.print(monthShortStr(month(t)));
    Serial.print(' ');
    Serial.println(year(t));
}

void loop() {
  time_t time = now();
  int h = hour(time);
  int m = minute(time);

  // Correct time for DST
  if (isDST(time)) {
    h += 1;
  }

  readCommand();
    
  if (lastMin != minute(time)) {
    printTime(time);   
    Serial.println("To set the time: Set yyyy-mm-dd hh:mm:ss");
    lastMin = minute(time);
  }

  if (lastSec != second(time)) {
    if (20 <= second(time) && second(time) < 40) {
      drawDay(weekday(time));
    } else {
      drawClock(h, m, true);
      delay(TICK);
      drawClock(h, m, false);
    }
    lastSec = second(time);

  }
  delay(100);
}
