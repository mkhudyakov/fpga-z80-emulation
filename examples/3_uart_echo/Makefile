# Project name
PROJECT = uart_echo

# Source files
SRC = uart_echo.v uart_tx.v uart_rx.v

# Constraints
PCF = uart_echo.pcf

# Output files
JSON = $(PROJECT).json
ASC = $(PROJECT).asc
BIN = $(PROJECT).bin

# Tools
YOSYS = yosys
NEXTPNR = nextpnr-ice40
ICEPACK = icepack
OPENFPGALOADER = openFPGALoader

# FPGA settings
DEVICE = up5k
PACKAGE = sg48

# Default target
all: $(BIN)

# Synthesis
$(JSON): $(SRC)
	$(YOSYS) -p "synth_ice40 -top uart_echo -json $@" $^

# Place and route
$(ASC): $(JSON) $(PCF)
	$(NEXTPNR) --$(DEVICE) --package $(PACKAGE) --json $< --pcf $(PCF) --asc $@

# Bitstream generation
$(BIN): $(ASC)
	$(ICEPACK) $< $@

# Flash the bitstream to FPGA
flash: $(BIN)
	cp $(BIN) /media/admin/iCELink/

# Clean build files
clean:
	rm -f *.json *.asc *.bin

.PHONY: all flash clean