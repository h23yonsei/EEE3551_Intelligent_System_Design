`timescale 1ns/1ps
module fifo #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 102
)(
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire                     wren_i,
    input  wire                     rden_i,
    input  wire [DATA_WIDTH-1:0]    wdata_i,
    output wire [DATA_WIDTH-1:0]    rdata_o,
    output wire                     full_o,
    output wire                     empty_o
);

    // Pointer bits
    localparam FIFO_DEPTH_LG2 = $clog2(FIFO_DEPTH); // 7
    reg [FIFO_DEPTH_LG2:0] wrptr;
    reg [FIFO_DEPTH_LG2:0] rdptr;

    wire [FIFO_DEPTH_LG2-1:0] wr_index = wrptr[FIFO_DEPTH_LG2-1:0];
    wire [FIFO_DEPTH_LG2-1:0] rd_index = rdptr[FIFO_DEPTH_LG2-1:0];
    wire wr_msb = wrptr[FIFO_DEPTH_LG2];
    wire rd_msb = rdptr[FIFO_DEPTH_LG2];

    // Full Empty Logic
    assign empty_o = (wrptr == rdptr);
    assign full_o  = (wr_index == rd_index) && (wr_msb != rd_msb);

    // Pointer Logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            wrptr <= 0;
        else if (wren_i && !full_o) begin
            if (wr_index == FIFO_DEPTH - 1)
                wrptr <= {~wr_msb, {FIFO_DEPTH_LG2{1'b0}}};
            else
                wrptr <= wrptr + 1;
        end
    end

    // Read pointer logic with clean wraparound
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            rdptr <= 0;
        else if (rden_i && !empty_o) begin
            if (rd_index == FIFO_DEPTH - 1)
                rdptr <= {~rd_msb, {FIFO_DEPTH_LG2{1'b0}}};
            else
                rdptr <= rdptr + 1;
        end
    end

    fifo_mem UMEM (
        .clka(clk),
        .ena(wren_i && !full_o),
        .wea(wren_i && !full_o),
        .addra(wr_index),
        .dina(wdata_i),

        .clkb(clk),
        .enb(rden_i && !empty_o),
        .addrb(rd_index),
        .doutb(rdata_o)
    );

endmodule
