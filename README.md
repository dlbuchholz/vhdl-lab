# vhdl-lab

This repository contains VHDL modules and testbenches for basic digital logic components, developed and tested using Xilinx ISE.
It is part of university lab exercises on digital logic design. The code is intended for educational purposes and is not designed for production or deployment.

## Implemented Modules

- 1a: 4-to-1 multiplexer (behavioral)
- 1b: 1-bit full adder (behavioral)
- 1c: 1-bit full adder (structural using two half adders)
- 2: 4-bit ripple-carry adder (structural using 1-bit full adders)
- 3: 4-bit binary counter with active-low reset
   - 3a: `counter_sync4`: synchronous reset
   - 3b: `counter_async4`: asynchronous reset
- 4: Shifter; Implements left/right shift by 1 based on control input `C(1:0)`: `C = "01"` → shift left
`C = "10"` → shift right
`C = "00"` or `"11"` → no shift
   - 4a (when else): `shifter_concurrent4`
   - 4b (if then else): `shifter_sequential4`
   - 4c (with select when): `shifter_concurrent_select4`
   - 4d (case): `shifter_sequential_case4`
  




## Target FPGA Configuration

Use the following settings when creating a new project in Xilinx ISE 14.7:

- Family: Spartan3E  
- Device: XC3S500  
- Package: VQ100  
- Speed: -5  
- Top-Level Source Type: HDL

## Simulation

All modules include testbenches with complete functional coverage using `assert`. Simulations are run using ISim. Extend simulation time if necessary (e.g., 20 µs) to allow testbench loops to complete.

## Getting Started with Xilinx ISE

1. **Create a new project**  
   - Open ISE → `File > New Project`
   - Name the project (e.g. `vhdl-lab`) and select a folder
   - Set FPGA configuration as listed above

2. **Add a VHDL source file**  
   - Right-click the project → `New Source` → VHDL Module  
   - Example: `mux4to1.vhd`  
   - You may define ports during creation or edit them later manually

3. **Add a testbench**  
   - `New Source` → VHDL Test Bench  
   - Example: `tb_mux4to1.vhd`  
   - Choose the module to test when prompted

4. **Simulate**  
   - Switch to `Behavioral Simulation` view in the hierarchy pane  
   - Right-click the testbench → `Simulate Behavioral Model`  
   - Set simulation run time to at least 20 µs (via `Simulation Properties`)

5. **Analyze waveforms and results**  
   - Use ISim to inspect signals  
   - `assert` statements in testbenches verify correctness automatically
