`timescale 1ns / 1ps

module clock_divider(
    input wire clk_100mhz,
    output reg clk_50hz
);
    
    reg [19:0] counter = 0;
    reg is_start = 1;
    
    always @(posedge clk_100mhz) begin
        if (is_start) begin
            clk_50hz <= 1;
            is_start <= 0;
        end
        
        else if (counter == 999999) begin
            clk_50hz <= ~clk_50hz;
            counter <= 0;
        end 
        else begin
            counter <= counter + 1;
        end
    end
    
endmodule
