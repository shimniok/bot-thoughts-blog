					;---------------------------------------------
					; ASDU 
					; DATE 12-19-2012
					;
					; MY 90 L05, C1, C2, K1, K2 TRUCK
					; MG5, NA5, NA6
					; ECM p/n 127747
					; (Used in MY 88 as S/S)
					; 
					;   GU2 = 2.73:1
					;   GU4 = 3.08:1
					;   GU6 = 3.42:1
					;   GT4 = 3.73:1 <- MINE
					;   GT5 = 4.10:1
					; INV COOL BP'S
					;		17 lns	
					;		BIN		Deg c
					;		----------------
					;		0 	   -5 
					;		16 		5 
					;		32 		15 
					;		48 		25 
					;		64 		35 
					;		80 		45 
					;		96 		55 
					;		112 	65 
					;		128 	75 
					;		144 	85 
					;		160 	95 
					;		176 	100 
					;		192 	105 
					;		208 	110 
					;		224 	115 
					;		240 	200 
					;		256 	201 
					;****************************************************
					; This asm file assembles with ASM11 to a stock ASDU.bin
					; It has been edited to exactly duplicate an ASDU.bin file, however
					; use this file at your own risk, if you blow up your engine, don't blame me!
					; Formatting was done strictly to be visually pleasing to me using notepad++
					; Jim_in_Dorris  12-16-2012
					;=============================================
        ORG $0000 	;
LD000  	FDB $80F9  	; CKSUM
LD002  	FDB $24F5  	; EPROM ID WORD
				    ;	
LD004  	FCB $42    	; EPROM ID BYTE
					;----------------------------------
LD005   FCB $88     ; AFR MD BYTE 1, 1000 1000 
                    ;
                    ;   b7 = 1 = ERG 1 Pass diag
                    ;   b6 = 1 = Not used
                    ;   b5 = 1 = Not used
                    ;   b4 = 1 = EGR INVERSE D.C.
                    ;
                    ;   b3 = 1 = BP EGR DC 32HZ 	0 = 128 Hz (EVRV)
                    ;   b2 = 1 = Not used       	
                    ;   b1 = 1 = GRID data opt
                    ;   b0 = 1 = Not used
					;---------------------------------
LD006   FCB $D0     ; AFR MD BYTE 2, 1101 0000
                    ;
                    ;   b7 = 1 = SEL Diff TPS opt for Acell Enr
                    ;   b6 = 1 = NO ENABLE MOTOR R/S DUE TO RESTART
                    ;   b5 = 1 = DO INT R/S ON BLM CELL CHANGE
                    ;   b4 = 1 = DO INT R/S ON ACCEL ENR
                    ;
                    ;   b3 = 1 = OPN LP DECELL AFR OPT
                    ;   b2 = 1 = Not used
                    ;   b1 = 1 = TCC RPM LD LMT		0 = MPH
					;   b0 = 1 = BURST KNK opt ON 	
					;----------------------------------
LD007  	FCB $24  	; AFR MD BYTE 3, 0010 01000
                    ;   
                    ;	b7  = 1 = SHFT LIGHT/TCC 	0 = TCC 
					;	b6  = 1 = Not used			  
					;	b5  = 1 =  HI GER SW POL	0 = LO SIG 		
					;	b4  = 1 = Not used 			
                    ;   
                    ;	b3  = 1 = ??
					;	b2  = 1 = Decell Fuel Cut Off, TCC UNLOCK			
					;	b1  = 1 = TEST HI GR IN HIWAY MODE SPK			
					;	b0  = 1 = Not used
					;---------------------------------
LD008   FCB  0      ; COLD START THROTLE KICKER ENABLE	
                    ; $00 = DISABLE 	
			 		; $40 = SELECTED, NORMAL OUTPUT MODE	
			 		; $44 = SELECTED, INVERTED OUTPUT MODE	
					;---------------------------------
LD009   FCB  0      ; SA INIT, (256/90)    77
					;	
LD00A   FDB  2185   ; ENG START UP RPM DRP PERIODS, (499 RPM)    
                    ; VAL = N * 65536 * (120/N CYL)    
					;----------------------------------	
LD00C   FCB  168    ; 4200 RPM, MAIN SPK HI EXTEND B.P. RPM/25   
					; MAX RPM FOR CALCULATED SPARK ADVANCE	
					;	
LD00D   FCB  46     ; DEG/1K RPM SLOPE (5 DEG/1K RPM)    
                    ; VAL = N * 65536/7200 (9.1)    
                    ; USED TILL RPM G.T. LD00C    
                    ;---------------------------------    
LD00E   FCB  240    ; NORMAL MAP FILTER COEF    
LD00F   FCB  240    ; TRANSIENT MAP FILT COEF    
					;	
LD010   FCB  40     ; TRANSIENT MAP COEF APPLY TIME, SEC/80  
LD011   FCB  2      ; DIFF TPS FOR MAP FILT COEF        
LD012   FCB  3      ; DIFF RPM TRANS MAP COEF (75 RPM)    
LD013   FCB  0      ; MPH THRESH FOR MAP FILT COEF       
					;
LD014  	FCB  28   	; MAIN SPARK BIAS (BIAS * 256/90)
LD015   FCB  57     ; COOL SPARK BIAS (BIAS * 256/90)
					;---------------------------------
LD016   FCB  8      ; NUM CYL'S, (MAY BE 3,4,6 or 8)       
					;	
LD017   FCB  4      ; ENG RUN TIME OUT PARAM, DRP'S 
LD018   FCB  40     ; ENG OFF TIME, (4 SEC'S)      
					;	
LD019   FDB  0119   ; MAX SA, 41 DEG  256/90   
					;----------------------------------	
LD01B   FDB  65508  ; MAX RETARD (9.4 Deg)    
                    ;                   Max SA      Max Retard    
                    ; 8 cyl big cap max = 42         4     
                    ; 6 cyl big cap max = 54        14    
                    ; 6 cyl sml cap max = 40         9    
                    ;----------------------------------    
LD01D   FCB  10     ; START UP SA COEF       
                    ; Filts SA from 0 at start    
        			;	
LD01E   FCB  240    ; RPM FILTER CONSTANT     
LD01F   FCB  192    ; RPM limit for Pseudo Baro read in WOT    
        			;
LD020   FCB  166    ; TPS Thresh for BARO calc     
LD021   FCB  5      ; Max Diff TPS for Baro calc,       
LD022   FCB  128    ; Baro A/D value filer, (coef 50%)     
					;
LD023   FCB  23     ; SA Diff for ALDL (8 Deg ?      
                    ;---------------------------------    
					;---------------------------------------------
					; HIWAY SPARK ADDER QUAL'S
					; QUALS FOR SPK ADDER TBL LD157
					;---------------------------------------------
LD024   FCB  96     ; 30 MPH, HWAY SPK ADV QUAL Thresh MPH, MIN
			 		; VAL = MPH * 3.2	
				 	;	
LD025   FCB  40     ; 40 Sec's HWAY SPK ADV QUAL MIN TIME Thresh (SEC/1)    
   					;
LD026   FCB  9      ; 2 SEC'S, SPK Time out reduce, (Sec * 5)-1))    
LD027   FCB  40     ; 40 SEC'S, PWR ENR SPK TIME OUT    
         	 	 	;
LD028   FCB  112    ; 2800 RPM, MIN RPM FOR SPK SA DECAY     
				 	;
LD029   FCB  39     ; Pwr Enr SPK Decay cool THRESH      
LD02A   FCB  2      ; Pwr Enr SK ADV INCREASE, Deg, 1.4 Deg    
                    ;---------------------------------    
					;---------------------------------------------
					; KNOCK PARAMS 
					;---------------------------------------------
LD02B   FCB  2      ; 2 MPH, Cut off for RETARD Increase
LD02C   FCB  56     ; 700 RPM, Cut off for RETARD Increase
LD02D   FCB  131    ; 48c KNOCK COOL Cut off, TBL 3
					;---------------------------------------------
					; BURST KNOCK RETARD QUALS
					;---------------------------------------------
LD02E   FCB  64     ; 34 Kpa, MAP Threshold
LD02F   FCB  51     ; 20% TPS Threshold
LD030   FCB  5      ; 2% Diff TPS
LD031   FCB  0      ; 0 Sec's, Duration of RETARD, Sec * 80 
					;---------------------------------------------
					; MAIN SPARK ADV vs MAP vs RPM
					;
					; 10-05-2000 Dissassemby of ASDX
					; 15 COL x 14 BLOCKS =  210 BYTES
					;
					; TBL =  2.8444  * (Spk Adv +  10 Bias)
					;---------------------------------------------
        ORG $0032   ;
L0032   FCB	 0      ; MIN MAP Val
L0033   FCB	 32     ; Min RPM Val
L0034   FCB	 15     ; LINES/BLOCK
					;---------------------------------------------
					; 400 RPM
					;     Spk Adv         MAP
					;---------------------------------------------
L0035   FCB  74     ;      16.0              30
L0036   FCB  74     ;      16.0              35
L0037   FCB  74     ;      16.0              40
L0038   FCB  74     ;      16.0              45
L0039   FCB  74     ;      16.0              50
L003A   FCB  68     ;      13.9              55
L003B   FCB  63     ;      12.1              60
L003C   FCB  54     ;       9.0              65
L003D   FCB  46     ;       6.2              70
L003E   FCB  40     ;       4.1              75
L003F   FCB  34     ;       2.0              80
L0040   FCB  28     ;      -0.2              85
L0041   FCB  23     ;      -1.9              90
L0042   FCB  20     ;      -3.0              95
L0043   FCB  17     ;      -4.0             100
					;---------------------------------------------
					; 600 RPM
					;     Spk Adv         MAP
					;---------------------------------------------
L0044   FCB  74     ;      16.0              30
L0045   FCB  74     ;      16.0              35
L0046   FCB  74     ;      16.0              40
L0047   FCB  74     ;      16.0              45
L0048   FCB  74     ;      16.0              50
L0049   FCB  74     ;      16.0              55
L004A   FCB  74     ;      16.0              60
L004B   FCB  54     ;       9.0              65
L004C   FCB  46     ;       6.2              70
L004D   FCB  40     ;       4.1              75
L004E   FCB  34     ;       2.0              80
L004F   FCB  28     ;      -0.2              85
L0050   FCB  28     ;      -0.2              90
L0051   FCB  28     ;      -0.2              95
L0052   FCB  28     ;      -0.2             100
					;---------------------------------------------
					; 800 RPM
					;     Spk Adv         MAP
					;---------------------------------------------
L0053   FCB  74     ;      16.0              30
L0054   FCB  74     ;      16.0              35
L0055   FCB  74     ;      16.0              40
L0056   FCB  74     ;      16.0              45
L0057   FCB  74     ;      16.0              50
L0058   FCB  68     ;      13.9              55
L0059   FCB  63     ;      12.1              60
L005A   FCB  54     ;       9.0              65
L005B   FCB  48     ;       6.9              70
L005C   FCB  40     ;       4.1              75
L005D   FCB  34     ;       2.0              80
L005E   FCB  31     ;       0.9              85
L005F   FCB  28     ;      -0.2              90
L0060   FCB  28     ;      -0.2              95
L0061   FCB  28     ;      -0.2             100
					;---------------------------------------------
					; 1000 RPM
                    ;      Spk Adv         MAP
					;---------------------------------------------
L0062   FCB  82     ;      18.8              3044
L0063   FCB  80     ;      18.1              35
L0064   FCB  80     ;      18.1              40
L0065   FCB  80     ;      18.1              45
L0066   FCB  74     ;      16.0              50
L0067   FCB  68     ;      13.9              55
L0068   FCB  63     ;      12.1              60
L0069   FCB  54     ;       9.0              65
L006A   FCB  48     ;       6.9              70
L006B   FCB  40     ;       4.1              75
L006C   FCB  34     ;       2.0              80
L006D   FCB  31     ;       0.9              85
L006E   FCB  28     ;      -0.2              90
L006F   FCB  26     ;      -0.9              95
L0070   FCB  26     ;      -0.9             100
					;---------------------------------------------
					; 1200 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L0071   FCB  88     ;      20.9              30
L0072   FCB  85     ;      19.9              35
L0073   FCB  82     ;      18.8              40
L0074   FCB  80     ;      18.1              45
L0075   FCB  74     ;      16.0              50
L0076   FCB  68     ;      13.9              55
L0077   FCB  63     ;      12.1              60
L0078   FCB  57     ;      10.0              65
L0079   FCB  54     ;       9.0              70
L007A   FCB  48     ;       6.9              75
L007B   FCB  43     ;       5.1              80
L007C   FCB  43     ;       5.1              85
L007D   FCB  40     ;       4.1              90
L007E   FCB  34     ;       2.0              95
L007F   FCB  34     ;       2.0             100
					;---------------------------------------------
					; 1400 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L0080   FCB  94     ;      23.0              30
L0081   FCB  88     ;      20.9              35
L0082   FCB  85     ;      19.9              40
L0083   FCB  82     ;      18.8              45
L0084   FCB  74     ;      16.0              50
L0085   FCB  68     ;      13.9              55
L0086   FCB  63     ;      12.1              60
L0087   FCB  63     ;      12.1              65
L0088   FCB  60     ;      11.1              70
L0089   FCB  51     ;       7.9              75
L008A   FCB  48     ;       6.9              80
L008B   FCB  48     ;       6.9              85
L008C   FCB  43     ;       5.1              90
L008D   FCB  37     ;       3.0              95
L008E   FCB  37     ;       3.0             100
					;---------------------------------------------
					; 1600 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L008F   FCB  97     ;      24.1              30
L0090   FCB  91     ;      22.0              35
L0091   FCB  85     ;      19.9              40
L0092   FCB  82     ;      18.8              45
L0093   FCB  77     ;      17.1              50
L0094   FCB  71     ;      15.0              55
L0095   FCB  71     ;      15.0              60
L0096   FCB  68     ;      13.9              65
L0097   FCB  68     ;      13.9              70
L0098   FCB  60     ;      11.1              75
L0099   FCB  57     ;      10.0              80
L009A   FCB  54     ;       9.0              85
L009B   FCB  48     ;       6.9              90
L009C   FCB  43     ;       5.1              95
L009D   FCB  40     ;       4.1             100
					;---------------------------------------------
					; 1800 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L009E   FCB  100    ;      25.2              30
L009F   FCB  94     ;      23.0              35
L00A0   FCB  88     ;      20.9              40
L00A1   FCB  82     ;      18.8              45
L00A2   FCB  77     ;      17.1              50
L00A3   FCB  74     ;      16.0              55
L00A4   FCB  68     ;      13.9              60
L00A5   FCB  68     ;      13.9              65
L00A6   FCB  63     ;      12.1              70
L00A7   FCB  63     ;      12.1              75
L00A8   FCB  57     ;      10.0              80
L00A9   FCB  57     ;      10.0              85
L00AA   FCB  54     ;       9.0              90
L00AB   FCB  48     ;       6.9              95
L00AC   FCB  46     ;       6.2             100
					;---------------------------------------------
					; 2000 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L00AD   FCB  102    ;      25.9              30
L00AE   FCB  97     ;      24.1              35
L00AF   FCB  91     ;      22.0              40
L00B0   FCB  85     ;      19.9              45
L00B1   FCB  80     ;      18.1              50
L00B2   FCB  77     ;      17.1              55
L00B3   FCB  74     ;      16.0              60
L00B4   FCB  68     ;      13.9              65
L00B5   FCB  68     ;      13.9              70
L00B6   FCB  65     ;      12.9              75
L00B7   FCB  57     ;      10.0              80
L00B8   FCB  57     ;      10.0              85
L00B9   FCB  54     ;       9.0              90
L00BA   FCB  46     ;       6.2              95
L00BB   FCB  43     ;       5.1             100
					;---------------------------------------------
					; 2200 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L00BC   FCB  102    ;      25.9              30
L00BD   FCB  97     ;      24.1              35
L00BE   FCB  91     ;      22.0              40
L00BF   FCB  85     ;      19.9              45
L00C0   FCB  80     ;      18.1              50
L00C1   FCB  77     ;      17.1              55
L00C2   FCB  74     ;      16.0              60
L00C3   FCB  68     ;      13.9              65
L00C4   FCB  68     ;      13.9              70
L00C5   FCB  68     ;      13.9              75
L00C6   FCB  60     ;      11.1              80
L00C7   FCB  60     ;      11.1              85
L00C8   FCB  54     ;       9.0              90
L00C9   FCB  51     ;       7.9              95
L00CA   FCB  48     ;       6.9             100
					;---------------------------------------------
					; 2400 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L00CB   FCB  105    ;      26.9              30
L00CC   FCB  100    ;      25.2              35
L00CD   FCB  94     ;      23.0              40
L00CE   FCB  88     ;      20.9              45
L00CF   FCB  82     ;      18.8              50
L00D0   FCB  80     ;      18.1              55
L00D1   FCB  77     ;      17.1              60
L00D2   FCB  74     ;      16.0              65
L00D3   FCB  74     ;      16.0              70
L00D4   FCB  74     ;      16.0              75
L00D5   FCB  74     ;      16.0              80
L00D6   FCB  63     ;      12.1              85
L00D7   FCB  54     ;       9.0              90
L00D8   FCB  51     ;       7.9              95
L00D9   FCB  51     ;       7.9             100
					;---------------------------------------------
					; 2800 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L00DA   FCB  108    ;      28.0              30
L00DB   FCB  102    ;      25.9              35
L00DC   FCB  97     ;      24.1              40
L00DD   FCB  91     ;      22.0              45
L00DE   FCB  85     ;      19.9              50
L00DF   FCB  82     ;      18.8              55
L00E0   FCB  80     ;      18.1              60
L00E1   FCB  77     ;      17.1              65
L00E2   FCB  74     ;      16.0              70
L00E3   FCB  71     ;      15.0              75
L00E4   FCB  68     ;      13.9              80
L00E5   FCB  68     ;      13.9              85
L00E6   FCB  63     ;      12.1              90
L00E7   FCB  54     ;       9.0              95
L00E8   FCB  54     ;       9.0             100
					;---------------------------------------------
					; 3200 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L00E9   FCB  108    ;      28.0              30
L00EA   FCB  102    ;      25.9              35
L00EB   FCB  100    ;      25.2              40
L00EC   FCB  94     ;      23.0              45
L00ED   FCB  88     ;      20.9              50
L00EE   FCB  85     ;      19.9              55
L00EF   FCB  85     ;      19.9              60
L00F0   FCB  85     ;      19.9              65
L00F1   FCB  85     ;      19.9              70
L00F2   FCB  85     ;      19.9              75
L00F3   FCB  82     ;      18.8              80
L00F4   FCB  65     ;      12.9              85
L00F5   FCB  63     ;      12.1              90
L00F6   FCB  57     ;      10.0              95
L00F7   FCB  57     ;      10.0             100
					;---------------------------------------------
					; 3600 RPM
					;      Spk Adv         MAP
					;---------------------------------------------
L00F8   FCB  111    ;      29.0              30
L00F9   FCB  105    ;      26.9              35
L00FA   FCB  102    ;      25.9              40
L00FB   FCB  97     ;      24.1              45
L00FC   FCB  94     ;      23.0              50
L00FD   FCB  91     ;      22.0              55
L00FE   FCB  91     ;      22.0              60
L00FF   FCB  91     ;      22.0              65
L0100   FCB  91     ;      22.0              70
L0101   FCB  91     ;      22.0              75
L0102   FCB  74     ;      16.0              80
L0103   FCB  71     ;      15.0              85
L0104   FCB  65     ;      12.9              90
L0105   FCB  65     ;      12.9              95
L0106   FCB  65     ;      12.9             100
					;---------------------------------------------
					;  COOLANT COMP SPARK Vs. LOAD Vs. Deg c COOL
					;
					; 10-05-2000 Dissassemby of ASDX
					; 15 COL x 12 BLOCKS =  180 BYTES
					;
					; TBL =  2.8444  * (Spk Adv +  20 Bias)
					;---------------------------------------------
        ORG $0107   ;
L0107   FCB	 16     ; MIN MAP Val
L0108   FCB	 64     ; Min Deg C Cool Val
L0109   FCB	 5      ; LINES/BLOCK
					;---------------------------------------------
					; 5 Deg C Cool
					;      Spk Adv         MAP
					;---------------------------------------------
L010A   FCB  71     ;       4.9              40
L010B   FCB  80     ;       8.1              30
L010C   FCB  85     ;       9.9              20
L010D   FCB  85     ;       9.9              10
L010E   FCB  85     ;       9.9               0
					;---------------------------------------------
					; 15 Deg C Cool
					;       Spk Adv         MAP
					;---------------------------------------------
L010F   FCB  71     ;       4.9              40
L0110   FCB  80     ;       8.1              30
L0111   FCB  85     ;       9.9              20
L0112   FCB  85     ;       9.9              10
L0113   FCB  85     ;       9.9               0
					;---------------------------------------------
					; 25 Deg C Cool
					;       Spk Adv         MAP
					;---------------------------------------------
L0114   FCB  57     ;       0.0              40
L0115   FCB  57     ;       0.0              30
L0116   FCB  71     ;       5.0              20
L0117   FCB  80     ;       8.1              10
L0118   FCB  80     ;       8.1               0
					;---------------------------------------------
					; 35 Deg C Cool
					;      Spk Adv         MAP
					;---------------------------------------------
L0119   FCB  57     ;       0.0              40
L011A   FCB  57     ;       0.0              30
L011B   FCB  71     ;       5.0              20
L011C   FCB  74     ;       6.0              10
L011D   FCB  74     ;       6.0               0
					;---------------------------------------------
					; 45 Deg C Cool
					;       Spk Adv         MAP
					;---------------------------------------------
L011E   FCB  57     ;       0.0              40
L011F   FCB  57     ;       0.0              30
L0120   FCB  57     ;       0.0              20
L0121   FCB  68     ;       3.9              10
L0122   FCB  68     ;       3.9               0
					;---------------------------------------------
					; 55 Deg C Cool
					;       Spk Adv         MAP
					;---------------------------------------------
L0123   FCB  57     ;       0.0              40
L0124   FCB  57     ;       0.0              30
L0125   FCB  57     ;       0.0              20
L0126   FCB  65     ;       2.9              10
L0127   FCB  65     ;       2.9               0
					;---------------------------------------------
					; 65 Deg C Cool
					;       Spk Adv         MAP
					;---------------------------------------------
L0128   FCB  57     ;       0.0              40
L0129   FCB  57     ;       0.0              30
L012A   FCB  57     ;       0.0              20
L012B   FCB  63     ;       2.1              10
L012C   FCB  63     ;       2.1               0
					;---------------------------------------------
					; 75 Deg C Cool
					;       Spk Adv         MAP
					;---------------------------------------------
L012D   FCB  57     ;       0.0              40
L012E   FCB  57     ;       0.0              30
L012F   FCB  57     ;       0.0              20
L0130   FCB  57     ;       0.0              10
L0131   FCB  57     ;       0.0               0
					;---------------------------------------------
					; 85 Deg C Cool
					;       Spk Adv         MAP
					;---------------------------------------------
L0132   FCB  57     ;       0.0              40
L0133   FCB  57     ;       0.0              30
L0134   FCB  57     ;       0.0              20
L0135   FCB  57     ;       0.0              10
L0136   FCB  57     ;       0.0               0
					;---------------------------------------------
					; 95 Deg C Cool
					;      Spk Adv         MAP
					;---------------------------------------------
L0137   FCB  57     ;       0.0              40
L0138   FCB  57     ;       0.0              30
L0139   FCB  57     ;       0.0              20
L013A   FCB  57     ;       0.0              10
L013B   FCB  57     ;       0.0               0
					;---------------------------------------------
					; 105 Deg C Cool
					;        Spk Adv         MAP
					;---------------------------------------------
L013C   FCB  74     ;       6.0              40
L013D   FCB  48     ;      -3.1              30
L013E   FCB  48     ;      -3.1              20
L013F   FCB  48     ;      -3.1              10
L0140   FCB  48     ;      -3.1               0
					;---------------------------------------------
					; 115 Deg C Cool
					;        Spk Adv         MAP
					;---------------------------------------------
L0141   FCB  46     ;      -3.8              40
L0142   FCB  46     ;      -3.8              30
L0143   FCB  46     ;      -3.8              20
L0144   FCB  46     ;      -3.8              10
L0145   FCB  46     ;      -3.8               0
					;=============================================
					;  EGR Spk Adv vs EGR CORR FACTOR        
					;
					; 02-01-2000 Dissassemby of ASDX
					;  17  BYTES
					;
					;  TBL =  2.844  * EGR %
					;---------------------------------------------
        ORG $0146   ;      SPK ADV           EGR%
                    ;---------------------------------
LD146   FCB  0      ;        0.0  		    0.00
LD147   FCB  0      ;        0.0  		    6.25
LD148   FCB  0      ;        0.0  		   12.50
LD149   FCB  6      ;        2.1		   18.75
LD14A   FCB  11     ;        3.9		   25.00
LD14B   FCB  14     ;        4.9		   31.25
LD14C   FCB  17     ;        6.0		   37.50
LD14D   FCB  17     ;        6.0		   43.75
LD14E   FCB  17     ;        6.0		   50.00
LD14F   FCB  17     ;        6.0		   56.25
LD150   FCB  17     ;        6.0		   62.50
LD151   FCB  17     ;        6.0		   68.75
LD152   FCB  17     ;        6.0		   75.00
LD153   FCB  17     ;        6.0		   81.25
LD154   FCB  17     ;        6.0		   87.50
LD155   FCB  17     ;        6.0		   93.75
LD156   FCB  17     ;        6.0		  100.00
					;---------------------------------------------     
					; HIWAY SPK ADV vs VACUUM        
					;        
					; ADDED SPK IF IN HIWAY MODE        
					; (See D024 & D025 FOR QUAL'S)        
					;		
					; VAL = SPK ADV * (256/90)        
					;--------------------------------------------- 
    	ORG	$0157	; Spk   	Vac Kpa
                    ;---------------------------------
LD157   FCB  0      ; 0     	50
LD158   FCB  0      ; 0     	40
LD159   FCB  0      ; 0     	30
LD15A   FCB  0      ; 0     	20
LD15B   FCB  0      ; 0     	10
LD15C   FCB  0      ; 0			 0
					;=============================================
					; PWR ENRICH SA CORRECTION TBL        
					;        
					; INCR SA IF PWR ENRICH IS ON        
					;        
					; VAL = Spk Adv * (256/90)        
					;=============================================
LD15D   FCB  144    ; 3600 RPM, UPPER TBL LIMIT
        ORG $015E   ; SPK       RPM
                    ;---------------------------------
LD15E   FCB  14     ; 4.9       800 
LD15F   FCB  6      ; 2.1       1200
LD160   FCB  6      ; 2.1       1600
LD161   FCB  14     ; 4.9       2000
LD162   FCB  14     ; 4.9       2400
LD163   FCB  14     ; 4.9       2800
LD164   FCB  14     ; 4.9       3200
LD165   FCB  14     ; 4.9       3600
					;---------------------------------------------
					; DEG BURST KNOCK RETARD vs COOL
					;
					;  VAL = Spk Adv * (256/90)
					;---------------------------------------------
LD166   FCB  208    ; 110c,  UPPER TBL LIMIT
		ORG $0167   ;  Deg's		Deg c COOL
			 		;---------------------------------
LD167   FCB  0      ; 0         	 75 
LD168   FCB  0      ; 0         	 85
LD169   FCB  0      ; 0         	 95
LD16A   FCB  0      ; 0         	100
LD16B   FCB  0      ; 0         	105
LD16C   FCB  0      ; 0         	110
					;---------------------------------------------
					; START UP SPARK
					;---------------------------------------------
					;---------------------------------------------
					; SPK TIME OUT vs COOL         
					;         
					; INITIAL SA WHICH IS DECAYED IN SOME TIME PERIOD        
					; SET BY TBL LD173        
					;		
					; VAL = Spk Adv * (256/90)        
					;---------------------------------------------
LD16D   FCB  4      ; 5 LINE TABLE
		ORG $016E	; Deg's		Deg c COOL
			 		;---------------------------------
LD16E   FCB  14     ; 4.9       COLD  
LD16F   FCB  28     ; 10        24.0  
LD170   FCB  28     ; 10        49.7
LD171   FCB  28     ; 10        80.5
LD172   FCB  14     ; 4.9       HOT
					;---------------------------------------------
					; SPK TIME OUT DECAY DELAY vs COOL        
					;        
					;  TBL = SECONDS        
					;---------------------------------------------8
LD173   FCB  4      ; 5 LINE TABLE
		ORG $0174   ; Dec's		Deg c 
					;---------------------------------
LD174   FCB  40     ; 40        COLD
LD175   FCB  30     ; 30        24.0      
LD176   FCB  20     ; 20        49.7
LD177   FCB  10     ; 10        80.5
LD178   FCB  5      ;  5        HOT
					;---------------------------------------------
					; SPK TIME OUT DECAY MULT vs COOL         
					;        
					; TBL = %MULT * 2.56          
					;---------------------------------------------
LD179   FCB  4      ; 5 LINE TABLE 
		ORG	$017A	; %MULT		Deg c COOL
          			;---------------------------------
LD17A   FCB  251    ;  98       COLD 
LD17B   FCB  248    ;  96       24.0 
LD17C   FCB  243    ;  95       49.7
LD17D   FCB  236    ;  92       80.5
LD17E   FCB  205    ;  80       HOT
					;---------------------------------------------
					; SPARK RETARD TABLES
					;---------------------------------------------
					;---------------------------------------------
					; MAX KNK RETARD LIMITS IN PWR ENR vs RPM    
					; ASDX, TYPE $42,  9 lines      
					;        
					;  TBL = SPK RETARD * (256/45)        
					;---------------------------------------------
    	ORG	$017F	;   Deg			 RPM
    				;---------------------------------
LD17F   FCB  34     ; 5.9        400
LD180   FCB  34     ; 5.9        600 
LD181   FCB  34     ; 5.9        800
LD182   FCB  46     ; 8.0       1200
LD183   FCB  46     ; 8.0       1600
LD184   FCB  46     ; 8.0       2000
LD185   FCB  46     ; 8.0       2400
LD186   FCB  46     ; 8.0       3200
LD187   FCB  46     ; 8.0       4000
					;---------------------------------------------
					; MAX KNK RETARD vs VACUUM        
					; ASDX, 5 LINES        
					;
					;  TBL = SPK RETARD * (256/45)        
					;---------------------------------------------
		ORG	$0188	; Deg.		Kpa VAC
    				;---------------------------------
LD188   FCB  34     ; 5.9       40
LD189   FCB  46     ; 8.0       30
LD18A   FCB  46     ; 8.0       20
LD18B   FCB  46     ; 8.0       10
LD18C   FCB  46     ; 8.0        0
					;---------------------------------------------
					; RETARD ATTACK RATE vs RPM
					;        
					; 02-01-2000 Dissassemby of ASDX
					;  9  BYTES
					;
					;  TBL =   DEG/msec / .0255
					;---------------------------------------------
        ORG $018D   ;      DEG/msec        RPM
                    ;---------------------------------
LD18D   FCB 2       ; 0.102      400
LD18E   FCB 9       ; 0.230      600
LD18F   FCB 9       ; 0.230      800
LD190   FCB 9       ; 0.230     1200
LD191   FCB 9       ; 0.230     1600
LD192   FCB 9       ; 0.230     2000
LD193   FCB 9       ; 0.230     2400
LD194   FCB 13      ; 0.332     3200
LD195   FCB 16      ; 0.360     4000
					;---------------------------------------------
					;  RETARD RECOVERY RATE vs RPM	
					;	
					; 02-01-2000 Dissassemby of ASDX
					;  9  BYTES
					;
					;  TBL =  .512  * PCT/msec
					;---------------------------------------------
        ORG $0196   ;      PCT/msec        RPM
                    ;---------------------------------
LD196   FCB  220    ;   429.7         400
LD197   FCB  50     ;    97.7         600
LD198   FCB  50     ;    97.7         800
LD199   FCB  50     ;    97.7        1200
LD19A   FCB  50     ;    97.7        1600
LD19B   FCB  50     ;    97.7        2000
LD19C   FCB  40     ;    78.1        2400
LD19D   FCB  40     ;    78.1        3200
LD19E   FCB  40     ;    78.1        4000
					;---------------------------------------------
					; SPK LATENTCY CORRECXTION vs RPM    
					; 0 - 4800 RPM    
					;     
					; TBL = USEC/15.26    
					;---------------------------------------------
LD19F   FCB  192    ; UPPER TBL RPM LIMIT
		ORG $01A0	; usec			RPM
					;---------------------------------
LD1A0   FCB  0      ;   0              0
LD1A1   FCB  0      ;   0            400
LD1A2   FCB  0      ;   0            800
LD1A3   FCB  3      ;  46           1200
LD1A4   FCB  7      ; 107           1600
LD1A5   FCB  9      ; 137           2000
LD1A6   FCB  9      ; 137           2400
LD1A7   FCB  12     ; 183           2800
LD1A8   FCB  11     ; 168           3200
LD1A9   FCB  9      ; 137           3600
LD1AA   FCB  10     ; 153           4000
LD1AB   FCB  10     ; 153           4400
LD1AC   FCB  9      ; 137           4800
					;---------------------------------------------
					; BARO CORECTION vs TPS    
					;     
					; 09-10-1997  Dissassemby of asdx  Lines= 5 
					;
					;  TBL = N * 17.28	Kpa/1K RPM    
					;---------------------------------------------
LD1AD   FCB  4      ; 5 LINE TABLE 
		ORG $01AE	; Kpa/1K RPM 	 %TPS
					;---------------------------------
LD1AE   FCB  255    ; 14.76    		  0
LD1AF   FCB  236    ; 13.65    		 25
LD1B0   FCB  85     ;  4.92    		 50
LD1B1   FCB  45     ;  2.60    		 75
LD1B2   FCB  27     ;  1.56    		100
					;---------------------------------------------
					; END OF SPARK PARAMS
					;---------------------------------------------
					;=============================================
					; EGR PARAM'S
					;       
					;=============================================
LD1B3   FCB  132    ; ..c COOL FOR EGR ENABLE (1K PU)  TBL 3
					;
LD1B4   FCB  0      ; 0 MPH LO VSS THRESH  FOR EGR ENABLE  
LD1B5   FCB  0      ; 0 MPH HI VSS THRESH  FOR EGR ENABLE 
    		 		;
LD1B6   FCB  5      ; 2%,  LOW TPS  FOR EGR ENABLE 
LD1B7   FCB  8      ; 3%,  HI  TPS  FOR EGR ENABLE 
			 		;
LD1B8   FCB  48     ; 35 Kpa MAP, LO VACUUM LD  FOR EGR ENABLE 
LD1B9   FCB  56     ; 38 Kpa MAP, HI VACUUM LD  FOR EGR ENABLE 
			 		;
LD1BA   FCB  255    ; 0.9960 SPK COEF FOR EGR OFF SPK FILTER
LD1BB   FCB  16     ; 0.0625 SPK COEF FOR EGR  ON SPK FILTER
			 		;
LD1BC   FCB  230    ; 0.898 EGR D.C. FILTER COEF
LD1BD   FCB  51     ; 19.9% D.C. THRESH FOR EGR ON 
			 		;
LD1BE   FCB  254    ; 1 Kpa VAC THRESH FOR EGR ON, (100 Kpa)
			 		;
LD1BF   FCB  128    ; 50% TPS HI TPS THRESH EGR
                    ; AFTER 50% GAIN = 0  
					;---------------------------------------------
					; PCT EGR Vs. VAC LOAD  Vs. RPM
					;
					; 02-01-2000 Dissassemby of asdx
					; 7 COL x 7 BLOCKS =  49 BYTES
					;
					;  TBL =  2.56  * Spk Adv
					;---------------------------------------------
        ORG $01C0	;
LD1C0   FCB  0      ; LD SEL 0 = VACUUM, 1 = MAP 
		ORG $01C1	;
L01C1   FCB	 80     ; MIN MAP Val
L01C2   FCB	 32     ; Min RPM Val
L01C3   FCB	 7      ; LINES/BLOCK
					;---------------------------------------------
					; 1000 RPM
					;        EGR %         MAP
					;---------------------------------------------
L01C4   FCB  255    ;        99.6              40 
L01C5   FCB  255    ;        99.6              50 
L01C6   FCB  255    ;        99.6              60 
L01C7   FCB  255    ;        99.6              70 
L01C8   FCB  255    ;        99.6              80 
L01C9   FCB  255    ;        99.6              90 
L01CA   FCB  255    ;        99.6             100 
					;---------------------------------------------
					; 1200 RPM
					;        EGR %         MAP
					;---------------------------------------------
L01CB   FCB  255    ;        99.6              40 
L01CC   FCB  255    ;        99.6              50 
L01CD   FCB  255    ;        99.6              60 
L01CE   FCB  255    ;        99.6              70 
L01CF   FCB  255    ;        99.6              80 
L01D0   FCB  255    ;        99.6              90 
L01D1   FCB  255    ;        99.6             100 
					;---------------------------------------------
					; 1400 RPM
					;        EGR %         MAP
					;---------------------------------------------
L01D2   FCB  255    ;        99.6              40 
L01D3   FCB  255    ;        99.6              50 
L01D4   FCB  255    ;        99.6              60 
L01D5   FCB  255    ;        99.6              70 
L01D6   FCB  255    ;        99.6              80 
L01D7   FCB  255    ;        99.6              90 
L01D8   FCB  255    ;        99.6             100 
					;---------------------------------------------
					; 1600 RPM
					;        EGR %         MAP
					;---------------------------------------------
L01D9   FCB  255    ;        99.6              40 
L01DA   FCB  255    ;        99.6              50 
L01DB   FCB  255    ;        99.6              60 
L01DC   FCB  255    ;        99.6              70 
L01DD   FCB  255    ;        99.6              80 
L01DE   FCB  255    ;        99.6              90 
L01DF   FCB  255    ;        99.6             100 
					;---------------------------------------------
					; 1800 RPM
					;        EGR %         MAP
					;---------------------------------------------
L01E0   FCB  255    ;        99.6              40 
L01E1   FCB  255    ;        99.6              50 
L01E2   FCB  255    ;        99.6              60 
L01E3   FCB  255    ;        99.6              70 
L01E4   FCB  255    ;        99.6              80 
L01E5   FCB  255    ;        99.6              90 
L01E6   FCB  255    ;        99.6             100 
					;---------------------------------------------
					; 2200 RPM
					;        EGR %         MAP
					;---------------------------------------------
L01E7   FCB  255    ;        99.6              40 
L01E8   FCB  255    ;        99.6              50 
L01E9   FCB  255    ;        99.6              60 
L01EA   FCB  255    ;        99.6              70 
L01EB   FCB  255    ;        99.6              80 
L01EC   FCB  255    ;        99.6              90 
L01ED   FCB  255    ;        99.6             100 
					;---------------------------------------------
					; 3000 RPM
					;        EGR %         MAP
					;---------------------------------------------
L01EE   FCB  255    ;        99.6              40 
L01EF   FCB  255    ;        99.6              50 
L01F0   FCB  255    ;        99.6              60 
L01F1   FCB  255    ;        99.6              70 
L01F2   FCB  255    ;        99.6              80 
L01F3   FCB  255    ;        99.6              90 
L01F4   FCB  255    ;        99.6             100 
					;---------------------------------------------
					; EGR GAIN vs COOLANT
					;
					; VAL = N * 128
					;---------------------------------------------
LD1F5   FCB  152    ; 60C, UPPER TBL LIMIT
		ORG $01F6	;  GAIN			Deg c
					;--------------------------------- 
LD1F6   FCB  128    ;  1.00     	 20 
LD1F7   FCB  128    ;  1.00     	 30
LD1F8   FCB  128    ;  1.00     	 40
LD1F9   FCB  128    ;  1.00     	 50
LD1FA   FCB  128    ;  1.00     	 60
LD1FB   FCB  128    ;  1.00     	 70
LD1FC   FCB  128    ;  1.00     	 80
LD1FD   FCB  128    ;  1.00     	 90
					;---------------------------------------------
					; EGR GAIN GAIN FACTOR vs BARO & MAP
					;
					; 02-01-2000 Dissassemby of asdx
					; 7 COL x 7 BLOCKS =  49 BYTES
					;
					;  TBL =  128  * Gain
					;---------------------------------------------
        ORG $01FE   ;
L01FE   FCB	 32     ; MIN Kpa BARO Val
L01FF   FCB	 96     ; Min KPA MAP Val
L0200   FCB	 4      ; LINES/BLOCK
					;---------------------------------------------
					; 40 KPA MAP
					;      Gain            Kpa BARO
					;---------------------------------------------
L0201   FCB  123    ;        0.96              75 
L0202   FCB  128    ;        1.00              80 
L0203   FCB  128    ;        1.00              85 
L0204   FCB  128    ;        1.00              90 
					;---------------------------------------------
					; 50 KPA MAP
					;      Gain            Kpa BARO
					;---------------------------------------------
L0205   FCB  128    ;        1.00              75 
L0206   FCB  128    ;        1.00              80 
L0207   FCB  128    ;        1.00              85 
L0208   FCB  128    ;        1.00              90 
					;---------------------------------------------
					; 60 KPA MAP
					;      Gain            Kpa BARO
					;---------------------------------------------
L0209   FCB  128    ;        1.00              75 
L020A   FCB  128    ;        1.00              80 
L020B   FCB  128    ;        1.00              85 
L020C   FCB  128    ;        1.00              90 
					;---------------------------------------------
					; 70 KPA MAP
					;      Gain            Kpa BARO
					;---------------------------------------------
L020D   FCB  128    ;        1.00              75 
L020E   FCB  128    ;        1.00              80 
L020F   FCB  128    ;        1.00              85 
L0210   FCB  128    ;        1.00              90 
					;---------------------------------------------
					; 80 KPA MAP
					;      Gain            Kpa BARO
					;---------------------------------------------
L0211   FCB  128    ;        1.00              75 
L0212   FCB  128    ;        1.00              80 
L0213   FCB  128    ;        1.00              85 
L0214   FCB  128    ;        1.00              90 
					;---------------------------------------------
					; 90 KPA MAP
					;      Gain            Kpa BARO
					;---------------------------------------------
L0215   FCB  128    ;        1.00              75 
L0216   FCB  128    ;        1.00              80 
L0217   FCB  128    ;        1.00              85 
L0218   FCB  128    ;        1.00              90 
					;---------------------------------------------
					; 100 KPA MAP
					;       Gain            Kpa BARO
					;---------------------------------------------
L0219   FCB  128    ;        1.00              75 
L021A   FCB  128    ;        1.00              80 
L021B   FCB  128    ;        1.00              85 
L021C   FCB  128    ;        1.00              90 
					;---------------------------------------------
					; 454 CID DIFF VALS NO EVEN SPACING IN NUM VALUF
					; 0, 16 & 32 HEADER ARE SAME	
					;
					;---------------------------------------------
					; EGR CORRECTION Vs. VACUUM Vs. EGR D.C.
					;
					; 02-01-2000 Dissassemby of asdx
					; 13 COL x 8 BLOCKS =  104 BYTES
					;
					;  TBL =  2.56  * MULT %
					;---------------------------------------------
        ORG $021D   ;
L021D   FCB	 48     ; MIN KPA VAC Val
L021E   FCB	 0      ; Min % EGR Val
L021F   FCB	 13     ; LINES/BLOCK
					;---------------------------------------------
					; 30 % EGR
					;      MULT %          KPA VAC
					;---------------------------------------------
L0220   FCB  0      ;         0.0             0.0 
L0221   FCB  16     ;         6.3             2.5 
L0222   FCB  32     ;        12.5             5.0 
L0223   FCB  48     ;        18.8             7.5 
L0224   FCB  64     ;        25.0            10.0 
L0225   FCB  80     ;        31.3            12.5 
L0226   FCB  96     ;        37.5            15.0 
L0227   FCB  112    ;        43.8            17.5 
L0228   FCB  128    ;        50.0            20.0 
L0229   FCB  144    ;        56.3            30.0 
L022A   FCB  160    ;        62.5            40.0 
L022B   FCB  176    ;        68.8            50.0 
L022C   FCB  192    ;        75.0            60.0 
					;---------------------------------------------
					; 40 % EGR
					;      MULT %          KPA VAC
					;---------------------------------------------
L022D   FCB  0      ;         0.0             0.0 
L022E   FCB  16     ;         6.3             2.5 
L022F   FCB  32     ;        12.5             5.0 
L0230   FCB  48     ;        18.8             7.5 
L0231   FCB  64     ;        25.0            10.0 
L0232   FCB  80     ;        31.3            12.5 
L0233   FCB  96     ;        37.5            15.0 
L0234   FCB  112    ;        43.8            17.5 
L0235   FCB  128    ;        50.0            20.0 
L0236   FCB  144    ;        56.3            30.0 
L0237   FCB  160    ;        62.5            40.0 
L0238   FCB  176    ;        68.8            50.0 
L0239   FCB  192    ;        75.0            60.0 
					;---------------------------------------------
					; 50 % EGR
					;      MULT %          KPA VAC
					;---------------------------------------------
L023A   FCB  0      ;         0.0             0.0 
L023B   FCB  16     ;         6.3             2.5 
L023C   FCB  32     ;        12.5             5.0 
L023D   FCB  48     ;        18.8             7.5 
L023E   FCB  64     ;        25.0            10.0 
L023F   FCB  80     ;        31.3            12.5 
L0240   FCB  96     ;        37.5            15.0 
L0241   FCB  112    ;        43.8            17.5 
L0242   FCB  128    ;        50.0            20.0 
L0243   FCB  144    ;        56.3            30.0 
L0244   FCB  160    ;        62.5            40.0 
L0245   FCB  176    ;        68.8            50.0 
L0246   FCB  192    ;        75.0            60.0 
					;---------------------------------------------
					; 60 % EGR
					;      MULT %          KPA VAC
					;---------------------------------------------
L0247   FCB  0      ;         0.0             0.0 
L0248   FCB  16     ;         6.3             2.5 
L0249   FCB  32     ;        12.5             5.0 
L024A   FCB  48     ;        18.8             7.5 
L024B   FCB  64     ;        25.0            10.0 
L024C   FCB  80     ;        31.3            12.5 
L024D   FCB  96     ;        37.5            15.0 
L024E   FCB  112    ;        43.8            17.5 
L024F   FCB  128    ;        50.0            20.0 
L0250   FCB  144    ;        56.3            30.0 
L0251   FCB  160    ;        62.5            40.0 
L0252   FCB  176    ;        68.8            50.0 
L0253   FCB  192    ;        75.0            60.0 
					;---------------------------------------------
					; 70 % EGR
					;      MULT %          KPA VAC
					;---------------------------------------------
L0254   FCB  0      ;         0.0             0.0 
L0255   FCB  16     ;         6.3             2.5 
L0256   FCB  32     ;        12.5             5.0 
L0257   FCB  48     ;        18.8             7.5 
L0258   FCB  64     ;        25.0            10.0 
L0259   FCB  80     ;        31.3            12.5 
L025A   FCB  96     ;        37.5            15.0 
L025B   FCB  112    ;        43.8            17.5 
L025C   FCB  128    ;        50.0            20.0 
L025D   FCB  144    ;        56.3            30.0 
L025E   FCB  160    ;        62.5            40.0 
L025F   FCB  176    ;        68.8            50.0 
L0260   FCB  192    ;        75.0            60.0 
					;---------------------------------------------
					; 80 % EGR
					;      MULT %          KPA VAC
					;---------------------------------------------
L0261   FCB  0      ;         0.0             0.0 
L0262   FCB  16     ;         6.3             2.5 
L0263   FCB  32     ;        12.5             5.0 
L0264   FCB  48     ;        18.8             7.5 
L0265   FCB  64     ;        25.0            10.0 
L0266   FCB  80     ;        31.3            12.5 
L0267   FCB  96     ;        37.5            15.0 
L0268   FCB  112    ;        43.8            17.5 
L0269   FCB  128    ;        50.0            20.0 
L026A   FCB  144    ;        56.3            30.0 
L026B   FCB  160    ;        62.5            40.0 
L026C   FCB  176    ;        68.8            50.0 
L026D   FCB  192    ;        75.0            60.0 
					;---------------------------------------------
					; 90 % EGR
					;      MULT %          KPA VAC
					;---------------------------------------------
L026E   FCB  0      ;         0.0             0.0 
L026F   FCB  16     ;         6.3             2.5 
L0270   FCB  32     ;        12.5             5.0 
L0271   FCB  48     ;        18.8             7.5 
L0272   FCB  64     ;        25.0            10.0 
L0273   FCB  80     ;        31.3            12.5 
L0274   FCB  96     ;        37.5            15.0 
L0275   FCB  112    ;        43.8            17.5 
L0276   FCB  128    ;        50.0            20.0 
L0277   FCB  144    ;        56.3            30.0 
L0278   FCB  160    ;        62.5            40.0 
L0279   FCB  176    ;        68.8            50.0 
L027A   FCB  192    ;        75.0            60.0 
					;---------------------------------------------
					; 100 % EGR
					;       MULT %          KPA VAC
					;---------------------------------------------
L027B   FCB  0      ;         0.0             0.0 
L027C   FCB  16     ;         6.3             2.5 
L027D   FCB  32     ;        12.5             5.0 
L027E   FCB  48     ;        18.8             7.5 
L027F   FCB  64     ;        25.0            10.0 
L0280   FCB  80     ;        31.3            12.5 
L0281   FCB  96     ;        37.5            15.0 
L0282   FCB  112    ;        43.8            17.5 
L0283   FCB  128    ;        50.0            20.0 
L0284   FCB  144    ;        56.3            30.0 
L0285   FCB  160    ;        62.5            40.0 
L0286   FCB  176    ;        68.8            50.0 
L0287   FCB  192    ;        75.0            60.0 
					;---------------------------------------------
					; AFR PARAM'S 
					;---------------------------------------------
		ORG $0288	;
LD288   FCB  96     ; 37.5% TPS HI/LO THRESH  (GAIM TERM)
			 		; TPS LD = (LD288/64) * A/D TPS - LD289)
			 		;
LD289   FCB  64     ; 25% Min TPS POSIT  (OFF SET TERM)   
					;---------------------------------
LD28A   FCB  32     ; LOW TPS COEF  
LD28B   FCB  255    ; MNR LOOP o2 COEF 
LD28C   FCB  2      ; SLOW o2 COEF FOR IDLE   
			 		;
LD28D   FCB  104    ;  451 mvdc, o2 FILT INIT  
                    ; VAL = N*230.4
			 		;
LD28E   FCB  16     ; COOL FILT COEF  (100 msec reads)
LD28F   FCB  16     ; ACCEL ENRICH DIFF MAP 6 Kpa
         	 		;
LD290   FCB  115    ; FILT COEF TPS  <-------<<< Diff for MG5
LD291   FCB  165    ; FILT COEF TPS  <-------<<< Diff for MG5

LD292   FCB  5      ;  4% DIFF TPS REQ FOR PWR ENRICH WHILE IN PWR ENRICH  <---<<
LD293   FCB  4      ; 244 usec ADDED TO BPW WHILE IAC IS OPENING  
                    ; VAL = MSEC * 16.384
                    ;
LD294   FCB  1      ; 100 MSEC TRANS FUEL CALC Intervle
LD295   FCB  52     ; TPS Filter Coef   <---<<
					;---------------------------------------------
					; CLOSED LOOP TIMER QUALS
					;---------------------------------------------
		ORG $0296	;
LD296   FCB  102    ; 38.9 Deg c, (102f) CLS LP Timer 
                    ; WARM THRESH, (1K PU)
			 		;
LD297   FCB  20     ; 10.0 Sec, WARM CLS LP Timer 
LD298   FCB  95     ; 47.5 Sec, COLD CLS LP Timer
					;---------------------------------
LD299   FCB  64     ; 18c COOL Min for CLS LP Enable 
LD29A   FCB  100    ; 20 Sec's For o2 To exceed window for CLS LP Qualify
					;---------------------------------------------
					; BLM MAP & RPM QUALIFIERS
					; ASDZ, $42 5.7L V8
					;---------------------------------------------
LD29B   FCB  1      ; 10.4 Kpa MAP THRESH FOR BLM     		<*******
LD29C   FCB  254    ; 104  Kpa MAP UPPER THRESH FOR BLM		<*******
LD29D   FCB  140    ; 3500 RPM UPPER BLM THRESH 			<*******
					;---------------------------------------------
					; OPEN LOOP IDLE CALIBRATIONS
					; L05
					;---------------------------------------------           
LD29E   FCB  4      ; 4 MPH, OPN LP IDLE THRESH
LD29F   FCB  5      ; 2%, OPN LP IDLE THRESH TPS  
LD2A0   FCB  1      ; ?? RPM, Open loop RPM thresh IDLE OFF <---< MG5
LD2A1   FCB  2      ; ?? RPM, Open loop RPM thresh IDLE ON  <---< MG5
LD2A2   FCB  160    ; 8 Sec's, Open loop IDLE AFR Ratio enable TIME DELAY
LD2A3   FCB  100    ; 5 Sec's, Open loop IDLE AFR Ratio TIME DELAY  
LD2A4   FCB  137    ; 13.7 Open loop AFR MAX AT IDLE
					;---------------------------------------------
LD2A5   FCB  6      ; 6 MPH Open loop DECEL THRESH
LD2A6   FCB  254    ; 6350 RPM Open loop DECEL THRESH
LD2A7   FCB  0      ; -40c Open loop DECEL THRESH 
					;
LD2A8   FCB  150    ; Open loop AFR MAX 15.0
LD2A9   FCB  135    ; 13.5 LEAN Open loop AFR LMT AT IDLE
LD2AA   FCB  147    ; AFR (STOCH)
					;----------------------------------------------
					;
LD2AB   FCB  8      ; Freq of blk learn update, (600 Msec) 
                    ; VAL = (N * 20)+1 
					;---------------------------------------------
					;
					;                   _______|______|_______|______
					;                          |      |       |
					;                     12   |  13  |  14   |  15    
					;                   _______|______|_______|______  HI MAP 81 Kpa
					;                          |      |       |
					;                      8   |  9   |   10  |  11     
					;                   _______|______|_______|______  MID MAP 58 Kpa
					;                          |      |       |
					;                      4   |  5   |   6   |   7     
					;                   _______|______|_______|______  LO  MAP 18 Kpa
					;                          |      |       |
					;                      0   |  1   |   2   |   3
					;                   _______|______|_______|______
					;                          |      |       |       
					;     750   LO RPM   ______|      |       |
					;                                 |       |
					;    1800   MID RPM  _____________|       |
					;                                         |
					;    2600   HI RPM   _____________________|
					;
					;---------------------------------------------
LD2AC   FCB  30     ;  800 RPM, BLM Cell boundry 
LD2AD   FCB  72     ; 1800 RPM, BLM Cell boundry 
LD2AE   FCB  104    ; 2600 RPM, BLM Cell boundry
					;
LD2AF   FCB  20     ; 20 Kpa, BLM Cell boundry
LD2B0   FCB  128   ; 52 Kpa, BLM Cell boundry
LD2B1   FCB  192    ; 75 Kpa, BLM Cell boundry
					;
LD2B2   FCB  3      ;  75 RPM  BLM cell Hyst  
LD2B3   FCB  8      ; 2.5 Kpa  BLM cell Hyst
					;---------------------------------------------
					; ASDZ INJECTOR FLOW COEF
					;---------------------------------------------
LD2B4   FCB  135    ; BPW const for EGR off, 
					;---------------------------------------------
					; LD2B4 Constant is used for fuel BPW when 
					; EGR is off. 
					;
					; If EGR is on, table LD324 gives a different 
					; contstant vs Vacumm for EGR compensation
					;
					; During EGR transients the val is filtered 
					; between the two constants for smoothing
					;
					;	Values shown for 5.7l engine 
					;---------------------------------------------
					; TBI 
					;   Val = 1461.5  * (VOL/RATE)
					;           VOL  = Vol of 1 Cylinder in liters, (0.7125l)
					;           RATE = Injector flow in gms/sec
					; 				   5.7l = 7.71 gms/sec (61.2#/HR)
					;				   (VOL/RATE) = 0.0924	l/gm/sec
					; 
					; PFI 
					;    Val = 365.375 * (VOL/RATE)
					;           VOL  = Vol of 1 Cylinder in liters, (0.7125l)
					;           RATE = Injector flow in gms/sec
					; 				   5.7l = 1.92751 gms/sec (#/HR)
					;				   (VOL/RATE) = 0.3696 l/gm/sec
					; LD2B4  BPW = 135
					;---------------------------------------------
					; EC PFI 
					;    Val = 365.375 * (VOL/RATE)
					;           VOL  = Vol of 1 Cylinder in liters, (0.7125l)
					;           RATE = Injector flow in gms/sec
					; 				   5.7l = 2.331 gms/sec (#/HR)
					;				   (VOL/RATE) = 0.3056 l/gm/sec
					;  LD2B4  BPW = 112
					;---------------------------------------------
					; EGR OFF TO ON FILTER
					;---------------------------------------------
LD2B5   FCB  15     ; 12.5%, EGR off filter coef
LD2B6   FCB  32     ; 50.0%, EGR  on filter coef
LD2B7   FCB  4      ;  Clsd lp intagrator window val, 4  
LD2B8   FCB  1      ;  BLM modifier (val * 128), 1.28%   
     				;---------------------------------
LD2B9   FCB  172    ; MAX BLM 
LD2BA   FCB  108    ; MIN BLM 
	  				;---------------------------------
LD2BB   FCB  135    ; MAX BLM VALUE AT INIT 
LD2BC   FCB  125    ; MIN BLM VALUE AT INIT
					;---------------------------------------------
					; o2 STATE LIMITS
					; VAL = N*230.4
					;---------------------------------------------
        ORG $02BD	; STAY IN CLSD LOOP WINDOW
     				;---------------------------------
LD2BD   FCB  161    ; 699 mvdc, o2 UPPER LIMIT  
LD2BE   FCB  81     ; 352 mvdc, o2 LOWER LIMIT
					;---------------------------------------------
					; TO GO CLSD LOOP O2 MUST EXCEED 
					; LD2BF - LD2C0 WINDOW 
					;---------------------------------------------
LD2BF   FCB  169    ; 699 mvdc, o2 UPPER LIMIT
LD2C0   FCB  81     ; 352 mvdc, o2 LOWER LIMIT
					;---------------------------------------------
					; CLS LP DECEL, ENLEAN QUALS 
					; Not used closed loop correction
					;---------------------------------------------
LD2C1   FCB  19     ;   17 Kpa, CLS Loop Decel, enlean MAP thresh  
LD2C2   FCB  40     ; 1000 RPM, CLS Loop Decel, enlean RPM thresh  
					;---------------------------------------------
LD2C3   FCB  40     ; CLS LP MIN INTEGRATOR VAL  
LD2C4   FCB  158    ; CLS lP Max INTEGRATOR VAL
					;---------------------------------------------
LD2C5   FCB  160    ; 16..0  MAX AFR 
					;---------------------------------------------
					; CLR FLOOD
					;---------------------------------------------
LD2C6   FCB  166    ; 65% , TPS VALUE, CLEAR FLOOD
LD2C7   FCB  60     ; CLR FLOOD AFR  6.0:1
					;---------------------------------------------
LD2C8   FCB  218    ; 10c, Cool TEMP THRSH FOR COLD START 
                    ; (A/D 1K PU)
					;---------------------------------------------
					; POWER ENRICH  PARAMS
					;
					; IF COOL OUTSIDE WINDOW PWR ENRICH
					; NOT DELAYED	L05 
					;---------------------------------------------
LD2C9   FCB  88     ; 50c, LOWER cool THRSH FOR Pwr Enr BYPASS DELAY
LD2CA   FCB  192    ; 105c, UPPER cool THRSH FOR Pwr Enr  BYPASS DELAY
LD2CB   FCB  26     ;  10.1% PWR ENR TPS HYST   
        			;---------------------------------
LD2CC   FCB  112    ; DELAY PWR ENRICH BELOW 2800 RPM
LD2CD   FCB  179    ; PWR ENRICH NOT DLY'ED IF TPS G.T. 69.9% 
LD2CE   FCB  0      ; Pwr Enr ON DELAY TMR, 0 Sec's   
                    ; VAL = SEC * 20     
					;
LD2CF   FCB  96     ; 55c 131f, COOL TEMP THRSH FOR PWR ENRICH   
LD2D0   FCB  80     ; 2000 RPM THRESH FOR PWR ENRICH
					;---------------------------------------------
					; CHOKE FUNCTIONS
					;
					;---------------------------------------------
LD2D1   FCB  15     ; 1.5:1 AFR PWR ENRICH FOR COLD
LD2D2   FCB  8      ; 1.8 Sec's, COLD AFR (CHOKE) TIME OUT
                    ; N = Sec * 5 -1
LD2D3   FCB  10     ; 2 Sec's, COOL TIME OUT (CHOKE) 
                    ; N = SEC * 5   
					;
LD2D4   FCB  10     ; 2 Sec's, HOT TIME OUT DECAY
LD2D5   FCB  64     ; 80c COOL THRESH FOR TIME OUT DECAY
					;---------------------------------------------
					; BPW PW'S ASDZ, L05, (5.7l) ($42)
					;
					; CAL = MSEC * 65.536
					;---------------------------------------------
LD2D6   FDB  0033   ;   504 usec, MIN BPW HYST VAL
LD2D8   FDB  0020   ;   305 usec, MIN BPW
			 		;
LD2DA   FDB  0026   ;   397 usec, INJ BIAS (ADDED)
LD2DC   FDB  0786   ; 11993 usec,  MAX ASYNCH BPW
                    ; <any excess save & delivered later)
  					;
LD2DE   FDB  0045   ;  686 usec, MIN ASYNC PW
                    ; (shorter is saved till later)
					;----------------------------------------------
					; DECEL ENLEAN PARAMS
					;
					;----------------------------------------------
LD2E0   FCB  3      ; 1% TPS DIFF DECEL ENLEAN INCR THRESH  
LD2E1   FCB  8      ; 2.5 Kpa DIFF DECEL ENLEAN INCR THRESH
LD2E2   FCB  96     ; 0.375  ENLEAN MAP FACTOR 
                    ; (Mult .375 * MAP for calc)
					;---------------------------------------------
					; Limits for FUEL CUT OFF In decel
					;
					; 4 LINE TBL
					;---------------------------------------------
LD2E3   FCB  56    	; 1400 RPM, FUEL CUT OFF, UPPER LIMIT <---<<< MG5
LD2E4   FCB  40    	; 1000 RPM, FUEL CUT OFF, LOWER LIMIT <---<<< +200 RPM
					;
LD2E5   FCB  18     ; 18 MPH, FUEL CUT OFF, UPPER LIMIT    
LD2E6   FCB  15     ; 15 MPH, FUEL CUT OFF, LOWER LIMIT  
					;----------------------------------------------
					;
LD2E7   FCB  8      ; 13.3 Kpa, DECEL FUEL Cut Off MAP Thresh, Lower     
LD2E8   FCB  64     ; 34.0 Kpa, DECEL FUEL Cut Off MAP Thresh, Upper 
          			;
LD2E9   FCB  255    ; RPM/12.5, 6375 RPM  To disable Cut Off, (Decel rate) 
LD2EA   FCB  255    ; MAP inc to disable Decell Fuel Cut Off, 99.6 Kpa 
					;
LD2EB   FDB  0464   ; 7.08 msec, Fuel pulse WHEN EXITING Decell Fuel Cut Off
                    ; by RPM < or Pk/Neut
                    ;---------------------------------
LD2ED   FCB  160    ; 2 Sec REQ FOR DECEL FUEL Cut Off 
LD2EE   FCB  32     ; 400 Msec AFTER DECEL FUEL Cut Off FOR BPW
					;
LD2EF   FCB  240    ; 3 SEC'S Min time between DECEL FUEL Cut Off
                    ; Sec * 80
                    ;---------------------------------
LD2F0   FCB  4      ; 2% MAX TPS FOR DECEL FUEL Cut Off 
					;
LD2F1   FCB  96     ; 0.375 MULT for BPW in decel fuel cut Off
                    ; every 12.5 msec loop
                    ;
LD2F2   FCB  128    ; 75c, DISABLE DECEL FUEL Cut Off BELOW THRESH  
					;---------------------------------------------
					; LOOP CONTROL CONSTANTS
					;---------------------------------------------
LD2F3   FCB  30     ; 130 mvdc, o2 WINDOW FOR FAST o2 R/L
					;
LD2F4   FCB  4      ; 4 Cnt's ERR THRESH FOR INTAGRATOR CORR
LD2F5   FCB  141    ; 0.550, SCALAR FOR MAP LD IN FLOW (1-0) 

LD2F6   FCB  4      ;  
LD2F7   FCB  25     ; 108 mvdc o2 SENSOR BIAS AT IDLE  

LD2F8   FCB  0      ; 0 sec's PORP TERM DURATION AT IDLE
LD2F9   FCB  14     ; PORP GAIN FACTOR FOR FLOW AT IDLE   <----<< MG5
LD2FA   FCB  9      ; INTEGRATOR DELAY BIAS AT IDLE
					;
LD2FB   FCB  232    ; 0.9063  POS ERR MOD FACTOR  FOR RICH o2 AVG
LD2FC   FCB  192    ; 0.75  IDLE ERR CORR TO ERROR	 <---< MG5
					;
LD2FD   FCB  241    ; 200 Deg c THRES FOR PK to DRIVE (1K PU)
LD2FE   FCB  27     ; 2.7 1 RATIO AFR TIME OUT FOR COLD PK to DRIVE
LD2FF   FCB  50     ; 10 SEC DELAY FOR COLD AFR PK to DRV CHANGE
					;
LD300   FCB  30     ;  54c, (129f), SHT DWN TEMP FOR HOT RESTART ENABLE
LD301   FCB  50     ;  90c, (194f), RESTART TEMP FOR HOT RESTART ENABLED
					;
LD302   FCB  20     ; 0.2 AFR Rich bias for hot restart
					;
LD303   FCB  30     ; 30 Steps IAC Bias for hot restart 
LD304   FDB  0010   ; 10 Sec's for Hot restart enabled 
                    ; TIME AFTER START VAL = SEC'S
					;---------------------------------------------
					; MAP FILTER COEF vs COOL
					;
					; USED TO CALC AVG MAP VAL'S
					;
					; 09-10-1997  Dissassemby of asdx  Lines= 6 
					;
					; TBL = COEF * 255
					;---------------------------------------------
LD306   FCB  80     ; UPPER TBL LIMIT
		ORG $0307	;  COEF			Deg c
			 		;---------------------------------
LD307   FCB  13     ;  0.051  		    -5
LD308   FCB  26     ;  0.102	 	    15
LD309   FCB  39     ;  0.152	 	    35
LD30A   FCB  43     ;  0.168  		    55
LD30B   FCB  51     ;  0.199  		    75
LD30C   FCB  102    ;  0.398  		    95
					;---------------------------------------------
					; ACCEL ENRICH vs Diff MAP
					;   **** PUMP SHOT ******
					;
					; 02-01-2000 Dissassemby of asdx
					;  5  BYTES
					;
					;  TBL =  .016384  * usec
					;---------------------------------------------
LD30D   FCB  4      ; 5 lines in table  
        ORG $030E	;      usec            Kap MAP
                    ;---------------------------------
L030E   FCB  2      ;         122               0 
L030F   FCB  4      ;         244              20 
L0310   FCB  7      ;         427              40 
L0311   FCB  10     ;         610              60 
L0312   FCB  12     ;         732              80 
					;---------------------------------------------
					; Accel Enrich vs Diff TPS
					; **** PUMP SHOT ******
					;   
					; 02-01-2000 Disassemby of asdx
					;  9  BYTES
					;
					;  TBL =  .016384  * usec
					;---------------------------------------------
LD313   FCB  128    ; MAX LIMIT 25% TPS DIFF
        ORG $0314	;      usec            Diff TPS%
                    ;---------------------------------
LD314   FCB  1      ;  61              0.0
LD315   FCB  5      ;  305             3.1
LD316   FCB  7      ;  427             6.3
LD317   FCB  10     ;  616             9.4
LD318   FCB  13     ;  793            12.5
LD319   FCB  15     ;  916            15.6
LD31A   FCB  17     ; 1038            18.8
LD31B   FCB  25     ; 1526            21.9
LD31C   FCB  37     ; 2258            25.0
					;---------------------------------------------
					; ACCEL ENRICH COOL TPS FILT COEF vs COOL TEMP
					;
					; TBL = COEF * 255
					;---------------------------------------------
LD31D   FCB 80      ; UPPER TBL LIMIT
                    ;
                    ; COEF      	Deg c COOL
                    ;---------------------------------
LD31E   FCB  26     ; 0.102     	-5
LD31F   FCB  26     ; 0.102     	15
LD320   FCB  32     ; 0.125     	35
LD321   FCB  38     ; 0.148     	55
LD322   FCB  45     ; 0.176     	75
LD323   FCB  64     ; 0.250     	95
					;=============================================
					; 5.7l LD w/Back Pressure EGR (asdx)
					;
					; This tbl provided a corrected value of 
					; effective cyl vol/Inj flow rate when EGR 
					; is active. 
					; 	1. Inj Flow is per bank, in gms/sec
					;	2. Cyl vol is liters/cyl
					;	3. Ratio = cyl vol/Inj flow
					;
					;  The resulting value is used to predict
					;  fuel flow using the speed density method. 
					;
					;  {During EGR off/on transients the value is 
					;  filtered between the value at LD2B4 and the
					;   table value for smoothing}
					;
					;	 189.48 =  .7125L / 7.713 g/sec TBI
					; TBL = 1461.5 * Volume/rate
					;=============================================
					;---------------------------------------------
					; EGR COMP TABLE Vs. AIR FLOW Vs. %EGR
					;
					; 10-05-2000 Dissassemby of ASDX
					; 17 COL x 5 BLOCKS =  85 BYTES
					;
					;  TBL =  189.48  * Cyl Vol
					;---------------------------------------------
        ORG $0324   ;
L0324   FCB	 16     ; MIN EGR % Val
L0325   FCB	 0      ; Min Air Flow Val
L0326   FCB	 17     ; LINES/BLOCK
					;---------------------------------------------
					; 8 Air Flow
					;      Cyl Vol         EGR %
					;---------------------------------------------
L0327   FCB  135    ;    0.7125             0.0
L0328   FCB  135    ;    0.7125             6.3
L0329   FCB  132    ;    0.6966            12.5
L032A   FCB  128    ;    0.6755            18.8
L032B   FCB  123    ;    0.6491            25.0
L032C   FCB  123    ;    0.6491            31.3
L032D   FCB  123    ;    0.6491            37.5
L032E   FCB  123    ;    0.6491            43.8
L032F   FCB  123    ;    0.6491            50.0
L0330   FCB  123    ;    0.6491            56.3
L0331   FCB  123    ;    0.6491            62.5
L0332   FCB  123    ;    0.6491            68.8
L0333   FCB  123    ;    0.6491            75.0
L0334   FCB  123    ;    0.6491            81.3
L0335   FCB  123    ;    0.6491            87.5
L0336   FCB  123    ;    0.6491            93.8
L0337   FCB  123    ;    0.6491           100.0
					;---------------------------------------------
					; 16 Air Flow
					;       Cyl Vol         EGR %
					;---------------------------------------------
L0338   FCB  135    ;    0.7125             0.0
L0339   FCB  135    ;    0.7125             6.3
L033A   FCB  132    ;    0.6966            12.5
L033B   FCB  128    ;    0.6755            18.8
L033C   FCB  123    ;    0.6491            25.0
L033D   FCB  123    ;    0.6491            31.3
L033E   FCB  123    ;    0.6491            37.5
L033F   FCB  123    ;    0.6491            43.8
L0340   FCB  123    ;    0.6491            50.0
L0341   FCB  123    ;    0.6491            56.3
L0342   FCB  123    ;    0.6491            62.5
L0343   FCB  123    ;    0.6491            68.8
L0344   FCB  123    ;    0.6491            75.0
L0345   FCB  123    ;    0.6491            81.3
L0346   FCB  123    ;    0.6491            87.5
L0347   FCB  123    ;    0.6491            93.8
L0348   FCB  123    ;    0.6491           100.0
					;---------------------------------------------
					; 24 Air Flow
					;       Cyl Vol         EGR %
					;---------------------------------------------
L0349   FCB  135    ;    0.7125             0.0
L034A   FCB  135    ;    0.7125             6.3
L034B   FCB  132    ;    0.6966            12.5
L034C   FCB  128    ;    0.6755            18.8
L034D   FCB  123    ;    0.6491            25.0
L034E   FCB  123    ;    0.6491            31.3
L034F   FCB  123    ;    0.6491            37.5
L0350   FCB  123    ;    0.6491            43.8
L0351   FCB  123    ;    0.6491            50.0
L0352   FCB  123    ;    0.6491            56.3
L0353   FCB  123    ;    0.6491            62.5
L0354   FCB  123    ;    0.6491            68.8
L0355   FCB  123    ;    0.6491            75.0
L0356   FCB  123    ;    0.6491            81.3
L0357   FCB  123    ;    0.6491            87.5
L0358   FCB  123    ;    0.6491            93.8
L0359   FCB  123    ;    0.6491           100.0
					;---------------------------------------------
					; 32 Air Flow
					;       Cyl Vol         EGR %
					;---------------------------------------------
L035A   FCB  135    ;    0.7125             0.0
L035B   FCB  135    ;    0.7125             6.3
L035C   FCB  132    ;    0.6966            12.5
L035D   FCB  128    ;    0.6755            18.8
L035E   FCB  123    ;    0.6491            25.0
L035F   FCB  123    ;    0.6491            31.3
L0360   FCB  123    ;    0.6491            37.5
L0361   FCB  123    ;    0.6491            43.8
L0362   FCB  123    ;    0.6491            50.0
L0363   FCB  123    ;    0.6491            56.3
L0364   FCB  123    ;    0.6491            62.5
L0365   FCB  123    ;    0.6491            68.8
L0366   FCB  123    ;    0.6491            75.0
L0367   FCB  123    ;    0.6491            81.3
L0368   FCB  123    ;    0.6491            87.5
L0369   FCB  123    ;    0.6491            93.8
L036A   FCB  123    ;    0.6491           100.0
					;---------------------------------------------
					; 40 Air Flow
					;       Cyl Vol         EGR %
					;---------------------------------------------
L036B   FCB  135    ;    0.7125             0.0
L036C   FCB  135    ;    0.7125             6.3
L036D   FCB  132    ;    0.6966            12.5
L036E   FCB  128    ;    0.6755            18.8
L036F   FCB  123    ;    0.6491            25.0
L0370   FCB  123    ;    0.6491            31.3
L0371   FCB  123    ;    0.6491            37.5
L0372   FCB  123    ;    0.6491            43.8
L0373   FCB  123    ;    0.6491            50.0
L0374   FCB  123    ;    0.6491            56.3
L0375   FCB  123    ;    0.6491            62.5
L0376   FCB  123    ;    0.6491            68.8
L0377   FCB  123    ;    0.6491            75.0
L0378   FCB  123    ;    0.6491            81.3
L0379   FCB  123    ;    0.6491            87.5
L037A   FCB  123    ;    0.6491            93.8
L037B   FCB  123    ;    0.6491           100.0
					;---------------------------------------------
					; MAIN FUEL (VE1) Vs. MAP Vs. RPM
					;  
					; 10-05-2000 Dissassemby of ASDX
					; 8 COL x 9 BLOCKS =  72 BYTES
					;
					;  TBL =  2.56  * VE %
					;---------------------------------------------
        ORG $037C   ;
L037C   FCB	 0      ; MIN RPM Val
L037D   FCB	 16     ; Min KPA MAP Val
L037E   FCB	 8      ; LINES/BLOCK
					;---------------------------------------------
					; 20 KPA MAP
					;      VE %            RPM
					;---------------------------------------------
L037F   FCB  0      ;       0.0             400
L0380   FCB  5      ;       2.0             800
L0381   FCB  15     ;       5.9            1200
L0382   FCB  25     ;       9.8            1600
L0383   FCB  36     ;      14.1            2000
L0384   FCB  46     ;      18.0            2400
L0385   FCB  50     ;      19.5            2800
L0386   FCB  55     ;      21.5           3200
					;---------------------------------------------
					; 30 KPA MAP
					;      VE %            RPM
					;---------------------------------------------
L0387   FCB  28     ;      10.9             400
L0388   FCB  58     ;      22.7             800
L0389   FCB  79     ;      30.9            1200
L038A   FCB  96     ;      37.5            1600
L038B   FCB  107    ;      41.8            2000
L038C   FCB  109    ;      42.6            2400
L038D   FCB  106    ;      41.4            2800
L038E   FCB  90     ;      35.2            3200
					;---------------------------------------------
					; 40 KPA MAP
					;      VE %            RPM
					;---------------------------------------------
L038F   FCB  31     ;      12.1             400
L0390   FCB  64     ;      25.0             800
L0391   FCB  90     ;      35.2            1200
L0392   FCB  103    ;      40.2            1600
L0393   FCB  112    ;      43.8            2000
L0394   FCB  114    ;      44.5            2400
L0395   FCB  118    ;      46.1            2800
L0396   FCB  116    ;      45.3            3200
					;---------------------------------------------
					; 50 KPA MAP
					;      VE %            RPM
					;---------------------------------------------
L0397   FCB  59     ;      23.0             400
L0398   FCB  75     ;      29.3             800
L0399   FCB  97     ;      37.9            1200
L039A   FCB  109    ;      42.6            1600
L039B   FCB  117    ;      45.7            2000
L039C   FCB  122    ;      47.7            2400
L039D   FCB  125    ;      48.8            2800
L039E   FCB  127    ;      49.6            3200
					;---------------------------------------------
					; 60 KPA MAP
					;      VE %            RPM
					;---------------------------------------------
L039F   FCB  79     ;      30.9             400
L03A0   FCB  92     ;      35.9             800
L03A1   FCB  105    ;      41.0            1200
L03A2   FCB  116    ;      45.3            1600
L03A3   FCB  124    ;      48.4            2000
L03A4   FCB  127    ;      49.6            2400
L03A5   FCB  135    ;      52.7            2800
L03A6   FCB  137    ;      53.5            3200
					;---------------------------------------------
					; 70 KPA MAP
					;      VE %            RPM
					;---------------------------------------------
L03A7   FCB  97     ;      37.9             400
L03A8   FCB  100    ;      39.1             800
L03A9   FCB  108    ;      42.2            1200
L03AA   FCB  120    ;      46.9            1600
L03AB   FCB  126    ;      49.2            2000
L03AC   FCB  136    ;      53.1            2400
L03AD   FCB  140    ;      54.7            2800
L03AE   FCB  137    ;      53.5            3200
					;---------------------------------------------
					; 80 KPA MAP
					;      VE %            RPM
					;---------------------------------------------
L03AF   FCB  103    ;      40.2             400
L03B0   FCB  106    ;      41.4             800
L03B1   FCB  113    ;      44.1            1200
L03B2   FCB  123    ;      48.0            1600
L03B3   FCB  131    ;      51.2            2000
L03B4   FCB  135    ;      52.7            2400
L03B5   FCB  140    ;      54.7            2800
L03B6   FCB  141    ;      55.1            3200
					;---------------------------------------------
					; 90 KPA MAP
					;      VE %            RPM
					;---------------------------------------------
L03B7   FCB  110    ;      43.0             400
L03B8   FCB  115    ;      44.9             800
L03B9   FCB  122    ;      47.7            1200
L03BA   FCB  125    ;      48.8            1600
L03BB   FCB  133    ;      52.0            2000
L03BC   FCB  143    ;      55.9            2400
L03BD   FCB  144    ;      56.3            2800
L03BE   FCB  152    ;      59.4            3200
					;---------------------------------------------
					; 100 KPA MAP
					;       VE %            RPM
					;---------------------------------------------
L03BF   FCB  120    ;      46.9             400
L03C0   FCB  120    ;      46.9             800
L03C1   FCB  124    ;      48.4            1200
L03C2   FCB  127    ;      49.6            1600
L03C3   FCB  128    ;      50.0            2000
L03C4   FCB  148    ;      57.8            2400
L03C5   FCB  159    ;      62.1            2800
L03C6   FCB  160    ;      62.5            3200
					;---------------------------------------------
					; MAIN FUEL TBL vs RPM, FL2
					;
					; 01-31-2000 Dissassemby of asdx
					;  17  BYTES
					;
					;  TBL =  2.56  * VE %
					;---------------------------------------------
        ORG $03C7   ;      VE %            RPM
                    ;---------------------------------
L03C7   FCB  64     ;      25.0            0
L03C8   FCB  100    ;      39.1          400
L03C9   FCB  100    ;      39.1          800
L03CA   FCB  100    ;      39.1         1200
L03CB   FCB  100    ;      39.1         1600
L03CC   FCB  100    ;      39.1         2000
L03CD   FCB  100    ;      39.1         2400
L03CE   FCB  100    ;      39.1         2800
L03CF   FCB  100    ;      39.1         3200
L03D0   FCB  105    ;      41.0         3600
L03D1   FCB  100    ;      39.1         4000
L03D2   FCB  95     ;      37.1         4400
L03D3   FCB  95     ;      37.1         4800
L03D4   FCB  95     ;      37.1         5200
L03D5   FCB  95     ;      37.1         5600
L03D6   FCB  95     ;      37.1         6000
L03D7   FCB  95     ;      37.1         6400
					;---------------------------------------------
					; INV COOL TBL, (1K P/U)
					; UESD FOR BPW CALC
					;
					; TBL = 50,000/DEG K
					;---------------------------------------------
		ORG	$03D8	; deg k     deg c   deg f
        			;---------------------------------
LD3D8   FCB  155    ;  323		  49.3	 121		
LD3D9   FCB  122    ;  410		 136.3   277	
LD3DA   FCB  132    ;  379       107.0   225					
LD3DB   FCB  137    ;  365        91.0   196					
LD3DC   FCB  142    ;  352        80.0   176					
LD3DD   FCB  145    ;  345        71.0   160					
LD3DE   FCB  149    ;  336        63.0   145
LD3DF   FCB  152    ;  329        56.0   133
LD3E0   FCB  155    ;  323        49.3   121
LD3E1   FCB  158    ;  317        43.3   110
LD3E2   FCB  161    ;  311        37.0    99
LD3E3   FCB  165    ;  303        30.5    87
LD3E4   FCB  169    ;  296        23.5    74
LD3E5   FCB  173    ;  289        15.5    60
LD3E6   FCB  179    ;  279         6.0    43
LD3E7   FCB  189    ;  265        -8.5    17
LD3E8   FCB  211    ;  237       -36.0   -33
					;---------------------------------------------
					; VOLTAGE COMP vs BATTERY
					;
					; 02-01-2000 Dissassemby of asdx  17 BYTES
					;
					;  TBL =  128  * MULT
					;---------------------------------------------
        ORG $03E9   ;      MULT            Bat VDC
                    ;---------------------------------
LD3E9   FCB  128    ; 1.000          0.0 
LD3EA   FCB  128    ; 1.000          1.6 
LD3EB   FCB  160    ; 1.250		     3.2 
LD3EC   FCB  160    ; 1.250		     4.8
LD3ED   FCB  160    ; 1.250		     6.4
LD3EE   FCB  147    ; 1.148		     8.0
LD3EF   FCB  147    ; 1.148		     9.6
LD3F0   FCB  141    ; 1.100         11.2
LD3F1   FCB  134    ; 1.047         12.8
LD3F2   FCB  128    ; 1.000         14.4
LD3F3   FCB  126    ; 0.984         16.0
LD3F4   FCB  122    ; 0.819         17.6  
LD3F5   FCB  120    ; 0.938         19.2  
LD3F6   FCB  118    ; 0.938         20.8  
LD3F7   FCB  116    ; 0.906         22.4  
LD3F8   FCB  114    ; 0.891         24.0  
LD3F9   FCB  112    ; 0.875         25.5  
					;---------------------------------------------
					; Decel COOLANT FACTOR vs COOLANT TEMP
					;
					; 02-01-2000 Dissassemby of asdx
					;  5  BYTES
					;
					;  TBL =  32  * MULT
					;---------------------------------------------
LD3FA   FCB  4      ; 5 line table   
		ORG $03FB 	;  MULT			Deg c
                    ;---------------------------------
LD3FB   FCB  32     ; 1.00        	COLD   
LD3FC   FCB  56     ; 1.75        	24.0   
LD3FD   FCB  64     ; 2.00        	49.0   
LD3FE   FCB  64     ; 2.00		   	80.5  
LD3FF   FCB  64     ; 2.00		    HOT   
					;---------------------------------------------
					; COLD START CRANK CORR vs %RPM	  Lines= 11
					;
					; Stretches BPW if eng cold & NOT RUNNING based on
					; Pct of engine running RPM
					;
					; TBL = FACTOR * 255
					;---------------------------------------------
LD400   FCB  10     ; 11 LINE TBL
        ORG $0401   ; MULT		     %RPM
                    ;---------------------------------
LD401   FCB  255    ;	0.996			  0    
LD402   FCB  255    ;	0.996			 10
LD403   FCB  255    ;	0.996			 20
LD404   FCB  255    ;	0.996			 30
LD405   FCB  255    ;	0.996			 40
LD406   FCB  255    ;	0.996			 50
LD407   FCB  255    ;	0.996			 60
LD408   FCB  255    ;	0.996			 70
LD409   FCB  243    ;	0.949			 80
LD40A   FCB  230    ;	0.898			 90
LD40B   FCB  218    ;	0.852	        100
					;---------------------------------------------
					; ACCEL ENRICH vs COOLANT
					;
					; 02-01-2000 Dissassemby of asdx
					;  17  BYTES
					;
					;  TBL =  32  * Factor
					;---------------------------------------------
 	     ORG $040C	;  FACTOR         COOL Deg c
    				;---------------------------------
L040C   FCB  160    ;  5.0              COLD
L040D   FCB  160    ;  5.0              -8.5
L040E   FCB  144    ;  4.5               6.0
L040F   FCB  112    ;  3.5              15.5
L0410   FCB  96     ;  3.0              23.5
L0411   FCB  96     ;  3.0              30.5
L0412   FCB  80     ;  2.5              37.0
L0413   FCB  75     ;  2.3              43.3
L0414   FCB  64     ;  2.0              49.3
L0415   FCB  46     ;  1.4              56.0
L0416   FCB  36     ;  1.1              63.0
L0417   FCB  32     ;  1.0              71.0
L0418   FCB  28     ;  0.9              80.0
L0419   FCB  24     ;  0.8              91.0
L041A   FCB  24     ;  0.8             107.0
L041B   FCB  24     ;  0.8             138.5
L041C   FCB  24     ;  0.8               HOT
					;---------------------------------------------
					; COLD ENGINE AIR/FUEL vs VACUUM
					; (OPN LP IF NOT CRANK)
					;
					;  SUM VAC AFR (LD41D) + COOL AFR (LD45A)
					;
					;   TABLE = 10 * A/F RATIO
					;---------------------------------------------
LD41D   FCB  8      ; 9 LINE TABLE   
        ORG $041E   ;      AFR             VAC Kpa
                    ;---------------------------------
L041E   FCB  35     ;       3.5              80
L041F   FCB  33     ;       3.3              70
L0420   FCB  32     ;       3.2              60
L0421   FCB  30     ;       3.0              50
L0422   FCB  25     ;       2.5              40
L0423   FCB  20     ;       2.0              30
L0424   FCB  15     ;       1.5              20
L0425   FCB  10     ;       1.0              10
L0426   FCB  0      ;       0.0               0
					;---------------------------------------------
					; TIME OUT AFR vs COOLANT
					; (SIMULUATED CHOKE)
					;
					; AFTER START UP AFR 
					; ICREASES WITH TIME, SIMULATING A CHOKE. 
					;
					; (TBL VALUED IS SUB'ED FROM CURRENT AFR,
					;   --> SMALL NUM IS LEAN)
					;
					;   TBL =  10  * AFR
					;---------------------------------------------
        ORG $0427	;  AFR       DEG c COOL
        			;---------------------------------
LD427   FCB  59     ;  5.9       COLD
LD428   FCB  45     ;  4.5        -7.0
LD429   FCB  37     ;  3.7         6.5
LD42A   FCB  32     ;  3.2        16.0
LD42B   FCB  27     ;  2.7        24.0
LD42C   FCB  27     ;  2.7        31.0 
LD42D   FCB  27     ;  2.7        37.3
LD42E   FCB  27     ;  2.7        43.7
LD42F   FCB  27     ;  2.7        49.7
LD430   FCB  27     ;  2.7        56.5
LD431   FCB  27     ;  2.7        63.5
LD432   FCB  27     ;  2.7        71.5
LD433   FCB  22     ;  2.2        80.5
LD434   FCB  22     ;  2.2        92.0
LD435   FCB  22     ;  2.2       108.5
LD436   FCB  22     ;  2.2       138.5
LD437   FCB  22     ;  2.2       HOT
					;---------------------------------------------
					; TIME OUT DECAY MULT vs COOL
					;
					; AFTER START UP AFR,
					; INCREASES WITH TIME, SIMULATING A  CHOKE. 
					;
					; TABLE = FACTOR * 256
					;---------------------------------------------
        ORG $0438   ; MULT    Deg c COOL
                    ;---------------------------------
LD438   FCB  243    ; 0.949       COLD
LD439   FCB  248    ; 0.969       -7.0
LD43A   FCB  251    ; 0.980        6.5
LD43B   FCB  251    ; 0.980       16.0
LD43C   FCB  243    ; 0.949       24.0
LD43D   FCB  243    ; 0.949       31.0
LD43E   FCB  251    ; 0.980       37.3
LD43F   FCB  251    ; 0.980       43.7
LD440   FCB  251    ; 0.980       49.7
LD441   FCB  251    ; 0.980       56.5
LD442   FCB  251    ; 0.980       63.5
LD443   FCB  251    ; 0.980       71.5
LD444   FCB  251    ; 0.980       80.5
LD445   FCB  243    ; 0.949       92.0
LD446   FCB  243    ; 0.949      108.5
LD447   FCB  243    ; 0.949      138.5
LD448   FCB  243    ; 0.949      HOT 
					;---------------------------------------------
					; CRANK AFR vs COOL
					;
					; AFR DURING CRANK
					;
					; TBL =  10  * AFR
					;---------------------------------------------
        ORG $0449   ; AFR       Deg c COOL
                    ;---------------------------------
LD449   FCB  7      ;  0.7      COLD
LD44A   FCB  22     ;  2.2       -7.0
LD44B   FCB  30     ;  3.0        6.5
LD44C   FCB  35     ;  3.5       16.0
LD44D   FCB  42     ;  4.2       24.0
LD44E   FCB  49     ;  4.9       31.0
LD44F   FCB  54     ;  5.4       37.3
LD450   FCB  60     ;  6.0       43.7
LD451   FCB  65     ;  6.5       49.7
LD452   FCB  75     ;  7.5       56.5
LD453   FCB  85     ;  8.5       63.5
LD454   FCB  95     ;  9.5       71.5
LD455   FCB  100    ; 10.0       80.5
LD456   FCB  100    ; 10.0       92.0
LD457   FCB  100    ; 10.0      108.5 
LD458   FCB  100    ; 10.0      138.5
LD459   FCB  45     ;  4.5      HOT 
					;---------------------------------------------
					; COLD ENG TEMP AFR vs COOL
					; (OPN LP IF NOT CRANK & CHOKE)
					; SUM VAC AFR (LD41D) + COOL AFR (LD45A)
					; 10-05-2000 Dissassemby of ASDX
					;  17  BYTES
					;
					;  TBL =  10  * AFR
					;---------------------------------------------
        ORG $045A   ;      AFR             COOL c
                    ;---------------------------------
L045A   FCB  72     ;       7.2           -40.0
L045B   FCB  93     ;       9.3            -7.0
L045C   FCB  104    ;      10.4             6.5
L045D   FCB  115    ;      11.5            16.0
L045E   FCB  120    ;      12.0            24.0
L045F   FCB  125    ;      12.5            31.0
L0460   FCB  130    ;      13.0            37.3
L0461   FCB  130    ;      13.0            43.7
L0462   FCB  130    ;      13.0            49.7
L0463   FCB  130    ;      13.0            56.5
L0464   FCB  130    ;      13.0            63.5
L0465   FCB  130    ;      13.0            71.5
L0466   FCB  130    ;      13.0            80.5
L0467   FCB  130    ;      13.0            92.0
L0468   FCB  130    ;      13.0           108.5
L0469   FCB  125    ;      12.5           138.5
L046A   FCB  125    ;      12.5           150.0
					;---------------------------------------------
					; ASYNC MULT vs RPM TABLE  
					; 
					;   THIS MULT IS USED TO CONVERT  SMALL PW 
					;   (PW/CYL)TO ASYNC (PW/12.5 Msec) INJ.
					;   FOR ASYNC INJECTIONS
					;
					; ASYNC IS BOTH INJECTORS, SYMO
					; SYNC  IS ATRNATING INJECTIONS
					;
					; FACTOR = (NUM CYLS/2) * (RPM/60) * (0.0125/2)
					; .0125 = PULSE PERIOD, (80 Hz)
					;
					; TBL = MULT * 64
					;---------------------------------------------
LD46B   FCB  8   	; 9 LINE TABLE
        ORG $046C   ;   MULT        RPM    
                    ;---------------------------------
LD46C   FCB  0      ;   0.000          0 
LD46D   FCB  21     ;   0.328        800
LD46E   FCB  43     ;   0.672       1600
LD46F   FCB  64     ;   1.000       2400
LD470   FCB  85     ;   1.328       3200
LD471   FCB  107    ;   1.672       4000
LD472   FCB  128    ;   2.000       4800
LD473   FCB  149    ;   2.328       5600
LD474   FCB  171    ;   2.672       6400
					;---------------------------------------------
					; BPW CONST MULT vs BARO
					;
					; TBL = MULT * 128
					;---------------------------------------------
        ORG $0475   ;   MULT         BARO Kpa
                    ;---------------------------------
LD475   FCB  136    ;   1.063            75         
LD476   FCB  131    ;   1.023            85
LD477   FCB  128    ;   1.000            95
LD478   FCB  128    ;   1.000           105
					;---------------------------------------------
					; PWR ENRICH TPS MULT vs BARO
					;
					; (MULT CURRENT TPS * THESE MULTIPLIERS)
					;
					; TABLE = FACTOR * 128
					;---------------------------------------------
        ORG $0479   ; FACTOR    BARO Kpa
                    ;---------------------------------
LD479   FCB  187    ; 1.46			 75
LD47A   FCB  187    ; 1.99			 85
LD47B   FCB  255    ; 1.99			 95
LD47C   FCB  255    ; 1.99			105
					;---------------------------------------------
					; TPS vs RPM THRESH FOR WOT ENABLE, ($42)
					; 
					; asdx, ECM 1227747 TYPE $42, 9 LINE TBL
					;
					;  TBL = TPS% * 2.56         
					;---------------------------------------------
		ORG	$047D	;  VDC     TPS %	 RPM          
        			;---------------------------------
LD47D   FCB  64    	;  1.30   	25         0
LD47E   FCB  64    	;  1.30   	25       400
LD47F   FCB  154   	;  3.08   	60       800  
LD480   FCB  154   	;  3.08   	60      1200  
LD481   FCB  140    ;  2.84    	55	    1600
LD482   FCB  128    ;  2.60    	50	    2000
LD483   FCB  128    ;  2.60     50      2400
LD484   FCB  102    ;  2.04   	40      2800
LD485   FCB  102    ;  2.04   	40      3200
					;---------------------------------------------
					; WOT FUEL Vs. RPM
					;
					; 02-01-2000 Dissassemby of asdx
					;  9  BYTES
					;
					;  TBL =  10  * AFR
					;---------------------------------------------
        ORG $0486   ;      AFR          RPM
                    ;---------------------------------
LD486   FCB  136    ;     13.6            0
LD487   FCB  136    ;     13.6          400
LD488   FCB  136    ;     13.6          800
LD489   FCB  132    ;     13.2         1200
LD48A   FCB  127    ;     12.7         1600
LD48B   FCB  127    ;     12.7         2000
LD48C   FCB  127    ;     12.7         2400
LD48D   FCB  127    ;     12.7         2800
LD48E   FCB  132    ;     13.2         3200
					;---------------------------------------------
					; Loop control
					;---------------------------------------------
					;---------------------------------------------
					; INTEGRATOR DELAY vs AIR FLOW
					; 5 LINE TBL USE AIR FLOW 0-64 BIN, ($0054)
					;
					; TBL = msec * 0.040
					;---------------------------------------------
		ORG $048F	; msec	  	   Air Flow
					;---------------------------------
LD48F   FCB  23     ;  575		   0
LD490   FCB  14     ;  350		  16
LD491   FCB  10     ;  250		  32
LD492   FCB  7      ;  175		  48
LD493   FCB  5      ;  125		  64
					;---------------------------------------------
					; MEAN Rich/Lean  THRES FOR UNFILTERED o2
					; AS A FUNCTION OF FLOW
					;
					;  TBL = 0.2304 * mvdc
					;---------------------------------------------
        ORG $0494   ;      mVDC            Air Flow
                    ;---------------------------------
L0494   FCB  100    ;       434               0
L0495   FCB  96     ;       417              16
L0496   FCB  94     ;       408              32
L0497   FCB  94     ;       408              48
L0498   FCB  94     ;       408              64
					;---------------------------------------------
					; RICH o2 THRESHOLD as FUNCT OF AIR FLOW
					;
					;  TBL = 0.2304 * mvdc
					;---------------------------------------------
        ORG $0499   ;      mVDC            Air Flow
                    ;---------------------------------
L0499   FCB  115    ;       499               0
L049A   FCB  104    ;       454              16
L049B   FCB  94     ;       408              32
L049C   FCB  94     ;       408              48
L049D   FCB  94     ;       408              64
					;---------------------------------------------
					; LEAN o2 THRES as FUNCT OF AIR FLOW
					;
					; TBL = 230.4 * VDC
					;---------------------------------------------
        ORG $049E   ;      mVDC            Air Flow
                    ;---------------------------------
L049E   FCB  90     ;       391               0
L049F   FCB  92     ;       399              16
L04A0   FCB  94     ;       408              32
L04A1   FCB  94     ;       408              48
L04A2   FCB  94     ;       408              64
					;---------------------------------------------
					; SLOW o2 FILTER TIME CONSTANT vs AIR FLOW
					; ASDX.BIN, (TYPE $42)
					;
					; TBL =	CONST * 256
					;---------------------------------------------
        ORG $04A3 	;  CONST      Air Flow
                    ;---------------------------------
LD4A3   FCB  7      ;   2.73			 0     
LD4A4   FCB  10     ;   3.91			16
LD4A5   FCB  16     ;   6.25			32
LD4A6   FCB  22     ;   8.59			48
LD4A7   FCB  26     ;  10.16			64
					;---------------------------------------------
					; PORPORTIONAL VALUE vs SLOW o2 ERROR
					; FOR SELECTING BIN VAL TO ADJUST THE INTEGRATOR
					;
					; TBL = BIN * 1
					;---------------------------------------------
		ORG	$04A8	; BIN			o2 ERROR
        			;---------------------------------
LD4A8   FCB  12     ; 	12		 	 0
LD4A9   FCB  12     ; 	12		 	 8
LD4AA   FCB  12     ; 	12		 	16
LD4AB   FCB  12     ; 	12		 	24
LD4AC   FCB  13     ; 	13		 	32
LD4AD   FCB  16     ; 	16		 	40
LD4AE   FCB  16     ; 	16		 	48
LD4AF   FCB  18     ; 	18		 	56
LD4B0   FCB  22     ; 	22		 	64
LD4B1   FCB  28     ; 	28		 	72
LD4B2   FCB  32     ; 	32		 	80
LD4B3   FCB  36     ; 	36		 	88
LD4B4   FCB  40     ; 	40		 	96
					;---------------------------------------------
					; PORP TERM DURATION o2 ERROR
					; FOR SELECTING SEC'S TO ALLOW ADJUST TO TAKE AFFECT
					;
					; 02-01-2000 Dissassemby of asdx
					;  13  BYTES
					;
					;  TBL =  .04  * Sec
					;---------------------------------------------
        ORG $04B5   ;  MSec       o2 ERROR
                    ;---------------------------------
LD4B5   FCB  1      ;    25     	0 
LD4B6   FCB  2      ;    50     	8
LD4B7   FCB  3      ;    50     	16
LD4B8   FCB  3      ;    70     	24
LD4B9   FCB  4      ;   100     	32
LD4BA   FCB  5      ;   139     	40
LD4BB   FCB  8      ;   200     	48
LD4BC   FCB  12     ;   300     	56
LD4BD   FCB  24     ;   600     	64
LD4BE   FCB  48     ;  1200     	72
LD4BF   FCB  96     ;  2400     	80
LD4C0   FCB  240    ;  4800     	88
LD4C1   FCB  240    ;  4800     	96
					;---------------------------------------------
					; PORP DURATION OFFSET TBL vs AIR FLOW
					;
					; TBL = SEC'S * 40
					;---------------------------------------------
        ORG	$04C2   ;    msec   	AIR FLOW
                    ;---------------------------------
LD4C2   FCB  0      ;     0   	     	 0
LD4C3   FCB  0      ;     0   	     	16
LD4C4   FCB  1      ;     25 	     	32
LD4C5   FCB  1      ;     25 	     	48
LD4C6   FCB  0      ;      0   	     	64
					;---------------------------------------------
					; PORP GAIN FLOW FACTOR vs AIR FLOW
					;
					; Used to modify porp gain count.
					; 
					;  TBL =  2.56  * GAIN %
					;---------------------------------------------
        ORG $04C7   ;      GAIN %          Air Flow
                    ;---------------------------------
L04C7   FCB  35     ;     13.67               0
L04C8   FCB  45     ;     17.58              16
L04C9   FCB  70     ;     27.34              32
L04CA   FCB  80     ;     31.25              48
L04CB   FCB  96     ;     37.50              64
					;----------------------------------------------
					; INT DELAY MULT vs SLOW O2 ERROR
					; 
					; 10-06-2000 Dissassemby of ASDX
					;  13  BYTES
					;
					;  TBL =  256  * Mult
					;---------------------------------------------
        ORG $04CC   ;      Mult            o2 ERROR
                    ;---------------------------------
L04CC   FCB  255    ;     0.996               0
L04CD   FCB  255    ;     0.996               8
L04CE   FCB  255    ;     0.996              16
L04CF   FCB  224    ;     0.875              24
L04D0   FCB  192    ;     0.750              32
L04D1   FCB  160    ;     0.625              40
L04D2   FCB  112    ;     0.438              48
L04D3   FCB  96     ;     0.375              56
L04D4   FCB  96     ;     0.375              64
L04D5   FCB  112    ;     0.438              72
L04D6   FCB  160    ;     0.625              80
L04D7   FCB  192    ;     0.750              88
L04D8   FCB  192    ;     0.750              96
					;----------------------------------------------
					; O2 SENS VOLTAGE BIAS FOR COLD OP'S
					;              
					; TBL = VDC * 230.4
					;----------------------------------------------
LD4D9   FCB  192    ; 105 Deg c, UPPER TBL LIMT 
        ORG $04DA   ;      mVDC            COOL c
                    ;---------------------------------
L04DA   FCB  0      ;       0.0           -40.0
L04DB   FCB  0      ;       0.0            -7.0
L04DC   FCB  0      ;       0.0             6.5
L04DD   FCB  0      ;       0.0            16.0
L04DE   FCB  4      ;      17.4            24.0
L04DF   FCB  4      ;      17.4            31.0
L04E0   FCB  4      ;      17.4            37.3
L04E1   FCB  4      ;      17.4            43.7
L04E2   FCB  4      ;      17.4            49.7
L04E3   FCB  4      ;      17.4            56.5
L04E4   FCB  4      ;      17.4            63.5
L04E5   FCB  4      ;      17.4            71.5
L04E6   FCB  0      ;       0.0            80.5
					;---------------------------------------------
					;  ALDL XMIT TABLE OR ADDRESSE'S
					; 127747 ECM
					;
					;  5.7L TBI    L05 C/K    87,91 TRUCKS
					;
					; DATA PIN: Read data on PIN "E" of ALDL Connector
					;
					; BAUD RATE:  160 Baud
					;             Open 		- 20 Bytes
					;             10k  		- 20 Bytes
					;             Shorted 	- 20 Bytes
					;
					;---------------------------------------------
    	ORG $04E7	;
LD4E7   FDB $D002   ; 1.  EPROM ID LSB
LD4E9   FDB $D003   ; 2.  EPROM ID MSB
					;---------------------------------
LD4EB   FDB $00FD   ; 3.  CURRENT IAC POSIT, (0-255)
					;	  N = COUNTS
					;---------------------------------
LD4ED   FDB $0025   ; 4.  COOLANT
					;	  see table 1
					;---------------------------------
LD4EF   FDB $0034   ; 5.  MPH,
					;	  (MPH/1)
					;---------------------------------
LD4F1   FDB $002D   ; 6.  MAP, (A/D, 0-255)
					;	  VOLTS = N * .0196
					;---------------------------------
LD4F3   FDB $001C   ; 7.  RPM/25
					;	  RPM = N * 25
					;---------------------------------
LD4F5   FDB $0048   ; 8.  TPS (A/D, 0-255)
					;	  VOLTS = N * .0196
					;---------------------------------
LD4F7   FDB $00A4   ; 9.  INTIGRATOR, (0-255)
					;
					;---------------------------------
LD4F9   FDB $003E   ; 10. o2 (A/D)
					;	  mvdc = 0.2304 * A/D VAL
					;---------------------------------
LD4FB   FDB $00E0   ; 11. ERROR WD 1   MALFFLG1  
					;
					; b7 Err  NO DRP'S
					; b6 Err  13 Oxygen sensor
					; b5 Err  14 Coolant sensor HIGH
					; b4 Err  15 Coolant sensor LOW
					;
					; b3 Err  21 TPS, HI
					; b2 Err  22 TPS, LOW
					; b1 Err  23 (not used)
					; b0 Err  24 Vss ERR
					;---------------------------------
LD4FD   FDB $00E1   ; 12. ERROR WD 2  MALFFLG2
					;
					; b7 Err 43 ESC FAILURE
					; b6 Err 44 Oxygen sensor LEAN
					; b5 Err 45 Oxygen sensor RICH
					; b4 Err 51 PROM Error
					;
					; b3 Err 52 CAL PACK MISSING
					; b2 Err 	(not used)
					; b1 Err 54 FUEL PUMP relay failure
					; b0 Err 55	ADU ERROR 
					;---------------------------------
LD4FF   FDB $00E2   ; 13. ERROR WD 3  MALFFLG3
					;
					; b7 Err 25 (not used)
					; b6 Err 31 (not used)
					; b5 Err 32	 EGR Err
					; b4 Err 33  MAP  Sensor  High err
					;
					; b3 Err 34 MAP Sensor Low err
					; b2 Err 35	(not used)
					; b1 Err 41	(not used)
					; b0 Err 42 EST Monitor err
					;---------------------------------
LD501   FDB $000E   ; 14. MAWF1, (FLAG), b1, 4, 7 & b6
					;
					; b7 1 = CLOSED LOOP FLAG
					; b6 1 = RICH/LEAN FLAG, (1 = RICH)
					; b5 1 = OLD HIGH GEAR FLAG
					; b4 1 = ASYNCHRONOUS FLAG
					;
					; b3 1=  4-3 DOWNSHIFT FOR TCC UNLOCK
					; b2 1 = LOW BATTERY
					; b1 1 = BLM ENABLE 
					; b0 1 = CLEAR FLOOD IN CRANK
					;---------------------------------
LD503   FDB $0045   ; 15. 	BATTERY VOLTS, (A/D, 0-255)
					; 		VOLTS = N * .1
					;---------------------------------
LD505   FDB $0801   ; 16. 	MCU2IO
					;
          			;	b7   AIR CONDITIONER, 0 = A/C Requested
          			;	b6   FRTJ (not used)
          			;	b5   HIGH GEAR        1 = On
          			;	b4   PARK NEUTRAL     0 = Drive
					;
          			;	b3   TCC              1 = TCC locked
          			;	b2   OF3 A/C          1 = A/C disabled
          			;	b1   AIR DIVERT       1 = Solenoid engaged
          			;	b0   AIR SWITCH       1 = Solenoid engaged
      				;
					;---------------------------------
LD507   FDB $0073   ; 17. 	OLD PA3
					;		N = COUNTs
					;---------------------------------
LD509   FDB $00A3   ; 18. 	BLM, (BLM/1
					;
					;---------------------------------
LD50B	FDB $00BA   ; 19. 	O2 CROSS COUNTS                
					;		N = COUNTS
					;=============================================
					;
					;	TABLE 1 --- COOLANT TEMPERATURE
					;
					;
					;	 A/D          DEGREES
					;	COUNTS           C
					;	-------       -------
					;	255            -40
					;	251            -30
					;	250            -25
					;	247            -20
					;	245            -15
					;	241            -10
					;	237            - 5
					;	231              0
					;	225              5
					;	218             10
					;	209             15
					;	199             20
					;	189             25
					;	177             30
					;	165             35
					;	152             40
					;	139             45
					;	126             50
					;  	114             55
					;  	102             60
					;  	92              65
					;  	81              70
					;  	72              75
					;  	64              80
					;  	56              85
					;  	50              90
					;  	44              95
					;  	39             100
					;  	34             105
					;  	30             110
					;   26             115
					;   23             120
					;   21             125
					;   18             130
					;   16             135
					;   14             140
					;   13             145
					;   12             150
					;    0             200
					;
					;=============================================
					;---------------------------------------------
					; DIAGNOSTIC PRAM MASK'S
					;
					; 	0 = disable error recognition
					; 	1 = Enable error recognition
					;
					;---------------------------------------------
		ORG $050D	;
					;---------------------------------
LD50D   FCB $FD 	; Mask for MALFFLG1,  1111 1101b
        			;
    		    	; 1  bit 0   code 24, VSS            
		        	; 0  bit 1   code 23, MAT Sensor lo temp, (NOT USED)
        			; 1  bit 2   code 22, TPS lo
        			; 1  bit 3   code 21, TPS hi
					;
        			; 1  bit 4   code 15, Coolant sensor lo
        			; 1  bit 5   code 14, Coolant Sensor Hi
        			; 1  bit 6   code 13, o2 sensor 
        			; 1  bit 7   code 12, No ref's, (eng not running ?)
	            	;---------------------------------
LD50E   FCB $39 	; Mask for MALFFLG2,  0011 1001
	            	;
    		    	; 1  bit 0  code 42, EST Mon error          
        			; 0  bit 1  code 41, NO DRP , (NOT USED)
        			; 0  bit 2  code 35, IAC ERROR, (NOT USED)
        			; 1  bit 3  code 34, MAP Sensor low
					;
        			; 1  bit 4  code 33, MAP Sensor hi
        			; 1  bit 5  code 32, EGR failure
        			; 0  bit 6  code 31, MAP LOW, (NOT USED)
        			; 0  bit 7  code 25, MAT Sensor high temp, (NOT USED)
            		;---------------------------------
LD50F   FCB $F9 	; Mask for MALFFLG3, 1111 1001
            		;
        			; 1  bit 0  code 55, ADU Error
        			; 0  bit 1  code 54, Fuel pump relay malfunction
        			; 0  bit 2  code 53, VATS, (NOT USED)
        			; 1  bit 3  code 52, Cal-pack missing
					;
        			; 1  bit 4  code 51, EPROM error
        			; 1  bit 5  code 45, o2 Rich
        			; 1  bit 6  code 44, o2 Lean
        			; 1  bit 7  code 43, ESC failure
        			;---------------------------------
        			;---------------------------------
LD510   FCB  50 	; Num of successive pwr ups w/no errors
                	; AFTER 50 Ok START'S ARR'S WILL BE RESET
					;---------------------------------------------
					; ERROR LOG TIME CONSTANTS
					;---------------------------------------------
LD511   FCB  10     ; CONST 1,  1 Ssec  
LD512   FCB  20     ; CONST 2,  2 Sec
LD513   FCB  100    ; CONST 3, 10 Sec
LD514   FCB  120    ; CONST 4, 12 Sec
					;---------------------------------------------
					; Error 13 param's
					; o2 Sensor
					;---------------------------------------------
LD515   FCB  60     ; Time since run eable, (120 Sec)
        			;---------------------------------
        			; TEST o2 WINDOW
        			;---------------------------------
LD516   FCB  81     ; 352 mvdc, o2 Sensor Lo limit
LD517   FCB  127    ; 552 mvdc, o2 Sensor Hi limit
LD518   FCB  13     ; TPS Min limit, (5%)
LD519   FCB  30     ; Time limit, (60 Sec)
					;---------------------------------------------
					; Error 13/14 param's
					; o2/MAP
					;---------------------------------------------
LD51A   FCB  81     ; Coolant Min thresh, (65 c, 159f) 1k PU
					;---------------------------------------------
					; Error 14 param's
					; HI COOLANT TEMP
					;---------------------------------------------
LD51B   FCB  1      ; TIME SINCE RUN ENABLE, (1 SEC)
LD51C   FCB  16     ; COOLANT HI LIMIT, (135c, 275f)
                    ; 1k PU
					;---------------------------------------------
					; Error 15 param's
					; HI COOLANT TEMP
					;---------------------------------------------
LD51D   FCB  0      ; TIME SINCE RUN ENABLE
LD51E   FCB  253    ; COOLANT LOW LIMIT, (-35c, -31f)
					;---------------------------------------------
					; Error 14/15 param
					; Coolant default
					;---------------------------------------------
LD51F   FCB  126    ; 50c, 122f Coolant default
					;---------------------------------------------
					; error 21 param's
					; TPS High
					;---------------------------------------------
LD520   FCB  128    ; TPS limit, (2.5vdc)
LD521   FCB  80     ; Time limtit, (8 Sec)
LD522   FCB  112    ; Baro limit, (51.7 Kpa)
					;---------------------------------------------
					; error 22 param's
					; Low TPS
					;---------------------------------------------
LD523   FCB  10     ; TPS limit, 0.20 VCD
LD524   FCB  48     ; DEFAULT TPS, 0.96 VDC
					;---------------------------------------------
					; ERR 24 
					; VSS
					;---------------------------------------------
LD525   FCB  4      ; 4 MPH VSS LIMIT
					;---------------------------------
        			; Valid test RPM window
					;---------------------------------
LD526   FCB  56     ;  1400 RPM LO LIMIT <---<<< +400 RPM MG5 
LD527   FCB  240    ;  6000 RPM HI LIMIT
					;---------------------------------
LD528   FCB  40     ; 30.6 Kpa MAP LIMIT
LD529   FCB  92     ; 65c, (149f) COOL LMT, 1k PU
					;
LD52A   FCB  5      ; 5 SEC TIME LMT
					;---------------------------------------------
					; ERR 32 
					; >> EGR <<
					;---------------------------------------------
LD52B   FCB  30     ; 30 Sec's DIAG CYCLE TIME
					;
        			; ENABLED IF IN MAP WINDOW
					;---------------------------------
LD52C   FCB  80     ; 38.2 Kpa, LO LD DISABLE
LD52D   FCB  208    ; 87.1 Kpa, HI LD DISABLE 
					;
        			; ENABLED IF IN TPS WINDOW
					;---------------------------------
LD52E   FCB  17     ; 6.6% LO TPS LIMIT
LD52F   FCB  64     ; 25%  HI TPS LIMIT
					;---------------------------------
LD530   FCB  250    ; 98% EGR ON THRESH
LD531   FCB  25     ; 2.5 SEC'S EGR ERR DELAY TMR
LD532   FCB  3      ; 3 CNTS FAIL CNT'T THRESH
LD533   FCB  10     ; 3.9% TPS, CHNG TO DISABLE TEST
					;---------------------------------
LD534   FCB  28     ; 2.8 Sec's TEST DURRATION
LD535   FCB  4      ; INTIGRATOR CNT LESS FOR EGR FAULT
LD536   FCB  45     ; 45 MPH REQ TO ENABLE TEST
LD537   FCB  255    ; 99.6% EGR D.C, DECREMENT FOR TEST IN WORK
        	        ; (Big Blk IS TYP 50%)
					;---------------------------------------------
					; error 33 param's
					; Hi MAP
					;---------------------------------------------
LD538   FCB  10     ; 0.20 VDC TPS limit  
LD539   FCB  156    ; MAP limit, (68 Kpa) 
LD53A   FCB  50     ; Time limit, (5 Sec)
					;---------------------------------------------
					; error 34 param's
					; Lo MAP
					;---------------------------------------------
LD53B   FCB  10     ; MAP limit, (23 Kpa)
LD53C   FCB  64     ; 1200 RPM, (TBL)
					;
LD53D   FCB  2      ; 0.02 SEC TIME LIMIT (SEC * 80)
LD53E   FCB  54     ; 1.08 VDC TPS LMT 
LD53F   FCB  218    ; 90.8 Kpa DEFAULT MAP IF ERR BEFORE (NOT RUNNING)
					;---------------------------------------------
					; ERROR 33/34 PARAM
					; MAP DEFAULT COEFF
					;---------------------------------------------
LD540   FCB  150    ; (2.34)         VAL = COEF * 64
					;---------------------------------------------
					; MAP BIAS DEFAULT
					; vs RPM
					;---------------------------------------------
LD541   FCB  64     ; UPPER TBL LIMIT 
	    ORG $0542   ; RPM/SPD A/D VAL,	 RPM
					;---------------------------------
LD542   FCB  112    ;     112		     800 
LD543   FCB  85     ;     85 		    1600    
LD544   FCB  51     ;     51 		    2400
LD545   FCB  35     ;     35 		    3200
					;---------------------------------------------
					; ERROR 42
					; EST MONITOR
					;---------------------------------------------
LD546   FCB  4      ; RPM limit, (450 RPM)
LD547   FCB  0      ; Num PA1 cnt's for error
LD548   FCB  4      ; Num of EST faults for 42A
LD549   FCB  4      ; Num of EST faults for 42B
					;---------------------------------------------
					; ERROR 43
					;
					; ESC FAIL
					;---------------------------------------------
LD54A   FCB  0      ; 0 SEC Eng run time prior to test  
LD54B   FCB  120    ; 240 SEC'S, Min time since run enable
LD54C   FCB  235    ; PA count limit
					;
LD54D   FCB  23     ; 2.3 SEC'S, EST fail test period
LD54E   FCB  3      ; TEST DURATION 
					;
LD54F   FCB  55     ; 84c, 183f ERR 43 TEMP LIMIT   
LD550   FCB  34     ; 105c, 221f ERR 43 HOT TEMP LIMIT   
					;
LD551   FCB  128    ; 3200 RPM LIMIT
LD552   FCB  195    ; 82 Kpa MAP LIMIT (TBL)
					;---------------------------------------------
					; SA TO FORCE KNK FOR TEST
					;---------------------------------------------
LD553   FCB  34     ; 11.9 Deg SA TEST SPK1ST Pwr Enr MODE 
LD554   FCB  63     ; 22.2 Deg SA TEST SPK 2ND Pwr Enr MODE
					;
LD555   FCB  2      ; KNOCK ACCUM LIMIT 
					;---------------------------------------------
					; ERR 44
					;---------------------------------------------
LD556   FCB  34     ; 148 mvdc o2 LOW LIMIT 
LD557   FCB  20     ; 20 Sec TIME REQ
					;---------------------------------------------
					; ERROR 45
					; RICH o2
					;---------------------------------------------
LD558   FCB  173    ; 751 mvdc, o2 SENSOR HI LIMIT,
LD559   FCB  60     ; 60 Sec's, TIME LIMIT
					;
LD55A   FCB  13     ; 13%, TPS HI LIMIT
LD55B   FCB  0      ; 0%,  TPS LO LIMIT
					;---------------------------------------------
					; ERROR 54
					; PUMP RELAY ERROR
					;---------------------------------------------
LD55C   FCB 30      ; Fuel pump delay time .. fm ign on to test bgn
					;=============================================
					; END OF DIAGNOSTICS
					;=============================================
					;---------------------------------------------
					;  AIR MANAGMENT PARMS TYPE $42, ASDZ
					;
					; NO AIR INJ, PUT 255 AT LD562 TO DISABEL
					; els USE 32 FOR ENABLE
					;---------------------------------------------
		ORG $055D	;
LD55D   FCB  0      ;  0 Kpa DIFF MAP THRESH
LD55E   FCB  0      ; DIVERT TIME
LD55F   FCB  2      ; MJR LP o2 COEF
LD560   FCB  192    ; 105c Cool, COOL TEMP
LD561   FCB  0      ; 0 Kpa MAX MAP FOR DIVERT
LD562   FCB  255    ; Disable air inj 
LD563   FCB  5      ; 5 Sec Air to Ports if in PWR enrich
					;---------------------------------------------
					; TCC PARAMS
					;
					;---------------------------------------------
LD564   FCB  112    ; 60c, TCC LOWER TEMP THRES
					;
LD565   FCB  3      ; TCC LD PARAM  SELECT 
                    ; 0000 0000 = VAC
                    ; 0000 0001 = MAP
                    ; 0000 0011 = TPS
  					;
LD566   FCB  0      ; 0 MPH TCC COAST RELEASE 
           			;--------------------------------------
LD567   FCB  7      ; 2.7% TPS, TCC COAST LO MPH LD LIMIT
LD568   FCB  7      ; 2.7% TPS, TCC COAST HI MPH LD LIMIT
LD569   FCB  1      ; .4% TPS HYST FOR COAST LD'S ,(2 ABOVE) 
          			;---------------------------------------
LD56A   FCB  0      ; 0 Sec COAST RELEASE TMR, (SEC * 10) 
					;
LD56B   FCB  255    ; MPH LAG FILT COEF
LD56C   FCB  1      ; 0.1 SEC, TCC DLY AFTER 4 -> 3 DN SHFT
                    ; 1 = NOP
					;
LD56D   FCB  5      ; 0.5 SEC TCC DLY BEFORE LOCK ENAB AFTER
                    ; OTHER CONDITIONS OK.
LD56E   FCB  100    ; 100 MPH TCC WILL NOT UNLOCK IF GT
					;---------------------------------------------
					; LO GEARS TCC
					;
					;---------------------------------------------
        ORG $056F   ; UNLOCK TO LOCK, LOW GEARS
                    ;---------------------------------
LD56F   FCB 26      ;   26 MPH, LO VSS LMT 
LD570   FCB 52      ; 1300 RPM, HI RPM LMT 
                    ;---------------------------------
  					;
                    ;---------------------------------
        ORG $0571   ; LOCK TO UNLOCK, LOW GEARS 
                    ;---------------------------------
LD571   FCB 24      ;  24 MPH, LO MPH   
LD572   FCB 36      ; 900 RPM, LO MPH
					;---------------------------------------------
					; TCC LD LIMIT vs MPH or RPM
					; LOW GEARS 
					;
					; Also used for shift light
					;
					; TABLE = %LD * 2.56
					;---------------------------------------------
					; UPPER LIMIT
					;---------------------------------------------
        ORG	$0573   ; %     	MPH     RPM 
                    ;---------------------------------
L0573   FCB  38     ;  14.8     10      1000
L0574   FCB  38     ;  14.8     15      1100
L0575   FCB  38     ;  14.8     20      1200
L0576   FCB  51     ;  19.9     25      1300
L0577   FCB  67     ;  26.2     30      1400
L0578   FCB  82     ;  32.0     35      1500
L0579   FCB  95     ;  37.1     40      1600
L057A   FCB  115    ;  44.9     45      1700
L057B   FCB  128    ;  50.0     50      1800
L057C   FCB  128    ;  50.0     55      1900
L057D   FCB  128    ;  50.0     60      2000
					;---------------------------------------------
					; LOW GEARS, LOW LIMIT
					;---------------------------------------------
        ORG $057E   ; %     	MPH     RPM 
                    ;---------------------------------
L057E   FCB  0      ;  0.0    	10      1000
L057F   FCB  0      ;  0.0   	15      1100
L0580   FCB  13     ;  5.0    	20      1200 
L0581   FCB  26     ;  10.2    	25      1300
L0582   FCB  36     ;  14.1    	30      1400
L0583   FCB  49     ;  19.1    	35      1500
L0584   FCB  59     ;  23.0    	40      1600
L0585   FCB  72     ;  28.1    	45      1700
L0586   FCB  82     ;  32.0    	50      1800
L0587   FCB  82     ;  32.0    	55      1900
L0588   FCB  82     ;  32.0    	60      2000
					;---------------------------------------------
					; HI GEARS TCC
					;
					;---------------------------------------------
        ORG $0589   ; UNLOCK TO LOCK
                    ;---------------------------------
LD589   FCB 26      ; LO MPH UNLOCKED TCC, HI GEARS  
LD58A   FCB 52      ; HI MPH UNLOCKED TCC, HI GEARS
                    ;---------------------------------
        ORG $058B   ; LOCK TO UNLOCK
                    ;---------------------------------
LD58B   FCB 24      ; LO MPH LOCKED TCC, HI GEARS  
LD58C   FCB 36      ; HI MPH LOCKED TCC, HI GEARS    
					;---------------------------------------------
					; TCC LD LIMIT vs MPH or RPM
					; HI GEARS  
					;
					; Also used for shift light
					;
					; TABLE = %LD * 2.56
					;---------------------------------------------
					; UPPER LIMIT
					;---------------------------------------------
        ORG $058D   ; %     	MPH     RPM 
                    ;---------------------------------
L058D   FCB  38     ;  14.8   	10      1000  
L058E   FCB  38     ;  14.8    	15      1100  
L058F   FCB  38     ;  14.8    	20      1200  
L0590   FCB  51     ;  19.9    	25      1300  
L0591   FCB  67     ;  26.2    	30      1400  
L0592   FCB  82     ;  32.0    	35      1500
L0593   FCB  95     ;  37.1    	40      1600
L0594   FCB  115    ;  44.9    	45      1700
L0595   FCB  128    ;  50.0    	50      1800 
L0596   FCB  128    ;  50.0    	55      1900 
L0597   FCB  128    ;  50.0    	60      2000 
					;--------------------------------------
					; LOWER LIMIT
        ORG $0598   ; %     	MPH     RPM 
                    ;---------------------------------
L0598   FCB  26     ;  10.2		10      1000
L0599   FCB  26     ;  10.2		15      1100
L059A   FCB  26     ;  10.2		20      1200
L059B   FCB  26     ;  10.2		25      1300
L059C   FCB  36     ;  14.1		30      1400
L059D   FCB  49     ;  19.1		35      1500
L059E   FCB  59     ;  23.0		40      1600
L059F   FCB  72     ;  28.1		45      1700
L05A0   FCB  82     ;  32.0		50      1800
L05A1   FCB  82     ;  32.0		55      1900
L05A2   FCB  82     ;  32.0		60      2000
					;---------------------------------------------
					; SHIFT LIGHT PARAMS
					;---------------------------------------------
					; UPPER RPM/MPH VAL OF A PAIR USED  TO CALC 
					; BEST RANGE
					;---------------------------------------------
		ORG $05A3	;
LD5A3   FCB  0      ;
LD5A4   FCB  255    ; RPM/MPH HI RATIO  1st GR
LD5A5   FCB  80     ; RPM/MPH HI RATIO  2nd GR
LD5A6   FCB  45     ; RPM/MPH HI RATIO  3rd GR
LD5A7   FCB  35     ; RPM/MPH HI RATIO  4th GR
					;---------------------------------------------
					; LOWER RPM/MPH VAL OF A PAIR USED  TO CALC 
					; BEST RANGE
					;---------------------------------------------
		ORG $05A8	;
LD5A8   FCB  110    ; RPM/MPH LOW RATIO  1st GR 
LD5A9   FCB  55     ; RPM/MPH LOW RATIO  2nd GR 
LD5AA   FCB  34     ; RPM/MPH LOW RATIO  3rd GR 
LD5AB   FCB  23     ; RPM/MPH LOW RATIO  4th GR 
					;---------------------------------------------
					; ENABLE LITE ON  PARAMS
					; (FOR MG5) 
					;---------------------------------------------
		ORG $05AC	;
LD5AC   FCB  64     ; 1600 RPM, IF 1ST GR IF G.T. THRESH
LD5AD   FCB  64     ; 1600 RPM, IF 2ND GR IF G.T. THRESH
LD5AE   FCB  254    ; 6350 RPM, IF 3RD GR IF G.T. THRESH
LD5AF   FCB  254    ; 6350 RPM, IF 4TH GR IF G.T. THRESH
					;----------------------------------------------
					; 0 - 2  MULT FOR ADJ TPS
					;        RELATIVE TO CURRENT GEAR	(MG5)
					;----------------------------------------------
		ORG $05B0	;
LD5B0   FCB  128    ; 1.000 ADJ TO TPS IN 1ST GR 
LD5B1   FCB  128    ; 1.000 ADJ TO TPS IN 2nd GR
LD5B2   FCB  128    ; 1.000 ADJ TO TPS IN 3rd GR
LD5B3   FCB  128    ; 1.000 ADJ TO TPS IN 4th GR 
					;----------------------------------------------
LD5B4   FCB  32     ; 15c, 59f MIN COOL FOR FOR LIGHT OFF FOR LOWER GEARS
        			;---------------------------------
LD5B5   FCB  13     ; 260 mvdc TPS, Light is OFF below thresh for LOWER gear
LD5B6   FCB  10     ; 200 mvdc TPS, Light is OFF below thresh for HIGH gear
LD5B7   FCB  170    ; 4250 RPM, Light always enabled above thresh
        			;---------------------------------
LD5B8   FCB  5      ; 0.5 Sec's 1st GEAR, DELAY BEFORE TURNING 
                    ; 			ON SHIFT LIGHT 
					;
LD5B9   FCB  25     ; 2.5 sec's 4th GEAR, DELAY BEFORE TURNING 
                    ; 			ON SHIFT LIGHT 
					;---------------------------------------------
					; TCC TPS MULT vs BARO
					;
					; USED FOR TCC & MAN XMISSION
					;
					; TBL = FACTOR * 128
					;---------------------------------------------
		ORG $05BA	; MULT	 	Kpa BARO
					;---------------------------------
LD5BA   FCB 128     ; 1.0       75
LD5BB   FCB 128     ; 1.0       85
LD5BC   FCB 128     ; 1.0       95
LD5BD   FCB 128     ; 1.0       105
					;---------------------------------------------
					; COLD START THROTTLE KICKER
					; >> NOT USED <<
					;---------------------------------------------
		ORG $05BE	;
LD5BE   FCB 0       ; 200c FOR KICKER ON
LD5BF   FCB 0       ; 200c FOR KICKER OFF
LD5C0   FCB 0       ;  0 VDC TPS FOR KICKER OFF 
					;---------------------------------------------
					; *** END OF XMISSION PARAMS ***
					;---------------------------------------------
					; IAC PARAMS    
					; TYPE 42 ECM, 5.7l V8    
					;	
					;---------------------------------------------
		ORG $05C1	;
LD5C1   FCB  25     ; 25 STEPS, INT NON VOL RAM FAIL FOR A/C ON STEPS
LD5C2   FCB  145    ; 145 STEPS, MOTOR PK POSIT		  <----<<<<<
LD5C3   FCB  20     ; 250 mSec's STEPPER MOTOR PK TO RUN DELAY
					; 		sec * 80
					;
LD5C4   FCB  34     ;   RPM PWR STEER STALL
LD5C5   FCB  40     ;   RPM TO EXIT PWR STEER STALL
					;
LD5C6   FCB  3      ; 1% TPS FOR CLOSED THROTLE
					;
LD5C7   FCB  2      ; Clsd Lp SMALL ERROR RETRACT
LD5C8   FCB  1      ; Clsd Lp LARGE ERROR RETRACT   
					;
LD5C9   FCB  1      ; Clsd Lp SMALL ERR EXTEND  
LD5CA   FCB  0      ; Clsd Lp LARGE ERR EXTEND     
					;
LD5CB   FCB  5      ; 63 RPM POS ERR BK PT FOR LARGE GAIN WD  
LD5CC   FCB  4      ; 51 RPM NEG ERR BK PT FOR LARGE GAIN WD  
					;---------------------------------------------
LD5CD   FCB  2      ; 25 RPM, DEAD BAND 
LD5CE   FCB  200    ; RETRACT PULSE RESET
					;
LD5CF   FCB  35     ; INIT MOTOR POSIT no A/C
LD5D0   FCB  5      ; MIN DIFF IAC STP'S w A/C  
LD5D1   FCB  35     ; MAX DIFF IAC STP'S w A/C  
					;
LD5D2   FCB  87     ; 8.7 VDC, STEPPER MOTER PROTECT
					;
LD5D3   FCB  40     ; DECEL STALL Fuel Cut Off  STP'S
LD5D4   FCB  0      ; DECEL  Fuel Cut Off  STP'S 
					;
LD5D5   FCB  60     ; ALDL RESET TRHRESH
LD5D6   FCB  0      ; DESIRED MP A/C ADJ BIAS
					;
LD5D7   FCB  5      ; 5 sec FOR ENABLE IAC KICK DN
LD5D8   FCB  25     ; KICK DN ADJ STEPS
					;
LD5D9   FCB  1      ; 1 STEP,PK/NEUT POSIT DIFF   <-----<<<
LD5DA   FCB  0      ; 0 DIFF ENG SPD FOR A/C ON (RPM/12.5)
					;
LD5DB   FCB  80     ; ALDL (1000 RPM)
LD5DC   FCB  5      ; STEPS INCR FOR BATT VDC DECREASE 
LD5DD   FCB  2      ; 0.2 VDC BATT DECR FOR INCR STEPS 
					;
LD5DE   FCB  145    ; MAX IAC    <-----<<<<       
					;---------------------------------------------
LD5DF   FCB  255    ; MOTOR R/S WITH A/C 255 STEPS
LD5E0   FCB  254    ; MOTOR R/S WITH OUT A/C 255 STEP
					;
LD5E1   FCB  96     ; 1200 RPM FOR COLD RPM IN KICK DN MODE   <-----<<< 
LD5E2   FCB  88     ; 1100 RPM MAX HOT RPM FOR PK/NEUT   <-----<<<
LD5E3   FCB  2      ;   25 RPM DIFF ADD FOR A/C ON
LD5E4   FCB  51     ; LOW Vss FILTER COEF 
LD5E5   FCB  51     ; MED Vss FILTER COEF 
LD5E6   FCB  16     ;  HI Vss FILTER COEF
LD5E7   FCB  2      ; 0.4 Swc, DECAY DELAY FOR LOW VSS Sec/5
LD5E8   FCB  5      ; 1.0 Sec, DECAY DELAY FOR HI  VSS Sec/5
LD5E9   FCB  22     ; DECAY DECAY COEF, LO Vss
LD5EA   FCB  30     ; DECAY FILT COEF
LD5EB   FCB  38     ; FAST DECAY FILTER COEF
					;
LD5EC   FCB  12     ; 3.75 MPH FOR MIN COEF THRESH
LD5ED   FCB  64     ; 20.0  MPH FOR MAX COEF THRESH
					;
LD5EE   FCB  10     ; 10 STEPS,  MIN VAL AT HI Vss
LD5EF   FCB  6      ; %TPS FOR THROT FOLLOWER BIAS
					;
LD5F0   FCB  32     ; %THROT FOLLOWER IN PK/NEUT
LD5F1   FCB  110    ; %THROT FOLLOWER NOT IN PK/NEUT
					;
LD5F2   FCB  60     ; MAX THROT FOLLOWER BIAS, 60 STEPS
					;
LD5F3   FCB  1      ; ... Deg c, TEMP FOR COLD RPM LIMITING	  TBL 2
LD5F4   FCB  16     ; 5 MPH, Vss FOR N BIAS = 0
					;---------------------------------------------
					; IAC MOTOR POSIT vs COOLANT
					; (IN STEPS) ASDZ, 5.7L V8 TYPE $42 ECM
					;
					;
					; TBL = STEPS
					;---------------------------------------------
		ORG	$05F5	;   STEPS     Deg c     Deg f
        			;---------------------------------
LD5F5   FCB  24     ; 24 		 HOT      	HOT
LD5F6   FCB  24     ; 24 		136.0     	277
LD5F7   FCB  24     ; 24 		107.0     	225
LD5F8   FCB  24     ; 24 		 91.0     	196
LD5F9   FCB  24     ; 24 		 80.0     	176
LD5FA   FCB  24     ; 24 		 71.0     	160
LD5FB   FCB  24     ; 24 		 63.0     	145
LD5FC   FCB  24     ; 24 		 56.0     	133
LD5FD   FCB  40     ; 40 		 49.3     	121
LD5FE   FCB  50     ; 50 		 43.3     	110
LD5FF   FCB  65     ; 65 		 37.0     	 99
LD600   FCB  80     ; 80 		 30.5     	 87
LD601   FCB  90     ; 90 		 23.5     	 74
LD602   FCB  100    ; 100		 15.5     	 60
LD603   FCB  110    ; 110 		  6.0     	 43
LD604   FCB  120    ; 120		 -8.5     	 17 
LD605   FCB  145    ; 145		 COLD     	COLD
					;---------------------------------------------
					; POSIT AFTER MOTOR RESET vs BARO
					;
					; TBL = STEPS
					;---------------------------------------------
		ORG $0606	; STEPS		Kpa BARO
					;---------------------------------
LD606   FCB  60     ; 60      	75 
LD607   FCB  50     ; 50      	85
LD608   FCB  40     ; 40      	95
LD609   FCB  40     ; 40      	105
					;---------------------------------------------
					; PWR STEER STALL vs BARO
					;
					; TBL = STEPS
					;---------------------------------------------
		ORG $060A	;  STEPS		Kpa BARO
					;---------------------------------
LD60A   FCB  24     ; 24      75 
LD60B   FCB  16     ; 16      85 
LD60C   FCB  12     ; 12      95 
LD60D   FCB  10     ; 10      105
					;---------------------------------------------
					; IAC DESIERD IDLE SPD vs COOL
					; (CLOSED LOOP)
					;
					; TBL = RPM/12.5
					;---------------------------------------------
		ORG $060E	; RPM   	Deg c   Deg f
                    ;---------------------------------
LD60E   FCB  48     ; 600    	 55     131
LD60F   FCB  48     ; 600    	 65     149
LD610   FCB  46     ; 575    	 75     167
LD611   FCB  42     ; 525    	 85     185
LD612   FCB  42     ; 525    	 95     203
LD613   FCB  42     ; 525    	100     212
LD614   FCB  46     ; 575    	105     221
LD615   FCB  50     ; 625    	110     230
LD616   FCB  52     ; 650    	115     239
					;=============================================
					; LAST CALIB  AT $D616
					;=============================================
		ORG $0617
        LDAA    #03		; LD D w/ $0301
        LDAB    #01		;
        JSR     $FBCE	; TO CPU
						;---------------------------------------------
        LDAA    $000F	;   
        ANDA    #8		; MASK FOR b3, AC ON
        TST     $D007	; 0010 0100, 3rd AFR OPT WD
        BMI     LD62C	;
        LDAB    $0005	;
        ANDB    #$80	; 1000 0000
        ABA     		;
						;
LD62C   LDAB    $0010	;
        ANDB    #$FE	; 1111 1110
        CBA     		;
        BNE     LD659	;
        LDAB    L0049	; TPS
        SUBB    L004A	;
        BCC     LD63A	; BR IF TPS GT ...
        NEGB    		;
LD63A   CMPB    >$D011	; DIFF TPS FOR MAP FILT COEF  
LD63D   BHI     LD659	;
LD63F   LDAB    $001F	; RPM/12.5
        SUBB    $0020	; OLD RPM/12.5
        BCC     LD646	; BR IF RPM POSITIVE
        NEGB    		; 0-RPM
LD646   CMPB    >$D012	; DIFF RPM TRANS MAP COEF (75 RPM) 
        BHI     LD659	; BR IF GT DIFF RPM 
        LDAB    L0034  	; MPH/1
        CMPB    >$D013	; 0 MPH, THRESH FOR MAP FILT COEF 
        BHI     LD659	; BR IF MPH G.T. 0 MPH
        LDAB    $002B	; TRANSIENT MAP TMR 
        BEQ     LD65F	; BR IF Z
        DECB    		; DECR TRANSIENT MAP TMR
        BRA     LD65C
						;---------------------------------------------
LD659   LDAB    >$D010	; 500 Msec,  TRANSIENT MAP COEF 
 						; APPLY TIME, SEC/80  
LD65C   STAB    $002B	; TRANSIENT MAP TMR 
						;
        INCA    		; INCR TMR ??
LD65F   STAA    $0010	; TMR
						;
        JSR     $FA59	; TO FIRWARE
						;---------------------------------------------
						;	*================================================
						;	* LOOK UP 2D VE2 VALUE
						;	*	(0 - 6400 RPM)
						;	*
						;	* ADD TO VE 3d RESULTS IN $00A9
						;	*
						;	* TBL = %VE * 2.56
						;	*================================================
        LDAA    $001C  	; RPM/25
        LDX     #$D3C7	; 2D LOOK PU OF VE2
        JSR     $FB49	; 2D LOOK PU 
						;---------------------------------------------
        STAA    L00A9	; FUEL FM TBL 
						;================================================
						;---------------
						; GET o2 VALUE
						;---------------
        JSR     $FBDB	; READ A/D, (o2 & TPS)
						;---------------------------------------------
        STAA    L003E  	; o2 VDC, (A/D)
						;
						;
        LDAA    #$0B	; $0B01
        LDAB    #$01	; 
        JSR     $FBCE	; TO CPU
						;---------------------------------------------
        LDAA    $001C  	; RPM/25
        CMPA    >$D028	; 2400 RPM, MIN RPM FOR SPK SA DECAY 
        BHI     LD684	; BR IF G.T. 2400 RPM
						;
        JSR     $FDCB	; TO CPU
						;---------------------------------------------
LD684   LDAA    L003F	; FILT o2 VAL
        STAA    L00BD	; INIT W/FILT o2 VAL
						;
						;
						;---------------------
						; FILTER o2 VAL
						;
						;---------------------
        LDX     L003F	; FILT o2 VAL
        LDAA    L003E  	; o2 VDC, (A/D)
        LDAB    >$D28B	; MNR LOOP o2 FILT COEF   
        JSR     $FB12	; LAG FILTER ROUTINE
						;---------------------------------------------
        STD     L003F	; SAVE FILT o2 VAL
						;
        ASLB    		;
        ADCA    #0		; ROUND
        STAA    L003E  	; FILT o2 VDC, (A/D)
        PSHA    		;
						;
        LDAB    >$D28C	; 2d, SLOW o2 COEF FOR IDLE
						;
        LDAA    $0002	;
        BMI     LD6AA	;
						;-------------------------------------------------
						; Lk Up  SLOW o2 FILTER TIME CONSTANT vs AIR FLOW
						; (0 - 64 gms/sec)
						;
						; TBL = 
						;-------------------------------------------------
        LDAA    L00BE	; AIR FLOW, (gms/sec)
        LDX     #$D4A3	; INDEX SLOW o2 FILTER TIME CONSTANT TBL
        JSR     $FB49	; 2d look pu 
						;---------------------------------------------
        TAB 			; RESULTS TO B Reg     					
						;						
						; FILTER ASYNC INJ PW	
						;						
LD6AA   PULA    		;
        LDX     L0043	; ASYNC INJ VAL
        JSR     $FB12	; LAG FILTER ROUTINE
						;---------------------------------------------
        STD     L0043	; ASYNC INJ VAL
						;------------------------------------------------					
						;	*================================================
						;	* LOOK UP FL 1
						;	* MAIN FUEL PREDICITIONS vs MAP vs RPM, (FL1)
						;	*
						;	* TBL = %VE * 2.56
						;	*================================================
        LDAA    $0026	; S/D MAP 
        LSRA    		; DIV BY 2 FOR LK UP
        LDAB    $001C  	; RPM/25
        CMPB    #128	; 3200 RPM 
        BLS     LD6BD	; BR IF RPM LT 3200
        LDAB    #128	; FORCE 3200 RPM
LD6BD   LDX     #$D37C	; POINT TO FL 1 TABLE
        JSR     $FB67	; 3D LOOK UP
						;---------------------------------------------
        ADDA    L00A9	; SAVE TOTAL VE RESULT
        BCC     LD6C9	; IF NO OVERFLOW
        LDAA    #255	; USE 100 % VE
LD6C9   STAA    L00A9	; SAVE VE RESULT
						;-------------------------------------------------  
						;	*================================================
						;	* GET TPS A/D VALUE & ERR CK FOR LO LIMIT  	
						;	*	
						;	*================================================
        JSR     $FBDB	; READ A/D, (o2 & TPS)
						;---------------------------------------------
        STAA    L0048  	; TPS, VDC
						;
        LDAB    $0009	;
        ANDB    #$DF	; MASK FOR b5
						;
        LDAA    $0001	;
        BPL     LD6F0	;
						;
						; CK FOR LOW TPS ERR TEST ENABLE
						;
        LDAA    >$D50D	; ERR ENABLE WD 1
        BITA    #$04 	; b2, ERR 22, TPS lo
        BEQ     LD6F8	; BR IF NOT b2
        LDAA    L0048  	; TPS, VDC
        CMPA    >$D523	; TPS limit, 0.20 VCD, (ERR 22)
        BCC     LD6F8	; IF TPS > .195 BR
						;
						; SET BIT 2 OF $0012
						; (TPS LOW ERR FLG)
						;
        LDAA    $0012	;
        ORAA    #4		; SET b2
        STAA    $0012	;
						;
        ORAB    #$20	; SET b5
        BRA     LD6F8	;
						;---------------------------------------------
LD6F0   LDAA    >$D289	; Min TPS IN %, (25%) 
        STAA    L004F	; MIN TPS VAL
        CLR     L0050	; TPS ERR TMR
						;						;
						; TPS OK				;
						;			            ;                                     
LD6F8   STAB    $0009	;
        JSR     $FCD8	; TO CPU
						;---------------------------------------------
        LDAB    $0002	;
        ANDB    #$7F	; CLR b7
						;
        CMPA    >$D5C6	; 1% TPS FOR CLOSED THROTTLE
        BHI     LD70F	; BR IF TPS L.T. 1%
						;
        LDAA    L0034  	; MPH/1
        CMPA    >$D2F6	; 4 MPH, THRES FOR IDLE 
        BHI     LD70F	; BR IF Vss LT 4 MPH
        ORAB    #$80	; SET b7
LD70F   STAB    $0002	;
						;
        LDAA    $0001	;
        BMI     LD718	;
        JMP     $D7F0	;
						;---------------------------------------------
						;
						; SUB OLD MAP fm CURRENT MAP
						;                                                             
LD718   CLRB    		;
        LDAA    $0026	; S/D MAP 
        SUBD    $002F	; FILT MAP
        BLS     LD74D	; BR IF DECELL
        TSTB    		;
        BPL     LD723	;
        INCA   			; INCR
LD723   PSHA    		;
        STAA    L0032	; DIFF MAP
						;
        LDAB    >$D28F	; 5 KPA, ACCEL ENRICH DIFF MAP 
        LDAA    L0049	; TPS
        CMPA    >$D290	; FILT TPS COEF
        BHI     LD735	;
						;
        ASLB    		; x2
        BCC     LD735	; BR IF NO OVERFLOW
        LDAB    #255	; USE MAX LMT
LD735   PULA    		;654
		CBA				; COMPARE B AND A REGS
		BLS		LD750	; IF LOWER OR SAME, SKIP PUMP SHOT
						; LK UP  ACCEL ENRICH vs Diff MAP
						; *** PUMP SHOT ***
						;
						; ASYNC ONLY TO STRETCH BPW
						; Table = msec * 16.384
						;-------------------------------------------------
        LDX     #$D30D	; Accel Enrich vs Diff MAP TBL
        JSR     $FB40	; 2d lk up w/line cnt in hdr	
						;---------------------------------------------
        LDAB    L0049	; TPS VAL	
        CMPB    >$D291	; FILT TPS COEF	
        BLS     LD751	; BR IF L.T. or E.Q. TPS	
        ASLA    		; MULT PMP SHOT * 2	
        BCC     LD751	; IF NO OVER FLOW	
        LDAA    #255	; USE MAX VAL	
        BRA     LD751	; EXIT	
						;---------------------------------------------
LD74D   CLR     L0032	; DIFF MAP	
LD750   CLRA    		; CLT PUMP SHOT	
						;
LD751   STAA    L0053	; SAVE PUMP SHOT LK UP	
        STAA    L0099	; SAVE PUMP SHOT LK UP	
						;--------------------------
						;
						; CK CURRENT TPS vs OLD TPS
						;
        LDAB    L00DF	;
						;
        LDAA    L0049	; TPS
        SUBA    L004B	; ACCEL ENRICH  FILTERED TPS
        BLS     LD78C	; BR IF NEW TPS gt OLD TPS
						; (CLR PUMP SHOT VAL)
						;
						; CK AFR OPT WORD 2
						; 
        TST     >$D006	; 2ND AFR OPT WORD, 1101 0000
        BPL     LD76A
						;
						;   B7 = 1 = SEL Diff TPS opt for Acell Enr
						;   B6 = 1 = NO ENABLE MOTOR R/S DUE TO RESTART
						;   B4 = 1 = DO INT R/S ON BLM CELL CHANGE
						;
        TST     L004C
        BPL     LD76A
        DECA    
        BEQ     LD78C	; (CLR PUMP SHOT VAL)
LD76A   BITB    #$10	; b4	
        BNE     LD773	; BR IF b4	
        CMPA    >$D292	; 2% DIFF TPS REQ FOR PWR ENRICH ...	
						; ... WHILE IN PWR ENRICH 	
        BLS     LD78C	; BR IF DIFF TPS G.T. 2%,  	
						; (CLR PUMP SHOT VAL)	
						;
						; CK AFR OPT WORD 2
						; 
LD773   TST     >$D006	; 2nd AFR OPT WORD	
        BMI     LD77B	; BR IF 	
        ASLA    		; x2
        BCS     LD77E	; BR IF OVERFLOW  	
LD77B   ASLA    		; x2
        BCC     LD780	; BR IF NO OVERFLOW, 	
LD77E   LDAA    #255	; USE MAX VALUE	
						;-------------------------------------------------
						; LK UP  Accel Enrich vs Diff TPS 
						; **** TPS PUMP SHOT ******
						;
						; ASYNC ONLY TO STRETCH BPW
						; Table = msec * 16.384
						;-------------------------------------------------
LD780   LDX     #$D313	; ACCEL ENRICH vs DIFF TPS 
						; CONTRIB vs DIFF TPS	
        JSR     $FB36	; 2d LK UP	
						;---------------------------------------------
         LDAB    L00DF	;
        ORAB    #$10	; SET b4, (TPS AE)	
        BRA     LD78F	;
						;---------------------------------------------
LD78C   CLRA    		; CLR PMP SHOT VAL	
        ANDB    #$EF	; CLR b4	
LD78F   STAB    L00DF	;	
						;
        STAA    L0052	; PMP SHOT BPW	
        STAA    L009A	;
						;
        CLRA    		;
        LDAB    L00DF	;
        BITB    #4		; BIT 2 (IAC OPENING)	
        BEQ     LD79F	; BR IF NOT b2	
						;
        LDAA    >$D293	; 244 usec ADDED TO BPW WHILE IAC 	
						; IS OPENING  	
						; VAL = MSEC * 16.384	
LD79F   ADDA    L0052	; BPW,LSB	
        BCS     LD7A7	; BR IF NO OVERFLOW
        ADDA    L0053	; BPW, MSB	
        BCC     LD7A9	; BR IF NO OVERFLOW	
LD7A7   LDAA    #255	; USE MAX VALUE	
LD7A9   BEQ     LD7C7	;	
						;
        LDAB    L0098	; BPW MULT	
        MUL     		;
        LSRD    		; DIV BY 8	
        LSRD    		;
        LSRD    		;
        ADDD    L0096	; BPW,  ASYN	
        STD     L0096	; BPW,  ASYN	
						;
        LDAA    $000D	; STATUS WD	
        BITA    #$40	; b5	
        BNE     LD7BD	; BR IF b5	
        ORAA    #$01	;
LD7BD   ORAA    #$C0	;
						;
        LDAB    $0006	;
        ORAB    #$01	; SET b0
        STAB    $0006	;
						;
        BRA     LD7CB	;
						;---------------------------------------------
LD7C7   LDAA    $000D	; STATUS WD	
        ANDA    #$BF	; CLR b6	
LD7CB   STAA    $000D	; STATUS WD	
						;
        LDAA    L0049	; TPS	
        CLRB    		;
						;						;
						; CK AFR OPT WD 2		;
						;						;
        TST     >$D006	; AFR OPT WORD 2	
        BPL     LD7EC	; BR IF MD WD IS POS	
        LDAB    L0070	;	
        BITB    #$02	; b1	
        BEQ     LD819	; BR IF NOT b1, (MPH for TCC)	
						;-------------------------------------------------
						; LK UP  ACCEL ENRICH COOL TPS FILT COEF 
						;
						;	 (-5 - 95c)
						; TBL = COEF * 255
						;-------------------------------------------------
        LDAA    $0021	; COOLANT	
        LSRA    		; DIV/2 for lk up	
        LDX     #$D31D	; ACCEL ENRICH COOL FILT COEF TBL	
        JSR     $FB36	; 2d LK UP	
						;---------------------------------------------
        TAB     		; COEF TO B Reg	
        LDAA    L0049	; CURRENT TPS	
        LDX     L004B	; ACCEL ENRICH  FILTERED TPS 	
        JSR     $FB12	; LAG FILTER ROUTINE	
						;---------------------------------------------
LD7EC   STD     L004B	; ACCEL ENRICH  FILTERED TPS	
						;
        BRA     LD819	;
						;---------------------------------------------
LD7F0   LDAA    L0049	; TPS
        CLRB    		;
        STD     L004B	; ACCEL ENRICH  FILTERED TPS
        STD     L004D	; FILTERED TPS	
						;
        LDAA    $0026	; S/D MAP 	
        STD     $002F	; FILT MAP	
						;
						;							 ;
						; DRP CNT'R MANAGMENT		 ;
						;							 ;
        LDAA    #255	; 
						;
        LDX     $BC00	; DRP COUNT	
        CPX     >$D00A	; ENG START UP RPM DRP PERIODS, (499 RPM)	
						; VAL = N * 65536 * (120/N CYL) 	
        BLS     LD811	; BR IF DRP CNT GT LMT, (499 RPM) 	
        STX     L0053	; SAVE DRP CNT	
						;
						;
        LDD     >$D00A 	; ENG START UP RPM DRP PERIODS, (499 RPM)	
						; VAL = N * 65536 * (120/N CYL)	
        JSR     $FB92	; 	
						;---------------------------------------------
        TSTB    		;
        BPL     LD811	; 	
						; ... 	
        INCA    		;
						;
						;---------------------------------------------
						; LK UP  COLD START CRANK CORR vs %RPM
						;
						;  ( 0 100% RPM)
						; TBL = MULT * 255
						;---------------------------------------------
LD811   LDX     #$D400	;  COLD START CRANK CORR TBL
        JSR     $FB40	; 2D LK UP W/LINE CNT IN HDR
						;---------------------------------------------
        STAA    L0058	; COLD START CRANK MULT
						;
						;
						;
						; CK OPN LP AFR
						;
LD819   LDAA    L00A6	;
						;
        LDAB    L00A5	; OPN LP AFR
        CMPB    #63		; 6.3:1
        BHI     LD842	; BR IF  OPN LP AFR LT 6.3:1
        CMPB    #15		;  
        BHI     LD82E	;
        CLRB    		;
        STD     L00AB	; TEMP BPW, (SYNC)
						;
						;
        LDAA    L00A5	; OPN LP AFR
        ASLA    		; x2
        ASLA    		; x2
						;
        BRA     LD835	;
						;---------------------------------------------
LD82E   LDAB    #64		;
        MUL     		;
        STD     L00AB	; TEMP BPW, (SYNC)
						;
        LDAA    L00A5	; OPN LP AFR
LD835   ASLA    		;
        ASLA    		;
						;
        BRA     LD849	;
						;---------------------------------------------
LD839   LDX     #L00AB	; TEMP BPW, (SYNC)
        JSR     $FBB9	;
						;---------------------------------------------
        STD     L00AB	; TEMP BPW, (SYNC)
						;
        RTS     		;
						;---------------------------------------------
LD842   LDAB    #16
        MUL     
        STD     L00AB	; TEMP BPW, (SYNC)
						;---------------------------------------------
						; LK UP OPN LP AFR
						;
						;---------------------------------------------
        LDAA    L00A5	; OPN LP AFR
LD849   LDX     #$FE33	; TBL
        JSR     $FB40	; 2d lk up W/LINE CNT IN HDR
						;---------------------------------------------
        BSR     LD839	;
						;---------------------------------------------
        LDAA    L00A9	;
        BSR     LD839	;
						;---------------------------------------------
        LDAA    $002E	;
        BSR     LD839	;
						;---------------------------------------------
        LDAA    L00AA	;
        BSR     LD839	;
						;---------------------------------------------
        LDAA    $0001	;
        BMI     LD865	;
        LDAA    L0058	; PORP DURATION, SEC'S
        BSR     LD839	;
						;---------------------------------------------
LD865:  LDAA    L00A3  	; BLM, BIN
        BMI     LD86F	; BR IF NEG
        LDAB    $000D	; STATUS WD 
        BITB    #$20	; b5
        BNE     LD87A	; BR IF b5
LD86F   JSR     $FBB9	;
						;---------------------------------------------
        ASLD    		; x2
        BCC     LD878	; BR IF NO OVERFLOW
        LDD     #$FFFF	; USE MAX VALUE
LD878   STD     L00AB	; TEMP BPW, (SYNC)
						;
						;
LD87A   LDAA    $0021	; COOLANT
        CMPA    >$D2F2	; DISABLE DECEL FUEL C/O BELOW 75 c   
        BCC     LD884	;
        JMP     $D946	;
						;---------------------------------------------
LD884   LDAA    $000F	;
        BITA    #$10	; BIT 4
        BNE     LD8B5	; EXIT FUEL C/O ROUTINE
        LDAB    $0009	;
        BITB    #$24	;
        BNE     LD89F	;
        LDAA    L0049	; TPS
        CMPA    >$D2F0	; 2% MAX TPS FOR DECEL FUEL C/O   
		BCS     LD89F	; BR IF TPS LT 2%
        LDAA    $0003	;
        ORAA    #$10	; SET b4, IN FUEL C/O
        STAA    $0003	;
						;
        BRA     LD8CB	;
						;---------------------------------------------
LD89F   LDAA    $0020	; OLD RPM/12.5
        SUBA    $001F	; RPM/12.5
        BCS     LD8AA	; BR IF RPM DECREASING
        CMPA    >$D2E9	; RPM/12.5, 6375 RPM  To disable C/O
						; (Decel rate) 
        BHI     LD8B5	; EXIT FUEL C/O ROUTINE
LD8AA   BITB    #$48	; b6 & b3
        BNE     LD8E2	; BR IF b6 & b3
        LDAA    L0032	; DIFF MAP
        CMPA    >$D2EA	; MAP INC TO DISABLE DFCO
        BLS     LD8D0	; BR IF MAP LT THRESH
						;
						; HERE TO COME OUT OF DECEL FUEL C/0
						;
						;
LD8B5   LDAA    L00A0	; POST DECEL C/O TMR
        BEQ     LD8CB	; BR IF TMR = 0
        LDD     L0096	; BPW,  ASYN
        ADDD    >$D2EB	; FUEL PULSE WHEN EXITING DFCO, 
						; 7.07 Msec	BY RPM < OR Pk/Neut
        BCC     LD8C3	; BR IF NO OVERFLOW
        LDD     #$7FFF	; USE MAX VALUE
LD8C3   STD     L0096	; BPW,  ASYN
						;
        LDAA    $000D	; STATUS WD
        ORAA    #$80	; SET b7
        STAA    $000D	; STATUS WD
						;
LD8CB   CLR     L00A0	; POST DECEL C/O TMR
        BRA     LD937	;
						;---------------------------------------------
LD8D0   LDAA    $0026	; S/D MAP 
						;
        LDAB    $0008	;
						;
        CMPA    >$D2E7	; DECEL FUEL C/O MAP Thresh, 
						; Lower, 22.5 Kpa    
        BCS     LD8E2	;
        BITB    #08		; b3, 
        BEQ     LD937	; BR IF NOT b3,
						;
        CMPA    >$D2E8	; DECEL FUEL C/O MAP Thresh, 
						; Upper, 45 Kpa
        BCC     LD937	;
						;---------------------------------------------
						; Limits for FUEL CUT OFF In decel
						;
						;	  1000/1400 RPM
						;		  15/18 MPH
						;
						; 4 LINE TBL
						;---------------------------------------------
LD8E2   LDX     #$D2E3	; POINT TO 4 LINE TBL
						;
        LDAB    $0008	;
        BITB    #$08	; BIT 3,
        BEQ     LD8EC	; BR IF NOT B3,
        INX     		;
LD8EC   LDAA    $001C  	; RPM/25
        CMPA    0,X		; 1000/1400 RPM HYST
        BLS     LD8B5	; BR IF RPM LT 1000/1500, (EXIT FUEL C/O)
        LDAA    L0034  	; MPH/1
        CMPA    2,X		; 15/18 MPH
        BCS     LD8B5	; BR IF Vss LT 15/18 MPH, (EXIT FUEL C/O)
						;							;
						; CK DECEL FUEL C/O TMR		;
						;							;		
        LDAA    L00A1	; DECEL FUEL C/O TMR
        BNE     LD934	; BR IF Non Z
        LDAB    >$D2EF 	; 3 Sec's MIN BETWEEN DECEL FUEL C/O
						;
        LDAA    $0003	;
        BITA    #$10	; b4, (IN FUEL C/O)
        BEQ     LD90B	; BR IF NOT b4
        ANDA    #$EF	; CLR b4
        STAA    $0003	;
						;
        STAB    L009F	; BETWEEN DECEL FUEL C/0 TIMER
LD90B   CMPB    L009F	; BETWEEN DECEL FUEL C/0 TIMER
        BLS     LD914	;
        INC     L009F	; INCR DECEL FUEL C/0 TIMER
        BRA     LD946	;
						;---------------------------------------------
LD914   LDAB    $0008	;
        ORAB    #8		; SET b3,
        STAB    $0008	;
						;
        LDAA    >$D2EE	; 400 Msec AFTER DECEL FUEL C/O FOR BPW
        STAA    L00A0	; POST DECEL C/O TMR
						;
        LDAA    $000D	; STATUS WD
        ORAA    #$10	; SET b4
        STAA    $000D	; STATUS WD
						;
        LDAA    L009E	; DECEL FUEL MULT
        SUBA    >$D2F1	; 10.2% MULT FOR BPW IN DECEL FUEL C/O
						; EVERY 12.5 MSEC LOOP 
        BCC     LD92D	; BR IF NO UNDERFLOW
        CLRA    		;
LD92D   STAA    L009E	; DECEL FUEL MULT
        JSR     $D839	;
						;---------------------------------------------
        BRA     LD9A4	;
						;---------------------------------------------
LD934   DECA    		; DECR DECEL FUEL TMR
        BRA     LD93A	;
						;---------------------------------------------
LD937   LDAA    >$D2ED	; 2 Sec REQ FOR DECEL FUEL C/O 
LD93A   STAA    L00A1	; DECEL FUEL C/O TMR
						;
        CLR     L009F	; BETWEEN DECEL FUEL C/O TIMER
						;
        LDAA    L00A0	; POST DECEL C/O TMR
        BEQ     LD946	; BR IF TMR = Z
        DEC     L00A0	; DECR POST DECEL C/O TMR
						;
LD946   LDAA    $0008	;
        ANDA    #$F7	; CLR b3
        STAA    $0008	;
						;
        LDAA    #255	;
        STAA    L009E	; DECEL FUEL MULT
						;
        LDD     L004D	; FILTERED TPS
        ASLB    		; x2
        ADCA    #0		; ROUND OFF
        BCC     LD958	; BR IF NO OVERFLOW
        DECA    		;
LD958   SUBA    L0049	; TPS
        BCS     LD99E	; BR TPS LT 
        CMPA    >$D2E0	; 1%, TPS DECEL ENLEAN INCR 
        BLS     LD99E	; BR IF TPS LT 1%
        LDD     $002F	; FILT MAP
        ASLB    		; x2
        ADCA    #0		;
        BCC     LD969	; BR IF NO OVERFLOW
        DECA    		;
LD969   SUBA    $0026	; S/D MAP 
        BCS     LD99E	; BR IF S/D MAP LT 0 or NEG
        CMPA    >$D2E1	; 2.5 Kpa DIFF DECEL ENLEAN INCR 
        BLS     LD99E	; BR IF MAP LT 2.5 Kpa
        LDAB    >$D2E2	; 0.375  ENLEAN MAP FACTOR 
						; (Mult .375 * map c)
        MUL     		;
        LDAB    L009D	; DECEL COOLANT FACTOR
        MUL     		;
        ASLD    		; x2
        BCS     LD982	; BR IF OVERFLOW
        ASLD    		; x2
        BCS     LD982	; BR IF OVERFLOW
        ASLD    		; x2
        BCC     LD984	; BR IF NO OVERFLOW
LD982   LDAA    #255	; USE MAX VALUE
LD984   NEGA    		;
        BEQ     LD99E	; BR IF Z
        LDAB    $000D	; STATUS WD
        ORAB    #$10	; SET b4
        STAB    $000D	; STATUS WD
						;
        STAA    L0058	; PORP DURATION, Sec's
        LDX     #L0096	; BPW,  ASYN
        JSR     $FBB9	;
						;---------------------------------------------
        STD     L0096	; BPW,  ASYN
        LDAA    L0058	; PORP DURATION, SEC'S
        JSR     $D839	;
						;---------------------------------------------
		BRA     LD9A7	;
						;---------------------------------------------
LD99E   LDAA    $000D	; STATUS WD
        ANDA    #$EF	; CLR b4
        STAA    $000D	; STATUS WD
						;
LD9A4   LDX     #L00AB	; TEMP BPW, (SYNC)
LD9A7   LDAA    L00B2	;
        JSR     $FBB9	;
						;---------------------------------------------
        ASLD    		; x2
        BCC     LD9B4	; BR IF NO OVERFLOW
        LDD     #$FFFF	;
        BRA     LD9CF	;
						;---------------------------------------------
LD9B4   STD     L00AB	; TEMP BPW, (SYNC)
        CLRA    		;
        LDAB    L00B1	;
        BMI     LD9C4	;
        ADDD    L00AB	; TEMP BPW, (SYNC)
        BCC     LD9CF	;
        LDD     #$FFFF	;
						;
        BRA     LD9CF	;
						;---------------------------------------------
LD9C4   NEGB    		;
        STD     L0051	;
						;
        LDD     L00AB	; TEMP BPW, (SYNC)
        SUBD    L0051	;
        BCC     LD9CF	; BR IF NO UNDERFLOW
        CLRA    		;
        CLRB    		;
LD9CF   STD     L00AB	; TEMP BPW, (SYNC)
						;
        LDD     L00AB	; TEMP BPW, (SYNC)
        ASLD    		; x2
        BCS     LD9DB	; BR IF OVERFLOW
        ASLD    		; x2
        BCS     LD9DB	; BR IF OVERFLOW
        BPL     LD9DE	;
LD9DB   LDD     #$7FFF	;
LD9DE   STD     L0053	;
						;
						;-------------------------------------------------
						; LK UP  ASYNC MULT vs  RPM  
						;
						;-------------------------------------------------
        LDAA    $001C  	; RPM/25
        LDX     #$D46B	; ASYNC MULT vs RPM TABLE
        JSR     $FB40	; 2D LK UP W/LINE CNT IN HDR
						;---------------------------------------------
        LDX     #L0053	; 
        JSR     $FBB9	;
						;---------------------------------------------
        STD     L0057	; ASYNC INJ FUEL ADDER
						;
        LDAA    $0000	;
        BITA    #$10	; b4
        BEQ     LD9FE	; BR IF NOT b4
						;
						; DO ZERO PW SYNC INJECTION
						;
        CLRA    		;
        CLRB    		;
        STD     $BC0E	; SYNC BPW PWM <--------------
						;
        JMP     >$DA9D	;
						;---------------------------------------------
LD9FE   LDAA    $0001	;
        BPL     LDA26	;
        LDX     L00AB	; TEMP BPW, (SYNC)
        CPX     >$D2D6	; 504 usec, MIN BPW HYST VAL
        BHI     LDA26	; BR IF BPW GT 504 usec
        LDAA    $000E  	; MAWF1
        BITA    #$10	; b4, Async Flag
        BNE     LDA18	; BR IF b4, Async Flag
        CPX     >$D2D8	; 305 usec, MIN BPW  
        BHI     LDA26	; BR IF GT 305 usec
        ORAA    #$10	; SET b4, Async Flag
        STAA    $000E  	; MAWF1
						;
LDA18   LDD     L0057	; ASYNC INJ MULT
        ADDD    L00AD	; ASYNC TEMP BPW
        STD     L00AD	; ASYNC TEMP BPW
						;
						; DO ZERO PW SYNC INJECTION
						;
        LDX     #$0000	; ZERO FUEL
        STX     $BC0E	; SYNC BPW PWM <-------------
        BRA     LDA44
						;---------------------------------------------
LDA26   LDAA    $000E  	; MAWF1
        ANDA    #$EF	; CLR b4, Async Flag
        STAA    $000E  	; MAWF1
						;
        LDX     #$0000	; ZERO FUEL
        STX     L00AD	; TEMP ASYNC BPW
						;
						;						
						; ADD IN INJ OFFSET BIAS
						; AND DO INJECTION
						;
        LDD     >$D2DA	; 397 usec, INJ BIAS (ADDED) *** 
        ADDD    L00AB	; TEMP BPW, (SYNC) 
        BCS     LDA3A	; BR IF OVERFLOW
        BPL     LDA3D	; 
LDA3A   LDD     #$7FFF	;
LDA3D   STD     $BC0E	; SYNC BPW PWM <--------------
						;
						;
        LDAA    $000D	; STATUS WD
        BPL     LDA9D	;
LDA44   LDD     L00AD	; TEMP BPW,  (ASYNC)
        ADDD    L0096	; BPW,  ASYNC
        PSHB    
        PSHA    
        PULX    
        CPX     >$D2DC	; 11.99 Msec, MAX ASYN BPW
						; ANY EXCESS SAVE & ED LATER 
						;
        BHI     LDA63	; BR IF BPW GT 12 Msec
        CPX     >$D2DE	; 687 usec, MIN ASYNC PW
						; SHORTER IS SAVED TER
						;
        BLS     LDA97	; BR IF BPW LT 687 usec
        ADDD    >$D2DA	; 397 usec, INJ BIAS (ADDED) ***
        STD     $BC14	; SYNC BPW PWM <-------------- 
						;
						; CLEAR ASYNC VALUE
						;						;
        CLRA    		;
        CLRB    		;
        STD     L0096	; BPW,  (ASYNC)
        STD     L00AD	; TEMP BPW,  (ASYNC)
        BRA     LDA7B
						;---------------------------------------------
						;---------------------------------------------										
						; CK ASYNC FUEL LIMITS & APPLY START UP BIAS
						; AND DO INJECTION
						;---------------------------------------------										
LDA63   LDD     >$D2DC	; 11.99 Msec, MAX ASYN BPW
						; ANY EXCESS SAVE & ED LATER 
						;
        ADDD    >$D2DA	; 397 usec, INJ BIAS (ADDED) ***
        STD     $BC14	; SYNC BPW PWM <--------------
						;
        LDD     L00AD	; TEMP BPW,  (ASYNC)
        SUBD    >$D2DC	; 11.99 Msec, MAX ASYN BPW
						; ANY EXCESS SAVE & ED LATER 
						;
        BCC     LDA79	; IF NO UNDERFLOW
        ADDD    L0096	; BPW,  ASYN 
        STD     L0096	; BPW,  ASYN 
						;
        CLRA    		;
        CLRB    		;
LDA79   STD     L00AD	; BPW, (ASYNC)
						;
LDA7B   JSR     $FD39	; 
						;---------------------------------------------
        LDD     $BC3C	; PWM
        ANDB    #$7F	; 0111 1111
        JSR     $FD39	; TO FIRMWARE
						;---------------------------------------------
        STD     $BC3C	; PWM
        ORAB    #$80	; SET b7
        JSR     $FD39	; TO FIRMWARE
						;---------------------------------------------
        STD     $BC3C	; PWM
						;
        LDAA    $000D	; STATUS WD
        ORAA    #$80	; SET b7
						;
        BRA     LDA9B	;
						;---------------------------------------------
LDA97   LDAA    $000D	; STATUS WD
        ANDA    #$7F	; CLR b7
LDA9B   STAA    $000D	;
						;
						;
LDA9D   LDAA    L0070	; 
        ANDA    #3		; mask, 0000 0011
        CMPA    #3		; 
        BEQ     LDAA8	; TO COLD ENG AFR vs VACUUM
        JMP     $DDE1	;
						;---------------------------------------------
						;  
						; AFR TEST ??
						;                                             
LDAA8   LDAA    >$D2AA	; AFR (STOCH), 14.7:1
        LDAB    $000E  	; MAWF1
        BITB    #$A0	; b7,5 	CLOSED LOOP, OLD HIGH AG 
        BNE     LDAD0	; BR IF b7 & b5
						;---------------------------------------------
						; LK UP  COLD ENGINE AFR vs VACUUM 
						; (TYPE $42)
						;---------------------------------------------
        LDX     #$D41D	; COLD ENGINE AFR vs VACUUM 
        LDAA    $0031	; VACUUM
        JSR     $FB40	; 2d lk up w/line count
						;---------------------------------------------
        ADDA    L00B5	; ADD IN AFR
        BCC     LDABF	; BR IF NO OVERFLOW
        LDAA    #255	; USE MAX LMT
LDABF   SUBA    L00E5	; AFR
        BCC     LDAC4	; BR IF NO UNDERFLOW
        CLRA    		; Zero
LDAC4   LDAB    $0002	;
        BPL     LDAD0	;
        CMPA    >$D2A9	; 14.0 LEAN OPN LP AFR LMT AT 
        BLS     LDAD0	; BR IF AFR GT 14.0
        LDAA    >$D2A9	;  14.0 LEAN OPN LP AFR LMT AT 
LDAD0   STAA    L00A5	; OPN LP AFR
        LDAB    $0002	;
        BITB    #$20	; b5
        BNE     LDAFD	; BR IF b5
        LDAA    L0034  	; MPH/1
        CMPA    >$D29E	; OPN LP IDLE THRESH, 4 MPH   
        BHI     LDAFD	;
        LDAA    L0049	; TPS
        CMPA    >$D29F	; OPN LP IDLE THRESH TPS , 1.2% 
        BHI     LDAFD	;
        LDAA    $001C  	; RPM/25
        CMPA    >$D2A1	; OPN LOOP 25 RPM THRESH IDLE    
        BHI     LDAFD	;
        BITB    #$0002	; b1
        BNE     LDAF6	; BR IF b1
        CMPA    >$D2A0	; OPN LOOP 1000 RPM THRESH IDLE 
        BHI     LDAFD	; BR IF RPM LT 1000 RPM
						;
LDAF6   LDAA    >$D2A4	; 13.7 OPN LP AFR MAX AT IDLE  
        CMPA    L00A5	; OPN LP AFR
        BLS     LDB53	; BR IF OPN LP AFR LT MAX LMT
LDAFD   ANDB    #$FD	; CLR b1
LDAFF   STAB    $0002	;
						;
        CLRB    		; CLR TMR
LDB02   STAB    L00B4	; IDLE AFR TMR
						;
						; CK AFR OPT WD 2
						; (OPN LP AFR OPT)
						;
        LDAA    >$D006	; AFR OPT WORD 2
        BITA    #8		; b3
        BEQ     LDB34	; BR IF NOT b3
						; B3 = 1 = OPN LP AFR 
        LDAA    $0003	;
        ORAA    #$02	; SET b1,  (OPN LP AFR OPT)
        STAA    $0003	;
						;
        LDAA    L00E3	; COOL TEMP
        CMPA    >$D2A7	; -40c OPN LP DECEL THRESH 
        BHI     LDB34	;
        LDAA    L0049	; TPS
        CMPA    >$D29F	; OPN LP IDLE THRESH TPS  
        BHI     LDB34	;
        LDAA    L0036	; MPH/3.2 VAL
        CMPA    >$D2A5	; 6 MPH OPN LP DECEL THRESH
        BLS     LDB34	;
        LDAA    $001C  	; RPM/25
        CMPA    >$D2A6	; 6350 RPM OPN LP DECEL THRESH
        BHI     LDB34	;
        LDAA    >$D2A8	;  OPN LOOP AFR MAX 15.0
        LDAB    $0008	;
        BMI     LDB3C	; BR IF B7,
						;
						; NOT OPEN LOOP AFR MODE SELECTED
						;
LDB34   LDAB    $0003
        ANDB    #$FD	; CLR b1,  (OPN LP AFR OPT)
        STAB    $0003	;
						;
        LDAA    L00A5	; OPN LP AFR
LDB3C   LDAB    $0001	;
        BPL     LDB81	; CK FOR CLR FLOOD
						;
        TST     $000E  	; MAWF1
        BMI     LDB47	; Closed Loop?
        BSR     LDB74
						;---------------------------------------------
LDB47   CMPA    >$D2C5	; 16.2 MAX AFR
        BLS     LDB4F	; BR IF AFR LT 16.2
        LDAA    >$D2C5	; USE 16.2 AFR
LDB4F   STAA    L00A5	; OPN LP AFR
        BRA     LDBA8	;
						;---------------------------------------------
LDB53   BITB    #$02	; b1
        BNE     LDB64	; BR IF b1
        LDAB    L00B4	; IDLE AFR TMR
        CMPB    >$D2A2	; 8 Sec's OPN LP IDLE AFR RATIO 
						; ENABLE TIME DELAY
        BCS     LDB6B	; BR IF TIME GT 8 SEC'S
        LDAB    $0002	;
        ORAB    #2		;
        BRA     LDAFF	;
						;---------------------------------------------
LDB64   LDAB    L00B4	; IDLE AFR TMR
        CMPB    >$D2A3	; 5 Sec's OPN LP IDLE AFR 
						; RATIO TIME DELAY 
        BCC     LDB3C	;
LDB6B   LDAA    L0070	;
        BITA    #4		;
        BNE     LDB72	;
        INCB    		;
LDB72   BRA     LDB02	;
						;---------------------------------------------
LDB74   LDAB    L00DE	;
        BITB    #$10	; BIT 4
        BEQ     LDB80	;
        SUBA    >$D302	; 0.2 AFR RICH BIAS FOR HOT 
        BCC     LDB80	;
        CLRA    		;
						;
LDB80   RTS     		;
						;---------------------------------------------
						;---------------------------------------------										
						; CK CLEAR FLOOD QUAL
						;
						;---------------------------------------------										
LDB81   LDAA    L00B6	; AFR
						;
        LDAB    >$D2C6	; 65% TPS VALUE, CLR FLOOD
        CMPB    L0049	; CURRENT TPS
        BHI     LDB93	;
        ADDA    >$D2C7	; CLR FLOOD AFR  6.0:1
        BCC     LDB91	; BR IF NOT OVERFLOW
        LDAA    #255	; USE MAX VAL
LDB91   BRA     LDBA4	;
						;---------------------------------------------
LDB93   LDAB    L00E3	; START UP COOL
        CMPB    >$D2C8	; TEMP THRSH FOR COLD START 
						; 10 C, (50f) (A/D 1K 
        BHI     LDB9E	;
        BSR     LDB74	;
						;---------------------------------------------
        BRA     LDBA4	;
						;---------------------------------------------
LDB9E   CMPA    L00B5	;
        BCS     LDBA4	;
        LDAA    L00B5	;
LDBA4   STAA    L00A5	; OPN LP AFR
						;
        BRA     LDC1A	;
						;---------------------------------------------
LDBA8   JSR     $FD18	;
						;---------------------------------------------
						;-------------------------------------------------
						; LK UP PWR ENRICH TPS MULT vs BARO 
						;
						; 4 LINE TBL W/MULT 50% TO 200%,
						; TYP VAL = 200%
						;-------------------------------------------------
        LDX     #$D479	; PWR ENRICH TPS MULT vs BARO TBL 	
        JSR     $FB45	; 2d LK UP	
						;---------------------------------------------
						;
						; MULT TPS by LK'ED UP TBL VAL
						;
        LDAB    L0049	; TPS		
        MUL     		;	
        ADCA    #0		; ROUND OFF	
        PSHA  			; SAVE MULT'ED TPS VAL TO 
						;--------------------------------------
						; LK UP TPS vs RPM THRESH FOR WOT TBL
						;
						;  9 LINE TBL, 0 - 3200 RPM
						;--------------------------------------
        LDX     #$D47D	; TPS vs RPM THRESH FOR WOT TBL	
        JSR     $FDDA	;	
						;---------------------------------------------
        TAB     		; SAVE TPS THESH VAL TO b REG
						;	
        LDAA    $000D	; STATUS WD 	
        BITA    #$20	; b5,  	
        BEQ     LDBCA	; BR IF NOT b5	
        SUBB    >$D2CB	;  10% TPS, PWR ENR TPS HYST 
        BCC     LDBCA	; BR IF 	
        CLRB    		;	
LDBCA   PULA    		;	
        SBA     		;	
        BCC     LDBD5	; BR IF NO UNDERFLOW	
						;	
        LDAA    >$D2CE	; PE ON DELAY TMR, 0 Sec's   
						; VAL = SEC * 20    
        STAA    L00BB	; PE ON DELAY TMR	
        BRA     LDC29	;	
						;---------------------------------------------
						;
						; CK COOLANT UPPER/LOWER LMT FOR PE BY PASS DELAY
						; WOT LK UP, 105c/50c
                        ;                             
LDBD5   LDAA    $0021	; COOLANT
        CMPA    >$D2CA	; UPPER TEMP THRSH FOR PE BYPASS 
        BHI     LDBF2	; BR IF COOL LT 105c, (LK UP WOT)
        CMPA    >$D2C9	; LOWER TEMP THRSH FOR PE BYPASS 
						; 50 C
        BLS     LDBF2	; LK UP WOT 
						;
						; CK RPM THRESH FOR WOT DELAY 
						;
        LDAA    >$D2CC	; DELAY PWR ENRICH BELOW 2800 RPM
        CMPA    $001C 	; RPM/25
        BLS     LDBEF	; BR IF RPM GT 2800 ROM
						;
						; CK THS THRESH FOR WOT DELAY 
						;
        LDAA    L0049	; TPS
        CMPA    >$D2CD	; PWR ENR NOT DLY'ED IF  TPS G.T.  
        BCS     LDC1C	; BR IF TPS LT 3.58VDC, (DELAY 
						;
						; RESET WOT DELAY TIMER
						;
LDBEF   CLRB    
        STAB    L00BB	; PE ON DELAY TMR
						;	================================================
						;	* WOT FUEL LOOK UP
						;	*
						;	* (0 - 3200 RPM)
						;	* TBL = AFR * 10
						;	================================================
						;
						; SET WOT FLAG b5, $000D
						;
LDBF2:  LDAA    $000D
        ORAA    #$20	; BIT 5, 0010 0000
        STAA    $000D	; SET BIT 5
        LDX     #$D486	; INDEX WOT AFR table 
        JSR     $FDDA
						;---------------------------------------------
        TAB     		; SAVE AFR TO B Reg
						;
						; CK COOL THRESH FOR WOT ENR
						;
        LDAA    $0021	; COOLANT
        CMPA    >$D2CF	; 55c COOL TEMP THRSH FOR PWR 
        BHI     LDC13	; BR IF COOL LT 55c
						;
						; CK RPM THRESH FOR WOT PWR ENR
						;
        LDAA    $001C  	; RPM/25
        CMPA    >$D2D0	; 2000 RPM THRESH FOR PWR ENRICH
        BCC     LDC13	; BR IF RPM GT 2000 RPM
        SUBB    >$D2D1	; 1.5:1 AFR PWR ENRICH FOR COLD
        BCC     LDC13	; BR IF GT 1.5:1  
        CLRB    
LDC13:  LDAA    L00A5	; OPN LP AFR
        CBA     		; 
        BLS     LDC2F
        STAB    L00A5	; OPN LP AFR
LDC1A   BRA     LDC2F	;
						;---------------------------------------------
LDC1C   LDAB    L00BB	; PE ON DELAY TMR
        BEQ     LDBF2 	; LK UP WOT
        LDAA    L0070
        ANDA    #$06
        BEQ     LDC29
        DEC     L00BB	; PE ON DELAY TMR
LDC29   LDAA    $000D	; STATUS WD
        ANDA    #$DF	; CLR b5, (WOT FLAG)
        STAA    $000D	; STATUS WD
LDC2F   LDAA    $0000
        BITA    #$02	; b1
        BEQ     LDC38	; BR IF NOT b1, 
        JSR     $5800	; HEADS UP  <----****
						;---------------------------------------------
						;=============================================
						; BLM STUFF
						;
						;=============================================
LDC38   LDAA    $000D	; STATUS WD
        ANDA    #$FB	; CLR b2
        STAA    $000D	; STATUS WD
						;
						;
        LDAB    L00A2	; BLM
        ANDB    #$03	; MASK FOR LSB
        LDX     #$D2AC	; Blk learn Mult RPM cell 
						; boundry, (750  RPM) 
        ABX     		;
        DEX     		;
        TSTB    		;
        BEQ     LDC59	;
        LDAA    0,X		;
        SUBA    >$D2B2	; Blk learn cell RPM Hyst, (75 
        BCS     LDC55	;
        CMPA    $001C  	; RPM/25
        BHI     LDC90	;
LDC55   CMPB    #3		;
        BEQ     LDC64	;
LDC59   LDAA    1,X		;
        ADDA    >$D2B2	; Blk learn cell RPM Hyst, (75 
        BCS     LDC64	;
        CMPA    $001C  	; RPM/25
        BCS     LDC90	;
						;... 
LDC64   LDAB    L00A2	; BLM
        ANDB    #$0C	;
        LSRB    		;
        LSRB    		;
        LDX     #$D2AF	; Blk learn Mult MAP cell 
						; boundry, (26.3 Kpa) 
        ABX     		;
        DEX     		;
        TSTB    		;
        BEQ     LDC81	;
        LDAA    0,X		;
        SUBA    >$D2B3	; Blk learn cell LOAD Hyst, (2.5 
        BCS     LDC7D	;
						;
        CMPA    $0026	; S/D MAP 
        BHI     LDC90	;
LDC7D   CMPB    #3		;
        BEQ     LDC8C	;
LDC81   LDAA    1,X		;
        ADDA    >$D2B3	; Blk learn cell LOAD Hyst, (2.5 
        BCS     LDC8C	;
        CMPA    $0026	; S/D MAP 
        BCS     LDC90	;
LDC8C   LDAB    L00A2	; BLM
        BRA     LDCC8	;
						;---------------------------------------------
						;                                   
						; SET BITS IN $000D		   
						;    					   
LDC90   LDAA    $000D	; STATUS WD
        ORAA    #$0C	; b2 & b3 
        STAA    $000D	; STATUS WD
						;
						;                                    
						; SET BITS IN $0006		   
						;    					   
        LDAA    $0006	;
        ORAA    #$01	; SET b0
        STAA    $0006	;
						;
        CLRB    		;
						;
        LDAA    $001C  	; RPM/25
        CMPA    >$D2AC	; Blk learn Mult RPM cell 
						; boundry, (750  RPM)  
        BCS     LDCB1	; IF RPM LT 750, BR
        INCB    		; B = 1 ?
        CMPA    >$D2AD	; Blk learn Mult RPM cell 
						; boundry, (1800 RPM)
        BCS     LDCB1	; IF RPM LT 1800, BR
        INCB    		; B = 2
        CMPA    >$D2AE	; Blk learn Mult RPM cell 
						; boundry, (2600 RPM)  
        BCS     LDCB1	; IF RPM LT 6375 RPM, BR
        INCB    		; B = 3    
						;
LDCB1:  LDAA    $0026	; S/D MAP 
        CMPA    >$D2AF	; Blk learn Mult MAP cell 
						; boundry, (26.3 Kpa)
        BCS     LDCC8	;
        ADDB    #4		;
        CMPA    >$D2B0	; Blk learn Mult MAP cell 
						; boundry, (60 Kpa) 
        BCS     LDCC8	;
        ADDB    #4		;
        CMPA    >$D2B1	; Blk learn Mult MAP cell 
						; boundry, (80 Kpa) 
        BCS     LDCC8	;
        ADDB    #4		;
LDCC8   LDX     #$00ED	; BLM CELL MATRIX
        ABX     		;
        LDAA    0,X		;
        CMPA    >$D2B9	; MAX BLM, 172 
        BHI     LDCD8	;
        CMPA    >$D2BA	;  MIN BLM, 108
        BCC     LDCE1	;
						;
						; SET BITS IN $0008
						;
LDCD8   LDAA    $0008	;
        ORAA    #$40	; 0100 0000
        STAA    $0008	;
						;
        JSR     $FDBD	;
						;---------------------------------------------
LDCE1   STAA    L00A3  	; BLM, BIN
        STAB    L00A2	; BLM
						;
        LDAA    >$D2B4	; BPW const for EGR off,   
        LDAB    >$D2B6	; EGR on filter coef      
						;
        TST     $0006	;
        BPL     LDD07	; BR IF EGR OFF
        LDAA    L00BE	; AIR FLOW, (gms/sec)
        LDAB    #197	; 
        MUL     		;
        ASLD    		;
        CMPA    #80		; AIR FLOW LMT
        BLS     LDCFC	;
        LDAA    #80		; LIMIT AIR FLOW
						;---------------------------------------------
						; Lk Up EGR COMP TABLE FOR AIR FLOW IN Gms/sec
						;
						; TBL IS  GMS/SEC vs PCT EGR
						; BL = N * 1461.5
						;---------------------------------------------
LDCFC   LDAB    L007F	; AIR FLOW FOR EGR
        LDX     #$D324	; EGR COMP TABLE FOR AIR FLOW IN 
        JSR     $FB67	; 3D LOOK UP ?
						;---------------------------------------------
        LDAB    >$D2B5	; EGR off filter coef
LDD07   LDX     L00A7	; EGR CORRECTION
        JSR     $FB12	; LAG FILTER ROUTINE
						;---------------------------------------------
        STD     L00A7	; EGR CORRECTION
						;
        ASLB    		;
        ADCA    #0		;
        PSHA    		;
						;---------------------------------------------
						; Lk Up  BPW CONST MULT vs BARO
						;
						;  (BARO 75 - 105 Kpa)
						; TBL = MULT * 128
						;---------------------------------------------
        LDX     #$D475	; BPW CONST MULT vs BARO
        JSR     $FD18	;
        JSR     $FB45	; 2d LK UP
						;---------------------------------------------
        PULB    		;
        MUL 			; APPLY MULTIPLIER    
        ASLD    		;
        BCC     LDD22	; BR IF NO OVERFLOW
        LDAA    #255	; USE MAX LMT
LDD22   STAA    L00A6	;
						;
        LDAA    L0070	;
        BITA    #$04	; b2
        BNE     LDD2D	; BR IF NOT b2
        JMP     >$DDDE	;
						;---------------------------------------------
LDD2D   LDAA    L009B	; TRANS FUEL CALC INTERVEL TMR
        BNE     LDD57	;
						;
						;
        LDAA    >$D294	; 100 MSEC TRANS FUEL CALC l
        STAA    L009B	; TRANS FUEL CALC INTERVEL TMR
						;
						;---------------------
						; FILTER TPS
						;---------------------
        LDAB    >$D295	; TPS Filter Coef
        LDX     L004D	; FILTERED TPS
        LDAA    L0049	; TPS
        JSR     $FB12	; LAG FILTER ROUTINE
						;---------------------------------------------
        STD     L004D	; FILTERED TPS
						;---------------------------------------------
						; LK UP  MAP FILTER COEF vs COOL 
						;
						;	(-5c - 95c)
						; TBL = COEF * 255
						;---------------------------------------------
        LDX     #$D306	; MAP FILTER COEF vs COOL TBL
        LDAA    $0021	; COOLANT
        LSRA    		; DIV BY 2 FOR LK UP
        JSR     $FB36	; 2d LK UP
						;---------------------------------------------
        TAB     		; FILT MAP TO B Reg
        LDX     $002F	; FILT MAP VAL, (OLD)
        LDAA    $0026	; S/D MAP 
        JSR     $FB12	; LAG FILTER ROUTINE
						;---------------------------------------------
        STD     $002F	; FILT MAP
        BRA     LDD5A	;
						;---------------------------------------------
LDD57   DEC     L009B	; TRANS FUEL CALC INTERVEL TMR
						;
LDD5A   LDAA    $000E  	; MAWF1
        BITA    #$02	; b1, BLM Enable
        BEQ     LDDCF	; BR IF NOT BLM Enable 
        LDAA    $000D	; STATUS WD
        BITA    #$08	; b3
        BNE     LDDCF	; STATUS WD
        LDAA    L00A4  	; CURRENT INTEGRATOR
        CMPA    #128	; STOCH ?
        BEQ     LDDCF	; BR IF AT TARGET AFR
        LDAB    L00B9	; INTEGRATOR DELAY TMR 
        INCB    		; INC TMR
        BMI     LDD78	; BT IF  
        STAB    L00B9	; INTEGRATOR DELAY TMR 
        ASLB    		; MULT * 2
        CMPB    L00B0	; INTEGRATOR DELAY
        BCS     LDDD4	;
LDD78   LDAB    L00B8	; BLK LEARN TMR
        INCB    		;
        BEQ     LDD84	;
        STAB    L00B8	; BLK LEARN TMR
        CMPB    >$D2AB	; FREQ OF BLK LEARN UPDATE, (170 
        BCS     LDDD4	; BR IF TMR G.T. 170 Msec
LDD84   SUBA    #128	; CK CURRENT INTEGRATOR VAL
        BCS     LDD95	; BR IF L.T. STOCH
        CMPA    >$D2B7	; Clsd lp intagrator window val, 
        BLS     LDDD4	; BR IF 
        LDAA    $000E  	; MAWF1
        BITA    #$40	; b6, RICH
        BNE     LDDD4	; IF b6
        BRA     LDDA1	;
						;---------------------------------------------
LDD95   NEGA    		; INVERT INT DIFF VAL
        CMPA    >$D2B7	; Clsd lp intagrator window val, 
        BLS     LDDD4	;
        LDAA    $000E  	; MAWF1
        BITA    #$40	; BIT 6, RICH
        BEQ     LDDD4	; BR IF NOT RICH
						;---------------------
						; UP DATE BLM CELLS
						;
						;---------------------
LDDA1   LDX     #$00ED	; BLM CELL MATRIX
        LDAB    L00A2	; BLM CELL NUMBER
        ABX     		; ADJ INDEX FOR BLM CELL REQUEST
        LDAA    0,X		; GET BLM VALUE FOR THIS CELL
						;
        LDAB    $000E  	; MAWF1
        BITB    #$40	; b6  (R/L) FLAG
        BEQ     LDDBE	; BR IF NOT RICH
        SUBA    >$D2B8	; BLM modifier, 1 
        BCS     LDDB9	;
        CMPA    >$D2BA	; MIN BLM, 103
        BCC     LDDCB	; BR IF BLM L.T. MIN
LDDB9   LDAA    >$D2BA	; GET MIN BLM, 103
        BRA     LDDCB	;
						;---------------------------------------------
LDDBE   ADDA    >$D2B8	; BLM modifier , 1
        BCS     LDDC8	; BR IF OVERFLOW
        CMPA    >$D2B9	; MAX BLM, 172
        BLS     LDDCB	; BR IF BLM = 172 or L.T. 172
LDDC8   LDAA    >$D2B9	; USE MAX BLM, 172
LDDCB   STAA    0,X		; SAVE TO BLM CELL ADDR
        STAA    L00A3  	; BLM FOR ALDL
LDDCF   CLRB    
        STAB    L00B9	; INTEGRATOR DELAY TMR 
        STAB    L00B8	; BLK LEARN TMR
						;
LDDD4   LDAA    $000D	; STATUS WD
        ANDA    #$F7	; CLR b3
        STAA    $000D	; STATUS WD
						;
        LDAA    $001F	; RPM/12.5
        STAA    $0020	; OLD RPM/12.5
						;
LDDDE   JMP     $E531	; TO CPU ADDR
						;---------------------------------------------
LDDE1   LDAA    $0001	;
        BPL     LDE08	;
        LDAA    $000E  	; MAWF1
        BMI     LDDF1	; BR IF CLOSED LOOP	?
						;
						; CK o2 FOR  TO GO CLSD LOOP,
						; 				
        LDAA    >$D2BF	; o2 Upper Limit TO GO CLSD LOOP, 
						; (734 MVDC)
						; TO GO CLSD LOOP o2 CEED 
						;								    
        LDAB    >$D2C0	; o2 Lower Limit, (352 mvdc)
						; to go CLSD LOOP o2 CEED 
        BRA     LDDF7
						;---------------------------------------------
						;
						; CK o2 FOR STAY IN CLSD LOOP WINDOW
						;------------------------------------------- 				
LDDF1   LDAA    >$D2BD	; o2 UPPER LIMIT, (700 mvdc)
						; STAY IN CLSD LOOP 
						;
        LDAB    >$D2BE	; o2 LOWER LIMIT, (352 mvdc)
						; STAY IN CLSD LOOP 
						;
LDDF7   CMPA    L003E  	; o2 VDC, (A/D)
        BCS     LDDFF	; IF o2 G.T. UPPER LIMIT
        CMPB    L003E  	; o2 VDC, (A/D)
        BLS     LDE08	; IF o2 L.T. LOWER LIMIT
LDDFF   CLR     L009C
						;==========================
						; SET BITS IN $00DE
						;==========================
        LDAB    L00DE
        ORAB    #1		; SET b0
        STAB    L00DE
						;------------------------
						; CALC AIR FLOW VALUE
						;------------------------
LDE08   LDAA    $002E	;
        LDAB    >$D2F5	; SCALAR FOR MAP LD IN AIR FLOW 5%
        MUL     		;
        LDAB    $001C  	; RPM/25
        ASLB    		;
        BCC     LDE15	;
        LDAB    #255	;
LDE15   MUL     		;
        CMPA    #64		; LIMIT AIR FLOW VALUE
        BLS     LDE1C	;
        LDAA    #64		; FORCE MAX LMT	
LDE1C   STAA    L00BE	; AIR FLOW, (gms/sec)
						;-------------------------------------------------
						; LK UP	o2 SENS VOLTAGE BIAS FOR COLD OP'S 
						;
						;-------------------------------------------------
        LDX     #$D4D9	; O2 SENS VOLTAGE BIAS FOR COLD L 
        LDAA    L00E3	; START UP COOL
        COMA    		;
        JSR     $FB36	; 2d LK UP
						;---------------------------------------------
        STAA    L0055	; SAVE o2 SENSOR VOLTAGE BIAS 
						;
        LDAB    #3		;
						;
LDE2B:  STAB    L0054	; COLD OP'S o2
        LDAA    #5		;
        MUL     		;
						;-------------------------------------------------
						; LK UP INTAGRATOR DELAY  vs AIR FLOW 	
						;
						;-------------------------------------------------
        LDX     #$D48F	; INTAGRATOR DELAY vs AIR FLOW 
        ABX     		; LINE FIND
						;
        LDAA    L00BE	; AIR FLOW, (gms/sec)
        JSR     $FB49	; 2D LOOK PU 
						;---------------------------------------------
        LDX     #$0055	; 368 mvdc o2 SENSOR VOLTAGE BIAS  
        LDAB    L0054	; COLD OP'S o2
        BEQ     LDE59	;
        TST     $0002	;
        BPL     LDE4E	;
        ADDA    >$D2F7	; 109 mvdc o2 SENSOR BIAS AT IDLE
        BCC     LDE53	;
        LDAA    #255	;
        BRA     LDE53	;
						;---------------------------------------------
LDE4E   SUBA    L0055	; o2 SENSOR VOLTAGE BIAS 
        BCC     LDE53	;
        CLRA    		;
LDE53   ABX     		;
        STAA    0,X		;
        DECB    		;
						;
        BRA     LDE2B	;
						;---------------------------------------------
LDE59   STAA    L00B0	; INTEGRATOR DELAY
						;
        LDAB    $000E  	; MAWF1	
						;
        LDAA    L0056	; Slow o2 ERROR
        ADDA    >$D2F3	; 130 MVDC, o2 WINDOW FOR FAST o2 
        BCS     LDE68	;
        CMPA    L003F	; FILT o2 VAL
        BCS     LDE7D	; GO SET RICH FLAG
LDE68   LDAA    L0056	; Slow o2 ERROR
        SUBA    >$D2F3	; 130 MVDC, o2 WINDOW FOR FAST o2 
        BCS     LDE73	;
        CMPA    L003F	; FILT o2 VAL
        BHI     LDE79	;
LDE73   LDAA    L003F	; FILT o2 VAL
        CMPA    L00BD	;
        BHI     LDE7D	;
LDE79   ANDB    #$BF	; CLR b6, $000E, MAWF1, RICH
						;
        BRA     LDE7F	;
						;---------------------------------------------
LDE7D   ORAB    #$40	; SET b6, RICH
LDE7F   CMPB    $000E  	; MAWF1
        BEQ     LDE8F	; BR IF Z
						;						;
						; INCR ALDL CTR			;
						;						;
        INC     L00BA ; O2 Cross Counts
						;
        LDAA    $0007	;
        ORAA    #$10	;
        STAA    $0007	;
						;
        CLRA    		;
        BRA     LDE94	;
						;---------------------------------------------
LDE8F   LDAA    L00BF	; PORP DURATION TMR	
        INCA    		; INCR TMR
        BEQ     LDE96	; BR IF Z
LDE94   STAA    L00BF	; PORP DURATION TMR
						;
LDE96   STAB    $000E 	; MAWF1
        BPL     LDF08 	; RESET INT VALUE, 128
        LDAA    $0008	;
        BITA    #$08	; ... b3
        BNE     LDEA6	;
        LDAB    $000D	; STATUS WD
        BITB    #$20	; b5	
        BEQ     LDEAE	; STATUS WD
LDEA6   LDAB    $0006	;
        ORAB    #$01	; SET b0
        STAB    $0006	;
						;
        BRA     LDF02	;
						;---------------------------------------------
LDEAE   LDAB    >$D006	; 2ND AFR OPT WORD, 0001 1000
        BITB    #$20	; BIT 5
        BEQ     LDEC5	;
        LDAB    $000D	; STATUS WD
        ASRB    		;
        BCC     LDEC5	;
        ASLB    		;
        STAB    $000D	; STATUS WD
						;
						; SET BITS IN $0006
						;
LDEBD   LDAB    $0006
        ORAB    #$01	; SET b0
        STAB    $0006
        BRA     LDF08 	; RESET INT VALUE, 128
						;---------------------------------------------
LDEC5   LDAB    $000D	; STATUS WD
        BITB    #$10	; b4
        BEQ     LDED7	; BR IF NOT b4
        LDAA    $000E  	; MAWF1
        BITA    #$40	; b6, RICH
        BNE     LDF18	; BR IF b6
        LDAA    L00A4  	; INTIGRATOR, BIN
        BPL     LDF18
        BRA     LDEBD
						;---------------------------------------------
						;
						; CK AFR OPT WD 2
						;
LDED7   LDAB    >$D006	; 2ND AFR OPT WORD
        BITB    #$10	; b 4 
						; 1 = DO INT R/S ON BLM ANGE
        BEQ     LDEE4	; BR IF NOT b4
        LDAA    $000D	; STATUS WD
        BITA    #04		; b2
        BNE     LDEBD	; BR IF NOT b2, (Reset = 128)
LDEE4   LDAB    $0002
        BITB    #$20	; b5
        BNE     LDF18	; BR IF b5
						;
						; CK DECEL QUAL'S
						;
        LDAB    $0026	; S/D MAP 
        CMPB    >$D2C1	; CLS LP Decel, ENLEAN MAP 
						; thresh. (26 Kpa)  
        BHI     LDF18
        LDAB    $001C  	; RPM/25
        CMPB    >$D2C2	; CLS LP Decel, ENLEAN RPM 
						; thresh. (1000 RPM)
        BLS     LDF18
        LDAA    $000E  	; MAWF1
        BITA    #$40	; b6, RICH
        BNE     LDF18	; BR IF b6
        LDAA    L00A4  	; INTIGRATOR, BIN
        BPL     LDF18
						;
						; SET BIT 2
						;
LDF02   LDAA    $000B
        ORAA    #4		; SET BIT 2
        STAA    $000B
						;-----------------------
						;  RESET INT VALUE, 128
						;-----------------------
LDF08   LDAA    #128	;
        STAA    L00A4  	; INTIGRATOR, BIN
        LDAA    #102
        STAA    L0043	;  ASYNC INJ VAL
						;-----------------------
						; CLR RAM LOC'S
						;----------------------
        CLRA    
        STAA    L00AF	; INTEGRATOR DELAY TMR
        STAA    L00BC	; PORP  FACTORED AIR FLOW
        JMP     $E008	; TO CPU
						;---------------------------------------------
LDF18   LDAB    $0008
        LDAA    L0043	;  ASYNC INJ VAL
        CMPA    L0057	; ASYNC INJ MULT
        BHI     LDF2C
        SUBA    L0058	; PORP DURATION, SEC'S
        BCS     LDF27
        CLRA    
        BRA     LDF46
						;---------------------------------------------
LDF27   NEGA    
        ANDB    #$FD	; 1111 1101
        BRA     LDF36
						;---------------------------------------------
LDF2C   SUBA    L0057	; ASYNC INJ MULT
        LDAB    >$D2FB	; 90.6% POS ERR MOD FACTOR  
						; FOR RICH o2 AVG
        MUL     		;
						;
        LDAB    $0008	;
        ORAB    #$02	; SET b1
LDF36   STAB    $0008	;
						;
        LDAB    $0002	;
        BPL     LDF40	;
        LDAB    >$D2FC	; 0.750 IDLE ERR CORR TO ERROR	
        MUL     		;
LDF40   CMPA    #96		;
        BLS     LDF46		;
        LDAA    #96		;
LDF46   STAA    $0457	; FOR HEADS UP USE
						;
        ASLA    		;
        STAA    L0056	; Slow o2 ERROR
						;-------------------------------------------------
						; LK UP  PORPORTIONAL VALUE vs SLOW FILT ERROR
						;
						;	(o2 ERR 0 - 96)
						; TBL = CNT * 1
						;--------------------------------------------------
        LDX     #$D4A8	; PORPORTIONAL  VAL vs SLOW FILT 
        JSR     $FB49	; 2d LOOK UP ROUTINE
						;---------------------------------------------
        STAA    L00BC	; PORP  FACTORED AIR FLOW
						;
        LDAB    $0002	;
        BPL     LDF61	;
        LDAA    >$D2F8	; 0 SEC'S PORP TERM DURATION AT 
        PSHA    		;
        LDAA    >$D2F9	; PORP GAIN FACTOR FOR FLOW AT 
						;
        BRA     LDF72	;
						;---------------------------------------------
						;---------------------------------------------
						; LK UP PORP TERM DURRATION vs o2 ERROR 
						;
						; (o2 ERR 0 - 96)
						; TBL = SEC'S * 40
						;---------------------------------------------                          
LDF61   LDAA    L0056	; Slow o2 ERROR
        LDX     #$D4B5	; PORP TERM DURRATION vs o2 ERROR 
        JSR     $FB49	; 2d look up routine
						;---------------------------------------------
        PSHA    		; SAVE TO STX
						;---------------------------------------------
						; LK UP PORP GAIN FLOW FACTOR vs AIR FLOW 
						;	(0 - 64 gms/Sec)
						;
						; TBL = SEC'S * 40
						;---------------------------------------------                           
        LDAA    L00BE	; AIR FLOW, (gms/sec)
        LDX     #$D4C7 	; PORP GAIN FLOW FACTOR vs AIR FLOW Tbl
        JSR     $FB49	; 2d LOOK UP ROUTINE
						;---------------------------------------------
LDF72   LDAB    L00BC	; PORP FACTORED AIR FLOW
        MUL     		; MULT * AIR FLOW
        ADCA    #00		; ROUND
        STAA    L00BC	; PORP  FACTORED AIR FLOW
						;---------------------------------------------
						;LK UP PORP TERM DURRATION vs AIR FLOW 
						; (0 - 64 gms/sec)
						;
						; TBL = SEC'S * 40
						;---------------------------------------------                   
        LDAA    L00BE	; AIR FLOW, (gms/sec)
        LDX     #$D4C2	; PORP DURRATION OFFSET TBL vs 
						; COUNTS FLOW tbl
        JSR     $FB49	; 2d look up routine
						;---------------------------------------------
        PULB    		;
        ABA     		; A + B
        BCC     LDF87	; IF NO OVERFLOW
        LDAA    #255	;  LIMIT
						;
LDF87   STAA    L0058	; SAVE PORP DURATION
						;---------------------------------------------
						; LK UP INT DELAY MULT vs SLOW O2 ERROR
						;	(o2 ERR 0 -	96)
						;
						; TBL = FACTOR * 255
						;---------------------------------------------
        LDAA    L0056	; Slow o2 ERROR
        LDX     #$D4CC	; INT DELAY MULT vs SLOW O2 ERROR 
        JSR     $FB49	; 2d look up routine
						;---------------------------------------------
        LDAB    L00B0	; GET INTEGRATOR DELAY 
        MUL     		; INTEGRATOR DELAY  * DELAY MULT
        LDAB    $0002	;
        BPL     LDF9F	;
        ADDA    >$D2FA	; INTEGRATOR DELAY BIAS AT IDLE, 
        BCC     LDF9F	; BR NO OVERFLOW
        LDAA    #255	; USE MAX
						;
LDF9F   STAA    L00B0	; SAVE  INTEGRATOR DELAY 
        STAA    $0458	; HEADS UP USE
						;---------------------------------------------
        LDAA    $0008	;
        ANDA    #$02	; b1
        LDAB    $000E  	; MAWF1
						;
        ANDB    #$40		; 0100 0000 
        ABA     		;
        BEQ     LDFBC	; GO CK INT REQUIREMENTS
        CMPA    #66		;
        BEQ     LDFBC	;
        LDAA    L00BC	; PORP  FACTORED AIR FLOW
        BEQ     LDFC3	;
        DEC     L00BC	; PORP  FACTORED AIR FLOW
						;
        BRA     LDFC3	;
						;---------------------------------------------
LDFBC   LDAA    L0056	; Slow o2 ERROR
        CMPA    >$D2F4	; 4 BITS, ERR THRESH FOR TOR CORR
        BHI     LDFD1	; BR IF AIR FLW L.T 4
LDFC3   CLR     L00AF	; INTEGRATOR DELAY TMR
        LDAA    L00BF	; PORP DURATION TMR	
        CMPA    L0058	; PORP DURATION, SEC'S
        BLS     LDFF7	;
        CLR     L00BC	; PORP  FACTORED AIR FLOW
        BRA     LDFF7	;
						;---------------------------------------------
LDFD1   LDAA    L00AF	; INTEGRATOR DELAY TIMER
        CMPA    L00B0	; INTEGRATOR DELAY
        BCS     LDFDA	; BR IF IND DLY TMR ...
        CLRA    		;
        BRA     LDFDB	;
						;---------------------------------------------										
						; CK INTEGRATOR LMTS
						;
						;---------------------------------------------										
LDFDA   INCA    		; INCR TMR
LDFDB   STAA    L00AF	; INTEGRATOR DELAY TIMER
        BNE     LDFF7	; BR IF TMR L.T REQ TIME
        LDAA    L00A4  	; CURRENT INTEGRATOR VAL
						;
        LDAB    $0008	;
        BITB    #2		; b1
        BNE     LDFEF	; BR IF b1
        CMPA    >$D2C4	; CLS lP Max INTAGRATOR VAL, 158
        BEQ     LDFF5	; BR IF INT L.T. MAX
        INCA    		;
        BRA     LDFF5	; GO SAVE INTEGRATOR
						;---------------------------------------------
LDFEF   CMPA    >$D2C3	; 40, CLS LP MIN INTAGRATOR VAL
        BEQ     LDFF5	; BR IF INT L.T. MIN 
        DECA    		;
LDFF5   STAA    L00A4  	; CURRENT INTIGRATOR
						;
LDFF7   LDAA    L00BC	; PORP FACTORED AIR FLOW
						;
        LDAB    $000E  	; MAWF1
        BITB    #$40	; b6, RICH
		;  fix required to correctly assemble		
		; BEQ     LE009	; BR IF NOT b6
LONE	FCB		$27
LTWO	FCB		$09		
LEND	FCB		$96		; Second half of this instruction is on next chip
 ;---------------------------------------------
 ;---------------------------------------------
	;
	;   END OF PROM !!!
	;
 ;---------------------------------------------
 ;---------------------------------------------
