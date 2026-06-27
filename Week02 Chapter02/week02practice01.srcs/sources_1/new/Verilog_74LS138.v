`timescale 1ns / 1ps
module Verilog_74LS138(
    input wire G1,G2A,G2B,
    input wire A,B,C,
    output reg[7:0] Y
    );
    always@(*)begin
        if(G1 & ~G2A & ~G2B)begin
            case({C,B,A})
                3'b000: Y = 8'b11111110;
                3'b001: Y = 8'b11111101;
                3'b010: Y = 8'b11111011;
                3'b011: Y = 8'b11110111;
                3'b100: Y = 8'b11101111;
                3'b101: Y = 8'b11011111;
                3'b110: Y = 8'b10111111;
                3'b111: Y = 8'b01111111;
                default: Y = 8'b11111111;
            endcase
        end else begin
            Y = 8'b11111111;
        end
    end
endmodule
