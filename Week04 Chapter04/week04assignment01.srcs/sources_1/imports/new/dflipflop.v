`timescale 1ns / 1ps
module dflipflop(
    input clk,
    input D,
    output reg Q
    );

    always @ (posedge clk) begin
        Q <= D;
    end
    
endmodule