# Week 07 — Chapter 7: UART Loopback Test (Assignment 2)

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

The second assignment designs a memory loopback module using UART serial communication. The `memory_control` module stores data received via UART Rx into BRAM and reads data from BRAM to transmit via UART Tx. A Jupyter notebook is used to send and receive image data over the serial link for verification.

## Key Concepts

- UART serial protocol: baud rate generation, start/stop bits, data framing
- UART Rx controller (serial-to-parallel) and Tx controller (parallel-to-serial)
- Memory controller for UART-BRAM bridge (loopback path)
- Edge detectors (posedge/negedge) for synchronization
- Metastability hardening for clock domain crossing
- Serial image transfer and verification with Python/Jupyter

## Files

| File | Type | Description |
|------|------|-------------|
| `memory_control.v` | Verilog | Memory controller — bridges UART Rx/Tx with BRAM |
| `loopback_top.v` | Verilog | Top-level loopback system |
| `uart_rx.v` | Verilog | UART receiver (serial → parallel) |
| `uart_rx_ctl.v` | Verilog | UART Rx state machine |
| `uart_tx.v` | Verilog | UART transmitter (parallel → serial) |
| `uart_tx_ctl.v` | Verilog | UART Tx state machine |
| `uart_baud_gen.v` | Verilog | Baud rate generator |
| `ClockDivider.v` | Verilog | Clock divider |
| `meta_harden.v` | Verilog | Metastability hardener |
| `reset_bridge.v` | Verilog | Reset synchronizer |
| `posedge_detector.v` | Verilog | Positive edge detector |
| `negedge_detector.v` | Verilog | Negative edge detector |
| `tb_loopback.v` | Testbench | Testbench for the loopback system |
| `tester_loopback.v` | Testbench | Test stimulus generator |
| `arty_s7.xdc` | Constraints | Arty S7 board constraints file |
| `assign2_uart_serial.ipynb` | Notebook | Jupyter notebook for serial image transfer |
| `Lenna.txt` | Data | Lenna image in text format for BRAM initialization |
| `assign2/` | Data | Sample images (Lenna, etc.) for loopback test |

## How to Run

### Simulation

1. Open `week07assignment01.xpr` in Xilinx Vivado
2. Run behavioral simulation with `tb_loopback` as the top module

### Board Test

1. Generate bitstream and program the Arty S7 board
2. Run `assign2_uart_serial.ipynb` to send/receive image data over UART
