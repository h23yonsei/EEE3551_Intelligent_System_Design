# Week 06 — Chapter 6: FIFO and Line Buffer

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

This lab implements two fundamental streaming data structures used in hardware accelerators: a FIFO (First In First Out) queue and a line buffer. These components are essential building blocks for image processing pipelines and AI hardware such as Google's TPU.

## Key Concepts

- FIFO: sequential write and read in order, enqueue/dequeue operations
- Circular buffer implementation with read/write pointers
- Full and empty flag generation
- Line buffer for sliding-window operations on 2D data (e.g., image rows)
- Application context: data reuse in TPU systolic arrays and CNN accelerators

## Files

| File | Type | Description |
|------|------|-------------|
| `fifo.v` | Verilog | FIFO queue module |
| `line_buffer.v` | Verilog | Line buffer module |
| `tb_fifo.v` | Testbench | Testbench for FIFO |
| `tb_line_buffer.v` | Testbench | Testbench for line buffer |

## How to Run

1. Open `week06practice01.xpr` in Xilinx Vivado
2. Run behavioral simulation with `tb_fifo` or `tb_line_buffer` as the top module
