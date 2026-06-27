`timescale 1ns / 1ps

module FSM #(
    parameter SRAM_INPUT_BW = 8,
    parameter SRAM_INPUT_AMAX = 2352,
    parameter SRAM_INPUT_ADR = $clog2(SRAM_INPUT_AMAX),
    parameter SRAM_CONV_WEIGHT_BW = 8,
    parameter SRAM_CONV_WEIGHT_AMAX = 1224,
    parameter SRAM_CONV_WEIGHT_ADR = $clog2(SRAM_CONV_WEIGHT_AMAX),
    parameter SRAM_FCL_WEIGHT_BW = 8,
    parameter SRAM_FCL_WEIGHT_AMAX = 2304,
    parameter SRAM_FCL_WEIGHT_ADR = $clog2(SRAM_FCL_WEIGHT_AMAX)
    )(
//////////////////////ILA testing//////////////////////////////////////////
    output wire [7:0] test_conv1,
    output wire [10:0] test_conv12_addr,
    output wire [23:0] test_ext_conv2_dout_00,
    output wire [3:0] test_conv2_wea,
    output wire test_conv2_valid_out,
    output wire test_conv2_done,
    output wire [9:0] test_conv2m_addra,
    output wire [23:0] test_maxfc_dina,
    output wire [23:0] test_maxfc_dinb,
    output wire signed [27:0] test_fc_out_0,
    output wire signed [27:0] test_fc_out_1,
    output wire signed [27:0] test_fc_out_2,
    output wire signed [27:0] test_fc_out_3,
    output wire signed [27:0] test_fc_out_4,
    output wire signed [27:0] test_fc_out_5,
    output wire signed [27:0] test_fc_out_6,
    output wire signed [27:0] test_fc_out_7,
    output wire signed [27:0] test_fc_out_8,
    output wire signed [27:0] test_fc_out_9,
    output wire test_fc_valid_out,
    output wire [SRAM_FCL_WEIGHT_BW-1:0] test_fcl_weight_0,
    output wire signed [7:0] test_maxpool_px_out,
    output wire test_maxfc_valid_in,
    output wire [9:0] test_maxfc_in_addra,
    
//////////////////////ILA testing//////////////////////////////////////////
    input  wire clk,
    input  wire resetn,
    input  wire start,
    output wire done,
    
    // ArgMax output
    output wire [3:0] result_0,
    output wire [3:0] result_1,
    output wire [3:0] result_2,
    
    // SRAM_INPUT enable
    output wire input_en,
    
    // SRAM_INPUT write enable
    output wire input_we,
    
    // SRAM_INPUT address
    output reg [SRAM_INPUT_ADR-1:0] input_addr,
    
    // read data from SRAM_INPUT
    input wire signed [SRAM_INPUT_BW-1:0] input_dout,
    
    // SRAM_CONV_WEIGHT enable
    output wire conv_en,
    
    // SRAM_CONV_WEIGHT write enable
    output wire conv_we,
    
    // SRAM_CONV_WEIGHT address
    output reg [SRAM_CONV_WEIGHT_ADR-1:0] conv_addr,
    
    // read data from SRAM_CONV_WEIGHT
    input wire signed [SRAM_CONV_WEIGHT_BW-1:0] conv_dout,
    
    // SRAM_FCL_WEIGHT enables
    output wire fcl_en_0,
    output wire fcl_en_1,
    output wire fcl_en_2,
    output wire fcl_en_3,
    output wire fcl_en_4,
    output wire fcl_en_5,
    output wire fcl_en_6,
    output wire fcl_en_7,
    output wire fcl_en_8,
    output wire fcl_en_9,
    
    // SRAM_FCL_WEIGHT write enables
    output wire fcl_we_0,
    output wire fcl_we_1,
    output wire fcl_we_2,
    output wire fcl_we_3,
    output wire fcl_we_4,
    output wire fcl_we_5,
    output wire fcl_we_6,
    output wire fcl_we_7,
    output wire fcl_we_8,
    output wire fcl_we_9,
    
    // SRAM_FCL_WEIGHT addresses
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_0,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_1,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_2,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_3,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_4,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_5,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_6,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_7,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_8,
    output wire [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr_9,
    
    // read data from SRAM_FCL_WEIGHT
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_0,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_1,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_2,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_3,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_4,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_5,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_6,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_7,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_8,
    input  wire signed [SRAM_FCL_WEIGHT_BW-1:0] fcl_dout_9
    );
//////////////////////ILA testing//////////////////////////////////////////
    assign test_conv1 = conv1_dout_0;
    assign test_conv12_addr = conv12_addr;
    assign test_ext_conv2_dout_00 = ext_conv2_dout;
    assign test_conv2_wea = conv2_wea;
    assign test_conv2_valid_out = conv2_valid_out;
    assign test_conv2_done = conv2_done;
    assign test_conv2m_addra = conv2_out_addra;
    assign test_maxfc_dina = maxfc_dina;
    assign test_maxfc_dinb = maxfc_dinb;
    assign test_fcl_weight_0 = fcl_dout_0;
    assign test_maxfc_valid_in = maxfc_valid_in;
    assign test_maxfc_in_addra = maxfc_in_addra;
    
//////////////////////ILA testing//////////////////////////////////////////
    
    
    assign input_we = 1'b0;
    
    assign conv_we = 1'b0;
    
    assign fcl_we_0 = 1'b0;
    assign fcl_we_1 = 1'b0;
    assign fcl_we_2 = 1'b0;
    assign fcl_we_3 = 1'b0;
    assign fcl_we_4 = 1'b0;
    assign fcl_we_5 = 1'b0;
    assign fcl_we_6 = 1'b0;
    assign fcl_we_7 = 1'b0;
    assign fcl_we_8 = 1'b0;
    assign fcl_we_9 = 1'b0;

    // state definition
    localparam IDLE = 5'd0;
    localparam CONV1 = 5'd1;
    localparam CONV2_00 = 5'd2;
    localparam CONV2_01 = 5'd3;
    localparam CONV2_02 = 5'd4;
    localparam CONV2_03 = 5'd5;
    localparam CONV2_04 = 5'd6;
    localparam CONV2_05 = 5'd7;
    localparam CONV2_06 = 5'd8;
    localparam CONV2_07 = 5'd9;
    localparam CONV2_08 = 5'd10;
    localparam CONV2_09 = 5'd11;
    localparam CONV2_10 = 5'd12;
    localparam CONV2_11 = 5'd13;
    localparam CONV2_12 = 5'd14;
    localparam CONV2_13 = 5'd15;
    localparam CONV2_14 = 5'd16;
    localparam CONV2_15 = 5'd17;
    localparam MAXFC_15 = 5'd18;
    localparam DONE = 5'd19;
    
    // present state & next state declaration
    reg [4:0] state;
    reg [4:0] next_state;
    reg [4:0] delayed_state;
    
    // present to next transition
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // delayed state
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            delayed_state <= IDLE;
        else
            delayed_state <= state;
    end
    
    //state transition
    always @(*)
    begin
        case(state)
            IDLE:
            begin
                if(start)
                    next_state = CONV1;
                else
                    next_state = IDLE;
            end            
            CONV1:
            begin
                if(conv1_done)
                    next_state = CONV2_00;
                else
                    next_state = CONV1;
            end
            CONV2_00: begin
                if (conv2_done)
                    next_state = CONV2_01;
                else
                    next_state = CONV2_00;
            end
            CONV2_01: begin
                if (conv2_done)
                    next_state = CONV2_02;
                else
                    next_state = CONV2_01;
            end
            CONV2_02: begin
                if (conv2_done)
                    next_state = CONV2_03;
                else
                    next_state = CONV2_02;
            end
            CONV2_03: begin
                if (conv2_done)
                    next_state = CONV2_04;
                else
                    next_state = CONV2_03;
            end
            CONV2_04: begin
                if (conv2_done)
                    next_state = CONV2_05;
                else
                    next_state = CONV2_04;
            end
            CONV2_05: begin
                if (conv2_done)
                    next_state = CONV2_06;
                else
                    next_state = CONV2_05;
            end
            CONV2_06: begin
                if (conv2_done)
                    next_state = CONV2_07;
                else
                    next_state = CONV2_06;
            end
            CONV2_07: begin
                if (conv2_done)
                    next_state = CONV2_08;
                else
                    next_state = CONV2_07;
            end
            CONV2_08: begin
                if (conv2_done)
                    next_state = CONV2_09;
                else
                    next_state = CONV2_08;
            end
            CONV2_09: begin
                if (conv2_done)
                    next_state = CONV2_10;
                else
                    next_state = CONV2_09;
            end
            CONV2_10: begin
                if (conv2_done)
                    next_state = CONV2_11;
                else
                    next_state = CONV2_10;
            end
            CONV2_11: begin
                if (conv2_done)
                    next_state = CONV2_12;
                else
                    next_state = CONV2_11;
            end
            CONV2_12: begin
                if (conv2_done)
                    next_state = CONV2_13;
                else
                    next_state = CONV2_12;
            end
            CONV2_13: begin
                if (conv2_done)
                    next_state = CONV2_14;
                else
                    next_state = CONV2_13;
            end
            CONV2_14: begin
                if (conv2_done)
                    next_state = CONV2_15;
                else
                    next_state = CONV2_14;
            end
            CONV2_15: begin
                if (conv2_done)
                    next_state = MAXFC_15;
                else
                    next_state = CONV2_15;
            end
            MAXFC_15:
            begin
                if(maxfc_done)
                    next_state = DONE;
                else
                    next_state = MAXFC_15;
            end
            DONE:
            begin
                if(start)
                    next_state = CONV1;
                else
                    next_state = DONE;
            end
            default: next_state = IDLE;
        endcase
    end
    
    assign done = (state == DONE);  
    
    // Convolution Layer 1    
    // conv1 module instance 
    conv1 #(
        .OUT_WIDTH(26),
        .OUT_HEIGHT(78),
        .OUT_DEPTH(26*78)
    ) conv1_inst (
        .clk(clk),
        .resetn(resetn),
        .valid_in(delayed_state == CONV1),
        .image_bram_dout(input_dout),
    
        .filter_bram_dout(conv_dout),
        .filter_bram_addr(conv_addr),
        
        .out_data0(conv1_dout_0),
        .out_data1(conv1_dout_1),
        .out_data2(conv1_dout_2),
        .out_data3(conv1_dout_3),
        .out_data4(conv1_dout_4),
        .out_data5(conv1_dout_5),
        .out_data6(conv1_dout_6),
        .out_data7(conv1_dout_7),
        .valid_out(conv1_valid_out),
        .done(conv1_done)
    );

    // Conv1 -> SRAM_CONV1_RESULT -> Conv2 connection
    // output data from conv1
    wire [7:0] conv1_dout_0;
    wire [7:0] conv1_dout_1;
    wire [7:0] conv1_dout_2;
    wire [7:0] conv1_dout_3;
    wire [7:0] conv1_dout_4;
    wire [7:0] conv1_dout_5;
    wire [7:0] conv1_dout_6;
    wire [7:0] conv1_dout_7;
    wire conv1_valid_out;
    wire conv1_done;

    wire conv2_input_sram_en;
    assign conv2_input_sram_en = 
    (state == CONV2_00) || (state == CONV2_01) || (state == CONV2_02) || 
    (state == CONV2_03) || (state == CONV2_04) || (state == CONV2_05) ||
    (state == CONV2_06) || (state == CONV2_07) || (state == CONV2_08) ||
    (state == CONV2_09) || (state == CONV2_10) || (state == CONV2_11) ||
    (state == CONV2_12) || (state == CONV2_13) || (state == CONV2_14) ||
    (state == CONV2_15);


    // SRAM_CONV1_RESULT_0 instance
    // conv1_valid_out || (state == CONV2) extend t0 all states
    SRAM_CONV1_RESULT SRAM_CONV1_RESULT_0 (
      .clka(clk),
      .ena(conv1_valid_out || conv2_input_sram_en),
      .wea(conv1_valid_out),
      .addra(conv12_addr),
      .dina(conv1_dout_0),
      .douta(conv2_din_0)
    );
    
    SRAM_CONV1_RESULT SRAM_CONV1_RESULT_1 (
      .clka(clk),
      .ena(conv1_valid_out || conv2_input_sram_en),
      .wea(conv1_valid_out),
      .addra(conv12_addr),
      .dina(conv1_dout_1),
      .douta(conv2_din_1)
    );
    
    SRAM_CONV1_RESULT SRAM_CONV1_RESULT_2 (
      .clka(clk),
      .ena(conv1_valid_out || conv2_input_sram_en),
      .wea(conv1_valid_out),
      .addra(conv12_addr),
      .dina(conv1_dout_2),
      .douta(conv2_din_2)
    );
    
    SRAM_CONV1_RESULT SRAM_CONV1_RESULT_3 (
      .clka(clk),
      .ena(conv1_valid_out || conv2_input_sram_en),
      .wea(conv1_valid_out),
      .addra(conv12_addr),
      .dina(conv1_dout_3),
      .douta(conv2_din_3)
    );
    
    SRAM_CONV1_RESULT SRAM_CONV1_RESULT_4 (
      .clka(clk),
      .ena(conv1_valid_out || conv2_input_sram_en),
      .wea(conv1_valid_out),
      .addra(conv12_addr),
      .dina(conv1_dout_4),
      .douta(conv2_din_4)
    );
    
    SRAM_CONV1_RESULT SRAM_CONV1_RESULT_5 (
      .clka(clk),
      .ena(conv1_valid_out || conv2_input_sram_en),
      .wea(conv1_valid_out),
      .addra(conv12_addr),
      .dina(conv1_dout_5),
      .douta(conv2_din_5)
    );
    
    SRAM_CONV1_RESULT SRAM_CONV1_RESULT_6 (
      .clka(clk),
      .ena(conv1_valid_out || conv2_input_sram_en),
      .wea(conv1_valid_out),
      .addra(conv12_addr),
      .dina(conv1_dout_6),
      .douta(conv2_din_6)
    );
    
    SRAM_CONV1_RESULT SRAM_CONV1_RESULT_7 (
      .clka(clk),
      .ena(conv1_valid_out || conv2_input_sram_en),
      .wea(conv1_valid_out),
      .addra(conv12_addr),
      .dina(conv1_dout_7),
      .douta(conv2_din_7)
    );
    
    // SRAM_CONV1_RESULT address 
    reg [10:0] conv12_addr;
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            conv12_addr <= 0;
        else
        begin
            if (state == CONV1)
            begin
                if (conv1_valid_out)
                    conv12_addr <= conv12_addr + 1;
                else if (conv1_done)
                    conv12_addr <= 0;
            end
            // extend to new states
            else if (conv2_input_sram_en)
            begin
                conv12_addr <= conv12_addr + 1;
                if (conv2_done)
                    conv12_addr <= 0;
            end
        end
    end
    
    // input data for conv2
    wire [7:0] conv2_din_0;
    wire [7:0] conv2_din_1;
    wire [7:0] conv2_din_2;
    wire [7:0] conv2_din_3;
    wire [7:0] conv2_din_4;
    wire [7:0] conv2_din_5;
    wire [7:0] conv2_din_6;
    wire [7:0] conv2_din_7;

    wire conv2_valid_in;
        assign conv2_valid_in = 
        (delayed_state == CONV2_00) || (delayed_state == CONV2_01) || (delayed_state == CONV2_02) || 
        (delayed_state == CONV2_03) || (delayed_state == CONV2_04) || (delayed_state == CONV2_05) ||
        (delayed_state == CONV2_06) || (delayed_state == CONV2_07) || (delayed_state == CONV2_08) ||
        (delayed_state == CONV2_09) || (delayed_state == CONV2_10) || (delayed_state == CONV2_11) ||
        (delayed_state == CONV2_12) || (delayed_state == CONV2_13) || (delayed_state == CONV2_14) ||
        (delayed_state == CONV2_15);
    
    // Convolution Layer 2
    Conv2_Layer #(
        .OUT_WIDTH(24),
        .OUT_HEIGHT(72),
        .OUT_DEPTH(24*72)
    ) Conv2_Layer_inst (
        .clk(clk),
        .resetn(resetn),
        .valid_in(conv2_valid_in), //delayed_state == CONV1
        
        .image_bram_dout_0(conv2_din_0), //input_dout
        .image_bram_dout_1(conv2_din_1), //input_dout
        .image_bram_dout_2(conv2_din_2), //input_dout
        .image_bram_dout_3(conv2_din_3), //input_dout
        .image_bram_dout_4(conv2_din_4), //input_dout
        .image_bram_dout_5(conv2_din_5), //input_dout
        .image_bram_dout_6(conv2_din_6), //input_dout
        .image_bram_dout_7(conv2_din_7), //input_dout
    
        .filter_bram_dout(conv_dout),
        
        .SRAM_CONV2_RESULT_wea(conv2_wea),
        .ext_conv2_result(ext_conv2_dout),
        
        .valid_out(conv2_valid_out),
        .done(conv2_done)
    );
    
    
    // Conv2 -> SRAM_CONV2_RESULT -> MaxFCArgMax Connection
    // output data from conv2
    wire [23:0] ext_conv2_dout;
    
    //wire conv2_valid_out;
    wire conv2_done;
    wire [2:0] conv2_wea;
    
    //wire [9:0] maxfc_in_addra;
    //wire [9:0] maxfc_in_addrb;
    //reg [9:0] conv2_out_addra;
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_00 (
    .clka(clk), .ena((state == CONV2_00) && conv2_valid_out || (state == CONV2_01)),
    .wea((state == CONV2_00) ? conv2_wea : 3'b000),
    .addra((state == CONV2_00) ? conv2_out_addra : (state == CONV2_01) ? maxfc_in_addra : 0),
    .dina(ext_conv2_dout), .douta(maxfc_dina_00),
    .clkb(clk), .enb(state == CONV2_01), .web(3'b0),
    .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_00)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_01 (
        .clka(clk), .ena((state == CONV2_01) && conv2_valid_out || (state == CONV2_02)),
        .wea((state == CONV2_01) ? conv2_wea : 3'b000),
        .addra((state == CONV2_01) ? conv2_out_addra : (state == CONV2_02) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_01),
        .clkb(clk), .enb(state == CONV2_02), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_01)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_02 (
        .clka(clk), .ena((state == CONV2_02) && conv2_valid_out || (state == CONV2_03)),
        .wea((state == CONV2_02) ? conv2_wea : 3'b000),
        .addra((state == CONV2_02) ? conv2_out_addra : (state == CONV2_03) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_02),
        .clkb(clk), .enb(state == CONV2_03), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_02)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_03 (
        .clka(clk), .ena((state == CONV2_03) && conv2_valid_out || (state == CONV2_04)),
        .wea((state == CONV2_03) ? conv2_wea : 3'b000),
        .addra((state == CONV2_03) ? conv2_out_addra : (state == CONV2_04) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_03),
        .clkb(clk), .enb(state == CONV2_04), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_03)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_04 (
        .clka(clk), .ena((state == CONV2_04) && conv2_valid_out || (state == CONV2_05)),
        .wea((state == CONV2_04) ? conv2_wea : 3'b000),
        .addra((state == CONV2_04) ? conv2_out_addra : (state == CONV2_05) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_04),
        .clkb(clk), .enb(state == CONV2_05), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_04)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_05 (
        .clka(clk), .ena((state == CONV2_05) && conv2_valid_out || (state == CONV2_06)),
        .wea((state == CONV2_05) ? conv2_wea : 3'b000),
        .addra((state == CONV2_05) ? conv2_out_addra : (state == CONV2_06) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_05),
        .clkb(clk), .enb(state == CONV2_06), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_05)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_06 (
        .clka(clk), .ena((state == CONV2_06) && conv2_valid_out || (state == CONV2_07)),
        .wea((state == CONV2_06) ? conv2_wea : 3'b000),
        .addra((state == CONV2_06) ? conv2_out_addra : (state == CONV2_07) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_06),
        .clkb(clk), .enb(state == CONV2_07), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_06)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_07 (
        .clka(clk), .ena((state == CONV2_07) && conv2_valid_out || (state == CONV2_08)),
        .wea((state == CONV2_07) ? conv2_wea : 3'b000),
        .addra((state == CONV2_07) ? conv2_out_addra : (state == CONV2_08) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_07),
        .clkb(clk), .enb(state == CONV2_08), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_07)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_08 (
        .clka(clk), .ena((state == CONV2_08) && conv2_valid_out || (state == CONV2_09)),
        .wea((state == CONV2_08) ? conv2_wea : 3'b000),
        .addra((state == CONV2_08) ? conv2_out_addra : (state == CONV2_09) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_08),
        .clkb(clk), .enb(state == CONV2_09), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_08)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_09 (
        .clka(clk), .ena((state == CONV2_09) && conv2_valid_out || (state == CONV2_10)),
        .wea((state == CONV2_09) ? conv2_wea : 3'b000),
        .addra((state == CONV2_09) ? conv2_out_addra : (state == CONV2_10) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_09),
        .clkb(clk), .enb(state == CONV2_10), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_09)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_10 (
        .clka(clk), .ena((state == CONV2_10) && conv2_valid_out || (state == CONV2_11)),
        .wea((state == CONV2_10) ? conv2_wea : 3'b000),
        .addra((state == CONV2_10) ? conv2_out_addra : (state == CONV2_11) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_10),
        .clkb(clk), .enb(state == CONV2_11), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_10)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_11 (
        .clka(clk), .ena((state == CONV2_11) && conv2_valid_out || (state == CONV2_12)),
        .wea((state == CONV2_11) ? conv2_wea : 3'b000),
        .addra((state == CONV2_11) ? conv2_out_addra : (state == CONV2_12) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_11),
        .clkb(clk), .enb(state == CONV2_12), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_11)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_12 (
        .clka(clk), .ena((state == CONV2_12) && conv2_valid_out || (state == CONV2_13)),
        .wea((state == CONV2_12) ? conv2_wea : 3'b000),
        .addra((state == CONV2_12) ? conv2_out_addra : (state == CONV2_13) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_12),
        .clkb(clk), .enb(state == CONV2_13), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_12)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_13 (
        .clka(clk), .ena((state == CONV2_13) && conv2_valid_out || (state == CONV2_14)),
        .wea((state == CONV2_13) ? conv2_wea : 3'b000),
        .addra((state == CONV2_13) ? conv2_out_addra : (state == CONV2_14) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_13),
        .clkb(clk), .enb(state == CONV2_14), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_13)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_14 (
        .clka(clk), .ena((state == CONV2_14) && conv2_valid_out || (state == CONV2_15)),
        .wea((state == CONV2_14) ? conv2_wea : 3'b000),
        .addra((state == CONV2_14) ? conv2_out_addra : (state == CONV2_15) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_14),
        .clkb(clk), .enb(state == CONV2_15), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_14)
    );
    
    SRAM_CONV2_RESULT SRAM_CONV2_RESULT_15 (
        .clka(clk), .ena((state == CONV2_15) && conv2_valid_out || (state == MAXFC_15)), 
        .wea((state == CONV2_15) ? conv2_wea : 3'b000),
        .addra((state == CONV2_15) ? conv2_out_addra : (state == MAXFC_15) ? maxfc_in_addra : 0),
        .dina(ext_conv2_dout), .douta(maxfc_dina_15),
        .clkb(clk), .enb(state == MAXFC_15), .web(3'b0),
        .addrb(maxfc_in_addrb), .dinb(24'b0), .doutb(maxfc_dinb_15)
    );


    
    reg [9:0] conv2_out_addra;
    
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
        begin
            conv2_out_addra <= 0;
        end
        else
        begin
            if (conv2_input_sram_en)
            begin
                if(conv2_valid_out)
                begin
                    if(conv2_out_addra < 575)
                        conv2_out_addra <= conv2_out_addra + 1;
                    else
                        conv2_out_addra <= 0;
                end
                else if(conv2_done)
                    conv2_out_addra <= 0;
            end
            else if(start)
            begin
                conv2_out_addra <= 0;
            end
        end
    end
    
    wire [9:0] maxfc_in_addra;
    wire [9:0] maxfc_in_addrb;
    
    assign maxfc_in_addra = maxfc_row_counter*24 + maxfc_col_counter;
    assign maxfc_in_addrb = (maxfc_row_counter+1)*24 + maxfc_col_counter;
    
    reg [4:0] maxfc_row_counter;
    reg [4:0] maxfc_col_counter;
    
    assign maxfc_input_sram_en = 
    (state == CONV2_01) || (state == CONV2_02) || (state == CONV2_03) || 
    (state == CONV2_04) || (state == CONV2_05) || (state == CONV2_06) ||
    (state == CONV2_07) || (state == CONV2_08) || (state == CONV2_09) ||
    (state == CONV2_10) || (state == CONV2_11) || (state == CONV2_12) ||
    (state == CONV2_13) || (state == CONV2_14) || (state == CONV2_15) ||
    (state == MAXFC_15);
    
    assign delayed_maxfc_input_sram_en = 
    (delayed_state == CONV2_01) || (delayed_state == CONV2_02) || (delayed_state == CONV2_03) || 
    (delayed_state == CONV2_04) || (delayed_state == CONV2_05) || (delayed_state == CONV2_06) ||
    (delayed_state == CONV2_07) || (delayed_state == CONV2_08) || (delayed_state == CONV2_09) ||
    (delayed_state == CONV2_10) || (delayed_state == CONV2_11) || (delayed_state == CONV2_12) ||
    (delayed_state == CONV2_13) || (delayed_state == CONV2_14) || (delayed_state == CONV2_15) ||
    (delayed_state == MAXFC_15);

    
    
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
        begin
            maxfc_row_counter <= 0;
            maxfc_col_counter <= 0;
        end
        else
        begin
            if(maxfc_input_sram_en)
            begin
                if(maxfc_col_counter < 23)
                    maxfc_col_counter <= maxfc_col_counter + 1;
                else
                begin
                    maxfc_col_counter <= 0;
                    maxfc_row_counter <= maxfc_row_counter + 2;
                end
            end
            /*
            if(maxfc_counter % 288 == 287)
            begin
                maxfc_row_counter <= 0;
                maxfc_col_counter <= 0;
            end
            */
            if(start || conv2_done)
            begin
                maxfc_row_counter <= 0;
                maxfc_col_counter <= 0;
            end
        end
    end    
    
    // input data_a for maxfc
    wire [23:0] maxfc_dina_00;
    wire [23:0] maxfc_dina_01;
    wire [23:0] maxfc_dina_02;
    wire [23:0] maxfc_dina_03;
    wire [23:0] maxfc_dina_04;
    wire [23:0] maxfc_dina_05;
    wire [23:0] maxfc_dina_06;
    wire [23:0] maxfc_dina_07;
    wire [23:0] maxfc_dina_08;
    wire [23:0] maxfc_dina_09;
    wire [23:0] maxfc_dina_10;
    wire [23:0] maxfc_dina_11;
    wire [23:0] maxfc_dina_12;
    wire [23:0] maxfc_dina_13;
    wire [23:0] maxfc_dina_14;
    wire [23:0] maxfc_dina_15;
    
    // input data_b for maxfc
    wire [23:0] maxfc_dinb_00;
    wire [23:0] maxfc_dinb_01;
    wire [23:0] maxfc_dinb_02;
    wire [23:0] maxfc_dinb_03;
    wire [23:0] maxfc_dinb_04;
    wire [23:0] maxfc_dinb_05;
    wire [23:0] maxfc_dinb_06;
    wire [23:0] maxfc_dinb_07;
    wire [23:0] maxfc_dinb_08;
    wire [23:0] maxfc_dinb_09;
    wire [23:0] maxfc_dinb_10;
    wire [23:0] maxfc_dinb_11;
    wire [23:0] maxfc_dinb_12;
    wire [23:0] maxfc_dinb_13;
    wire [23:0] maxfc_dinb_14;
    wire [23:0] maxfc_dinb_15;
    
    // input data for maxfc
    wire [23:0] maxfc_dina;
    wire [23:0] maxfc_dinb;
    
    // counter for maxfc input data
    /*
    reg [12:0] maxfc_counter;
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            maxfc_counter <= 0;
        else
        begin
            if(state == MAXFC)
            begin
                if(maxfc_counter < 4607)
                    maxfc_counter <= maxfc_counter + 1;
                else
                    maxfc_counter <= 0;
            end
            else
                maxfc_counter <= 0;
        end
    end
    */
    
    assign maxfc_dina = (state == CONV2_01) ? maxfc_dina_00 :
                        (state == CONV2_02) ? maxfc_dina_01 :
                        (state == CONV2_03) ? maxfc_dina_02 :
                        (state == CONV2_04) ? maxfc_dina_03 :
                        (state == CONV2_05) ? maxfc_dina_04 :
                        (state == CONV2_06) ? maxfc_dina_05 :
                        (state == CONV2_07) ? maxfc_dina_06 :
                        (state == CONV2_08) ? maxfc_dina_07 :
                        (state == CONV2_09) ? maxfc_dina_08 :
                        (state == CONV2_10) ? maxfc_dina_09 :
                        (state == CONV2_11) ? maxfc_dina_10 :
                        (state == CONV2_12) ? maxfc_dina_11 :
                        (state == CONV2_13) ? maxfc_dina_12 :
                        (state == CONV2_14) ? maxfc_dina_13 :
                        (state == CONV2_15) ? maxfc_dina_14 :
                        (state == MAXFC_15) ? maxfc_dina_15 : 0;
  
    assign maxfc_dinb = (state == CONV2_01) ? maxfc_dinb_00 :
                        (state == CONV2_02) ? maxfc_dinb_01 :
                        (state == CONV2_03) ? maxfc_dinb_02 :
                        (state == CONV2_04) ? maxfc_dinb_03 :
                        (state == CONV2_05) ? maxfc_dinb_04 :
                        (state == CONV2_06) ? maxfc_dinb_05 :
                        (state == CONV2_07) ? maxfc_dinb_06 :
                        (state == CONV2_08) ? maxfc_dinb_07 :
                        (state == CONV2_09) ? maxfc_dinb_08 :
                        (state == CONV2_10) ? maxfc_dinb_09 :
                        (state == CONV2_11) ? maxfc_dinb_10 :
                        (state == CONV2_12) ? maxfc_dinb_11 :
                        (state == CONV2_13) ? maxfc_dinb_12 :
                        (state == CONV2_14) ? maxfc_dinb_13 :
                        (state == CONV2_15) ? maxfc_dinb_14 :
                        (state == MAXFC_15) ? maxfc_dinb_15 : 0;

    
    // maxpool valid_out
    wire maxpool_valid_out;
    wire maxpool_valid_out_0;
    wire maxpool_valid_out_1;
    wire maxpool_valid_out_2;
    
    assign maxpool_valid_out = maxpool_valid_out_0 && maxpool_valid_out_1 && maxpool_valid_out_2;
    
    // SRAM_FCL_WEIGHT enable signal
    assign fcl_en_0 = maxpool_valid_out;
    assign fcl_en_1 = maxpool_valid_out;
    assign fcl_en_2 = maxpool_valid_out;
    assign fcl_en_3 = maxpool_valid_out;
    assign fcl_en_4 = maxpool_valid_out;
    assign fcl_en_5 = maxpool_valid_out;
    assign fcl_en_6 = maxpool_valid_out;
    assign fcl_en_7 = maxpool_valid_out;
    assign fcl_en_8 = maxpool_valid_out;
    assign fcl_en_9 = maxpool_valid_out;
    
    // SRAM_FCL_WEIGHT address
    reg [SRAM_FCL_WEIGHT_ADR-1:0] fcl_addr;
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            fcl_addr <= 0;
        else
        begin
            if(maxpool_valid_out)
                fcl_addr <= fcl_addr + 1;
            else if(fcl_addr == SRAM_FCL_WEIGHT_AMAX-1)
                fcl_addr <= 0;
                
            if(start)
                fcl_addr <= 0;
        end
    end
    
    assign fcl_addr_0 = fcl_addr;
    assign fcl_addr_1 = fcl_addr;
    assign fcl_addr_2 = fcl_addr;
    assign fcl_addr_3 = fcl_addr;
    assign fcl_addr_4 = fcl_addr;
    assign fcl_addr_5 = fcl_addr;
    assign fcl_addr_6 = fcl_addr;
    assign fcl_addr_7 = fcl_addr;
    assign fcl_addr_8 = fcl_addr;
    assign fcl_addr_9 = fcl_addr;
    
    
    reg [4:0] prev_state;
    reg [8:0] maxfc_valid_counter;
    wire maxfc_valid_in;
    
    assign maxfc_valid_in = delayed_maxfc_input_sram_en && (maxfc_valid_counter < 288);

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            prev_state <= 5'd0;
            maxfc_valid_counter <= 9'd0;
        end
        else begin
            if (state != prev_state) begin
                // State just changed ¢®©¡ reset counter
                prev_state <= state;
                maxfc_valid_counter <= 9'd0;
            end else if (state >= CONV2_01 && state <= MAXFC_15) begin
                // Increment counter only in CONV2_01 to CONV2_15
                if (maxfc_valid_counter < 9'd288)
                    maxfc_valid_counter <= maxfc_valid_counter + 1;
            end
        end
    end
    
    MaxFCArgMax #(
        .DATA_WIDTH(8),
        .PIXEL_NUM(2304),
        .OUTPUT_NUM(10)
    ) maxfc_argmax_0 (
        .clk(clk),
        .resetn(resetn),
        .start(start),
    
        // MaxPool inputs
        .px_row0(maxfc_dina[7:0]), // CONV2-MaxPool BRAM douta
        .px_row1(maxfc_dinb[7:0]), // CONV2-MaxPool BRAM doutb
        .valid_in(maxfc_valid_in), // douta, doutb signal
        
        // MaxPool valid_out
        .maxpool_valid_out(maxpool_valid_out_0),
    
        // FC Layer weights
        .weight_0(fcl_dout_0),
        .weight_1(fcl_dout_1),
        .weight_2(fcl_dout_2),
        .weight_3(fcl_dout_3),
        .weight_4(fcl_dout_4),
        .weight_5(fcl_dout_5),
        .weight_6(fcl_dout_6),
        .weight_7(fcl_dout_7),
        .weight_8(fcl_dout_8),
        .weight_9(fcl_dout_9),
    
        // ArgMax outputs
        .argmax_out(result_0), // final 0 ~ 9 output
        .valid_out(maxfc_done_0) // output signal
        
        /////////////////////////////////////////////
        ,.test_fc_out_0(test_fc_out_0),
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
        .test_maxpool_px_out(test_maxpool_px_out)
        /////////////////////////////////////////////
    );

    MaxFCArgMax #(
        .DATA_WIDTH(8),
        .PIXEL_NUM(2304),
        .OUTPUT_NUM(10)
    ) maxfc_argmax_1 (
        .clk(clk),
        .resetn(resetn),
        .start(start),
    
        // MaxPool inputs
        .px_row0(maxfc_dina[15:8]), // CONV2-MaxPool BRAM douta
        .px_row1(maxfc_dinb[15:8]), // CONV2-MaxPool BRAM doutb
        .valid_in(maxfc_valid_in), // douta, doutb signal
        
        // MaxPool valid_out
        .maxpool_valid_out(maxpool_valid_out_1),
    
        // FC Layer weights
        .weight_0(fcl_dout_0),
        .weight_1(fcl_dout_1),
        .weight_2(fcl_dout_2),
        .weight_3(fcl_dout_3),
        .weight_4(fcl_dout_4),
        .weight_5(fcl_dout_5),
        .weight_6(fcl_dout_6),
        .weight_7(fcl_dout_7),
        .weight_8(fcl_dout_8),
        .weight_9(fcl_dout_9),
    
        // ArgMax outputs
        .argmax_out(result_1), // final 0 ~ 9 output
        .valid_out(maxfc_done_1) // output signal
    );
    
    MaxFCArgMax #(
        .DATA_WIDTH(8),
        .PIXEL_NUM(2304),
        .OUTPUT_NUM(10)
    ) maxfc_argmax_2 (
        .clk(clk),
        .resetn(resetn),
        .start(start),
    
        // MaxPool inputs
        .px_row0(maxfc_dina[23:16]), // CONV2-MaxPool BRAM douta
        .px_row1(maxfc_dinb[23:16]), // CONV2-MaxPool BRAM doutb
        .valid_in(maxfc_valid_in), // douta, doutb signal
        
        // MaxPool valid_out
        .maxpool_valid_out(maxpool_valid_out_2),
    
        // FC Layer weights
        .weight_0(fcl_dout_0),
        .weight_1(fcl_dout_1),
        .weight_2(fcl_dout_2),
        .weight_3(fcl_dout_3),
        .weight_4(fcl_dout_4),
        .weight_5(fcl_dout_5),
        .weight_6(fcl_dout_6),
        .weight_7(fcl_dout_7),
        .weight_8(fcl_dout_8),
        .weight_9(fcl_dout_9),
    
        // ArgMax outputs
        .argmax_out(result_2), // final 0 ~ 9 output
        .valid_out(maxfc_done_2) // output signal
    );
    
    wire maxfc_done_0;
    wire maxfc_done_1;
    wire maxfc_done_2;
    
    assign maxfc_done = maxfc_done_0 && maxfc_done_1 && maxfc_done_2;
    
    // SRAM_INPUT data input  
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
        begin
            input_addr <= 0;
        end
        else
        begin
            if(input_en)
                input_addr <= input_addr + 1;
            else
                input_addr <= 0;
        end
    end  
    
    assign input_en = (state == CONV1);

    // conv1: once, conv2: every image
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
        begin
            conv_addr <= 0;
        end
        else
        begin
            if (state == CONV1 && conv_addr < 72) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_00 && conv_addr < 144) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_01 && conv_addr < 216) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_02 && conv_addr < 288) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_03 && conv_addr < 360) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_04 && conv_addr < 432) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_05 && conv_addr < 504) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_06 && conv_addr < 576) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_07 && conv_addr < 648) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_08 && conv_addr < 720) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_09 && conv_addr < 792) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_10 && conv_addr < 864) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_11 && conv_addr < 936) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_12 && conv_addr < 1008) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_13 && conv_addr < 1080) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_14 && conv_addr < 1152) begin
                conv_addr <= conv_addr + 1;
            end else if (state == CONV2_15 && conv_addr < 1224) begin
                conv_addr <= conv_addr + 1;
            end else if (maxfc_done) begin
                conv_addr <= 0;
            end
            
                
        end
    end
    
    assign conv_en = (state == CONV1     && conv_addr < 72 )  ||
                     (state == CONV2_00  && conv_addr < 144)  ||
                     (state == CONV2_01  && conv_addr < 216)  ||
                     (state == CONV2_02  && conv_addr < 288)  ||
                     (state == CONV2_03  && conv_addr < 360)  ||
                     (state == CONV2_04  && conv_addr < 432)  ||
                     (state == CONV2_05  && conv_addr < 504)  ||
                     (state == CONV2_06  && conv_addr < 576)  ||
                     (state == CONV2_07  && conv_addr < 648)  ||
                     (state == CONV2_08  && conv_addr < 720)  ||
                     (state == CONV2_09  && conv_addr < 792)  ||
                     (state == CONV2_10  && conv_addr < 864)  ||
                     (state == CONV2_11  && conv_addr < 936)  ||
                     (state == CONV2_12  && conv_addr < 1008) ||
                     (state == CONV2_13  && conv_addr < 1080) ||
                     (state == CONV2_14  && conv_addr < 1152) ||
                     (state == CONV2_15  && conv_addr < 1224);
       

    
endmodule