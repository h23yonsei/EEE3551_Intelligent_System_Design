module MaxFCArgMax #(
    parameter DATA_WIDTH = 8,
    parameter PIXEL_NUM = 2304,
    parameter OUTPUT_NUM = 10
)(
    input wire clk,
    input wire resetn,
    input wire start,

    // MaxPool inputs
    input wire signed [DATA_WIDTH-1:0] px_row0,
    input wire signed [DATA_WIDTH-1:0] px_row1,
    input wire valid_in,
    
    // MaxPool valid_out
    output wire maxpool_valid_out,

    // FC_Layer weights
    input wire signed [DATA_WIDTH-1:0] weight_0,
    input wire signed [DATA_WIDTH-1:0] weight_1,
    input wire signed [DATA_WIDTH-1:0] weight_2,
    input wire signed [DATA_WIDTH-1:0] weight_3,
    input wire signed [DATA_WIDTH-1:0] weight_4,
    input wire signed [DATA_WIDTH-1:0] weight_5,
    input wire signed [DATA_WIDTH-1:0] weight_6,
    input wire signed [DATA_WIDTH-1:0] weight_7,
    input wire signed [DATA_WIDTH-1:0] weight_8,
    input wire signed [DATA_WIDTH-1:0] weight_9,

    // ArgMax outputs
    output wire [3:0] argmax_out,
    output wire valid_out
    
    //////////////////////////////////////////////////
    ,output  wire signed [DATA_WIDTH*2+12-1:0] test_fc_out_0, test_fc_out_1, test_fc_out_2, test_fc_out_3, test_fc_out_4,
    output wire signed [DATA_WIDTH*2+12-1:0] test_fc_out_5, test_fc_out_6, test_fc_out_7, test_fc_out_8, test_fc_out_9,
    output wire test_fc_valid_out,
    output wire signed [DATA_WIDTH-1:0] test_maxpool_px_out
    //////////////////////////////////////////////////
);

    /////////////////////////////////////////////////////
    assign test_fc_out_0 = fc_out_0;
    assign test_fc_out_1 = fc_out_1;
    assign test_fc_out_2 = fc_out_2;
    assign test_fc_out_3 = fc_out_3;
    assign test_fc_out_4 = fc_out_4;
    assign test_fc_out_5 = fc_out_5;
    assign test_fc_out_6 = fc_out_6;
    assign test_fc_out_7 = fc_out_7;
    assign test_fc_out_8 = fc_out_8;
    assign test_fc_out_9 = fc_out_9;
    assign test_fc_valid_out = fc_valid_out;
    assign test_maxpool_px_out = maxpool_px_out;
    /////////////////////////////////////////////////////

    // MaxPool to FC
    wire signed [DATA_WIDTH-1:0] maxpool_px_out;

    // FC to ArgMax
    wire signed [DATA_WIDTH*2+12-1:0] fc_out_0, fc_out_1, fc_out_2, fc_out_3, fc_out_4;
    wire signed [DATA_WIDTH*2+12-1:0] fc_out_5, fc_out_6, fc_out_7, fc_out_8, fc_out_9;
    wire fc_valid_out;

    // MaxPool
    MaxPool #(
        .DATA_WIDTH(DATA_WIDTH)
    ) maxpool_inst (
        .clk(clk),
        .resetn(resetn),
        .px_row0(px_row0),
        .px_row1(px_row1),
        .valid_in(valid_in),
        .px_out(maxpool_px_out),
        .valid_out(maxpool_valid_out)
    );

    // FC Layer
    FC_Layer #(
        .DATA_WIDTH(DATA_WIDTH),
        .PIXEL_NUM(PIXEL_NUM),
        .OUTPUT_NUM(OUTPUT_NUM)
    ) fc_layer_inst (
        .clk(clk),
        .resetn(resetn),
        .start(start),
        
        .valid_in(maxpool_valid_out),
        .data_in(maxpool_px_out),

        .weight_0(weight_0),
        .weight_1(weight_1),
        .weight_2(weight_2),
        .weight_3(weight_3),
        .weight_4(weight_4),
        .weight_5(weight_5),
        .weight_6(weight_6),
        .weight_7(weight_7),
        .weight_8(weight_8),
        .weight_9(weight_9),

        .fc_out_0(fc_out_0),
        .fc_out_1(fc_out_1),
        .fc_out_2(fc_out_2),
        .fc_out_3(fc_out_3),
        .fc_out_4(fc_out_4),
        .fc_out_5(fc_out_5),
        .fc_out_6(fc_out_6),
        .fc_out_7(fc_out_7),
        .fc_out_8(fc_out_8),
        .fc_out_9(fc_out_9),

        .valid_out(fc_valid_out)
    );

    // ArgMax
    ArgMax #(
        .DATA_WIDTH(DATA_WIDTH)
    ) argmax_inst (
        .clk(clk),
        .resetn(resetn),
        .valid_in(fc_valid_out),

        .fc_out_0(fc_out_0),
        .fc_out_1(fc_out_1),
        .fc_out_2(fc_out_2),
        .fc_out_3(fc_out_3),
        .fc_out_4(fc_out_4),
        .fc_out_5(fc_out_5),
        .fc_out_6(fc_out_6),
        .fc_out_7(fc_out_7),
        .fc_out_8(fc_out_8),
        .fc_out_9(fc_out_9),

        .argmax_out(argmax_out),
        .valid_out(valid_out)
    );

endmodule
