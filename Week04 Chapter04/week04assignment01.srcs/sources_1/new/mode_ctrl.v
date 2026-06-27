`timescale 1ns / 1ps
module mode_ctrl(
    input wire clk_50hz,
    input wire sw1, sw2, sw3,
    output reg [1:0] mode
);

    localparam IDLE = 2'b00;
    localparam COIN = 2'b01;
    localparam SELL = 2'b10;
    localparam FILL = 2'b11;

    reg [1:0] state, next_state;
    
    always @(posedge clk_50hz) begin
        if (!sw3)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        if (!sw3)
            next_state = IDLE;
        else begin
            case ({sw1, sw2})
                2'b00: next_state = SELL;
                2'b01: next_state = FILL;
                2'b10, 2'b11: next_state = COIN;
                default: next_state = IDLE;
            endcase
        end
    end

    always @(*) begin
        mode = state;
    end

endmodule
