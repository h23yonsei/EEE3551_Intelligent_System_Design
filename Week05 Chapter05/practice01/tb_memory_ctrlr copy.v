`timescale 1ns / 1ps
module tb_memory_ctrlr();

    reg clk;
    initial clk = 1'b0;
    always #5 clk <= ~clk;

    reg resetn;
    reg start;

    reg [31:0] SRAM2_compare [0:191];

    wire done;

    initial begin
        $readmemh("C:/vivado/week05practice01/init_memory.hex", Utop_memory_ctrlr.SRAM1.mem);
    end


    initial begin
        $display("Welcom EE3551_Practice5_1!");
        resetn <= 1'b1;
        start <= 1'b0;
        #302
        resetn <= 1'b0;
        #50
        resetn <= 1'b1;
        #50
        start <= 1'b1;
        #10
        start <= 1'b0;
        
        @(posedge done) begin
            $display("DUT Finishs Operation!");
            #10
            compare_memory();
            #10
            $finish();
        end
    end


    initial begin
      #300000
        $display("Error: Hit safety net @ %8dns", $time);
        $finish();
    end

    integer i;
    task compare_memory;
        begin
            $readmemh("C:/vivado/week05practice01/answer_memory.hex", SRAM2_compare);
            for(i=0; i<192; i=i+1) begin
                if(Utop_memory_ctrlr.SRAM2.mem[i] != SRAM2_compare[i])
                begin
                    $display("Error: memory comparison failed @ %8dns", $time);
                    $display("[%d] IDEAL : %h DUT : %h", i, SRAM2_compare[i], Utop_memory_ctrlr.SRAM2.mem[i]);
                    $writememh("C:/vivado/week05practice01/result_memory.hex", Utop_memory_ctrlr.SRAM2.mem);
                    $finish;
                end
                if(i<10)
                    $display("[%d] IDEAL : %h DUT : %h", i, SRAM2_compare[i], Utop_memory_ctrlr.SRAM2.mem[i]);

            end
            $display("PASS: memory comparison succeed @ %8dns", $time);
            $writememh("C:/vivado/week05practice01/result_memory.hex", Utop_memory_ctrlr.SRAM2.mem);
        end
    endtask

    top_memory_ctrlr Utop_memory_ctrlr(
        .clk(clk),
        .resetn(resetn),

        .start(start),
        .done(done)
    );
    

endmodule
