`timescale 1ns / 1ps

module tb_Conv2_Layer;
    parameter DATA_WIDTH = 8;
    parameter INPUT_WIDTH = 26;
    parameter OUTPUT_WIDTH = 24;
    parameter INPUT_CHANNEL = 8;
    parameter OUTPUT_CHANNEL = 16;
    parameter KERNEL_SIZE = 9;
    
    reg clk;
    reg resetn;
    reg weight_start;
    reg conv2_start;
    reg signed [7:0] weight_data;
    reg signed [7:0] pixel_data [0:7];
    
    wire signed [7:0] conv2_result [0:15];
    wire [2:0] state;
    wire [3:0] weight_filter;
    wire [3:0] weight_channel;
    wire [3:0] weight_count;
    wire signed [19:0] check_conv;
    wire signed [7:0] check_weight;
    wire signed [7:0] check_window;
    wire [11:0] check_last_conv_counter;
    wire  [10:0] SRAM_CONV2_RESULT_addr;
    wire valid_out;
    wire CONV2_DONE;
    integer i, x, y;
    
    // Clock generation
    initial clk = 1;
    always #5 clk = ~clk;
    
    // DUT instantiation
    Conv2_Layer #(
        .DATA_WIDTH(DATA_WIDTH),
        .INPUT_WIDTH(INPUT_WIDTH),
        .OUTPUT_WIDTH(OUTPUT_WIDTH),
        .INPUT_CHANNEL(INPUT_CHANNEL),
        .OUTPUT_CHANNEL(OUTPUT_CHANNEL),
        .KERNEL_SIZE(KERNEL_SIZE)
    ) uut (
        .clk(clk),
        .resetn(resetn),
        .weight_start(weight_start),
        .conv2_start(conv2_start),
        .weight_in(weight_data),
        .pixel_in_0(pixel_data[0]),
        .pixel_in_1(pixel_data[1]),
        .pixel_in_2(pixel_data[2]),
        .pixel_in_3(pixel_data[3]),
        .pixel_in_4(pixel_data[4]),
        .pixel_in_5(pixel_data[5]),
        .pixel_in_6(pixel_data[6]),
        .pixel_in_7(pixel_data[7]),
        .conv2_result_0(conv2_result[0]),
        .conv2_result_1(conv2_result[1]),
        .conv2_result_2(conv2_result[2]),
        .conv2_result_3(conv2_result[3]),
        .conv2_result_4(conv2_result[4]),
        .conv2_result_5(conv2_result[5]),
        .conv2_result_6(conv2_result[6]),
        .conv2_result_7(conv2_result[7]),
        .conv2_result_8(conv2_result[8]),
        .conv2_result_9(conv2_result[9]),
        .conv2_result_10(conv2_result[10]),
        .conv2_result_11(conv2_result[11]),
        .conv2_result_12(conv2_result[12]),
        .conv2_result_13(conv2_result[13]),
        .conv2_result_14(conv2_result[14]),
        .conv2_result_15(conv2_result[15]),
        .SRAM_CONV2_RESULT_addr(SRAM_CONV2_RESULT_addr),
        .valid_out(valid_out),
        .CONV2_DONE(CONV2_DONE),
        .state(state),
        .weight_filter(weight_filter),
        .weight_channel(weight_channel),
        .weight_count(weight_count),
        .check_conv(check_conv),
        .check_weight(check_weight),
        .check_window(check_window),
        .check_last_conv_counter(check_last_conv_counter)
    );
    
    // Test sequence
    initial begin
        $display("=== Conv2_Layer Testbench Started ===");
        
        // Initialize signals
        resetn = 0;
        weight_start = 0;
        conv2_start = 0;
        weight_data = 0;
        for (i = 0; i < 8; i = i + 1) 
            pixel_data[i] = 0;
        
        // Reset sequence
        #20;
        resetn = 1;
        #10;
        $display("Reset completed");
        
        // Load weights: 16 filters * 8 channels * 9 weights = 1152 weights
        $display("Starting weight loading...");
        weight_start = 1;
        for (i = 0; i < 16 * 8 * 9; i = i + 1) begin
            weight_data = (i % 16) + 1; // Simple pattern: 1 to 16
            #10;
            if (i % 144 == 0) 
                $display("Loaded %0d weights (Filter %0d)", i+1, i/144);
        end
        weight_start = 0;
        $display("Weight loading completed");
        
        // Wait a bit
        #100;
        
        // Start convolution
        $display("Starting convolution...");
        conv2_start = 1;
        #10;
        conv2_start = 0;
        
        // Feed pixel data: 78x26 pixels for each of 8 channels
        $display("Feeding pixel data...");
        for (y = 0; y < 78; y = y + 1) begin
            for (x = 0; x < 26; x = x + 1) begin
                for (i = 0; i < 8; i = i + 1)
                    pixel_data[i] = (y * 26 + x + i * 10) % 128; // Deterministic pattern
                #10;
                
                if ((y * 26 + x) % 200 == 0)
                    $display("Loaded %0d pixels", y * 26 + x + 1);
            end
        end
        $display("Pixel data feeding completed");
        
        // Wait for processing to complete
        #2000;
        
        // Display results
        $display("===== CONV2 OUTPUT =====");
        for (i = 0; i < 16; i = i + 1)
            $display("conv2_result[%0d] = %d", i, conv2_result[i]);
        
        $display("=== Testbench Completed ===");
        $finish;
    end
    
    // State monitoring
    always @(posedge clk) begin
        case (state)
            3'd0: ; // IDLE
            3'd1: $display("State: WEIGHT (Filter:%0d, Channel:%0d, Count:%0d)", 
                          weight_filter, weight_channel, weight_count);
            3'd2: $display("State: IMAGE_WAIT");
            3'd3: $display("State: STORE_FIRST");
            3'd4: $display("State: CAL");
            3'd5: $display("State: DONE");
            default: $display("State: UNKNOWN(%0d)", state);
        endcase
    end
    
    // Timeout protection
    initial begin
        #50000; // 50000 time units timeout
        $display("ERROR: Testbench timeout!");
        $finish;
    end

endmodule