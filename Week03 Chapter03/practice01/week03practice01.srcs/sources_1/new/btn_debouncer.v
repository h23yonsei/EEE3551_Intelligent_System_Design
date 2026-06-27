`timescale 1ns / 1ps

module btn_debouncer(
    input wire clk,
    input wire in,
    output wire out
);

    wire dff1_o;
    
    dflipflop dff1 (
        .clk(clk),
        .D(in),
        .Q(dff1_o)
    );
    
    wire dff2_o;
    dflipflop dff2 (
        .clk(clk),
        .D(dff1_o),
        .Q(dff2_o)
    );
    
    assign out = dff1_o & ~dff2_o;
    
endmodule
