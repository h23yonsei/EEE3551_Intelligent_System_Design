`timescale 1ns / 1ps

module top #(
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
    input wire clk,
    input wire resetn,
    
    input  wire start,
    output wire done,
    
    // ArgMax output
    output wire [3:0] result_0,
    output wire [3:0] result_1,
    output wire [3:0] result_2,
    
    // SRAM_INPUT ports
    input wire input_clka,
    input wire input_ena,
    input wire input_wea,
    input wire [11:0] input_addra,
    input wire signed [7:0]  input_dina,
    output wire signed [7:0] input_douta,
    
    // SRAM_CONV_WEIGHT ports
    input wire conv_clka,
    input wire conv_ena,
    input wire conv_wea,
    input wire [10:0] conv_addra,
    input wire signed [7:0]  conv_dina,
    output wire signed [7:0] conv_douta,
    
    // SRAM_FCL_WEIGHT_0 ports
    input wire fcl_clka_0,
    input wire fcl_ena_0,
    input wire fcl_wea_0,
    input wire [11:0] fcl_addra_0,
    input wire signed [7:0]  fcl_dina_0,
    output wire signed [7:0] fcl_douta_0,
    
    // SRAM_FCL_WEIGHT_1 ports
    input wire fcl_clka_1,
    input wire fcl_ena_1,
    input wire fcl_wea_1,
    input wire [11:0] fcl_addra_1,
    input wire signed [7:0]  fcl_dina_1,
    output wire signed [7:0] fcl_douta_1,
    
    // SRAM_FCL_WEIGHT_2 ports
    input wire fcl_clka_2,
    input wire fcl_ena_2,
    input wire fcl_wea_2,
    input wire [11:0] fcl_addra_2,
    input wire signed [7:0]  fcl_dina_2,
    output wire signed [7:0] fcl_douta_2,
    
    // SRAM_FCL_WEIGHT_3 ports
    input wire fcl_clka_3,
    input wire fcl_ena_3,
    input wire fcl_wea_3,
    input wire [11:0] fcl_addra_3,
    input wire signed [7:0]  fcl_dina_3,
    output wire signed [7:0] fcl_douta_3,
    
    // SRAM_FCL_WEIGHT_4 ports
    input wire fcl_clka_4,
    input wire fcl_ena_4,
    input wire fcl_wea_4,
    input wire [11:0] fcl_addra_4,
    input wire signed [7:0]  fcl_dina_4,
    output wire signed [7:0] fcl_douta_4,
    
    // SRAM_FCL_WEIGHT_5 ports
    input wire fcl_clka_5,
    input wire fcl_ena_5,
    input wire fcl_wea_5,
    input wire [11:0] fcl_addra_5,
    input wire signed [7:0]  fcl_dina_5,
    output wire signed [7:0] fcl_douta_5,
    
    // SRAM_FCL_WEIGHT_6 ports
    input wire fcl_clka_6,
    input wire fcl_ena_6,
    input wire fcl_wea_6,
    input wire [11:0] fcl_addra_6,
    input wire signed [7:0]  fcl_dina_6,
    output wire signed [7:0] fcl_douta_6,
    
    // SRAM_FCL_WEIGHT_7 ports
    input wire fcl_clka_7,
    input wire fcl_ena_7,
    input wire fcl_wea_7,
    input wire [11:0] fcl_addra_7,
    input wire signed [7:0]  fcl_dina_7,
    output wire signed [7:0] fcl_douta_7,
    
    // SRAM_FCL_WEIGHT_8 ports
    input wire fcl_clka_8,
    input wire fcl_ena_8,
    input wire fcl_wea_8,
    input wire [11:0] fcl_addra_8,
    input wire signed [7:0]  fcl_dina_8,
    output wire signed [7:0] fcl_douta_8,
    
    // SRAM_FCL_WEIGHT_9 ports
    input wire fcl_clka_9,
    input wire fcl_ena_9,
    input wire fcl_wea_9,
    input wire [11:0] fcl_addra_9,
    input wire signed [7:0]  fcl_dina_9,
    output wire signed [7:0] fcl_douta_9
    );
    
    // SRAM_INPUT variables
    wire input_en;
    wire input_we;
    wire input_web;
    wire [11:0] input_addr;
    wire signed [7:0]  input_din;
    wire signed [7:0]  input_dout;
    
    // SRAM_CONV_WEIGHT variables
    wire conv_en;
    wire conv_we;
    wire conv_web;
    wire [10:0] conv_addr;
    wire signed [7:0]  conv_din;
    wire signed [7:0]  conv_dout;
    
    // SRAM_FCL_WEIGHT_0 variables
    wire fcl_en_0;
    wire fcl_we_0;
    wire fcl_web_0;
    wire [11:0] fcl_addr_0;
    wire signed [7:0]  fcl_din_0;
    wire signed [7:0]  fcl_dout_0;
    
    // SRAM_FCL_WEIGHT_1 variables
    wire fcl_en_1;
    wire fcl_we_1;
    wire fcl_web_1;
    wire [11:0] fcl_addr_1;
    wire signed [7:0]  fcl_din_1;
    wire signed [7:0]  fcl_dout_1;
    
    // SRAM_FCL_WEIGHT_2 variables
    wire fcl_en_2;
    wire fcl_we_2;
    wire fcl_web_2;
    wire [11:0] fcl_addr_2;
    wire signed [7:0]  fcl_din_2;
    wire signed [7:0]  fcl_dout_2;
    
    // SRAM_FCL_WEIGHT_3 variables
    wire fcl_en_3;
    wire fcl_we_3;
    wire fcl_web_3;
    wire [11:0] fcl_addr_3;
    wire signed [7:0]  fcl_din_3;
    wire signed [7:0]  fcl_dout_3;
    
    // SRAM_FCL_WEIGHT_4 variables
    wire fcl_en_4;
    wire fcl_we_4;
    wire fcl_web_4;
    wire [11:0] fcl_addr_4;
    wire signed [7:0]  fcl_din_4;
    wire signed [7:0]  fcl_dout_4;
    
    // SRAM_FCL_WEIGHT_5 variables
    wire fcl_en_5;
    wire fcl_we_5;
    wire fcl_web_5;
    wire [11:0] fcl_addr_5;
    wire signed [7:0]  fcl_din_5;
    wire signed [7:0]  fcl_dout_5;
    
    // SRAM_FCL_WEIGHT_6 variables
    wire fcl_en_6;
    wire fcl_we_6;
    wire fcl_web_6;
    wire [11:0] fcl_addr_6;
    wire signed [7:0]  fcl_din_6;
    wire signed [7:0]  fcl_dout_6;
    
    // SRAM_FCL_WEIGHT_7 variables
    wire fcl_en_7;
    wire fcl_we_7;
    wire fcl_web_7;
    wire [11:0] fcl_addr_7;
    wire signed [7:0]  fcl_din_7;
    wire signed [7:0]  fcl_dout_7;
    
    // SRAM_FCL_WEIGHT_8 variables
    wire fcl_en_8;
    wire fcl_we_8;
    wire fcl_web_8;
    wire [11:0] fcl_addr_8;
    wire signed [7:0]  fcl_din_8;
    wire signed [7:0]  fcl_dout_8;
    
    // SRAM_FCL_WEIGHT_9 variables
    wire fcl_en_9;
    wire fcl_we_9;
    wire fcl_web_9;
    wire [11:0] fcl_addr_9;
    wire signed [7:0]  fcl_din_9;
    wire signed [7:0]  fcl_dout_9;
    
    assign input_web = input_we;
    
    assign conv_web = conv_we;
    
    assign fcl_web_0 = fcl_we_0;
    assign fcl_web_1 = fcl_we_1;
    assign fcl_web_2 = fcl_we_2;
    assign fcl_web_3 = fcl_we_3;
    assign fcl_web_4 = fcl_we_4;
    assign fcl_web_5 = fcl_we_5;
    assign fcl_web_6 = fcl_we_6;
    assign fcl_web_7 = fcl_we_7;
    assign fcl_web_8 = fcl_we_8;
    assign fcl_web_9 = fcl_we_9;
    
    
    FSM FSM_inst (.clk(clk), .resetn(resetn), .start(start), .done(done),
                .result_0(result_0), .result_1(result_1), .result_2(result_2),
                .input_en(input_en), .input_we(input_we), .input_addr(input_addr), .input_dout(input_dout),
                .conv_en(conv_en), .conv_we(conv_we), .conv_addr(conv_addr), .conv_dout(conv_dout),
                .fcl_en_0(fcl_en_0), .fcl_we_0(fcl_we_0), .fcl_addr_0(fcl_addr_0), .fcl_dout_0(fcl_dout_0),
                .fcl_en_1(fcl_en_1), .fcl_we_1(fcl_we_1), .fcl_addr_1(fcl_addr_1), .fcl_dout_1(fcl_dout_1),
                .fcl_en_2(fcl_en_2), .fcl_we_2(fcl_we_2), .fcl_addr_2(fcl_addr_2), .fcl_dout_2(fcl_dout_2),
                .fcl_en_3(fcl_en_3), .fcl_we_3(fcl_we_3), .fcl_addr_3(fcl_addr_3), .fcl_dout_3(fcl_dout_3),
                .fcl_en_4(fcl_en_4), .fcl_we_4(fcl_we_4), .fcl_addr_4(fcl_addr_4), .fcl_dout_4(fcl_dout_4),
                .fcl_en_5(fcl_en_5), .fcl_we_5(fcl_we_5), .fcl_addr_5(fcl_addr_5), .fcl_dout_5(fcl_dout_5),
                .fcl_en_6(fcl_en_6), .fcl_we_6(fcl_we_6), .fcl_addr_6(fcl_addr_6), .fcl_dout_6(fcl_dout_6),
                .fcl_en_7(fcl_en_7), .fcl_we_7(fcl_we_7), .fcl_addr_7(fcl_addr_7), .fcl_dout_7(fcl_dout_7),
                .fcl_en_8(fcl_en_8), .fcl_we_8(fcl_we_8), .fcl_addr_8(fcl_addr_8), .fcl_dout_8(fcl_dout_8),
                .fcl_en_9(fcl_en_9), .fcl_we_9(fcl_we_9), .fcl_addr_9(fcl_addr_9), .fcl_dout_9(fcl_dout_9));
    
    // SRAM_INPUT instance
    SRAM_INPUT SRAM_INPUT_inst (
      .clka(input_clka),
      .ena(input_ena),
      .wea(input_wea),
      .addra(input_addra),
      .dina(input_dina),
      .douta(input_douta),
      .clkb(clk),
      .enb(input_en),
      .web(input_web),
      .addrb(input_addr),
      .dinb(input_din),
      .doutb(input_dout)
    ); 
    
    // SRAM_CONV_WEIGHT instance
    SRAM_CONV_WEIGHT SRAM_CONV_WEIGHT_inst (
      .clka(conv_clka),
      .ena(conv_ena),
      .wea(conv_wea),
      .addra(conv_addra),
      .dina(conv_dina),
      .douta(conv_douta),
      .clkb(clk),
      .enb(conv_en),
      .web(conv_web),
      .addrb(conv_addr),
      .dinb(conv_din),
      .doutb(conv_dout)
    );   
    
    // SRAM_FCL_WEIGHT_0 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_0 (
      .clka(fcl_clka_0),
      .ena(fcl_ena_0),
      .wea(fcl_wea_0),
      .addra(fcl_addra_0),
      .dina(fcl_dina_0),
      .douta(fcl_douta_0),
      .clkb(clk),
      .enb(fcl_en_0),
      .web(fcl_web_0),
      .addrb(fcl_addr_0),
      .dinb(fcl_din_0),
      .doutb(fcl_dout_0)
    );
    
    // SRAM_FCL_WEIGHT_1 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_1 (
      .clka(fcl_clka_1),
      .ena(fcl_ena_1),
      .wea(fcl_wea_1),
      .addra(fcl_addra_1),
      .dina(fcl_dina_1),
      .douta(fcl_douta_1),
      .clkb(clk),
      .enb(fcl_en_1),
      .web(fcl_web_1),
      .addrb(fcl_addr_1),
      .dinb(fcl_din_1),
      .doutb(fcl_dout_1)
    );
    
    // SRAM_FCL_WEIGHT_2 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_2 (
      .clka(fcl_clka_2),
      .ena(fcl_ena_2),
      .wea(fcl_wea_2),
      .addra(fcl_addra_2),
      .dina(fcl_dina_2),
      .douta(fcl_douta_2),
      .clkb(clk),
      .enb(fcl_en_2),
      .web(fcl_web_2),
      .addrb(fcl_addr_2),
      .dinb(fcl_din_2),
      .doutb(fcl_dout_2)
    );
    
    // SRAM_FCL_WEIGHT_3 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_3 (
      .clka(fcl_clka_3),
      .ena(fcl_ena_3),
      .wea(fcl_wea_3),
      .addra(fcl_addra_3),
      .dina(fcl_dina_3),
      .douta(fcl_douta_3),
      .clkb(clk),
      .enb(fcl_en_3),
      .web(fcl_web_3),
      .addrb(fcl_addr_3),
      .dinb(fcl_din_3),
      .doutb(fcl_dout_3)
    );
    
    // SRAM_FCL_WEIGHT_4 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_4 (
      .clka(fcl_clka_4),
      .ena(fcl_ena_4),
      .wea(fcl_wea_4),
      .addra(fcl_addra_4),
      .dina(fcl_dina_4),
      .douta(fcl_douta_4),
      .clkb(clk),
      .enb(fcl_en_4),
      .web(fcl_web_4),
      .addrb(fcl_addr_4),
      .dinb(fcl_din_4),
      .doutb(fcl_dout_4)
    );
    
    // SRAM_FCL_WEIGHT_5 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_5 (
      .clka(fcl_clka_5),
      .ena(fcl_ena_5),
      .wea(fcl_wea_5),
      .addra(fcl_addra_5),
      .dina(fcl_dina_5),
      .douta(fcl_douta_5),
      .clkb(clk),
      .enb(fcl_en_5),
      .web(fcl_web_5),
      .addrb(fcl_addr_5),
      .dinb(fcl_din_5),
      .doutb(fcl_dout_5)
    );
    
    // SRAM_FCL_WEIGHT_6 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_6 (
      .clka(fcl_clka_6),
      .ena(fcl_ena_6),
      .wea(fcl_wea_6),
      .addra(fcl_addra_6),
      .dina(fcl_dina_6),
      .douta(fcl_douta_6),
      .clkb(clk),
      .enb(fcl_en_6),
      .web(fcl_web_6),
      .addrb(fcl_addr_6),
      .dinb(fcl_din_6),
      .doutb(fcl_dout_6)
    );
    
    // SRAM_FCL_WEIGHT_7 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_7 (
      .clka(fcl_clka_7),
      .ena(fcl_ena_7),
      .wea(fcl_wea_7),
      .addra(fcl_addra_7),
      .dina(fcl_dina_7),
      .douta(fcl_douta_7),
      .clkb(clk),
      .enb(fcl_en_7),
      .web(fcl_web_7),
      .addrb(fcl_addr_7),
      .dinb(fcl_din_7),
      .doutb(fcl_dout_7)
    );
    
    // SRAM_FCL_WEIGHT_8 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_8 (
      .clka(fcl_clka_8),
      .ena(fcl_ena_8),
      .wea(fcl_wea_8),
      .addra(fcl_addra_8),
      .dina(fcl_dina_8),
      .douta(fcl_douta_8),
      .clkb(clk),
      .enb(fcl_en_8),
      .web(fcl_web_8),
      .addrb(fcl_addr_8),
      .dinb(fcl_din_8),
      .doutb(fcl_dout_8)
    );
    
    // SRAM_FCL_WEIGHT_9 instance
    SRAM_FCL_WEIGHT SRAM_FCL_WEIGHT_9 (
      .clka(fcl_clka_9),
      .ena(fcl_ena_9),
      .wea(fcl_wea_9),
      .addra(fcl_addra_9),
      .dina(fcl_dina_9),
      .douta(fcl_douta_9),
      .clkb(clk),
      .enb(fcl_en_9),
      .web(fcl_web_9),
      .addrb(fcl_addr_9),
      .dinb(fcl_din_9),
      .doutb(fcl_dout_9)
    );
    
endmodule
