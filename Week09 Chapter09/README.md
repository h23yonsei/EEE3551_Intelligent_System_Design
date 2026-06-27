# Week 09 — Chapter 9: Block Design and Custom IP

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

This lab introduces the Zynq Processing System (PS) and Programmable Logic (PL) architecture, the AXI interconnect protocol, and Vivado Block Design flow. The practice packages a custom memory controller as an AXI-Lite IP and integrates it with the Zynq PS in a block design. A separate block design project demonstrates the complete PS-PL system.

## Key Concepts

- Zynq SoC: Processing System (ARM Cortex-A9) + Programmable Logic (FPGA fabric)
- AXI (Advanced eXtensible Interface) protocol: five independent channels (AR, R, AW, W, B)
- Vivado Block Design: IP integrator, connection automation
- Custom IP packaging with AXI-Lite slave interface
- PS-PL data transfer via memory-mapped registers

## Files

### Practice 01 — Custom AXI-Lite Memory Controller IP

| File | Type | Description |
|------|------|-------------|
| `practice01/memory_ctrlr.v` | Verilog | Memory controller module |
| `practice01/top_memory_ctrlr.v` | Verilog | Top-level wrapper with AXI interface |
| `practice01/xgui/top_memory_ctrlr_v1_0.tcl` | Tcl | IP GUI configuration script |

### Block Design Project

| File | Type | Description |
|------|------|-------------|
| `bd/week09page47.xpr` | Project | Block design Vivado project |

### Documents

| File | Type | Description |
|------|------|-------------|

## How to Run

1. Open `practice01/week09practice01.xpr` in Xilinx Vivado to view the custom IP
2. Open `bd/week09page47.xpr` to view the block design integration
