`timescale 1ns / 1ps
module fsm_ctrl(
    input wire clk_1hz,
    input wire clk_50hz,
    input wire sw0,
    input wire sw1,
    input wire sw3,
    output reg [3:0] num,
    output reg [1:0] led
);

    parameter IDLE  = 2'b00;
    parameter UP    = 2'b01;
    parameter DOWN  = 2'b10;
    parameter READY = 2'b11;

    reg [1:0] state = 2'b00;
    reg [1:0] next_state;

    always @(*) begin
        case (state)
            IDLE: begin
                if (!sw3) next_state = IDLE;
                else next_state = READY;
            end
            UP: begin
                if (!sw3) next_state = IDLE;
                else if (!sw0) next_state = READY;
                else next_state = UP;
            end
            DOWN: begin
                if (!sw3) next_state = IDLE;
                else if (sw0) next_state = UP;
                else if (!sw1 & !sw0) next_state = READY;
                else next_state = DOWN;
            end
            READY: begin
                if (!sw3) next_state = IDLE;
                else if(sw0) next_state = UP;
                else if(sw1 & !sw0) next_state = DOWN;
                else next_state = READY;
            end
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk_1hz or negedge sw3) begin
        if (!sw3) 
            num <= 4'b0000;
        else begin
            case (state)
                UP: if (num < 4'b1111) num <= num + 1;
                DOWN: if (num > 4'b0000) num <= num - 1;
                default: num <= num;
            endcase
        end
    end

    always @(posedge clk_50hz or negedge sw3) begin
        if (!sw3) begin
            state <= IDLE;
            led <= 2'b00;
        end
        else begin
            state <= next_state;
            case (state)
                IDLE:  led <= 2'b00;
                UP:    led <= 2'b01;
                DOWN:  led <= 2'b10;
                READY: led <= 2'b00;
                default: led <= 2'b00;
            endcase
        end
    end

endmodule
