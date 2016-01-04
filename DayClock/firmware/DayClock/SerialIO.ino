
void flushInput(void)
{
    do {
        delay(2);
        Serial.read();
    } while (Serial.available() > 0);
}

// Read command from the Arduino serial monitor to set the RTC.
// Case-sensitive and must be entered exactly as (24-hour clock):
//  Set yyyy-mm-dd hh:mm:ss
void readCommand()
{
    char cmd[24] = "set yyyy-mm-dd hh:mm:ss";
    static int i;
    tmElements_t tmSet;
    time_t tSet;

    if (Serial.available() >= 23) {             // enough characters for the whole command?
        i = 0;                                   // yes, read the available characters
        while (Serial.available() > 0) {
            if (i >= sizeof(cmd) - 1) {          // too many characters to fit in buffer
                flushInput();                    // clear out the input buffer
                Serial.print("Too long: ");
                Serial.println(cmd);
                return;
            }
            delay(2);                            //let the next character trickle in
            cmd[i++] = char(Serial.read());
        }
        cmd[i] = 0;                              //put in string terminator

        if (strncmp(cmd, "set ", 4) == 0) {
            tmSet.Year = 1000 * (cmd[4] - '0') + 100 * (cmd[5] - '0') + 10 * (cmd[6] - '0') + cmd[7] - '0' - 1970;
            tmSet.Month = 10 * (cmd[9] - '0') + cmd[10] - '0';
            tmSet.Day = 10 * (cmd[12] - '0') + cmd[13] - '0';
            tmSet.Hour = 10 * (cmd[15] - '0') + cmd[16] - '0';
            tmSet.Minute = 10 * (cmd[18] - '0') + cmd[19] - '0';
            tmSet.Second = 10 * (cmd[21] - '0') + cmd[22] - '0';
            tSet = makeTime(tmSet);		 //convert to time_t
            // Correct for DST
            if (isDST(month(tSet), day(tSet), weekday(tSet), hour(tSet))) {
              tSet -= 3600;       // subtract an hour
            }
            setTime(tSet);			 //set the system time
            RTC.set(tSet);		         //set the rtc            
            Serial.println("RTC set!");
            flushInput();                        //discard any extraneous trailing characters
            printTime(tSet);
        } else {
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

    printI00(h, ':');
    printI00(minute(t), ':');
    printI00(second(t), ' ');
    Serial.print(dayShortStr(weekday(t)));
    Serial.print(' ');
    printI00(day(t), ' ');
    Serial.print(monthShortStr(month(t)));
    Serial.print(' ');
    Serial.print(year(t));
    Serial.print(' ');
    if (isDST(month(t), day(t), weekday(t), hour(t))) Serial.print("DST");
    Serial.println();
}


