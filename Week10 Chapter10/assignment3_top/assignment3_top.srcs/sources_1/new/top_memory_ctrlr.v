`timescale 1ns / 1ps
module top_memory_ctrlr(
    input wire clk,
    input wire resetn,
    
    input  wire start,
    output wire done,
    
    input wire s1_clka,
    input wire s1_ena,
    input wire s1_wea,
    input wire [13:0] s1_addra,
    input wire [7:0] s1_dina,
    output wire [7:0] s1_douta,
    
    input wire s2_clka,
    input wire s2_ena,
    input wire s2_wea,
    input wire [13:0] s2_addra,
    input wire [7:0] s2_dina,
    output wire [7:0] s2_douta
    );

    wire s1_en, s2_en;
    wire s1_we, s2_we;
    wire s1_web;
    wire s2_web;
    wire [13:0] s1_addr;
    wire [13:0] s2_addr;
    wire [7:0] s1_din, s1_dout;
    wire [7:0] s2_din, s2_dout;
    
    assign s1_web = s1_we;
    assign s2_web = s2_we;


    memory_ctrlr #(.BRAM1_BW(8), .BRAM1_AMAX(10404), .BRAM2_BW(8), .BRAM2_AMAX(10000)) 
    Umemory_ctrlr (.clk(clk), .resetn(resetn), .start(start), .done(done),
                   .s1_en(s1_en), .s1_we(s1_we), .s1_addr(s1_addr), .s1_dout(s1_dout),
                   .s2_en(s2_en), .s2_we(s2_we), .s2_addr(s2_addr), .s2_din(s2_din));
    
    BRAM1 BRAM1 (
      .clka(s1_clka),
      .ena(s1_ena),
      .wea(s1_wea),
      .addra(s1_addra),
      .dina(s1_dina),
      .douta(s1_douta),
      .clkb(clk),
      .enb(s1_en),
      .web(s1_web),
      .addrb(s1_addr),
      .dinb(s1_din),
      .doutb(s1_dout)
    );
    
    BRAM2 BRAM2 (
      .clka(s2_clka),
      .ena(s2_ena),
      .wea(s2_wea),
      .addra(s2_addra),
      .dina(s2_dina),
      .douta(s2_douta),
      .clkb(clk),
      .enb(s2_en),
      .web(s2_web),
      .addrb(s2_addr),
      .dinb(s2_din),
      .doutb(s2_dout)
    );
    
endmodule
