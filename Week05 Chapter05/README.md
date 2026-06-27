# Week 05 — Chapter 5: Memory and BRAM

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

This lab introduces memory systems (SRAM, DRAM) and implements a memory controller that interfaces with Vivado Block RAM (BRAM) IP. Two practice projects cover basic SRAM read/write operations and a memory wrapper with COE-initialized BRAM.

## Key Concepts

- RAM types: SRAM (static) vs. DRAM (dynamic, requires refresh)
- SRAM cell structure, I/O interfaces (chip-select, output-enable, write-enable)
- Memory controller FSM for read/write sequencing
- Vivado Block Memory Generator IP instantiation
- COE file format for BRAM initialization

## Files

### Practice 01 — Memory Controller and SRAM

| File | Type | Description |
|------|------|-------------|
| `practice01/memory_ctrlr.v` | Verilog | Memory controller module |
| `practice01/sram_test.v` | Verilog | SRAM test module |
| `practice01/top_memory_ctrlr.v` | Verilog | Top-level memory controller wrapper |
| `practice01/tb_memory_ctrlr copy.v` | Testbench | Testbench for the memory controller |

### Practice 02 — Memory Wrapper with BRAM

| File | Type | Description |
|------|------|-------------|
| `practice02/memory_ctrlr.v` | Verilog | Memory controller module |
| `practice02/top_memory_wrapper.v` | Verilog | Top-level memory wrapper with BRAM |
| `practice02/tb_top_memory_wrapper.v` | Testbench | Testbench for the memory wrapper |
| `practice02/initialize_memory.coe` | Data | COE file for BRAM initialization |

### Documents

| File | Type | Description |
|------|------|-------------|

## How to Run

1. Open `practice01/week05practice01.xpr` or `practice02/week05practice02.xpr` in Xilinx Vivado
2. Run behavioral simulation to verify memory read/write operations
