module MaxPool #(
    parameter DATA_WIDTH = 8
)(
    input wire clk,
    input wire resetn,
    input wire signed [DATA_WIDTH-1:0] px_row0, // row0 input pixel
    input wire signed [DATA_WIDTH-1:0] px_row1, // row1 input pixel
    input wire valid_in, // input valid
    output reg signed [DATA_WIDTH-1:0] px_out, // output pixel
    output reg valid_out // output valid
);

    reg signed [DATA_WIDTH-1:0] row0_buf, row1_buf; // pixel buffer
    reg toggle; // odd/even column toggle
    reg [4:0] col_count; // 0 ~ 23 column counter

    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
        begin
            row0_buf <= 0;
            row1_buf <= 0;
            toggle <= 0;
            col_count <= 0;
            px_out <= 0;
            valid_out <= 0;
        end
        else if(valid_in)
        begin
            toggle <= ~toggle;
            col_count <= col_count + 1;

            if(toggle == 0)
            begin
                // even column input: pixel buffer
                row0_buf <= px_row0;
                row1_buf <= px_row1;
                valid_out <= 0;
            end
            else
            begin
                // odd column input: execute maxpool
                px_out <= max4(row0_buf, px_row0, row1_buf, px_row1);
                valid_out <= 1;
            end

            if(col_count == 23)
            begin
                col_count <= 0;
            end
        end
        else
        begin
            valid_out <= 0;
        end
    end

    // maxpooling function
    function signed [DATA_WIDTH-1:0] max4;
        input signed [DATA_WIDTH-1:0] a, b, c, d;
        reg signed [DATA_WIDTH-1:0] ab_max, cd_max;
        begin
            ab_max = (a > b) ? a : b;
            cd_max = (c > d) ? c : d;
            max4 = (ab_max > cd_max) ? ab_max : cd_max;
        end
    endfunction

endmodule
