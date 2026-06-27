`timescale 1ns / 1ps

module tb_fsm;

    // Parameters
    parameter SRAM_INPUT_BW = 8;
    parameter SRAM_INPUT_AMAX = 2352;
    parameter SRAM_INPUT_ADR = $clog2(SRAM_INPUT_AMAX);
    parameter SRAM_CONV_WEIGHT_BW = 8;
    parameter SRAM_CONV_WEIGHT_AMAX = 1224;
    parameter SRAM_CONV_WEIGHT_ADR = $clog2(SRAM_CONV_WEIGHT_AMAX);
    parameter SRAM_FCL_WEIGHT_BW = 8;
    parameter SRAM_FCL_WEIGHT_AMAX = 2304;
    parameter SRAM_FCL_WEIGHT_ADR = $clog2(SRAM_FCL_WEIGHT_AMAX);

    //////////////////////////////////////
    wire [7:0] test_conv1;
    wire [10:0] test_conv12_addr;
    wire [23:0] test_ext_conv2_dout_00;
    wire [3:0] test_conv2_wea;
    wire test_conv2_valid_out;
    wire test_conv2_done;
    wire [9:0] test_conv2m_addra;
    wire [23:0] test_maxfc_dina;
    wire [23:0] test_maxfc_dinb;
    wire signed [27:0] test_fc_out_0;
    wire signed [27:0] test_fc_out_1;
    wire signed [27:0] test_fc_out_2;
    wire signed [27:0] test_fc_out_3;
    wire signed [27:0] test_fc_out_4;
    wire signed [27:0] test_fc_out_5;
    wire signed [27:0] test_fc_out_6;
    wire signed [27:0] test_fc_out_7;
    wire signed [27:0] test_fc_out_8;
    wire signed [27:0] test_fc_out_9;
    wire test_fc_valid_out;
    wire [SRAM_FCL_WEIGHT_BW-1:0] test_fcl_weight_0;
    wire signed [7:0] test_maxpool_px_out;
    wire test_maxfc_valid_in;
    wire [9:0] test_maxfc_in_addra;
    //////////////////////////////////////
    // Clock and reset
    reg clk = 0;
    reg resetn = 0;
    always #5 clk = ~clk;

    // Control
    reg start = 0;
    wire done;

    // Result
    wire [3:0] result_0;
    wire [3:0] result_1;
    wire [3:0] result_2;

    // FSM interface wires
    wire input_en, input_we;
    wire [SRAM_INPUT_ADR-1:0] input_addr;
    reg  signed [SRAM_INPUT_BW-1:0] input_dout;

    wire conv_en, conv_we;
    wire [SRAM_CONV_WEIGHT_ADR-1:0] conv_addr;
    reg  signed [SRAM_CONV_WEIGHT_BW-1:0] conv_dout;

    wire fcl_en_0, fcl_en_1, fcl_en_2, fcl_en_3, fcl_en_4;
    wire fcl_en_5, fcl_en_6, fcl_en_7, fcl_en_8, fcl_en_9;

    wire fcl_we_0, fcl_we_1, fcl_we_2, fcl_we_3, fcl_we_4;
    wire fcl_we_5, fcl_we_6, fcl_we_7, fcl_we_8, fcl_we_9;

    wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_0, fcl_addr_1, fcl_addr_2, fcl_addr_3, fcl_addr_4;
    wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_5, fcl_addr_6, fcl_addr_7, fcl_addr_8, fcl_addr_9;

    reg  signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_0, fcl_dout_1, fcl_dout_2, fcl_dout_3, fcl_dout_4;
    reg  signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_5, fcl_dout_6, fcl_dout_7, fcl_dout_8, fcl_dout_9;

    // DUT
    FSM #(
        .SRAM_INPUT_BW(SRAM_INPUT_BW),
        .SRAM_INPUT_AMAX(SRAM_INPUT_AMAX),
        .SRAM_CONV_WEIGHT_BW(SRAM_CONV_WEIGHT_BW),
        .SRAM_CONV_WEIGHT_AMAX(SRAM_CONV_WEIGHT_AMAX),
        .SRAM_FCL_WEIGHT_BW(SRAM_FCL_WEIGHT_BW),
        .SRAM_FCL_WEIGHT_AMAX(SRAM_FCL_WEIGHT_AMAX)
    ) dut (
        .clk(clk),
        .resetn(resetn),
        .start(start),
        .done(done),
        .result_0(result_0),
        .result_1(result_1),
        .result_2(result_2),
        .input_en(input_en),
        .input_we(input_we),
        .input_addr(input_addr),
        .input_dout(input_dout),
        .conv_en(conv_en),
        .conv_we(conv_we),
        .conv_addr(conv_addr),
        .conv_dout(conv_dout),
        .fcl_en_0(fcl_en_0), .fcl_en_1(fcl_en_1), .fcl_en_2(fcl_en_2), .fcl_en_3(fcl_en_3), .fcl_en_4(fcl_en_4),
        .fcl_en_5(fcl_en_5), .fcl_en_6(fcl_en_6), .fcl_en_7(fcl_en_7), .fcl_en_8(fcl_en_8), .fcl_en_9(fcl_en_9),
        .fcl_we_0(fcl_we_0), .fcl_we_1(fcl_we_1), .fcl_we_2(fcl_we_2), .fcl_we_3(fcl_we_3), .fcl_we_4(fcl_we_4),
        .fcl_we_5(fcl_we_5), .fcl_we_6(fcl_we_6), .fcl_we_7(fcl_we_7), .fcl_we_8(fcl_we_8), .fcl_we_9(fcl_we_9),
        .fcl_addr_0(fcl_addr_0), .fcl_addr_1(fcl_addr_1), .fcl_addr_2(fcl_addr_2), .fcl_addr_3(fcl_addr_3), .fcl_addr_4(fcl_addr_4),
        .fcl_addr_5(fcl_addr_5), .fcl_addr_6(fcl_addr_6), .fcl_addr_7(fcl_addr_7), .fcl_addr_8(fcl_addr_8), .fcl_addr_9(fcl_addr_9),
        .fcl_dout_0(fcl_dout_0), .fcl_dout_1(fcl_dout_1), .fcl_dout_2(fcl_dout_2), .fcl_dout_3(fcl_dout_3), .fcl_dout_4(fcl_dout_4),
        .fcl_dout_5(fcl_dout_5), .fcl_dout_6(fcl_dout_6), .fcl_dout_7(fcl_dout_7), .fcl_dout_8(fcl_dout_8), .fcl_dout_9(fcl_dout_9)
        //////////////////////////////////////////
        ,.test_conv1(test_conv1),
        .test_conv12_addr(test_conv12_addr),
        .test_ext_conv2_dout_00(test_ext_conv2_dout_00),
        .test_conv2_wea(test_conv2_wea),
        .test_conv2_valid_out(test_conv2_valid_out),
        .test_conv2_done(test_conv2_done),
        .test_conv2m_addra(test_conv2m_addra),
        .test_maxfc_dina(test_maxfc_dina),
        .test_maxfc_dinb(test_maxfc_dinb),
        .test_fc_out_0(test_fc_out_0),
        .test_fc_out_1(test_fc_out_1),
        .test_fc_out_2(test_fc_out_2),
        .test_fc_out_3(test_fc_out_3),
        .test_fc_out_4(test_fc_out_4),
        .test_fc_out_5(test_fc_out_5),
        .test_fc_out_6(test_fc_out_6),
        .test_fc_out_7(test_fc_out_7),
        .test_fc_out_8(test_fc_out_8),
        .test_fc_out_9(test_fc_out_9),
        .test_fc_valid_out(test_fc_valid_out),
        .test_fcl_weight_0(test_fcl_weight_0),
        .test_maxpool_px_out(test_maxpool_px_out),
        .test_maxfc_valid_in(test_maxfc_valid_in),
        .test_maxfc_in_addra(test_maxfc_in_addra)
    );

    // Simulated BRAM
    reg signed [7:0] input_mem [0:SRAM_INPUT_AMAX-1];
    reg signed [7:0] conv_mem  [0:SRAM_CONV_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_0 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_1 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_2 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_3 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_4 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_5 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_6 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_7 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_8 [0:SRAM_FCL_WEIGHT_AMAX-1];
    reg signed [7:0] fcl_mem_9 [0:SRAM_FCL_WEIGHT_AMAX-1];

    initial begin
    // Load first input image and weights
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/input_3_flatten.hex", input_mem);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/conv_weight_flatten.hex", conv_mem);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_0.hex", fcl_mem_0);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_1.hex", fcl_mem_1);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_2.hex", fcl_mem_2);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_3.hex", fcl_mem_3);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_4.hex", fcl_mem_4);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_5.hex", fcl_mem_5);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_6.hex", fcl_mem_6);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_7.hex", fcl_mem_7);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_8.hex", fcl_mem_8);
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/fc1_weight_flatten_9.hex", fcl_mem_9);

    // Reset and start first image
    #20 resetn = 1;
    #20 start = 1;
    #10 start = 0;

    // Wait for first image to complete
    wait(done);
    #200;
    $display("Prediction (Image 1): %d%d%d", result_0, result_1, result_2);

    // Load second input image
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment4/assignment4_top/input_6_flatten.hex", input_mem);

    // Reset and start second image
    #200;  // 충분한 시간 대기
    start = 1;
    #10 start = 0;

    // Wait for second image to complete
    wait(done);
    #200;
    $display("Prediction (Image 2): %d%d%d", result_0, result_1, result_2);

    $stop;
end


    // BRAM read logic - synchronous 1-cycle latency
    always @(posedge clk) begin
        if (input_en)
            input_dout <= input_mem[input_addr];

        if (conv_en)
            conv_dout <= conv_mem[conv_addr];
    
        if (fcl_en_0 && !fcl_we_0) fcl_dout_0 <= fcl_mem_0[fcl_addr_0];
        if (fcl_en_1 && !fcl_we_1) fcl_dout_1 <= fcl_mem_1[fcl_addr_1];
        if (fcl_en_2 && !fcl_we_2) fcl_dout_2 <= fcl_mem_2[fcl_addr_2];
        if (fcl_en_3 && !fcl_we_3) fcl_dout_3 <= fcl_mem_3[fcl_addr_3];
        if (fcl_en_4 && !fcl_we_4) fcl_dout_4 <= fcl_mem_4[fcl_addr_4];
        if (fcl_en_5 && !fcl_we_5) fcl_dout_5 <= fcl_mem_5[fcl_addr_5];
        if (fcl_en_6 && !fcl_we_6) fcl_dout_6 <= fcl_mem_6[fcl_addr_6];
        if (fcl_en_7 && !fcl_we_7) fcl_dout_7 <= fcl_mem_7[fcl_addr_7];
        if (fcl_en_8 && !fcl_we_8) fcl_dout_8 <= fcl_mem_8[fcl_addr_8];
        if (fcl_en_9 && !fcl_we_9) fcl_dout_9 <= fcl_mem_9[fcl_addr_9];
    end
    
    /*
    always @(posedge clk) begin
    if (input_en && !input_we)
        $display("input[%0d] = %0d", input_addr, input_dout);
    if (conv_en && !conv_we)
        $display("conv[%0d] = %0d", conv_addr, conv_dout);
    if (fcl_en_0 && !fcl_we_0)
        $display("fcl0[%0d] = %0d", fcl_addr_0, fcl_dout_0);
    end
    */
endmodule
