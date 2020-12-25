SHELL:=/bin/bash # for readarray
DOWNLOAD_DIR = backup
SRC_DIR = src
SRC_FILES = $(wildcard $(SRC_DIR)/*.py)
PORT = /dev/ttyUSB0
ESP32_BAUD = 115200
AMPY_BAUD = 115200
AMPY_DELAY = 0.5

.PHONY: all help upload download reset generate_ampy

default: help

help: ## List available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

upload: ## Load the python files into flash
	@$(foreach pyfile, $(SRC_FILES), ampy -b $(AMPY_BAUD) -p $(PORT) put $(pyfile);)

download: ## Grab all available files from the ESP32
	@mkdir -p ./${DOWNLOAD_DIR}; \
	readarray LIST <<< $$(ampy -b $(AMPY_BAUD) -p $(PORT) ls); \
	for pyfile in "$${LIST[@]}"; do \
		NAME="$$(echo -e "$$pyfile" | sed -e 's/[[:space:]]*$$//')"; \
		echo -e "Downloading $$NAME ..."; \
		ampy -b $(AMPY_BAUD) -p $(PORT) get $$NAME ./${DOWNLOAD_DIR}/$$NAME; \
	done; \
	echo "Done"

reset: ## Reset the ESP32
	esptool.py --chip esp32 --baud $(ESP32_BAUD) --port $(PORT) run

generate_ampy: ## Generate a .ampy file based on makefile settings
	@printf "AMPY_PORT=$(PORT)\nAMPY_BAUD=$(AMPY_BAUD)\nAMPY_DELAY=$(AMPY_DELAY)\n" > .ampy