module filter_window (
    input  wire clk,
    input  wire resetn,            // Active-low reset
    input  wire en,                // Enable loading weights
    input  wire [7:0] data_in,     // One 8-bit weight per clock

    // 3x3 filter weights, row-major order
    output reg signed [7:0] weight0,
    output reg signed [7:0] weight1,
    output reg signed [7:0] weight2,
    output reg signed [7:0] weight3,
    output reg signed [7:0] weight4,
    output reg signed [7:0] weight5,
    output reg signed [7:0] weight6,
    output reg signed [7:0] weight7,
    output reg signed [7:0] weight8
);

    reg [3:0] count;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            count <= 0;
            // Optional: zero-initialize all weights
            weight0 <= 0; weight1 <= 0; weight2 <= 0;
            weight3 <= 0; weight4 <= 0; weight5 <= 0;
            weight6 <= 0; weight7 <= 0; weight8 <= 0;

        end
        else if (en) begin
            case (count)
                4'd0: weight0 <= data_in;
                4'd1: weight1 <= data_in;
                4'd2: weight2 <= data_in;
                4'd3: weight3 <= data_in;
                4'd4: weight4 <= data_in;
                4'd5: weight5 <= data_in;
                4'd6: weight6 <= data_in;
                4'd7: weight7 <= data_in;
                4'd8: begin
                    weight8 <= data_in;
                end
            endcase
            if (count < 10) count <= count + 1;
        end
        else begin
            count <= 0;
        end
    end

endmodule