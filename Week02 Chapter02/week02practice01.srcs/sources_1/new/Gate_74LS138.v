`timescale 1ns / 1ps
module Gate_74LS138(
    input wire G1,G2A,G2B,
    input wire A,B,C,
    output wire [7:0] Y
    );
    wire enable;
    
    //define enable signal
    assign enable = G1 & ~G2A & ~G2B;
    
    //define output
    assign Y[0] = ~(~A & ~B & ~C & enable);
    assign Y[1] = ~(A & ~B & ~C & enable);
    assign Y[2] = ~(~A & B & ~C & enable);
    assign Y[3] = ~(A & B & ~C & enable);
    assign Y[4] = ~(~A & ~B & C & enable);
    assign Y[5] = ~(A & ~B & C & enable);
    assign Y[6] = ~(~A & B & C & enable);
    assign Y[7] = ~(A & B & C & enable);
endmodule
