`timescale 1ns / 1ps
module memory_ctrlr #(
    parameter SRAM1_BW = 16,
    parameter SRAM1_AMAX = 256,
    parameter SRAM1_ADR = $clog2(SRAM1_AMAX),
    parameter SRAM2_BW = 32,
    parameter SRAM2_AMAX = 192,
    parameter SRAM2_ADR = $clog2(SRAM2_AMAX)
    )(
    input  wire clk,
    input  wire resetn,
    input  wire start,
    output wire done,

    output wire s1_en,
    output wire s2_en,
    output wire s1_we,
    output wire s2_we,
    output wire [SRAM1_ADR-1:0] s1_addr,
    output wire [SRAM2_ADR-1:0] s2_addr,
    input  wire [SRAM1_BW-1:0] s1_dout,
    output wire [SRAM2_BW-1:0] s2_din
    );

    // FSM related declarations
    parameter IDLE = 3'd0,
        P1_READ1 = 3'd1, P1_READ2 = 3'd2, P1_WRITE = 3'd3,
        P2_READ = 3'd4, P2_WRITE = 3'd5, FINISH = 3'd6;
    reg [2:0] state = IDLE;
    
    // cursors and temp registers
    reg [SRAM1_ADR-1:0] sram1_cursor = 0;
    reg [SRAM2_ADR-1:0] sram2_cursor = 191;
    reg [SRAM1_BW-1:0] sram1_temp;

    // for FINISH
    reg is_finish;
    assign done = is_finish;

    // for enable and write enable
    reg sram1_enable, sram1_write;      // SRAM1 ctrl signals
    reg sram2_enable, sram2_write;      // SRAM2 ctrl signals
    assign s1_en = sram1_enable;
    assign s1_we = sram1_write;
    assign s2_en = sram2_enable;
    assign s2_we = sram2_write;
    
    // for address and bitwidth
    reg [SRAM1_ADR-1:0] sram1_addr;
    reg [SRAM2_ADR-1:0] sram2_addr;
    reg [SRAM2_BW-1:0] sram2_input;
    assign s1_addr = sram1_addr;
    assign s2_addr = sram2_addr;
    assign s2_din  = sram2_input;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= IDLE;
            sram1_cursor <= 0;
            sram2_cursor <= 191;
            is_finish <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    is_finish <= 0;
                    if (start) begin
                        sram1_cursor <= 0;
                        sram2_cursor <= 191;
                        state <= P1_READ1;  // to next state
                    end
                end

                P1_READ1: begin
                    sram1_enable <= 1; sram1_write <= 0;    // read SRAM1
                    sram1_addr <= sram1_cursor;             // SRAM1 read address is cursor's
                    sram2_addr <= sram2_cursor;             // SRAM2 write address is cursor's
                    state <= P1_READ2;                      // to next state
                end

                P1_READ2: begin
                    sram1_temp <= s1_dout;                 // temp holds 1st data
                    sram1_addr <= sram1_cursor + 1;         // SRAM1 read address is cursor's next
                    state <= P1_WRITE;                      // to next state
                end

                P1_WRITE: begin
                    sram2_enable <= 1; sram2_write <= 1;    // write SRAM2
                    sram2_input <= {sram1_temp, s1_dout};   // assign input data
                    
                    sram1_cursor <= sram1_cursor + 8'd2;    // move SRAM1 cursor
                    sram2_cursor <= sram2_cursor - 8'd1;    // move SRAM2 cursor
                    
                    if (sram1_cursor >= 126) begin
                        state <= P2_READ;   // go to P2 if cursor is equal to or over 128
                        sram2_cursor <= 0;  // initialize SRAM2 cursor
                    end
                    else
                        state <= P1_READ1;  // repeat until cursor is at 126
                end

                P2_READ: begin
                    sram1_enable <= 1; sram1_write <= 0;    // read SRAM1
                    sram1_addr <= sram1_cursor;             // SRAM1 read address is cursor's
                    state <= P2_WRITE;                      // to next state
                end

                P2_WRITE: begin
                    sram2_enable <= 1; sram2_write <= 1;    // write SRAM2
                    sram2_addr <= sram2_cursor;             // SRAM2 write address is cursor's
                    
                    if (sram1_cursor[0] == 1'b0)            // assign input data
                        sram2_input <= {16'd0, s1_dout};
                    else
                        sram2_input <= {s1_dout, 16'd0};
                    
                    sram1_cursor <= sram1_cursor + 8'd1;    // move SRAM1 cursor
                    sram2_cursor <= sram2_cursor + 8'd1;    // move SRAM2 cursor
                    
                    if (sram1_cursor >= 255)
                        state <= FINISH;
                    else
                        state <= P2_READ;
                end

                FINISH: begin
                    is_finish <= 1;
                    sram1_enable <= 0;
                    sram2_enable <= 0;
                    sram2_write <= 0;
                end
            endcase
        end
    end

endmodule
