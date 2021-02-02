# Installation Notes

## Getting started

1. Get tools we need
    - vscode
    - python3
    - Optional Tools
        - git (https://git-scm.com/download/win)
        - TortoiseGit (https://download.tortoisegit.org/tgit/2.11.0.0/TortoiseGit-2.11.0.0-64bit.msi)

1. Download ESP32 micropython binary (https://micropython.org/resources/firmware/esp32-idf3-20200902-v1.13.bin)

1. (Optional) Install python extension for vscode

1. Install python scripts
    - pip install esptool
    - pip install adafruit-ampy

1. Plug in ESP32 and discover which com port it uses via device manager

1. (Potentially) install CP2104 uart drivers (https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers)

1. Erase ESP32 `esptool.py.exe --chip esp32 --port COM1 erase_flash`

1. Flash in micropython `esptool.py --chip esp32 --port COM3 --baud 460800 write_flash -z 0x1000 esp32-idf3-20200902-v1.13.bin`

1. Verify micropython is installed `ampy --port COM3 --baud 115200 ls` if command does not work, press reset button on ESP32 (if there are two, try both!). Should see `/boot.py` upon success

## Making an LED blink

1. Let's make our own custom program and upload it. First make a new file called `main.py` and place it in the currrent directory.

1. Copy and paste the following into the file

``` python
# Blinks the red LED attached to pin 13 once a second
import time # Generic python module to access time
import machine # Micropython-specific python module

# Get the pin and assign it to be an OUTput
led = machine.Pin(13, machine.Pin.OUT)

# Blink the LED forever
while True:
    led.on()
    time.sleep(0.5)
    led.off()
    time.sleep(0.5)
```

The line `led = machine.Pin(13, machine.Pin.OUT)` may need to be adjusted, depending on your ESP32 devkit. For The Adafruit ESP32 Feather it is `GPIO13`, for the ESP-WROOM32 Devkit1 it is `GPIO2`. Use `13` or `2` respectively.

1. Upload the file to the ESP32 using `ampy --port COM4 --baud 115200 main.py`

1. Check that the file uploaded successfully `ampy --port COM3 --baud 115200 ls`

1. Reset the ESP32 by either unplugging the cable or hitting the reset button. 

1. The LED should now blink!