`timescale 1ns / 1ps
module memory_ctrlr (
  input wire clk,
  input wire resetn,

  input wire start,
  output wire done,
  
  output wire ena,
  output wire wea,
  output wire [7:0] addra,
  output wire [15:0] dina,

  output wire enb,
  output wire [7:0] addrb,
  input wire [15:0] doutb
);

    reg [7:0] cursor;
    reg [15:0] accum;
    
    reg [2:0] state;
    localparam IDLE = 3'd0,
        CLKCYCLE1  = 3'd1, CLKCYCLE2  = 3'd2, CLKCYCLE3  = 3'd3,
        WRITE  = 3'd4, DONE = 3'd5;
        
    reg ctrl_done;
    reg ctrl_ena;
    reg ctrl_wea;
    reg [7:0] ctrl_addra;
    reg [15:0] ctrl_dina;
    reg ctrl_enb;
    reg [7:0] ctrl_addrb;
    reg [15:0] ctrl_doutb;
    
    assign done = ctrl_done;
    assign ena = ctrl_ena;
    assign wea = ctrl_wea;
    assign addra = ctrl_addra;
    assign dina = ctrl_dina;
    assign enb = ctrl_enb;
    assign addrb = ctrl_addrb;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // genenral
            cursor <= 0;
            accum <= 0;
            ctrl_done <= 0;
            // Port A, B
            ctrl_ena <= 0;
            ctrl_wea <= 0;
            ctrl_enb <= 0;
            ctrl_addra <= 0;
            ctrl_dina <= 0;
            ctrl_addrb <= 0;
            // state transition
            state <= IDLE;
        end
    
        else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        // genenral
                        cursor <= 0;
                        accum <= 0;
                        ctrl_done <= 0;
                        // Port A, B
                        ctrl_ena <= 0;
                        ctrl_wea <= 0;
                        ctrl_enb <= 1;
                        ctrl_addra <= 0;
                        ctrl_dina <= 0;
                        ctrl_addrb <= 0;
                        // state transition
                        state <= CLKCYCLE1;
                    end
                    else
                        state <= IDLE;
                end

                CLKCYCLE1: begin
                    ctrl_addrb <= cursor;
                    state <= CLKCYCLE2;
                end

                CLKCYCLE2: begin
                    state <= CLKCYCLE3;
                end
                
                CLKCYCLE3: begin
                    ctrl_doutb <= doutb;
                    state <= WRITE;
                end
        
                WRITE: begin
                    // Port A, B
                    ctrl_ena <= 1;
                    ctrl_wea <= 1;
                    ctrl_enb <= 0;
                    ctrl_addra <= cursor;
                    ctrl_dina <= accum + ctrl_doutb;
                    accum <= accum + ctrl_doutb;
                    cursor <= cursor + 1;
                    if (cursor == 8'd255) begin
                        ctrl_ena <= 0;
                        ctrl_wea <= 0;
                        ctrl_enb <= 0;
                        state <= DONE;
                    end
                    else begin
                        state <= CLKCYCLE1;
                    end
                end

                DONE: begin
                    ctrl_done <= 1;
                end
            endcase
        end
    end
endmodule