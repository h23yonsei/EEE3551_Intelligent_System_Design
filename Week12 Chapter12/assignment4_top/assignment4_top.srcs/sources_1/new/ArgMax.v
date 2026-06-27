module ArgMax #(
    parameter DATA_WIDTH = 8
)(
    input wire clk,
    input wire resetn,
    input wire valid_in,

    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_0,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_1,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_2,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_3,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_4,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_5,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_6,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_7,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_8,
    input wire signed [DATA_WIDTH*2+12-1:0] fc_out_9,

    output reg [3:0] argmax_out,
    output reg valid_out
);

    reg signed [DATA_WIDTH*2+12-1:0] values [0:9];
    reg [3:0] max_idx;
    reg signed [DATA_WIDTH*2+12-1:0] max_val;

    integer i;

    always @(*)
    begin
        values[0] = fc_out_0; values[1] = fc_out_1;
        values[2] = fc_out_2; values[3] = fc_out_3;
        values[4] = fc_out_4; values[5] = fc_out_5;
        values[6] = fc_out_6; values[7] = fc_out_7;
        values[8] = fc_out_8; values[9] = fc_out_9;

        max_val = values[0];
        max_idx = 0;

        for(i = 1; i < 10; i = i + 1)
        begin
            if(values[i] > max_val)
            begin
                max_val = values[i];
                max_idx = i[3:0];
            end
        end
    end

    reg valid_in_d; // wait for calculation
    
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
        begin
            valid_in_d <= 0;
            valid_out <= 0;
            argmax_out <= 0;
        end
        else
        begin
            valid_in_d <= valid_in;
            valid_out <= valid_in_d;
            if(valid_in_d)
                argmax_out <= max_idx;
        end
    end

endmodule
