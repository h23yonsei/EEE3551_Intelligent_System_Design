`timescale 1ns / 1ps
module ssd_ctrl(
    input wire clk_50hz,
    input wire [3:0] num,
    output reg aa, ab, ac, ad, ae, af, ag,
    output reg C
);

    reg [3:0] tens;
    reg [3:0] ones;
    reg tens_or_ones = 0;

    always @(*) begin
        if (num >= 10) begin
            tens = 4'b0001;
            ones = num - 4'd10;
        end else begin
            tens = 4'b0000;
            ones = num;
        end
    end

    always @(posedge clk_50hz) begin
        tens_or_ones <= ~tens_or_ones;
        C <= tens_or_ones;
    end

    always @(*) begin
        case (tens_or_ones ? ones : tens)
            4'b0000: {aa, ab, ac, ad, ae, af, ag} = 7'b1111110;
            4'b0001: {aa, ab, ac, ad, ae, af, ag} = 7'b0110000;
            4'b0010: {aa, ab, ac, ad, ae, af, ag} = 7'b1101101;
            4'b0011: {aa, ab, ac, ad, ae, af, ag} = 7'b1111001;
            4'b0100: {aa, ab, ac, ad, ae, af, ag} = 7'b0110011;
            4'b0101: {aa, ab, ac, ad, ae, af, ag} = 7'b1011011;
            4'b0110: {aa, ab, ac, ad, ae, af, ag} = 7'b1011111;
            4'b0111: {aa, ab, ac, ad, ae, af, ag} = 7'b1110000;
            4'b1000: {aa, ab, ac, ad, ae, af, ag} = 7'b1111111;
            4'b1001: {aa, ab, ac, ad, ae, af, ag} = 7'b1111011;
            default: {aa, ab, ac, ad, ae, af, ag} = 7'b0000000;
        endcase
    end

endmodule
