`timescale 1ns / 1ps

module top_counter(
    input wire [1:0] btn,
    input wire clk_100mhz,
    input wire sw,
    output reg [3:0] jc,
    output reg [3:0] jd
    );

    wire clk_50hz;
    wire deb_btn0, deb_btn1;
    reg [3:0] current_num = 4'd0;

    clock_divider clk_div (
        .clk_100mhz(clk_100mhz),
        .clk_50hz(clk_50hz)
    );

    btn_debouncer btn_debouncer0 (
        .clk(clk_50hz),
        .in(btn[0]),
        .out(deb_btn0)
    );

    btn_debouncer btn_debouncer1 (
        .clk(clk_50hz),
        .in(btn[1]),
        .out(deb_btn1)
    );
    
    always @(posedge clk_50hz or negedge sw) begin
        if (!sw) begin
            current_num <= 4'd0;
            jc <= 4'b1111;
            jd <= 4'b0011;
        end 
        else begin
            if (deb_btn0 && current_num < 4'd9) begin
                current_num <= current_num + 1;
            end 
            else if (deb_btn1 && current_num > 4'd0) begin
                current_num <= current_num - 1;
            end
        
            case (current_num)
                4'd0: begin jc <= 4'b1111; jd <= 4'b0011; end
                4'd1: begin jc <= 4'b0110; jd <= 4'b0000; end
                4'd2: begin jc <= 4'b1011; jd <= 4'b0101; end
                4'd3: begin jc <= 4'b1111; jd <= 4'b0100; end
                4'd4: begin jc <= 4'b0110; jd <= 4'b0110; end
                4'd5: begin jc <= 4'b1101; jd <= 4'b0110; end
                4'd6: begin jc <= 4'b1101; jd <= 4'b0111; end
                4'd7: begin jc <= 4'b0111; jd <= 4'b0000; end
                4'd8: begin jc <= 4'b1111; jd <= 4'b0111; end
                4'd9: begin jc <= 4'b0111; jd <= 4'b0110; end
                default: begin jc <= 4'b1111; jd <= 4'b0011; end
            endcase
        end
    end
    
endmodule
