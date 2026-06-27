`timescale 1ns / 1ps
module action_ctrl(
    input wire clk_50hz,
    input wire sw3,
    input wire [3:0] btn_task,
    input wire [1:0] item_num,
    input wire [7:0] coin_value,
    output reg [7:0] balance = 0,
    output reg [2:0] stock1 = 0,
    output reg [2:0] stock2 = 0,
    output reg [2:0] stock3 = 0,
    output reg [1:0] last_filled_item_num = 0
);

    reg [7:0] item_price;

    always @(*) begin
        case (item_num)
            2'd1: item_price = 8'd3;
            2'd2: item_price = 8'd5;
            2'd3: item_price = 8'd7;
            default: item_price = 8'd0;
        endcase
    end

    always @(posedge clk_50hz) begin
        if (!sw3) begin
            balance <= 0;
            stock1 <= 0;
            stock2 <= 0;
            stock3 <= 0;
            last_filled_item_num <= 0;
        end
        else begin
            case (btn_task)
                4'b0000, 4'b0011, 4'b0111: begin
                     if (balance + coin_value <= 50)
                     balance <= balance + coin_value;
                end
                4'b0001: if (balance >= item_price && stock1 > 0) begin
                     balance <= balance - item_price;
                     stock1 <= stock1 - 1;
                end
                4'b0010: if (stock1 < 5) begin
                    stock1 <= stock1 + 1;
                    last_filled_item_num <= item_num;
                end
                4'b0100: if (balance >= item_price && stock2 > 0) begin
                     balance <= balance - item_price;
                     stock2 <= stock2 - 1;
                end
                4'b0101: if (stock2 < 5) begin
                     stock2 <= stock2 + 1;
                     last_filled_item_num <= item_num;
                end
                4'b1000: if (balance >= item_price && stock3 > 0) begin
                     balance <= balance - item_price;
                     stock3 <= stock3 - 1;
                end
                4'b1001: if (stock3 < 5) begin
                     stock3 <= stock3 + 1;
                     last_filled_item_num <= item_num;
                end    
            endcase
        end
    end
    
endmodule
