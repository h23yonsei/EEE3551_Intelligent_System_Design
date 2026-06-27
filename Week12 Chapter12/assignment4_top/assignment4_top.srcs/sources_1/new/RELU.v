`timescale 1ns / 1ps

module RELU #(
    parameter data_in_width = 22
    )(
    input wire signed [data_in_width - 1: 0] data_in,
    output wire signed [7:0] data_out
    );
    
    wire signed [data_in_width - 1:0] relu_out;
    assign relu_out = (data_in < 0) ? {data_in_width*{1'b0}} : data_in;
    assign data_out = {1'b0, relu_out[10 +: 7]};
endmodule
