module AllAdd (
    input  wire resetn,
    input  wire signed [11:0] s_in1_12,
    input  wire signed [11:0] s_in2_12,
    input  wire signed [11:0] s_in3_12,
    input  wire signed [11:0] s_in4_12,
    input  wire signed [11:0] s_in5_12,
    input  wire signed [11:0] s_in6_12,
    input  wire signed [11:0] s_in7_12,
    input  wire signed [11:0] s_in8_12,
    input  wire signed [11:0] s_in9_12,
    output wire signed [15:0] s_out_16
);
    reg signed [12:0] sum1, sum2, sum3, sum4;
    reg signed [13:0] sum5, sum6;
    reg signed [14:0] sum7; 
    reg signed [14:0] s_in9_15;

    always @(*) begin
        if(!resetn) begin
       sum1 <= 13'd0; sum2 <= 13'd0; sum3 <= 13'd0; sum4 <= 13'd0;
       sum5 <= 14'd0; sum6 <= 14'd0; sum7 <= 15'd0;
       s_in9_15 <= 15'd0;
   end
   else begin
            sum1 = s_in1_12 + s_in2_12;
            sum2 = s_in3_12 + s_in4_12;
            sum3 = s_in5_12 + s_in6_12;
            sum4 = s_in7_12 + s_in8_12;

            sum5 = sum1 + sum2;
            sum6 = sum3 + sum4;

            sum7 = sum5 + sum6;

            s_in9_15 = {{3{s_in9_12[11]}}, s_in9_12};  //sign extend in9
   end
    end

    assign s_out_16 = sum7 + s_in9_15;

endmodule