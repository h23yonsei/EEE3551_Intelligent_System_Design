`timescale 1ns / 1ps

module FC_Layer #(
    parameter DATA_WIDTH = 8,
    parameter PIXEL_NUM = 2304,
    parameter OUTPUT_NUM = 10
)(
    input wire clk,
    input wire resetn,
    input wire start,
    
    input wire valid_in,
    input wire signed [DATA_WIDTH-1:0] data_in,

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

    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_0,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_1,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_2,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_3,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_4,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_5,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_6,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_7,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_8,
    output reg signed [DATA_WIDTH*2+12-1:0] fc_out_9,

    output reg valid_out
);
    //////////////////////////////////
    reg valid_in_buf;
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            valid_in_buf <= 0;
        else
            valid_in_buf <= valid_in;
    end
    
    reg signed [DATA_WIDTH-1:0] data_in_buf;
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            data_in_buf <= 0;
        else
            data_in_buf <= data_in;
    end
    //////////////////////////////////
    reg [15:0] pixel_cnt;

    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
        begin
            pixel_cnt <= 0;
            valid_out <= 0;
            fc_out_0 <= 0;
            fc_out_1 <= 0;
            fc_out_2 <= 0;
            fc_out_3 <= 0;
            fc_out_4 <= 0;
            fc_out_5 <= 0;
            fc_out_6 <= 0;
            fc_out_7 <= 0;
            fc_out_8 <= 0;
            fc_out_9 <= 0;
        end
        else
        begin
            valid_out <= 0;

            if(valid_in_buf)
            begin
                fc_out_0 <= fc_out_0 + data_in_buf * weight_0;
                fc_out_1 <= fc_out_1 + data_in_buf * weight_1;
                fc_out_2 <= fc_out_2 + data_in_buf * weight_2;
                fc_out_3 <= fc_out_3 + data_in_buf * weight_3;
                fc_out_4 <= fc_out_4 + data_in_buf * weight_4;
                fc_out_5 <= fc_out_5 + data_in_buf * weight_5;
                fc_out_6 <= fc_out_6 + data_in_buf * weight_6;
                fc_out_7 <= fc_out_7 + data_in_buf * weight_7;
                fc_out_8 <= fc_out_8 + data_in_buf * weight_8;
                fc_out_9 <= fc_out_9 + data_in_buf * weight_9;

                pixel_cnt <= pixel_cnt + 1;

                if(pixel_cnt == PIXEL_NUM-1)
                begin
                    valid_out <= 1;
                    pixel_cnt <= 0;
                end
            end
            
            else if(start)
            begin
                fc_out_0 <= 0;
                fc_out_1 <= 0;
                fc_out_2 <= 0;
                fc_out_3 <= 0;
                fc_out_4 <= 0;
                fc_out_5 <= 0;
                fc_out_6 <= 0;
                fc_out_7 <= 0;
                fc_out_8 <= 0;
                fc_out_9 <= 0;
            end
        end
    end

endmodule
