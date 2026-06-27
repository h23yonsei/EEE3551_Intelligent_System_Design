`timescale 1ns / 1ps
module clock_divider(
    input wire clk_100mhz,
    output reg clk_50hz,
    output reg clk_1hz
);
    reg [19:0] counter_50hz = 0;
    reg [25:0] counter_1hz = 0;
    reg is_start_50hz = 1;
    reg is_start_1hz = 1;

    always @(posedge clk_100mhz) begin
        if (is_start_50hz) begin
            clk_50hz <= 1;
            is_start_50hz <= 0;
        end
        
        else if (counter_50hz == 999999) begin
            clk_50hz <= ~clk_50hz;
            counter_50hz <= 0;
        end 
        else begin
            counter_50hz <= counter_50hz + 1;
        end
    end
    
    always @(posedge clk_100mhz) begin
        if (is_start_1hz) begin
            clk_1hz <= 1;
            is_start_1hz <= 0;
        end
        
        else if (counter_1hz == 49999999) begin
            clk_1hz <= ~clk_1hz;
            counter_1hz <= 0;
        end 
        else begin
            counter_1hz <= counter_1hz + 1;
        end
    end
endmodule
