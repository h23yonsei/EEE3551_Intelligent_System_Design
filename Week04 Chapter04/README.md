# Week 04 — Chapter 4: Vending Machine (Assignment 1)

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

The first assignment designs a vending machine module using a Finite State Machine (FSM). The machine sells three items at prices 3, 5, and 7, accepts coins of value 1, 5, and 10, and operates in three modes: *Item Filling*, *Coin Inserting*, and *Selling*. The design uses switches, buttons, LEDs, and seven-segment displays on the FPGA board.

## Key Concepts

- FSM-based controller design with multiple operating modes
- Coin balance tracking and item stock management (max stock 5, max balance 50)
- Seven-segment display output for balance and stock
- LED indicators for out-of-stock items
- Board implementation on Xilinx FPGA

## Files

| File | Type | Description |
|------|------|-------------|
| `week04assignment01.srcs/sources_1/new/skeleton.v` | Verilog | Top-level skeleton module |
| `week04assignment01.srcs/sources_1/new/action_ctrl.v` | Verilog | Action controller (buy/refill logic) |
| `week04assignment01.srcs/sources_1/new/btn_ctrl.v` | Verilog | Button input controller |
| `week04assignment01.srcs/sources_1/new/led_ctrl.v` | Verilog | LED output controller |
| `week04assignment01.srcs/sources_1/new/mode_ctrl.v` | Verilog | Mode FSM controller |
| `week04assignment01.srcs/sources_1/new/ssd_ctrl.v` | Verilog | Seven-segment display controller |
| `week04assignment01.srcs/sources_1/imports/new/btn_debouncer.v` | Verilog | Button debouncer (imported from Ch 3) |
| `week04assignment01.srcs/sources_1/imports/new/clock_divider.v` | Verilog | Clock divider (imported from Ch 3) |
| `week04assignment01.srcs/sources_1/imports/new/dflipflop.v` | Verilog | D flip-flop (imported from Ch 3) |
| `week04assignment01.srcs/sim_1/new/test.v` | Testbench | Testbench |

## How to Run

1. Open `week04assignment01.xpr` in Xilinx Vivado
2. Run behavioral simulation with `test` as the top module, or generate bitstream for board implementation
