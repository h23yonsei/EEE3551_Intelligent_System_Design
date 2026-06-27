# EEE3551 Intelligent System Design and Applications

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications (지능형시스템설계및응용) |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

This repository contains all lab materials for EEE3551 Intelligent System Design and Applications. The course progresses from digital logic fundamentals in Verilog HDL through memory systems and communication interfaces to designing hardware accelerators for image processing and CNN inference on an FPGA.

## Course Structure

| Week | Chapter | Topic | Type |
|------|---------|-------|------|
| [Week 01](Week01/) | — | Course Introduction | — |
| [Week 02](Week02%20Chapter02/) | Ch 2 | Verilog HDL Basics | Practice |
| [Week 03](Week03%20Chapter03/) | Ch 3 | Sequential Logic Design | Practice |
| [Week 04](Week04%20Chapter04/) | Ch 4 | Vending Machine | Assignment 1 |
| [Week 05](Week05%20Chapter05/) | Ch 5 | Memory and BRAM | Practice |
| [Week 06](Week06%20Chapter06/) | Ch 6 | FIFO and Line Buffer | Practice |
| [Week 07](Week07%20Chapter07/) | Ch 7 | UART Loopback Test | Assignment 2 |
| [Week 09](Week09%20Chapter09/) | Ch 9 | Block Design and Custom IP | Practice |
| [Week 10](Week10%20Chapter10/) | Ch 10 | Image Filtering System | Assignment 3 |
| [Week 12](Week12%20Chapter12/) | Ch 12 | CNN Accelerator | Assignment 4 |

## Topics Covered

### Digital Design Fundamentals (Weeks 02–04)
- Vivado tool flow, Verilog HDL syntax, simulation, and testbench design
- Combinational logic (74LS138 decoder/demux) and sequential logic (counters, FSMs)
- Clock divider, button debouncer, seven-segment display driver
- FSM-based vending machine with FPGA board implementation

### Memory and Communication (Weeks 05–07)
- SRAM/DRAM theory, memory controller design, Vivado Block RAM IP
- FIFO queue and line buffer for streaming data pipelines
- UART serial communication (Rx/Tx) and memory loopback test

### SoC Integration and AI Acceleration (Weeks 09–12)
- Zynq PS-PL architecture, AXI protocol, Vivado Block Design
- Custom AXI-Lite IP packaging and PS-PL data transfer
- Sobel edge detection image filter with 2D convolution hardware
- CNN accelerator for MNIST digit classification (Conv, ReLU, MaxPool, FC, ArgMax)

## Platform

- **FPGA:** Xilinx Spartan-7 (Arty S7) / Zynq-7000
- **EDA:** Xilinx Vivado 2021.1
- **Software:** Python 3, Jupyter Notebook

## License

Released under the [MIT License](LICENSE).
