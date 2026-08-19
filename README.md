# 4x4-Systolic-Array-Matrix-Multiplier
# Hardware Accelerator for Matrix Multiplication using Systolic Array

A 4×4 systolic array matrix multiplier implemented in SystemVerilog, demonstrating a hardware-efficient, pipelined approach to parallel matrix multiplication — the same core architectural pattern used in real-world ML accelerators like Google's TPU.

---

## Overview

Traditional matrix multiplication repeatedly fetches operands from memory, which becomes a bandwidth bottleneck as matrix size grows. A systolic array avoids this by arranging small identical Processing Elements (PEs) in a grid, where each PE performs a multiply-accumulate operation and passes its operands to neighboring PEs on every clock cycle — maximizing data reuse and enabling highly parallel computation with minimal memory traffic.

This project implements a 4×4 grid of PEs to compute **C = A × B** for two 4×4 signed matrices.

---

## Architecture

**Processing Element (`PE.sv`)**

Each PE is the fundamental building block of the array. On every clock edge, it:
- Multiplies its two inputs (`in_a` from the left, `in_b` from above)
- Accumulates the result into a local register (`acc`)
- Registers and forwards `in_a` to the PE on its right, and `in_b` to the PE below, one cycle later

This one-cycle registered forwarding is what creates the correct diagonal data skew across the array — no separate skew logic is needed elsewhere, since each PE's own timing naturally staggers the data flow.

**Systolic Array (`Systolic_Array.sv`)**

Instantiates a 4×4 grid of PEs using generate/genvar loops and wires each PE's outputs into its neighboring PEs (`a[i][j+1]`, `a[i+1][j]`), forming the systolic data flow pattern. Matrix A's rows enter from the left, matrix B's columns enter from the top, and each PE accumulates one element of the output matrix C.

**Top-Level Wrapper (`design.sv`)**

Exposes a clean top-level interface for the 4×4 input matrices and the resulting 4×4 output matrix.

---

## Verification

The testbench (`testbench.sv`) streams two 4×4 signed matrices into the array over 4 clock cycles, allows the pipeline to fully propagate, and dumps the resulting output matrix for verification against expected results. Simulation waveforms are captured via VCD dump for waveform-level inspection.

---

## Project Files

| File | Description |
|---|---|
| `PE.sv` | Single Processing Element — multiply-accumulate + operand forwarding |
| `Systolic_Array.sv` | 4×4 grid of PEs wired in systolic data-flow pattern |
| `design.sv` | Top-level module wrapping the systolic array |
| `testbench.sv` | Testbench streaming matrix inputs and verifying output |

---

## How to Run

This project is designed to run on [EDA Playground](https://www.edaplayground.com/) or any SystemVerilog-capable simulator:

1. Load `design.sv`, `PE.sv`, and `Systolic_Array.sv` into the design panel
2. Load `testbench.sv` into the testbench panel
3. Select a SystemVerilog-capable simulator
4. Run the simulation and inspect the `$display` output and VCD waveform for the resulting C matrix

---

## Key Concepts Demonstrated

- Systolic array architecture and data-flow design
- Multiply-accumulate (MAC) unit design
- Parametrized, scalable RTL using SystemVerilog `generate` constructs
- Pipelined, register-based data propagation for correct temporal alignment
- Functional verification via directed testbench and waveform analysis

---

## Future Extensions

- Scale to larger array sizes (8×8, 16×16) for bigger matrix support
- Add a randomized, self-checking testbench (generator–driver–monitor–scoreboard structure) for more rigorous verification
- Extend to support tiled matrix multiplication for matrices larger than the native array size
- Add FPGA synthesis and PPA (Power, Performance, Area) metrics

---

## Author

**Chhavi verma**
