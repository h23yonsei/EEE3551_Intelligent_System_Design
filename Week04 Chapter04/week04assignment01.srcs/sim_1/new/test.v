`timescale 1ns / 1ps
module test;
    reg clk = 0;
    reg sw1 = 0, sw2 = 0, sw3 = 0;
    reg btn1 = 0, btn2 = 0, btn3 = 0;
    wire LED2, LED3, LED4, LED5;
    wire aa, ab, ac, ad, ae, af, ag, cat;
    
    vending_machine test_vending_machine (
        .clk(clk),
        .btn1(btn1), .btn2(btn2), .btn3(btn3),
        .sw1(sw1), .sw2(sw2), .sw3(sw3),
        .LED2(LED2), .LED3(LED3), .LED4(LED4), .LED5(LED5),
        .aa(aa), .ab(ab), .ac(ac), .ad(ad), .ae(ae), .af(af), .ag(ag),
        .cat(cat)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("Time: %t Mode: %2b BTN: %3b Stock1: %d Stock2: %d Stock3: %d Balance: %2d LED: %4b", 
            $time, test_vending_machine.inst_mode_ctrl.mode,
            {test_vending_machine.inst_btn_debouncer1.out,
            test_vending_machine.inst_btn_debouncer2.out,
            test_vending_machine.inst_btn_debouncer3.out},
            test_vending_machine.inst_action_ctrl.stock1,
            test_vending_machine.inst_action_ctrl.stock2,
            test_vending_machine.inst_action_ctrl.stock3,
            test_vending_machine.inst_action_ctrl.balance,
            {LED2, LED3, LED4, LED5}
);

        sw3 = 1; // on
        #100;

        sw1 = 0;
        sw2 = 1;
        $display("FILL: fill all 3 items 6 times, boundary check");

        repeat(6) begin   // fill item 1 6 times
            #100 btn1 = 1;
            #20_000_000 btn1 = 0;
            #50_000_000;
        end

        repeat(6) begin   // fill item 2 6 times
            #100 btn2 = 1;
            #20_000_000 btn2 = 0;
            #50_000_000;
        end

        repeat(6) begin   // fill item 3 6 times
            #100 btn3 = 1;
            #20_000_000 btn3 = 0;
            #50_000_000;
        end

        sw1 = 1;
        sw2 = 0;
        $display("COIN: insert to 48");

        repeat(3) begin   // +10 3 times (30)
            #100 btn3 = 1;
            #20_000_000 btn3 = 0;
            #50_000_000;
        end
        repeat(3) begin   // +5 3 times (45)
            #100 btn2 = 1;
            #20_000_000 btn2 = 0;
            #50_000_000;
        end
        repeat(3) begin   // +1 3 times (48)
            #100 btn1 = 1;
            #20_000_000 btn1 = 0;
            #50_000_000;
        end
        $display("COIN: +10, +5 boundary Check");
        #100 btn3 = 1;
        #20_000_000 btn3 = 0;
        #50_000_000;
        
        #100 btn2 = 1;
        #20_000_000 btn2 = 0;
        #50_000_000;
        $display("COIN: insert to 50");
        repeat(2) begin   // +1 2 times (50)
            #100 btn1 = 1;
            #20_000_000 btn1 = 0;
            #50_000_000;
        end
        $display("COIN: +1 boundary check");
        #100 btn1 = 1;
        #20_000_000 btn1 = 0;
        #50_000_000;

        sw1 = 0;
        sw2 = 0;
        $display("SELL: Sell item1 6 times, item3 6 times, boundary check");
        repeat(6) begin   // sell item 1 6 times + boundary check (35)
            #100 btn1 = 1;
            #20_000_000 btn1 = 0;
            #50_000_000;
        end
        
        repeat(6) begin   // sell item 3 6 times + boundary check (00)
            #100 btn3 = 1;
            #20_000_000 btn3 = 0;
            #50_000_000;
        end

        sw1 = 1;
        sw2 = 0;
        $display("COIN: inset to 50");

        repeat(5) begin   // +10 5 times (50)
            #100 btn3 = 1;
            #20_000_000 btn3 = 0;
            #50_000_000;
        end
        
        sw1 = 0;
        sw2 = 0;
        $display("SELL: sell item2 6 times, boundary check");
        repeat(6) begin   // sell item 2 6 times + boundary check (25)
            #100 btn2 = 1;
            #20_000_000 btn2 = 0;
            #50_000_000;
        end
        
        $display("off");
        sw3 = 0; // off
        #20_000_000;
        $display("on");
        sw3 = 1; // on
        #20_000_000;

        $finish;
    end

endmodule
