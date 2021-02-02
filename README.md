# Micropython and the ESP32

## Device required

- ESP32 development kit (tested on [Adafruit HUZZAH32 - ESP32 Feather Board](https://www.adafruit.com/product/3405))

## Recommended Tools

- [Python 3.x](https://www.python.org/downloads/) (with pip)
- [Visual Studio Code (vscode)](https://code.visualstudio.com/)

## Installation

First step is to grab the micropython binary from [here](https://micropython.org/download/esp32/), I recommend the latest stable version from the ESP-IDF v3.x branch, which is currently [v1.13](https://micropython.org/resources/firmware/esp32-idf3-20200902-v1.13.bin)

Next the very handy tool [esptool.py](https://github.com/espressif/esptool), which is used to load the binary onto the ESP32. It can be installed via pip
>pip install esptool

Also required is [ampy](https://github.com/scientifichackers/ampy) which is used to upload our python filest to the devkit. It can be installed via pip
>pip install adafruit-ampy

## Setup

Plug a micro USB cable into the ESP32 devkit, a new COM port should appear on your computer (if not, you may need to install a device driver for the CP2104 USB-UART, or similiar device, depending on your devkit).

Erase the flash of the ESP32 using the following, please replace `COM4` with the appropriate port
>esptool.py --chip esp32 --port COM4 erase_flash

Then program the micropython firmware into the ESP32
>esptool.py --chip esp32 --port COM4 --baud 460800 write_flash -z 0x1000 esp32-idf3-20200902-v1.13.bin

Lets test `ampy` and make sure it's working
>ampy --port COM4 --baud 115200 ls

Expected result is

```bash
/boot.py
```

## Run Example

Let's upload a simple example that blinks the red LED on the HUZZAH32 devkit

Run the following
>ampy --port COM4 --baud 115200 put src/main.py

Verify the main.py was uploaded
>ampy --port COM4 --baud 115200 ls

Expected result is

```bash
/boot.py
/main.py
```

Now press the reset button on the HUZZAH, the red LED should begin to blink!

## Notes

If an `.ampy` file is filled in and placed in the directory you are using `ampy` it can save you a lot of typing. An example `.ampy` is in the `docs` directory, edit it to match your settings and rename it `.ampy` and place it in the base directory of this repository, where you are running the commands.

## References

- [ESP32 Micropython Quick Reference](https://docs.micropython.org/en/latest/esp32/quickref.html)