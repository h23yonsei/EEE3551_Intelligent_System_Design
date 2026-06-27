`timescale 1ns / 1ps
module vending_machine(
    input wire clk,
    input wire btn1, btn2, btn3,
    input wire sw1, sw2, sw3,
    output wire LED5, 
    output reg LED4, LED3, LED2,
    output wire aa, ab, ac, ad, ae, af, ag, cat
);

    wire clk_50hz;
    clock_divider inst_clock_divider (
        .clk_100mhz(clk),
        .clk_50hz(clk_50hz)
    );

    wire deb_btn1, deb_btn2, deb_btn3;
    btn_debouncer inst_btn_debouncer1 (.clk(clk_50hz), .in(btn1), .out(deb_btn1));
    btn_debouncer inst_btn_debouncer2 (.clk(clk_50hz), .in(btn2), .out(deb_btn2));
    btn_debouncer inst_btn_debouncer3 (.clk(clk_50hz), .in(btn3), .out(deb_btn3));

    wire [1:0] mode;
    mode_ctrl inst_mode_ctrl (
        .clk_50hz(clk_50hz),
        .sw1(sw1),
        .sw2(sw2),
        .sw3(sw3),
        .mode(mode)
    );

    wire [1:0] item_num;
    wire [7:0] coin_value;
    wire [3:0] btn_task;
    btn_ctrl inst_btn_ctrl (
        .mode(mode),
        .deb_btn1(deb_btn1),
        .deb_btn2(deb_btn2),
        .deb_btn3(deb_btn3),
        .item_num(item_num),
        .coin_value(coin_value),
        .btn_task(btn_task)
    );

    wire [7:0] balance;
    wire [2:0] stock1, stock2, stock3;
    wire [1:0] last_filled_item_num;
    action_ctrl inst_action_ctrl (
        .clk_50hz(clk_50hz),
        .sw3(sw3),
        .btn_task(btn_task),
        .item_num(item_num),
        .coin_value(coin_value),
        .balance(balance),
        .stock1(stock1),
        .stock2(stock2),
        .stock3(stock3),
        .last_filled_item_num(last_filled_item_num)
    );

    wire led2, led3, led4;
    led_ctrl inst_led_ctrl (
        .sw3(sw3),
        .mode(mode),
        .stock1(stock1),
        .stock2(stock2),
        .stock3(stock3),
        .last_filled_item_num(last_filled_item_num),
        .led2(led2), .led3(led3), .led4(led4), .led5(LED5)
    );

    always @(*) begin
        LED2 = led2;
        LED3 = led3;
        LED4 = led4;
    end

    ssd_ctrl inst_ssd_ctrl (
        .clk_50hz(clk_50hz),
        .sw3(sw3),
        .mode(mode),
        .balance(balance),
        .stock1(stock1),
        .stock2(stock2),
        .stock3(stock3),
        .last_filled_item_num(last_filled_item_num),
        .aa(aa), .ab(ab), .ac(ac), .ad(ad), .ae(ae), .af(af), .ag(ag),
        .cat(cat)
    );

endmodule
