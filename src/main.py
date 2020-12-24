# Blinks the red LED attached to pin 13 once a second

import time
import machine

# Get the pin and assign it to be an OUTput
led = machine.Pin(13, machine.Pin.OUT)

# Blink the LED forever
while True:
    led.on()
    time.sleep(0.5)
    led.off()
    time.sleep(0.5)