#include <stdio.h>
#include <inttypes.h>

typedef uint8_t boolean;
enum booleans { false=0, true=1 };

#include "DayClock/datehelp.h"
#include "DayClock/DST.ino"

char *dowtos(int dow) {
  char *s;
  switch(dow) {
    case 1:
      s = "Sun";
      break;
    case 2:
      s = "Mon";
      break;
    case 3:
      s = "Tue";
      break;
    case 4:
      s = "Wed";
      break;
    case 5:
      s = "Thu";
      break;
    case 6:
      s = "Fri";
      break;
    case 7:
      s = "Sat";
      break;
    default :
      s = "???";
      break;
  }
  return s;
}

int main(int argc, char **argv) {
  int month, date, dow, hour;

  // check months. Should print 4 - 11:
  printf("\nCheck months, should print\n4 5 6 7 8 9 10 11...\n");
  for (month = 1; month <= 12; month++) {
    if (isDST(month, 1, 1, 0)) {
      printf("%d ", month);
    }
  }
  printf("\n");

  printf("\nCheck March dates, should print Sun Mar 15 - Sun Mar 31:\n");
  for (date = 1; date <= 31; date++) {
    if (isDST(3, date, Sun, 0)) {
      printf("Sun, Mar %02d\n", date);
    }
  }

  printf("\nCheck March dow, should print Mar 09 Mon, Mar 10 Mon Tue, Mar 11 Mon Tue Wed ...\n");
  for (date = 1; date <= 15; date++) {
    printf("Mar %02d: ", date);
    for (dow = 1; dow <= 7; dow++) {
      if (isDST(3, date, dow, 0)) {
        printf(" %s", dowtos(dow));
      }
    }
    printf("\n");
  }

  printf("\nCheck March times, should print 02-23 on Sun Mar 08, 00-23 on subsequent days...\n");
  dow = 0;
  for (date = 1; date < 16; date++) {
    if (++dow > Sat) dow = Sun;
    printf("%s Mar %02d: ", dowtos(dow), date);
    for (hour = 0; hour < 24; hour++) {
      if (isDST(3, date, dow, hour)) {
        printf(" %02d", hour);
      }
    }
    printf("\n");
  }

  printf("\nCheck November dates, should print Sat Nov 1 - Sat Nov 6:\n");
  for (date = 1; date <= 31; date++) {
    if (isDST(11, date, Sat, 0)) {
      printf("Sat, Nov %02d\n", date);
    }
  }

  printf("\nCheck November dow, should print Nov 01: Mon-Sat;  Nov 02: Tue-Sat, Nov 03: Wed-Sat ...\n");
  for (date = 1; date <= 8; date++) {
    printf("Nov %02d: ", date);
    for (dow = 1; dow <= 7; dow++) {
      if (isDST(11, date, dow, 3)) {
        printf(" %s", dowtos(dow));
      }
    }
    printf("\n");
  }

  printf("\nCheck November times, should print 00-23 Mon Nov 01 - Sat Nov 06; 00-01 on Sun Nov 07:\n");
  dow = 2;
  for (date = 1; date < 9; date++) {
    printf("%s Nov %02d: ", dowtos(dow), date);
    for (hour = 0; hour < 24; hour++) {
      if (isDST(11, date, dow, hour)) {
        printf(" %02d", hour);
      }
    }
    printf("\n");
    if (++dow > Sat) dow = Sun;
  }

}
