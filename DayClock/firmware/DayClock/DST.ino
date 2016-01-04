/** Determine if Daylight Savings Time is active or not.
 *
 * based on: http://stackoverflow.com/questions/5590429/calculating-daylight-savings-time-from-only-date
 *
 *   This is actually deceptively simple. There are a few facts that will help us:
 *   In most of the US, DST starts on the second Sunday of March and ends on the first Sunday of
 *   November, at 2:00 AM both times.
 *
 *   The second Sunday in March will always be between the 8th and the 14th inclusive.
 *   The first Sunday in November will always be between the 1st and 7th inclusive.
 *   The day of week numbering is quite convenient because the day - day-of-week will give you
 *      the previous Sunday.
 *
 * INPUT:
 *   mo - month, 1-12
 *   d  - date, 1-31
 *   wd - day of week, 1-7
 */
boolean isDST(int mo, int d, int wd, int hr) {
  boolean dst = false;
  int prevSunday = d - wd + 1;

  if (mo >= Apr && mo <= Oct) {    // April thru October are definitely DST
    dst = true;
  } else if (mo == Mar) {          // March might be DST...
    if (prevSunday <= 7) {         // No DST if first Sunday
      dst = false;
    } else if (prevSunday <= 14) { // if Second Sunday...
      if (wd > Sun) {              // yes if > Sunday
        dst = true;
      } else {                     // yes, if Sunday, after 2am...
        dst = hr >= 2;
      }
    } else {                       // Yes DST if third Sunday or later
      dst = true;
    }
  } else if (mo == Nov) {          // Nov might be DST...
    if (prevSunday < 1) {          // Yes if before first Sun
      dst = true;
    } else if (prevSunday < 14) {  // if first Sunday...
      if (wd > Sun) {              // no if > Sunday, after 2am...
        dst = false;
      } else {
        dst = hr < 2;              // if Sunday, before 2am
      }
    } else {                       // No DST if 2nd Sunday or later...
      dst = false;
    }

  } else {
    dst = false;
  }
    
  return dst;
}
