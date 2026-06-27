`timescale 1ns/1ps
module line_buffer#(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 102,
    parameter NUM_FIFO   = 3
    )(
    input   wire    clk,
    input   wire    resetn,
    output  wire    ready,
    input   wire    wren_i,    
    input   wire    rden_i,    
    input   wire    [DATA_WIDTH-1:0] data_in,
    output  wire    [DATA_WIDTH-1:0] data_out_0,
    output  wire    [DATA_WIDTH-1:0] data_out_1,
    output  wire    [DATA_WIDTH-1:0] data_out_2
    );

    // FIFO status signals
    wire full_0, full_1, full_2;
    wire empty_0, empty_1, empty_2;

    // Counter to route writes
    reg [8:0] counter;
    wire [1:0] wren_i_sel;

    assign wren_i_sel = (counter < 9'd102)   ? 2'd0 :
                        (counter < 9'd204)   ? 2'd1 : 2'd2;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            counter <= 9'd0;
        else if (wren_i)
            counter <= (counter == 9'd305) ? 9'd0 : counter + 9'd1;
    end

    // Write enables for each FIFO
    wire wren_0 = wren_i & (wren_i_sel == 2'd0) & ~full_0;
    wire wren_1 = wren_i & (wren_i_sel == 2'd1) & ~full_1;
    wire wren_2 = wren_i & (wren_i_sel == 2'd2) & ~full_2;

    // Ready flag management
    reg ready_toggle;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            ready_toggle <= 1'b0;
        else if (full_0 & full_1 & full_2)
            ready_toggle <= 1'b1;
        else if (empty_0 & empty_1 & empty_2)
            ready_toggle <= 1'b0;
    end

    assign ready     = ready_toggle;
    assign rden_all  = rden_i & ready_toggle;

    // FIFO 0
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) Ufifo_0 (
        .clk(clk),
        .rst_n(resetn),
        .wren_i(wren_0),
        .rden_i(rden_all),
        .wdata_i(data_in),
        .rdata_o(data_out_0),
        .full_o(full_0),
        .empty_o(empty_0)
    );

    // FIFO 1
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) Ufifo_1 (
        .clk(clk),
        .rst_n(resetn),
        .wren_i(wren_1),
        .rden_i(rden_all),
        .wdata_i(data_in),
        .rdata_o(data_out_1),
        .full_o(full_1),
        .empty_o(empty_1)
    );

    // FIFO 2
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) Ufifo_2 (
        .clk(clk),
        .rst_n(resetn),
        .wren_i(wren_2),
        .rden_i(rden_all),
        .wdata_i(data_in),
        .rdata_o(data_out_2),
        .full_o(full_2),
        .empty_o(empty_2)
    );

endmodule
