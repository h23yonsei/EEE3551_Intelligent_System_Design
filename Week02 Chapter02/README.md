# Week 02 — Chapter 2: Verilog HDL Basics

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

This lab introduces the Vivado design flow and Verilog HDL fundamentals. The practice involves implementing a 74LS138 3-to-8 decoder/demultiplexer using both gate-level and behavioral Verilog descriptions, then simulating with a testbench.

## Key Concepts

- Vivado project creation, simulation, and synthesis flow
- Verilog HDL syntax: `module`, `wire`, `reg`, `assign`, `always`
- Combinational logic design (gate-level vs. behavioral)
- Sequential logic design with `always @(posedge clk)`
- 74LS138 decoder/demultiplexer implementation

## Files

| File | Type | Description |
|------|------|-------------|
| `week02practice01.srcs/sources_1/new/Gate_74LS138.v` | Verilog | Gate-level 74LS138 decoder |
| `week02practice01.srcs/sources_1/new/Verilog_74LS138.v` | Verilog | Behavioral 74LS138 decoder |
| `week02practice01.srcs/sim_1/new/tb_74LS138.v` | Testbench | Testbench for the decoder modules |
| `week02practice01.srcs/sim_1/new/week2_discussion.v` | Testbench | Discussion exercise testbench |

## How to Run

1. Open `week02practice01.xpr` in Xilinx Vivado
2. Run behavioral simulation with `tb_74LS138` as the top module
