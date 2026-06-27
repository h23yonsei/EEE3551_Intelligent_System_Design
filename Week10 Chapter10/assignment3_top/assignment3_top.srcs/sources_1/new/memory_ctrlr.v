`timescale 1ns / 1ps

module memory_ctrlr #(
    parameter BRAM1_BW = 8,
    parameter BRAM1_AMAX = 10404,
    parameter BRAM1_ADR = $clog2(BRAM1_AMAX),
    parameter BRAM2_BW = 8,
    parameter BRAM2_AMAX = 10000,
    parameter BRAM2_ADR = $clog2(BRAM2_AMAX)
    )(
    input  wire clk,
    input  wire resetn,
    input  wire start,
    output wire done,

    output wire s1_en,
    output wire s2_en,
    output wire s1_we,
    output wire s2_we,
    output wire [BRAM1_ADR-1:0] s1_addr,
    output wire [BRAM2_ADR-1:0] s2_addr,
    input  wire [BRAM1_BW-1:0] s1_dout,
    output wire [BRAM2_BW-1:0] s2_din
    );

    localparam IDLE = 2'b00;
    localparam READ = 2'b01;
    localparam CONV = 2'b10;
    localparam DONE = 2'b11;

    reg [BRAM1_ADR-1:0] s1_addr_reg;
    reg [BRAM1_ADR-1:0] s2_addr_reg;
    
    wire [BRAM2_BW-1:0] result_S;
    wire valid;
    
    reg [8:0] count_read;
    reg [6:0] count_conv;
    
    wire ready;
    
    reg wren_i;
    reg rden_i;
    
    wire [BRAM1_BW-1:0] data_out0;
    wire [BRAM1_BW-1:0] data_out1;
    wire [BRAM1_BW-1:0] data_out2;

    assign s1_en = (state == READ);
    assign s1_we = 1'b0;
    assign s1_addr = s1_addr_reg;

    assign s2_en = (state == CONV && valid == 1);
    assign s2_we = (state == CONV && valid == 1);
    assign s2_addr = s2_addr_reg;

    assign s2_din = result_S;

    assign done = (state == DONE);
    
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            wren_i <= 0;
        else
            wren_i <= (state == READ);
    end
    
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            rden_i <= 0;
        else
            rden_i <= (state == CONV);
    end
    
    //present state & next state declaration
    reg [1:0] state;
    reg [1:0] next_state;
    
    //present to next transition
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    always @(*)
    begin
        case(state)
            IDLE:
            begin 
                if(start)
                    next_state = READ;
                else
                    next_state = IDLE;
            end            
            READ:
            begin
                if(count_read == 9'd306)
                    next_state = CONV;
                else
                    next_state = READ;
            end
            CONV:
            begin
                if(s2_addr_reg == 14'd9999)
                    next_state = DONE;
                else if(count_conv == 7'd100)
                    next_state = READ;
                else
                    next_state = CONV;
            end
            DONE:
            begin
                if(!resetn)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            count_read <= 9'd0;
        else
        begin
            if(state == READ) 
            begin
                if(count_read == 9'd306)
                    count_read <= 9'd0;
                else
                    count_read <= count_read + 1;
            end
            else
                count_read <= 9'd0;
        end
    end

    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            s1_addr_reg <= 14'd0;
        else
        begin
            if(state == READ) 
            begin
                if(count_read == 9'd306)
                    s1_addr_reg <= s1_addr_reg - 204;
                else
                    s1_addr_reg <= s1_addr_reg + 14'd1;
            end
            else
                s1_addr_reg <= s1_addr_reg;
        end
    end

    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            count_conv <= 7'd0;
        else
        begin
            if(state == CONV && valid == 1)
            begin
                if(count_conv == 7'd100)
                    count_conv <= 7'd0;
                else
                    count_conv <= count_conv + 1;
            end
            else
                count_conv <= 7'd0;
        end
    end

    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            s2_addr_reg <= 14'd0;
        else
        begin
            if(state == CONV && valid == 1) 
                s2_addr_reg <= s2_addr_reg + 1;
            else
                s2_addr_reg <= s2_addr_reg;
        end
    end

    line_buffer #(
    .DATA_WIDTH(8),
    .FIFO_DEPTH(102),
    .NUM_FIFO(3)
    ) line_buffer_0(
        .clk(clk),
        .resetn(resetn),
        .ready(ready),
        .wren_i(wren_i),    
        .rden_i(rden_i),    
        .data_in(s1_dout),
        .data_out0(data_out0),
        .data_out1(data_out1),
        .data_out2(data_out2)
    );
    
    Matrix_gen #(
    .DATA_WIDTH(8),
    .ROW(102),
    .COL(102)
    ) Matrix_gen_0(
        .clk(clk),
        .resetn(resetn),
        .data_in0(data_out0),
        .data_in1(data_out1),
        .data_in2(data_out2),
        .ready(ready),
        .result_S(result_S),
        .valid(valid)
    );

endmodule
