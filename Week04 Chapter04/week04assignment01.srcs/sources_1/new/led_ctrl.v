`timescale 1ns / 1ps
module led_ctrl(
    input wire sw3,
    input wire [1:0] mode,
    input wire [2:0] stock1, stock2, stock3,
    input wire [1:0] last_filled_item_num,
    output reg led2, led3, led4, led5
);

    always @(*) begin
        if (!sw3) begin     // off
            {led2, led3, led4, led5} = 4'b0000;
        end 
        else begin
            led5 = 1; // on

            case (mode)
                2'b11: begin // FILL
                    led2 = (last_filled_item_num == 2'd1);
                    led3 = (last_filled_item_num == 2'd2);
                    led4 = (last_filled_item_num == 2'd3);
                end
                2'b10: begin // SELL
                    led2 = (stock1 == 0);
                    led3 = (stock2 == 0);
                    led4 = (stock3 == 0);
                end
                2'b01: begin // COIN
                    {led2, led3, led4} = 3'b000;
                end
                2'b00: begin // IDLE
                    {led2, led3, led4} = 3'b000;
                end
            endcase
        end
    end

endmodule
