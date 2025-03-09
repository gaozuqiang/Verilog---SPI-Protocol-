# Verilog---SPI-Protocol-
This repository contains a Verilog implementation of the Serial Peripheral Interface (SPI) protocol. SPI is a synchronous serial communication protocol used for short-distance communication, primarily in embedded systems.

SPI Module Descriptions
-spi_master.v
  -Generates SPI clock based on a configurable divider
  -Controls MOSI (Master Out Slave In) and reads from MISO (Master In Slave Out)

-spi_slave.v
  -Responds to SPI master signals
  -Handles MISO and MOSI appropriately
