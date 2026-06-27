module PixelSignExt (
    input  wire [7:0] us_pixel_8,
    output reg signed [8:0] s_pixel_9
);
    always @(us_pixel_8)
    begin
        s_pixel_9 <= {1'b0, us_pixel_8};
    end
    
endmodule
