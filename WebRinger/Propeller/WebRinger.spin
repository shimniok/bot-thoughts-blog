{
 WebRinger -- Rings a bell when it receives a signal
 on an input pin (ideally, sent by a standalone, web
 enabled host like a Raspberry Pi)

 Dependencies..: Servo32v7
 Author........: Michael Shimniok  www.bot-thoughts.com
}
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000       '80 MHz

  ms = 80000
  delay = 100

  bell = 9
  bellMiddle = 1100
  bellRight = 950

VAR
  long stack1[6]
  long count
  
OBJ
  servo : "Servo32v7"   ' Servo controller
  pc : "Simple_Serial"
  
PUB Start | pos, c

  pc.init(31,30,9600)

  servo.start
  servo.ramp

  cognew(PinCount, @stack1)

  repeat
    if (count > 0)
      ring
      count := count - 1
    waitcnt(cnt+500*ms)

PUB PinCount

  repeat
    waitpeq(|<20, |<20, 0)        ' wait for pin 20 to go high
    count := count + 1
    waitpeq(0, |<20, 0)         ' wait for pin 20 to go low again
    

PUB ring
  repeat 4
    servo.set(bell, bellRight)
    waitcnt(cnt + delay*ms)
    servo.set(bell, bellMiddle)
    waitcnt(cnt + delay*ms)
      