`timescale 1ns / 1ps

module test;
    reg sw0, sw1, sw3;
    reg clk_100mhz;
    wire [3:0] jc, jd;
    wire [1:0] led;
    
    top_module test_moodule (
        .clk_100mhz(clk_100mhz),
        .sw0(sw0), .sw1(sw1), .sw3(sw3),
        .led(led),
        .jc(jc), .jd(jd)
    );
    
    initial begin
        clk_100mhz = 0;
        forever #5 clk_100mhz = ~clk_100mhz;    
    end
    
    initial begin
        $monitor("Time=%0t | sw0=%b sw1=%b sw3=%b | num = %d", 
                 $time, sw0, sw1, sw3, test_moodule.fsm.num);
    end

    initial begin
        $display("IDLE");
        sw3 = 0;
        sw0 = 0;
        sw1 = 0;
        repeat (1) #1_000_000_000;
        
        $display("UP");
        sw3 = 1;
        sw0 = 1;
        repeat (5) #1_000_000_000;
        
        $display("still UP");
        sw1 = 1;
        repeat (5) #1_000_000_000;
        
        $display("READY");
        sw0 = 0;
        sw1 = 0;
        repeat (3) #1_000_000_000;
        
        $display("UP, check for boundary");
        sw0 = 1;
        sw1 = 0;
        repeat (7) #1_000_000_000;
        
        $display("DOWN, check for boundary");
        sw0 = 0;
        sw1 = 1;
        repeat (17) #1_000_000_000;
        
        $display("UP");
        sw0 = 1;
        repeat (3) #1_000_000_000;
        
        $display("IDLE");
        sw3 = 0;
        repeat (3) #1_000_000_000;
        $finish;
    end
endmodule
