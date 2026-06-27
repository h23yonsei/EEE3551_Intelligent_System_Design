`timescale 1ns / 1ps

module tb_top_counter;
    reg [1:0] btn;
    reg clk_100mhz;
    reg sw;
    wire [3:0] jc, jd;
    reg [3:0] display_num;
    
    top_counter test (
        .btn(btn),
        .clk_100mhz(clk_100mhz),
        .sw(sw),
        .jc(jc),
        .jd(jd)
    );
    
    initial begin
        clk_100mhz = 0;
        forever #5 clk_100mhz = ~clk_100mhz;
    end
    
    always @(*) begin
        case ({jc, jd})
            8'b1111_0011: display_num = 4'd0;
            8'b0110_0000: display_num = 4'd1;
            8'b1011_0101: display_num = 4'd2;
            8'b1111_0100: display_num = 4'd3;
            8'b0110_0110: display_num = 4'd4;
            8'b1101_0110: display_num = 4'd5;
            8'b1101_0111: display_num = 4'd6;
            8'b0111_0000: display_num = 4'd7;
            8'b1111_0111: display_num = 4'd8;
            8'b0111_0110: display_num = 4'd9;
            default: display_num = 4'd0;
        endcase
    end
    
    initial begin        
        sw = 0;
        btn = 2'b00;
        #20000000;
        
        sw = 1;
    
        repeat (11) begin
            btn[0] = 1;
            #20000000;
            btn[0] = 0;
            #20000000;
        end
        repeat (11) begin
            btn[1] = 1;
            #20000000;
            btn[1] = 0;
            #20000000;
        end
        repeat (2) begin
            btn[0] = 1;
            #20000000;
            btn[0] = 0;
            #20000000;
        end
        sw = 0;
        #10000000
        $finish;
    end
endmodule
