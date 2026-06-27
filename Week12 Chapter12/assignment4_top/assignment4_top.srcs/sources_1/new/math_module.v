module conv2_math_module (
    input  wire signed [7:0] pixel0,
    input  wire signed [7:0] pixel1,
    input  wire signed [7:0] pixel2,
    input  wire signed [7:0] pixel3,
    input  wire signed [7:0] pixel4,
    input  wire signed [7:0] pixel5,
    input  wire signed [7:0] pixel6,
    input  wire signed [7:0] pixel7,
    input  wire signed [7:0] pixel8,

    input  wire signed [7:0] weight0,
    input  wire signed [7:0] weight1,
    input  wire signed [7:0] weight2,
    input  wire signed [7:0] weight3,
    input  wire signed [7:0] weight4,
    input  wire signed [7:0] weight5,
    input  wire signed [7:0] weight6,
    input  wire signed [7:0] weight7,
    input  wire signed [7:0] weight8,

    //output wire signed [7:0] result
    output wire signed [19:0] result
);

    // 1. Element-wise multiplications
    wire signed [15:0] product0 = pixel0 * weight0;
    wire signed [15:0] product1 = pixel1 * weight1;
    wire signed [15:0] product2 = pixel2 * weight2;
    wire signed [15:0] product3 = pixel3 * weight3;
    wire signed [15:0] product4 = pixel4 * weight4;
    wire signed [15:0] product5 = pixel5 * weight5;
    wire signed [15:0] product6 = pixel6 * weight6;
    wire signed [15:0] product7 = pixel7 * weight7;
    wire signed [15:0] product8 = pixel8 * weight8;

    // 2. Add all products together
    wire signed [19:0] sum = product0 + product1 + product2 +
                             product3 + product4 + product5 +
                             product6 + product7 + product8;
    assign result = sum;
endmodule
