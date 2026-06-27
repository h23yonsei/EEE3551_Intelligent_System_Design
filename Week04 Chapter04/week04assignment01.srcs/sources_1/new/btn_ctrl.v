`timescale 1ns / 1ps
module btn_ctrl(
    input wire [1:0] mode,
    input wire deb_btn1, deb_btn2, deb_btn3,
    output reg [3:0] btn_task,
    output reg [1:0] item_num,
    output reg [7:0] coin_value
);

    always @(*) begin
        btn_task = 4'b1111;
        item_num = 2'd0;
        coin_value = 8'd0;

        if (mode != 2'b00) begin    // if not IDLE
            if (deb_btn1 && !deb_btn2 && !deb_btn3) begin
                case (mode)
                    2'b01: btn_task = 4'b0000; // COIN, add 1
                    2'b10: btn_task = 4'b0001; // SELL, item 1
                    2'b11: btn_task = 4'b0010; // FILL, item 1
                endcase
            end
            else if (!deb_btn1 && deb_btn2 && !deb_btn3) begin
                case (mode)
                    2'b01: btn_task = 4'b0011; // COIN, add 5
                    2'b10: btn_task = 4'b0100; // SELL, item 2
                    2'b11: btn_task = 4'b0101; // FILL, item 2
                endcase
            end
            else if (!deb_btn1 && !deb_btn2 && deb_btn3) begin
                case (mode)
                    2'b01: btn_task = 4'b0111; // COIN, add 10
                    2'b10: btn_task = 4'b1000; // SELL, item 3
                    2'b11: btn_task = 4'b1001; // FILL, item 3
                endcase
            end
        end

        case (btn_task)     // item_num per task
            4'b0001, 4'b0010: item_num = 2'd1;
            4'b0100, 4'b0101: item_num = 2'd2;
            4'b1000, 4'b1001: item_num = 2'd3;
        endcase

        case (btn_task)     // value per task
            4'b0000: coin_value = 8'd1;
            4'b0011: coin_value = 8'd5;
            4'b0111: coin_value = 8'd10;
        endcase
    end

endmodule
