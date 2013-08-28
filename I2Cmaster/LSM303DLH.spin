{{ LSM303DLH - Test I2Cmaster driver object

Michael Shimniok

}}
CON
  _clkmode      = xtal1 + pll16x
  _xinfreq      = 5_000_000
  _stack        = 50

'' LSM303DLH registers
'' --- Mag ---
  CRA_REG_M     = $00
  CRB_REG_M     = $01
  MR_REG_M      = $02
  OUT_X_M       = $03
  OUT_Y_M       = $05
  OUT_Z_M       = $07
'' --- Acc --- 
  CTRL_REG1_A   = $20
  CTRL_REG4_A   = $23
  OUT_X_A       = $28
  OUT_Y_A       = $2A
  OUT_Z_A       = $2C
  
'' LSM303DLH address
  addr_mag      = $1E
  addr_acc      = $18
  
OBJ
  Wire: "I2Cmaster"
  Serial: "FullDuplexSerial"

PUB Main | ack, x, y, z, i, v[6]

  Wire.init(19, 18, Wire.NORMAL)
  Serial.start(31, 30, 0, 9600)

  '' Initialize Accelerometer
  writeReg(addr_acc, CTRL_REG1_A, %00101111)            ' Normal mode, 100Hz, XYZ enable
  writeReg(addr_acc, CTRL_REG4_A, %01010000)            ' data MSB@lower addr, ±4g

  '' Initialize Magnetometer
  writeReg(addr_mag, CRA_REG_M, %00010000)              ' Data output rate, 15Hz
  writeReg(addr_mag, CRB_REG_M, %10000000)              ' ±4.0 Gauss
  writeReg(addr_mag, MR_REG_M,  %00000000)              ' Continuous-conversion mode

  repeat
    '' accel
    Serial.str(String("Acc: "))
    x := readRegShort(addr_acc,OUT_X_A)
    Serial.dec(x)
    Serial.tx(32)
    y := readRegShort(addr_acc,OUT_Y_A)
    Serial.dec(y)
    Serial.tx(32)
    z := readRegShort(addr_acc,OUT_Z_A)
    Serial.dec(z)
    Serial.tx(32)
    '' Mag
    Serial.str(String(" Mag: "))
    x := readRegShort(addr_mag,OUT_X_M)
    Serial.dec(x)
    Serial.tx(32)
    y := readRegShort(addr_mag,OUT_Y_M)
    Serial.dec(y)
    Serial.tx(32)
    z := readRegShort(addr_mag,OUT_Z_M)
    Serial.dec(z)
    Serial.tx(32)
    Serial.tx(13)
    waitcnt(clkfreq/10 + cnt)

PUB readRegShort(a, r):val | lo, hi
    hi:=readReg(a,r)
    lo:=readReg(a,r+1)
    val := (hi << 8)|(lo & $ff)
    if (val & (1<<15)) ' convert uint16_t to int32_t
      val := ~val + 1
          
PUB readReg(a, r):val | ack
    Wire.start
    ack := Wire.write(a<<1) ' write
    Wire.write(r)
    Wire.start
    ack |= Wire.write((a<<1)|1) ' read
    val := Wire.read(false)
    Wire.stop
    ifnot (ack)
      Serial.tx(13)
      Serial.str(String("NACK"))
      Serial.tx(13)

PUB writeReg(a, r, v) | ack
  Wire.start
  ack := Wire.write(a<<1)              ' write
  ack |= Wire.write(r)
  ack |= Wire.write(v)
  Wire.stop
    ifnot (ack)
      Serial.tx(13)
      Serial.str(String("NACK"))
      Serial.tx(13)