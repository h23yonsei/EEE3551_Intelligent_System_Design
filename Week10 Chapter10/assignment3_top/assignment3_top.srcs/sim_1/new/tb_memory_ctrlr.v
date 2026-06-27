`timescale 1ns/1ps

module tb_memory_ctrlr;

    reg clk;
    reg resetn;
    reg start;

    wire [13:0] sram1_addr;
    reg [7:0]  sram1_data;

    wire [13:0] sram2_addr;
    wire [7:0]  sram2_data;
    wire        sram2_we;
    wire        done_led;

    // Instantiate the DUT (memory controller)
    memory_ctrlr dut (
        .clk(clk),
        .resetn(resetn),
        .start(start),
        .done_led(done_led),
        .s1_en(),
        .s2_en(),
        .s1_we(),
        .s2_we(sram2_we),
        .s1_addr(sram1_addr),
        .s2_addr(sram2_addr),
        .s1_dout(sram1_data),
        .s2_din(sram2_data)
    );

    // Image and tracking
    reg [7:0] fake_image [0:102*102-1];
    reg [15:0] write_count = 0;

    // Clock generation
    always #5 clk = ~clk;
    initial begin

        clk = 0;
        resetn = 0;
        start = 0;
        sram1_data = 0;
        #20;
        resetn = 1;

        $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment3/assignment3_top/fake_image.hex", fake_image);
        // Start after reset
        #20;
        start = 1;
        #10;
        start = 0;
    end

    always @(posedge clk) begin
        // Serve image data when requested
        sram1_data <= fake_image[sram1_addr];

        // Track how many outputs were written
        if (sram2_we) begin
            $display("Write @ %0d: %0d", sram2_addr, sram2_data);
            write_count <= write_count + 1;
        end

        if (done_led) begin
            $display("\nDONE! Total Writes = %0d\n", write_count);
            $finish;
        end
    end

endmodule
