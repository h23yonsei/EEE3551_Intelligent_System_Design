# Week 12 — Chapter 12: CNN Accelerator (Assignment 4)

| | |
|---|---|
| **Course** | EEE3551 Intelligent System Design and Applications |
| **Semester** | 2025 Spring, Yonsei University |
| **Student** | Seunghyun Lee |

## Overview

The final assignment designs a CNN (Convolutional Neural Network) hardware accelerator that classifies MNIST handwritten digits on a Zynq FPGA. The accelerator implements two convolution layers, ReLU activation, max pooling, and a fully connected layer entirely in programmable logic (PL), with the processing system (PS) handling data loading and result readback.

## Key Concepts

- CNN architecture: Conv1 (8 filters, 3x3) → ReLU → Conv2 (16 filters, 3x3) → ReLU → MaxPool (2x2) → FC (2304→10) → ArgMax
- 2D convolution with multiple input/output channels
- ReLU activation function in hardware
- Max pooling with 2x2 window
- Fully connected layer with signed 8-bit integer arithmetic
- Bit precision management: sign extension, saturation to [-128, 127]
- PS-PL integration via block design for data transfer and control

## Architecture

```text
Input (1, 28, 28) → [Conv1: 8, 3, 3] → [ReLU] → [Conv2: 16, 3, 3] → [ReLU] → [MaxPool: 2x2] → [FC: 2304→10] → [ArgMax] → Prediction
                      (8, 26, 26)                  (16, 24, 24)          (16, 12, 12)              (10)
```

## Files

### Block Design Project

| File | Type | Description |
|------|------|-------------|
| `assignment4_bd/assignment4_bd.xpr` | Project | Block design Vivado project (PS + PL IP) |

### Top-Level Design

| File | Type | Description |
|------|------|-------------|
| `assignment4_top/...sources_1/new/top.v` | Verilog | Top-level CNN accelerator |
| `assignment4_top/...sources_1/new/FSM.v` | Verilog | Main FSM controller |
| `assignment4_top/...sources_1/new/conv1.v` | Verilog | First convolution layer |
| `assignment4_top/...sources_1/new/conv1_math.v` | Verilog | Conv1 arithmetic module |
| `assignment4_top/...sources_1/new/Conv2_Layer.v` | Verilog | Second convolution layer |
| `assignment4_top/...sources_1/new/conv_slide_reg.v` | Verilog | Convolution sliding register |
| `assignment4_top/...sources_1/new/filter_window.v` | Verilog | Filter window generator |
| `assignment4_top/...sources_1/new/math_module.v` | Verilog | Arithmetic module |
| `assignment4_top/...sources_1/new/RELU.v` | Verilog | ReLU activation function |
| `assignment4_top/...sources_1/new/MaxPool.v` | Verilog | 2x2 max pooling |
| `assignment4_top/...sources_1/new/FC_Layer.v` | Verilog | Fully connected layer |
| `assignment4_top/...sources_1/new/MaxFCArgMax.v` | Verilog | FC output + ArgMax logic |
| `assignment4_top/...sources_1/new/ArgMax.v` | Verilog | ArgMax — finds predicted digit |

### Testbenches

| File | Type | Description |
|------|------|-------------|
| `assignment4_top/...sim_1/new/tb_FSM.v` | Testbench | FSM controller testbench |
| `assignment4_top/...sim_1/new/tb_Conv2_Layer.v` | Testbench | Conv2 layer testbench |
| `assignment4_top/...sim_1/new/tb_MaxFCArgMax.v` | Testbench | FC + ArgMax testbench |

### Custom IP

| File | Type | Description |
|------|------|-------------|
| `ip_repo/edit_csrr_v1_0.xpr` | Project | Custom IP Vivado project |

### Documents

| File | Type | Description |
|------|------|-------------|

## How to Run

1. Open `assignment4_top/assignment4_top.xpr` in Xilinx Vivado
2. Run behavioral simulation with `tb_FSM` to verify the CNN pipeline
3. Open `assignment4_bd/assignment4_bd.xpr` for the block design with PS integration
4. Generate bitstream and deploy to Zynq board for MNIST classification
