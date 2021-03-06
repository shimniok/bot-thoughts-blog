{{
BubbleDisplay.spin
http://www.bot-thoughts.com/2014/11/bubble-display-propeller.html

Test for HP Bubble Display, 4-digit, 7-segment, common anode

Pinout:       Segments:
                ──a──
  111          │     │
  210987       f     b
 ┌┴┴┴┴┴┴┐      │     │
 │ 1234 │       ──g──
 └┬┬┬┬┬┬┘      │     │
  123456       e     c
               │     │
                ──d── •dp
Hookup:

Prop  Pin  Name
---- ----- ----
p16 - 6    Cathode 4, digit 1
p17 - 4    Cathode 3, digit 2
p18 - 10   Cathode 2, digit 3
p19 - 1    Cathode 1, digit 4
p20 - 12   Anode A
p21 - 11   Anode B
p22 - 3    Anode C
p23 - 8    Anode D
p24 - 2    Anode E
p25 - 9    Anode F
p26 - 7    Anode G
p27 - 5    Anode DP

}}
CON
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000
  _stack = ($3000 + $3000 + 100) >> 2   'accomodate display memory and stack

  CA_4 = |<16
  CA_3 = |<17
  CA_2 = |<18
  CA_1 = |<19
  AN_A = |<20
  AN_B = |<21
  AN_C = |<22
  AN_D = |<23
  AN_E = |<24
  AN_F = |<25
  AN_G = |<26
  AN_P = |<27

  A = 0
  B = 1
  C = 2
  D = 3
  E = 4
  F = 5
  G = 6
  P = 7

  delay = 1000

VAR
  long stack[50]
  long b1, b2, b3, b4

PUB Start | i

  b1 := b2 := b3 := b4 := 0

  cognew(display, @stack)

  repeat
    repeat i from 0 to 9999
      b4 := i // 10
      b3 := (i/10) // 10
      b2 := (i/100) // 10
      b1 := (i/1000) // 10
      waitcnt(clkfreq/10+cnt)

PUB display | bit, s

  dira := CA_1|CA_2|CA_3|CA_4|AN_A|AN_B|AN_C|AN_D|AN_E|AN_F|AN_G|AN_P

  ano[A] := AN_A
  ano[B] := AN_B
  ano[C] := AN_C
  ano[D] := AN_D
  ano[E] := AN_E
  ano[F] := AN_F
  ano[G] := AN_G
  ano[P] := AN_P

  repeat s from A to P
    seg[s] := CA_1|CA_2|CA_3|CA_4

  ' The idea is to loop through each segment (anodes), and activate only
  ' the required cathodes for each. That way we only ever have a single
  ' segment at a time, and illumination of each segment (with a resistor
  ' tied to it) is exactly the same.

  ' So for example, 1234 requires segment A to be lit for the 2 and 3 but
  ' not the 1 and 4. We use an array to manage the cathode settings for
  ' each segment in this case, CA_1|CA_4 because the cathode must be low
  ' for the segment to light up.

  ' The Constants CA_? are the cathode outa settings so we can just set
  ' outa := seg[B] for example. We also have to set the appropriate anode
  ' high to supply the segment (on each digit) with current.

  repeat
    setdigit(1, b1)
    setdigit(2, b2)
    setdigit(3, b3)
    setdigit(4, b4)
    repeat s from A to P
      bit := seg[s]|ano[s]
      outa := bit
      waitcnt(clkfreq/delay+cnt)

PUB setdigit(digit, value)|set, unset
  ' digit: is the display digit position, 1-4
  ' value: is the 0-9 value to display in the specified position;
  '        values 10-19 set the decimal point and use the 1's position;
  '        all other values turn off the specified position.

  ' Cathode is active low, so to turn on a particular position's cathode bit
  ' CA_?, clear that bit: seg[A] &= set.  To turn off a particular position,
  ' CA_?, set that bit: seg[A] |= unset

  ' unset is computed to raise the specified position bit via OR
  case digit
    1: unset := CA_1
    2: unset := CA_2
    3: unset := CA_3
    4: unset := CA_4
    other: return

  ' set is computed to lower the specified position bit via AND
  ' To affect only CA_1 thru CA_4, set is masked to these bits.
  set := !unset & (CA_1|CA_2|CA_3|CA_4)

  if (value > 9) and (value < 20)
    seg[P] &= set
    value -= 10
  else
    seg[P] |= unset

  case value
    0: seg[A] &= set
       seg[B] &= set
       seg[C] &= set
       seg[D] &= set
       seg[E] &= set
       seg[F] &= set
       seg[G] |= unset

    1: seg[A] |= unset
       seg[B] &= set
       seg[C] &= set
       seg[D] |= unset
       seg[E] |= unset
       seg[F] |= unset
       seg[G] |= unset

    2: seg[A] &= set
       seg[B] &= set
       seg[C] |= unset
       seg[D] &= set
       seg[E] &= set
       seg[F] |= unset
       seg[G] &= set

    3: seg[A] &= set
       seg[B] &= set
       seg[C] &= set
       seg[D] &= set
       seg[E] |= unset
       seg[F] |= unset
       seg[G] &= set

    4: seg[A] |= unset
       seg[B] &= set
       seg[C] &= set
       seg[D] |= unset
       seg[E] |= unset
       seg[F] &= set
       seg[G] &= set

    5: seg[A] &= set
       seg[B] |= unset
       seg[C] &= set
       seg[D] &= set
       seg[E] |= unset
       seg[F] &= set
       seg[G] &= set

    6: seg[A] &= set
       seg[B] |= unset
       seg[C] &= set
       seg[D] &= set
       seg[E] &= set
       seg[F] &= set
       seg[G] &= set

    7: seg[A] &= set
       seg[B] &= set
       seg[C] &= set
       seg[D] |= unset
       seg[E] |= unset
       seg[F] |= unset
       seg[G] |= unset

    8: seg[A] &= set
       seg[B] &= set
       seg[C] &= set
       seg[D] &= set
       seg[E] &= set
       seg[F] &= set
       seg[G] &= set

    9: seg[A] &= set
       seg[B] &= set
       seg[C] &= set
       seg[D] &= set
       seg[E] |= unset
       seg[F] &= set
       seg[G] &= set

    other:
       seg[A] |= unset
       seg[B] |= unset
       seg[C] |= unset
       seg[D] |= unset
       seg[E] |= unset
       seg[F] |= unset
       seg[G] |= unset

  return

DAT
        seg   long 0[8]
        ano   long 0[8]

