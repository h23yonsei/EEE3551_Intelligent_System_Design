`timescale 1ns / 1ps
module ssd_ctrl(
    input wire clk_50hz,
    input wire sw3,
    input wire [1:0] mode,
    input wire [7:0] balance,
    input wire [2:0] stock1,
    input wire [2:0] stock2,
    input wire [2:0] stock3,
    input wire [1:0] last_filled_item_num,
    output reg aa, ab, ac, ad, ae, af, ag,
    output reg cat
);

    reg [3:0] tens = 0;
    reg [3:0] ones = 0;
    reg [7:0] display_num = 0;
    reg toggle_digit = 0;

    always @(posedge clk_50hz) begin
        toggle_digit <= ~toggle_digit;
        cat <= toggle_digit;
    end
    
    always @(*) begin
        tens = display_num / 8'd10;
        ones = display_num - tens * 8'd10;
    end

    always @(*) begin
        case (mode)
            2'b11: begin // FILL
                case (last_filled_item_num)
                    2'd1: display_num = stock1;
                    2'd2: display_num = stock2;
                    2'd3: display_num = stock3;
                    default: display_num = 8'd0;
                endcase
            end
            2'b01, 2'b10: display_num = balance; // COIN or SELL
            default: display_num = 8'd0; // IDLE
        endcase
    end

    always @(*) begin
        if (!sw3) begin
            {aa, ab, ac, ad, ae, af, ag} = 7'b0000000;
        end
        else begin
            case (toggle_digit ? ones : tens)
                4'd0: {aa, ab, ac, ad, ae, af, ag} = 7'b1111110;
                4'd1: {aa, ab, ac, ad, ae, af, ag} = 7'b0110000;
                4'd2: {aa, ab, ac, ad, ae, af, ag} = 7'b1101101;
                4'd3: {aa, ab, ac, ad, ae, af, ag} = 7'b1111001;
                4'd4: {aa, ab, ac, ad, ae, af, ag} = 7'b0110011;
                4'd5: {aa, ab, ac, ad, ae, af, ag} = 7'b1011011;
                4'd6: {aa, ab, ac, ad, ae, af, ag} = 7'b1011111;
                4'd7: {aa, ab, ac, ad, ae, af, ag} = 7'b1110000;
                4'd8: {aa, ab, ac, ad, ae, af, ag} = 7'b1111111;
                4'd9: {aa, ab, ac, ad, ae, af, ag} = 7'b1110011;
                default: {aa, ab, ac, ad, ae, af, ag} = 7'b0000000;
            endcase
        end
    end

endmodule
