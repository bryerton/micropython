# boot.py
# Executed on every boot, including deep-sleep wake-boot

import esp
esp.osdebug(None)

# Uncomment the following lines to enable the web REPL
# import webrepl
# webrepl.start()

# Uncomment the following two lines to disable REPL on UART0
# import uos
# uos.dupterm(None, 1)

import gc
gc.collect()
