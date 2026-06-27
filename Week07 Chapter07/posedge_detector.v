`timescale 1ns / 1ps
module posedge_detector(
    input   clk,
    input   rst,
    input   in,
    output   out
    );
    
    reg d_ff;
    always @(posedge clk, posedge rst) begin
        if(rst) d_ff <= 1'b0;
        else d_ff <=in;
    end
    
    assign out = (in)&&(d_ff^in);
endmodule
