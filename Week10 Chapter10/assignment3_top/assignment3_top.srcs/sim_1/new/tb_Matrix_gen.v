`timescale 1ns / 1ps

module tb_Matrix_gen;

    // Parameters
    parameter DATA_WIDTH = 8;

    // Signals
    reg clk;
    reg resetn;
    reg ready;
    reg [DATA_WIDTH-1:0] data_in0;
    reg [DATA_WIDTH-1:0] data_in1;
    reg [DATA_WIDTH-1:0] data_in2;
    wire [DATA_WIDTH-1:0] result_S;
    wire valid;

    // Clock generation
    always #5 clk = ~clk;  // 100MHz clock (period = 10ns)

    // DUT instantiation
    Matrix_gen #(
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .clk(clk),
        .resetn(resetn),
        .data_in0(data_in0),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .ready(ready),
        .result_S(result_S),
        .valid(valid),
        .count(count) // add
    );
    wire [6:0] count; // add
    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        resetn = 0;
        ready = 0;
        data_in0 = 0;
        data_in1 = 0;
        data_in2 = 0;

        // Reset pulse
        #15;
        resetn = 1;
        #20;

        // Enable ready signal
        ready = 1;

        // Generate random data when ready is high
        repeat (50) begin
            if (ready) begin
                data_in0 = $random % 256;  // Random 8-bit data
                data_in1 = $random % 256;
                data_in2 = $random % 256;
                $display("Time: %0t | data_in1: %h, data_in2: %h, data_in3: %h", $time, data_in0, data_in1, data_in2);
            end
            #10;
        end
        
        // Disable ready signal and end simulation
        ready = 0;
        #50;
        $finish;
    end

    // Monitor output
    always @(posedge clk) begin
        if (valid) begin
            $display("Time: %0t | result_S: %h", $time, result_S);
        end
    end

endmodule
