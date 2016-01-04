void drawChar(int d, int c) {
  for (int row=0; row < MAXROW; row++) {
    lc.setRow(d, row, font[c*MAXROW+row]);
  }
}

void drawMonth(int month) {
  switch (month) {
    case JAN :
      drawChar(2, LETTER_J);
      drawChar(1, LETTER_A);
      drawChar(0, LETTER_N);
      break;
    case FEB :
      drawChar(2, LETTER_F);
      drawChar(1, LETTER_E);
      drawChar(0, LETTER_B);
      break;
    case MAR :
      drawChar(2, LETTER_M);
      drawChar(1, LETTER_A);
      drawChar(0, LETTER_R);
      break;
    case APR :
      drawChar(2, LETTER_A);
      drawChar(1, LETTER_P);
      drawChar(0, LETTER_R);
      break;
    case MAY :
      drawChar(2, LETTER_M);
      drawChar(1, LETTER_A);
      drawChar(0, LETTER_Y);
      break;
    case JUN :
      drawChar(2, LETTER_J);
      drawChar(1, LETTER_U);
      drawChar(0, LETTER_N);
      break;
    case JUL :
      drawChar(2, LETTER_J);
      drawChar(1, LETTER_U);
      drawChar(0, LETTER_L);
      break;
    case AUG :
      drawChar(2, LETTER_A);
      drawChar(1, LETTER_U);
      drawChar(0, LETTER_G);
      break;
    case SEP :
      drawChar(2, LETTER_S);
      drawChar(1, LETTER_E);
      drawChar(0, LETTER_P);
      break;
    case OCTO :
      drawChar(2, LETTER_O);
      drawChar(1, LETTER_C);
      drawChar(0, LETTER_T);
      break;
    case NOV :
      drawChar(2, LETTER_N);
      drawChar(1, LETTER_O);
      drawChar(0, LETTER_V);
      break;
    case DECE :
      drawChar(2, LETTER_D);
      drawChar(1, LETTER_E);
      drawChar(0, LETTER_C);
      break;
  }
}

void drawDate(int date) {
  int d10 = date / 10;

  Serial.print(d10);
  Serial.print(" ");
  Serial.println(date);

  drawChar(2, (d10 > 0) ? d10 : LETTER_BLANK);
  drawChar(1, date - d10*10);
  drawChar(0, LETTER_BLANK);
 
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


