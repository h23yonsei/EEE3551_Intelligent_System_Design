module SignedMult (
    input  wire signed [8:0] s_pixel_9,
    input  wire signed [2:0] s_coeff_3,
    output reg signed [11:0] s_mult_12
);
    always @(s_pixel_9 or s_coeff_3)
    begin
        s_mult_12 <= s_pixel_9 * s_coeff_3;
    end
    
endmodule
