`timescale 1ns / 1ns
module tb_loopback();

    parameter MEMORY_DEPTH = 14'd100;

    reg clk_100MHz;
    initial clk_100MHz =1'b0;
    always #5 clk_100MHz<= !clk_100MHz;
        
    wire     clk_50MHz;
        
    ClockDivider#(
        .divide_rate(2)
    ) UClockDivider(
        .clk_in(clk_100MHz),
        .rst(rst_pin),
        .clk_out(clk_50MHz)
        );
        
    reg rst_pin;
    reg rx_switch;
    reg tx_switch;
    reg rx_switch_tester;
    reg tx_switch_tester;
        
    wire uart_rx;
    wire uart_tx;
    wire led;
    

    tester_loopback#(
        .BAUD_RATE(115_200),
        .CLOCK_RATE(50_000_000),
        .MEMORY_DEPTH(MEMORY_DEPTH)
    )   tester(
        .clk(clk_50MHz),
        .rst(rst_pin),
        .rx_switch(rx_switch_tester),
        .tx_switch(tx_switch_tester),
        .uart_rx(uart_tx),
        .uart_tx(uart_rx)
    );


    loopback_top#(
        .BAUD_RATE(115_200),
        .CLOCK_RATE(50_000_000),
        .MEMORY_DEPTH(MEMORY_DEPTH)
    ) loopback(
        .clk(clk_100MHz),
        .rst(rst_pin),
        .uart_rx(uart_rx),
        .rx_switch(rx_switch),
        .tx_switch(tx_switch),
        .uart_tx(uart_tx),
        .led(led)
    );
    
    initial begin
        rst_pin=1'b0;
        rx_switch=1'b0;
        tx_switch=1'b0;
        rx_switch_tester=1'b0;
        tx_switch_tester=1'b0;
        #3
        rst_pin=1'b1;
        #100
        rst_pin=1'b0;
        #10
        rx_switch=1'b1;
        #10
        tx_switch_tester=1'b1;
        #200_000_000
        $finish;

    end
    
    always @ (posedge clk_50MHz)begin
        if(led == 1'b1) begin
            // $display("led on");
            #300
            rx_switch=1'b0;
            tx_switch_tester <= 1'b0;
            #300
            rx_switch_tester <= 1'b1;
            #300
            tx_switch <= 1'b1;
        end
    end
endmodule
