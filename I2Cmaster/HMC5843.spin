{{ HMC5843 - Test I2Cmaster driver object

Michael Shimniok

}}
CON
  _clkmode      = xtal1 + pll16x
  _xinfreq      = 5_000_000
  _stack        = 50

'' HMC5843 address
  waddr  = $3c
  raddr  = $3d
        
'' HMC5843 registers
  confA  = 00
  confB  = 01
  mode   = 02
  xmsb   = 03
  xlsb   = 04
  ymsb   = 05
  ylsb   = 06
  zmsb   = 07
  zlsb   = 08
  status = 09
  idA    = 10
  idB    = 11
  idC    = 12
  
OBJ
  Wire: "I2Cmaster"
  Serial: "FullDuplexSerial"

PUB Main | x, xhi, xlo, y, yhi, ylo, z, zhi, zlo
  Wire.init(16, 17, Wire.NORMAL)
  Serial.start(31, 30, 0, 9600)

  Wire.start
  Wire.write(waddr)
  Wire.write(mode)
  Wire.write(0)
  Wire.stop

  repeat
    Wire.start
    Wire.write(waddr)
    Wire.write(3) ' start reading at xmsb
    Wire.start
    Wire.write(raddr)
    xhi := Wire.read(true)
    xlo := Wire.read(true)
    x := (xhi << 8) | (xlo & $ff)
    if (x & (1<<15)) ' convert uint16_t to int32_t
      x := ~x + 1 
    yhi := Wire.read(true)
    ylo := Wire.read(true)
    y := (yhi << 8) | (ylo & $ff)
    if (y & (1<<15)) ' convert uint16_t to int32_t
      y := ~y + 1 
    zhi := Wire.read(true)
    zlo := Wire.read(false)
    z := (zhi << 8) | (zlo & $ff)
    if (z & (1<<15)) ' convert uint16_t to int32_t
      z := ~z + 1 
    Wire.stop
    Serial.dec(x)
    Serial.tx(32)
    Serial.dec(y)
    Serial.tx(32)
    Serial.dec(z)
    Serial.tx(13)
    waitcnt(clkfreq/10 + cnt)
    
    
 
     
    