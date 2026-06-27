`timescale 1ns / 1ps

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
    input   wire    [DATA_WIDTH-1:0]    data_in,
    output  wire    [DATA_WIDTH-1:0]    data_out0,
    output  wire    [DATA_WIDTH-1:0]    data_out1,
    output  wire    [DATA_WIDTH-1:0]    data_out2
    );    
    
    wire full_0, full_1, full_2;
    wire empty_0, empty_1, empty_2;
    
    //write enable for each FIFO
    wire wren_0, wren_1, wren_2;
    
    //reg to wire
    reg ready_reg;
    assign ready = ready_reg;
    
    //variable for count of FIFO
    reg [8:0] count;
    
    //count of FIFO
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            count <= 0;
        else if (count == FIFO_DEPTH*3)
            count <= 0;
        else if (wren_i)
            count <= count + 1;
        else
            count <= count;
    end
    
    //write process
    assign wren_0 = (wren_i && count <= (FIFO_DEPTH-1) && !full_0) ? 1 : 0;
    assign wren_1 = (wren_i && count >= FIFO_DEPTH && count <= (FIFO_DEPTH*2 - 1) && !full_1) ? 1 : 0;
    assign wren_2 = (wren_i && count >= (FIFO_DEPTH*2) && !full_2) ? 1 : 0;
   
    //read process
    //assign rden_i = (ready_reg) ? 1 : 0; //read when ready is 1
                 
    //ready logic
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            ready_reg <= 0;
        else if(full_0 && full_1 && full_2) //ready is 1 when all FIFOs are full
            ready_reg <= 1;
        else if(empty_0 && empty_1 && empty_2) //ready is 0 when all FIFOs are empty
            ready_reg <= 0;
        else
            ready_reg <= ready_reg;
    end

    fifo #(
    .DATA_WIDTH(8),
    .FIFO_DEPTH(102) 
    ) Ufifo_0(
        .clk(clk),
        .rst_n(resetn),
        .wren_i(wren_0), //assign write enable to FIFO_0
        .rden_i(rden_i), //read 3 FIFOs in parallel
        .wdata_i(data_in), //write data in sequence
        .rdata_o(data_out0),
        .full_o(full_0),
        .empty_o(empty_0)
    );

    fifo #(
    .DATA_WIDTH(8),
    .FIFO_DEPTH(102)
    ) Ufifo_1(
        .clk(clk),
        .rst_n(resetn),
        .wren_i(wren_1), //assign write enable to FIFO_1
        .rden_i(rden_i), //read 3 FIFOs in parallel
        .wdata_i(data_in), //write data in sequence
        .rdata_o(data_out1),
        .full_o(full_1),
        .empty_o(empty_1)
    );

    fifo #(
    .DATA_WIDTH(8),
    .FIFO_DEPTH(102)
    ) Ufifo_2(
        .clk(clk),
        .rst_n(resetn),
        .wren_i(wren_2), //assign write enable to FIFO_2
        .rden_i(rden_i), //read 3 FIFOs in parallel
        .wdata_i(data_in), //write data in sequence
        .rdata_o(data_out2),
        .full_o(full_2),
        .empty_o(empty_2)
    );    

endmodule
