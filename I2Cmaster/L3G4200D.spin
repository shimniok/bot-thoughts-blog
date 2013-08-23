{{ L3G4200D - Test I2Cmaster driver object

Michael Shimniok

}}
CON
  _clkmode      = xtal1 + pll16x
  _xinfreq      = 5_000_000
  _stack        = 50

'' L3G4200D registers

  L3G4200D_WHO_AM_I      = $0F
   
  L3G4200D_CTRL_REG1     = $20
  L3G4200D_CTRL_REG2     = $21
  L3G4200D_CTRL_REG3     = $22
  L3G4200D_CTRL_REG4     = $23
  L3G4200D_CTRL_REG5     = $24
  L3G4200D_REFERENCE     = $25
  L3G4200D_OUT_TEMP      = $26
  L3G4200D_STATUS_REG    = $27
   
  L3G4200D_OUT_X_L       = $28
  L3G4200D_OUT_X_H       = $29
  L3G4200D_OUT_Y_L       = $2A
  L3G4200D_OUT_Y_H       = $2B
  L3G4200D_OUT_Z_L       = $2C
  L3G4200D_OUT_Z_H       = $2D
   
  L3G4200D_FIFO_CTRL_REG = $2E
  L3G4200D_FIFO_SRC_REG  = $2F
   
  L3G4200D_INT1_CFG      = $30
  L3G4200D_INT1_SRC      = $31
  L3G4200D_INT1_THS_XH   = $32
  L3G4200D_INT1_THS_XL   = $33
  L3G4200D_INT1_THS_YH   = $34
  L3G4200D_INT1_THS_YL   = $35
  L3G4200D_INT1_THS_ZH   = $36
  L3G4200D_INT1_THS_ZL   = $37
  L3G4200D_INT1_DURATION = $38
   
'' L3G4200D address
  waddr  = $D2
  raddr  = $D3
  
OBJ
  Wire: "I2Cmaster"
  Serial: "FullDuplexSerial"

PUB Main | x, xhi, xlo, y, yhi, ylo, z, zhi, zlo
  Wire.init(16, 17, Wire.NORMAL)
  Serial.start(31, 30, 0, 9600)

  Wire.start
  Wire.write(waddr)
  Wire.write(L3G4200D_CTRL_REG1)
  Wire.write($0f)' Normal power mode, all axes enabled
  Wire.stop
  Wire.start
  Wire.write(L3G4200D_CTRL_REG4)
  Wire.write($20)' 2000 dps full scale
  Wire.stop

  repeat
    Wire.start
    Wire.write(waddr)
    ' assert the MSB of the address to get the gyro 
    ' to do slave-transmit subaddress updating.
    Wire.write( L3G4200D_OUT_X_L | (1 << 7) )
    Wire.start
    Wire.write(raddr)
    xlo := Wire.read(true)
    xhi := Wire.read(true)
    x := (xhi << 8) | (xlo & $ff)
    if (x & (1<<15)) ' convert uint16_t to int32_t
      x := ~x + 1 
    ylo := Wire.read(true)
    yhi := Wire.read(true)
    y := (yhi << 8) | (ylo & $ff)
    if (y & (1<<15)) ' convert uint16_t to int32_t
      y := ~y + 1 
    zlo := Wire.read(true)
    zhi := Wire.read(false)
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
    
    
 
     
    