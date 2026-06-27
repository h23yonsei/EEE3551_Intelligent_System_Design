`timescale 1ns / 1ps
module top_module(
    input wire clk_100mhz,
    input wire sw0, sw1, sw3,
    
    output wire [1:0] led,
    output wire [3:0] jc,
    output wire [3:0] jd,
    output wire [3:0] num_out
);

    wire clk_50hz, clk_1hz;
    wire [3:0] num;
    wire deb_sw0, deb_sw1;
    wire aa, ab, ac, ad, ae, af, ag, C;

    clock_divider clk_div (
        .clk_100mhz(clk_100mhz),
        .clk_50hz(clk_50hz),
        .clk_1hz(clk_1hz)
    );
    
    sw_debouncer sw_deb0 (
        .clk(clk_50hz),
        .in(sw0),
        .out(deb_sw0)
    );
    
    sw_debouncer sw_deb1 (
        .clk(clk_50hz),
        .in(sw1),
        .out(deb_sw1)
    ); 

    fsm_ctrl fsm (
        .clk_1hz(clk_1hz),
        .clk_50hz(clk_50hz),
        .sw0(deb_sw0),
        .sw1(deb_sw1),
        .sw3(sw3),
        .num(num),
        .led(led)
    );

    ssd_ctrl ssd (
        .clk_50hz(clk_50hz),
        .num(num),
        .aa(aa), .ab(ab), .ac(ac), .ad(ad), .ae(ae), .af(af), .ag(ag), .C(C)
    );
    
    assign jc[0] = aa;
    assign jc[1] = ab;
    assign jc[2] = ac;
    assign jc[3] = ad;
    assign jd[0] = ae;
    assign jd[1] = af;
    assign jd[2] = ag;
    assign jd[3] = C;

endmodule
