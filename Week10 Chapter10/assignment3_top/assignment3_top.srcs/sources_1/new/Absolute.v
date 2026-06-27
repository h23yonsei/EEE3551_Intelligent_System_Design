module Absolute (
    input  wire signed [15:0] s_in_16,
    output reg [15:0] abs_in_16
);

    always @(s_in_16)
    begin
        abs_in_16 = (s_in_16 < 0) ? -s_in_16 : s_in_16;
    end
    
endmodule