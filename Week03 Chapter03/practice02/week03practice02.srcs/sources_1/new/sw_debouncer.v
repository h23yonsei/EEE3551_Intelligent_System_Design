`timescale 1ns / 1ps
module sw_debouncer(
    input wire clk,
    input wire in,
    output reg out
);

    wire dff1_o;
    wire dff2_o;
    
    dflipflop dff1 (
        .clk(clk),
        .D(in),
        .Q(dff1_o)
    );
    
    dflipflop dff2 (
        .clk(clk),
        .D(dff1_o),
        .Q(dff2_o)
    );
    
    always @(posedge clk) begin
        if (dff1_o & dff2_o)  
            out <= 1;
        else if (~dff1_o & ~dff2_o)  
            out <= 0;
    end

endmodule
