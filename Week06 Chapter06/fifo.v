module fifo #(
    //FIFO ??: 8bit ???? ???? 8?? ?? ??
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 102  
    )(
    input   wire                        clk,
    input   wire                        rst_n,
    input   wire                        wren_i, //write enable
    input   wire                        rden_i, //read enable
    input   wire    [DATA_WIDTH-1:0]    wdata_i, //input data
    output  wire    [DATA_WIDTH-1:0]    rdata_o, //output data
    output  wire                        full_o, //FIFO? ???? full? 1
    output  wire                        empty_o //FIFO? ???? empty? 1
    );
    
    localparam FIFO_DEPTH_LG2 = $clog2(FIFO_DEPTH); //log2(8) = 3bit? ?? ??
    
    //??? 3bit???, ??? 1bit? ???.
    //?? ??? write, read? ?? ??? ? ?? ???? ??
    reg [FIFO_DEPTH_LG2:0] wrptr; //write ??(4bit)
    reg [FIFO_DEPTH_LG2:0] rdptr; //read ??(4bit)
    
 
    // Full & empty check
    assign empty_o  =   (wrptr==rdptr); //write??? read?? ???? emnpty
    //write??? read??? MSB? ??? ??? bit? ???? full
    assign full_o   =   (wrptr[FIFO_DEPTH_LG2-1:0]==rdptr[FIFO_DEPTH_LG2-1:0]) & 
                        (wrptr[FIFO_DEPTH_LG2] != rdptr[FIFO_DEPTH_LG2]);

    // Write pointer counter seq logic
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin //reset? ?? ???
            wrptr <= {(FIFO_DEPTH_LG2+1){1'b0}};
        end 
        else if (wren_i) begin //write enable?
            if(wrptr == 8'd101) wrptr <= 8'd128; //0_(101? 2??) -> 1 000_0000
            else if(wrptr == 8'd229) wrptr <= 8'd0; //1_(101? 2??) -> 0 000_0000
            else                wrptr <= wrptr + 'd1; //?? + 1 (???? ?? ??? ??)
        end
        else begin // ?? ??
            wrptr <= wrptr;
        end
    end
    
    // Read pointer counter seq logic   
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin //reset? ?? ???
            rdptr <= {(FIFO_DEPTH_LG2+1){1'b0}};
        end 
        else if (rden_i) begin //read enbale?
            if(rdptr == 8'd101) rdptr <= 8'd128;
            else if(rdptr == 8'd229) rdptr <= 8'd0;
            else rdptr <= rdptr + 'd1; //?? + 1(???? ?? ?? ??? ??)
        end
        else begin
            rdptr <= rdptr; //?? ??
        end
    end
    
    fifo_mem UMEM( //BRAM ?????
        .clka(clk), 
        .ena(wren_i), 
        .wea(wren_i), 
        .addra(wrptr[FIFO_DEPTH_LG2-1:0]), 
        .dina(wdata_i), 
        .clkb(clk), 
        .enb(rden_i), 
        .addrb(rdptr[FIFO_DEPTH_LG2-1:0]), 
        .doutb(rdata_o));
        
endmodule