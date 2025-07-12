# vhdl-lab

This repository contains VHDL modules and testbenches for basic digital logic components, developed and tested using Xilinx ISE.
It is part of university lab exercises on digital logic design. The code is intended for educational purposes and is not designed for production or deployment.

## Implemented Modules

- 1a: 4-to-1 multiplexer (behavioral)
- 1b: 1-bit full adder (behavioral)
- 1c: 1-bit full adder (structural using two half adders)
- 2: 4-bit ripple-carry adder (structural using 1-bit full adders)

## Target FPGA Configuration

Use the following settings when creating a new project in Xilinx ISE 14.7:

- Family: Spartan3E  
- Device: XC3S500  
- Package: VQ100  
- Speed: -5  
- Top-Level Source Type: HDL

## Simulation

All modules include testbenches with complete functional coverage using `assert`. Simulations are run using ISim. Extend simulation time if necessary (e.g., 20 µs) to allow testbench loops to complete.
