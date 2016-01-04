
#define MAXROW 8      // maximum number of LED rows

enum days { SUN=0, MON, TUE, WED, THU, FRI, SAT };

enum months { JAN=1, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCTO, NOV, DECE };

enum letters { LETTER_A=13, LETTER_B, LETTER_C, LETTER_D, LETTER_E, LETTER_F, LETTER_G,
  LETTER_H, LETTER_I, LETTER_J, LETTER_L, LETTER_M, LETTER_N, LETTER_O, LETTER_P, 
  LETTER_R, LETTER_S, LETTER_T, LETTER_U, LETTER_V, LETTER_W, LETTER_Y,
  LETTER_COLON, LETTER_BLANK };

byte font[37*MAXROW] = {
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
  
                          B01111100, // B
                          B01111110,
                          B01100110,
                          B01111100,
                          B01111110,
                          B01100011,
                          B01111111,
                          B01111110,

                          B00111111, // C
                          B01111111,
                          B01100000,
                          B01100000,
                          B01100000,
                          B01100000,
                          B01111111,
                          B00111111,

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

                          B00111111, // G
                          B01111111,
                          B01100000,
                          B01100001,
                          B01100011,
                          B01100011,
                          B01111111,
                          B00111111,

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

                          B00111111, // J
                          B01111111,
                          B00000011,
                          B00000011,
                          B01000011,
                          B01100111,
                          B01111110,
                          B00111100,

                          B00100000, // L
                          B01100000,
                          B01100000,
                          B01100000,
                          B01100000,
                          B01100000,
                          B01111111,
                          B01111111,
                          
                          B01000001, // M
                          B01100011,
                          B01110111,
                          B01111111,
                          B01101011,
                          B01100011,
                          B01100011,
                          B01100011,
                          
                          B01100010, // N
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

                          B00111100, // P
                          B01111111,
                          B01100011,
                          B01100011,
                          B01111111,
                          B01111100,
                          B01100000,
                          B01100000,

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
                       
                          B00100001, // V
                          B01100011,
                          B01100011,
                          B01100011,
                          B01100011,
                          B00110110,
                          B00111100,
                          B00011000,      
                        
                          B01100011, // W
                          B01100011,
                          B01100011,
                          B01101011,
                          B01111111,
                          B01110111,
                          B01100011,
                          B01000001,

                          B00100001, // Y
                          B01100011,
                          B01100011,
                          B01100011,
                          B01111111,
                          B00111111,
                          B00000011,
                          B00111111,
                         
                          B00000000, // :
                          B00000000,
                          B00000000,
                          B01000000,
                          B00000000,
                          B01000000,
                          B00000000,
                          B00000000,
 
                          B00000000, // blank
                          B00000000,
                          B00000000,
                          B00000000,
                          B00000000,
                          B00000000,
                          B00000000,
                          B00000000
                          
                       };

