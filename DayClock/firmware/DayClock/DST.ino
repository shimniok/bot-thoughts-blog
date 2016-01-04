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

