# Week 10 — Chapter 10: Image Filtering System (Assignment 3)

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

The third assignment designs a hardware image filtering system that implements the Sobel edge detector using 2D convolution. The Sobel filter detects horizontal and vertical edges by applying two 3x3 kernels to each pixel. The design is packaged as a custom IP (PL) and integrated with the Zynq PS via block design.

## Key Concepts

- 2D convolution: sliding a kernel over an image, multiply-accumulate
- Sobel edge detection: horizontal (Gx) and vertical (Gy) gradient kernels
- Edge strength calculation: S(i,j) = |Sx(i,j)| + |Sy(i,j)|
- Signed arithmetic and bit precision management in hardware
- Line buffer and FIFO for streaming pixel data through the convolution pipeline
- PS-PL system integration with custom filtering IP

## Architecture

```text
Input Image → [Line Buffer] → [3x3 Window] → [Sobel Gx + Gy] → [|Gx| + |Gy|] → Edge Image
```

## Files

### Block Design Project

| File | Type | Description |
|------|------|-------------|
| `assignment3_bd/assignment3_bd.xpr` | Project | Block design Vivado project (PS + PL IP) |

### Top-Level Design

| File | Type | Description |
|------|------|-------------|
| `assignment3_top/...sources_1/new/top_memory_ctrlr.v` | Verilog | Top-level memory controller |
| `assignment3_top/...sources_1/new/memory_ctrlr.v` | Verilog | Memory controller |
| `assignment3_top/...sources_1/new/Matrix_gen.v` | Verilog | 3x3 matrix window generator |
| `assignment3_top/...sources_1/new/SignedMult.v` | Verilog | Signed multiplier |
| `assignment3_top/...sources_1/new/AllAdd.v` | Verilog | Summation of products |
| `assignment3_top/...sources_1/new/Absolute.v` | Verilog | Absolute value module |
| `assignment3_top/...sources_1/new/MakePixel.v` | Verilog | Pixel output generator |
| `assignment3_top/...sources_1/new/PixelSignExt.v` | Verilog | Pixel sign extension |
| `assignment3_top/...sources_1/new/fifo.v` | Verilog | FIFO module |
| `assignment3_top/...sources_1/new/line_buffer.v` | Verilog | Line buffer module |

### Testbenches

| File | Type | Description |
|------|------|-------------|
| `assignment3_top/...sim_1/new/tb_top_memory_ctrlr.v` | Testbench | Top-level system testbench |
| `assignment3_top/...sim_1/new/tb_Matrix_gen.v` | Testbench | Matrix generator testbench |
| `assignment3_top/...sim_1/new/tb_line_buffer.v` | Testbench | Line buffer testbench |
| `assignment3_top/...sim_1/new/tb_memory_ctrlr.v` | Testbench | Memory controller testbench |

### Custom IP

| File | Type | Description |
|------|------|-------------|
| `ip_repo/csr_1.0/` | IP | Custom AXI-Lite IP package for PS-PL integration |

### Documents

| File | Type | Description |
|------|------|-------------|

## How to Run

1. Open `assignment3_top/assignment3_top.xpr` in Xilinx Vivado
2. Run behavioral simulation with `tb_top_memory_ctrlr` to verify the filtering pipeline
3. Open `assignment3_bd/assignment3_bd.xpr` for the block design with PS integration
