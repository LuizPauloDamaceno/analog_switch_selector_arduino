#!/usr/bin/python
import time
import serial
ser = serial.Serial('/dev/ttyUSB0', 9600)
time.sleep(2)
ser.write('BIPM')
