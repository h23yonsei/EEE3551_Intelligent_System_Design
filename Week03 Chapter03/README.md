# Week 03 — Chapter 3: Sequential Logic Design

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

This lab covers sequential logic design in Verilog, including clock dividers, counters, D flip-flops, button debouncers, finite state machines (FSMs), and seven-segment display (SSD) controllers. Two practice projects build up from basic sequential components to a complete FSM-driven SSD system.

## Key Concepts

- Clock divider for frequency reduction
- D flip-flop as a basic sequential element
- Button debouncer for clean switch input
- Finite State Machine (FSM) design and control
- Seven-segment display (SSD) multiplexing

## Files

### Practice 01 — Counter and Clock Divider

| File | Type | Description |
|------|------|-------------|
| `practice01/.../sources_1/new/top_counter.v` | Verilog | Top-level counter module |
| `practice01/.../sources_1/new/clock_divider.v` | Verilog | Clock divider module |
| `practice01/.../sources_1/new/dflipflop.v` | Verilog | D flip-flop module |
| `practice01/.../sources_1/new/btn_debouncer.v` | Verilog | Button debouncer module |
| `practice01/.../sim_1/new/test1.v` | Testbench | Testbench |

### Practice 02 — FSM and SSD Controller

| File | Type | Description |
|------|------|-------------|
| `practice02/.../sources_1/new/top_module.v` | Verilog | Top-level FSM system |
| `practice02/.../sources_1/new/fsm_ctrl.v` | Verilog | FSM controller |
| `practice02/.../sources_1/new/ssd_ctrl.v` | Verilog | Seven-segment display controller |
| `practice02/.../sources_1/new/clock_divider.v` | Verilog | Clock divider |
| `practice02/.../sources_1/new/sw_debouncer.v` | Verilog | Switch debouncer |
| `practice02/.../sim_1/new/test.v` | Testbench | Testbench |

### Documents

| File | Type | Description |
|------|------|-------------|

## How to Run

1. Open `practice01/week03practice01.xpr` or `practice02/week03practice02.xpr` in Xilinx Vivado
2. Run behavioral simulation to verify counter/FSM behavior
