module MakePixel(
    input wire [15:0] abs_in1_16,
    input wire [15:0] abs_in2_16,
    input wire clk,
    output reg [7:0] us_resultpixel_8
    );
    
    wire [15:0] abs_sum;
    assign abs_sum = abs_in1_16 + abs_in2_16;
    
    always @(abs_in1_16 or abs_in2_16)
    begin
        us_resultpixel_8 <= (abs_sum > 16'd255) ? 8'd255 : abs_sum[7:0];
    end
    
endmodule
