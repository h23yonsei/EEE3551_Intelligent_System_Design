`timescale 1ns/1ps

module tb_MaxFCArgMax;

    parameter DATA_WIDTH = 8;
    parameter PIXEL_NUM = 12;

    reg clk;
    reg resetn;
    reg valid_in;
    reg signed [DATA_WIDTH-1:0] px_row0;
    reg signed [DATA_WIDTH-1:0] px_row1;

    reg signed [DATA_WIDTH-1:0] weight_0, weight_1, weight_2, weight_3, weight_4,
                                weight_5, weight_6, weight_7, weight_8, weight_9;

    wire [3:0] argmax_out;
    wire argmax_valid_out;

    // DUT: MaxFCArgMax 모듈 인스턴스
    MaxFCArgMax #(
        .DATA_WIDTH(DATA_WIDTH),
        .PIXEL_NUM(PIXEL_NUM)
    ) uut (
        .clk(clk),
        .resetn(resetn),
        .valid_in(valid_in),
        .px_row0(px_row0),
        .px_row1(px_row1),
        .weight_0(weight_0),
        .weight_1(weight_1),
        .weight_2(weight_2),
        .weight_3(weight_3),
        .weight_4(weight_4),
        .weight_5(weight_5),
        .weight_6(weight_6),
        .weight_7(weight_7),
        .weight_8(weight_8),
        .weight_9(weight_9),
        .argmax_out(argmax_out),
        .valid_out(argmax_valid_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    integer i;

    initial begin
        // 초기화
        resetn = 0;
        valid_in = 0;
        px_row0 = 0;
        px_row1 = 0;
        
        /*
        // 예시 가중치 초기화
        weight_0 = 91;
        weight_1 = -14;
        weight_2 = -128;
        weight_3 = 77;
        weight_4 = -63;
        weight_5 = 32;
        weight_6 = 0;
        weight_7 = 119;
        weight_8 = -101;
        weight_9 = 45;
        */

        #20;
        resetn = 1;
        #10;

            // ...

        // 24픽셀씩 2행 데이터 입력 (MaxPool에서 2x2씩 처리 -> 12x12 출력 생성)
        for (i = 0; i < 24; i = i + 1) begin
            @(posedge clk);
            valid_in = 1;
    
            // px_row0, px_row1 할당
            case (i)
                0:  begin px_row0 = 12;  px_row1 = 87;  end
                1:  begin 
                        px_row0 = 45;  
                        px_row1 = 3;   
    
                        // i=1일 때 weight 변경
                        weight_0 = 91;
                        weight_1 = -14;
                        weight_2 = -128;
                        weight_3 = 77;
                        weight_4 = -63;
                        weight_5 = 32;
                        weight_6 = 0;
                        weight_7 = 119;
                        weight_8 = -101;
                        weight_9 = 45;
                    end
                2:  begin px_row0 = 67;  px_row1 = 128; end
                3:  begin 
                        px_row0 = 23;  
                        px_row1 = 49;  
    
                        // i=3일 때 weight 변경
                        weight_0 = -45;
                        weight_1 = 67;
                        weight_2 = -77;
                        weight_3 = 14;
                        weight_4 = -90;
                        weight_5 = 11;
                        weight_6 = 35;
                        weight_7 = 123;
                        weight_8 = 50;
                        weight_9 = -9;
                    end
                4:  begin px_row0 = 91;  px_row1 = 7;   end
                5:  begin 
                        px_row0 = 30;  
                        px_row1 = 118; 
    
                        // i=5일 때 weight 변경
                        weight_0 = 5;
                        weight_1 = -100;
                        weight_2 = 50;
                        weight_3 = -75;
                        weight_4 = 25;
                        weight_5 = 80;
                        weight_6 = -15;
                        weight_7 = 60;
                        weight_8 = -30;
                        weight_9 = 10;
                    end
                6:  begin px_row0 = 5;   px_row1 = 96;  end
                7:  begin 
                        px_row0 = 77;  
                        px_row1 = 34;  
    
                        // i=7일 때 weight 변경
                        weight_0 = -12;
                        weight_1 = 44;
                        weight_2 = -33;
                        weight_3 = 22;
                        weight_4 = -11;
                        weight_5 = 77;
                        weight_6 = -88;
                        weight_7 = 33;
                        weight_8 = -22;
                        weight_9 = 11;
                    end
                8:  begin px_row0 = 50;  px_row1 = 20;  end
                9:  begin 
                        px_row0 = 16;  
                        px_row1 = 104; 
    
                        // i=9일 때 weight 변경
                        weight_0 = 123;
                        weight_1 = -56;
                        weight_2 = 89;
                        weight_3 = -45;
                        weight_4 = 67;
                        weight_5 = -78;
                        weight_6 = 90;
                        weight_7 = -34;
                        weight_8 = 21;
                        weight_9 = -11;
                    end
                10: begin px_row0 = 63;  px_row1 = 11;  end
                11: begin 
                        px_row0 = 8;   
                        px_row1 = 55;  
    
                        // i=11일 때 weight 변경
                        weight_0 = -23;
                        weight_1 = 45;
                        weight_2 = -67;
                        weight_3 = 89;
                        weight_4 = -12;
                        weight_5 = 34;
                        weight_6 = -56;
                        weight_7 = 78;
                        weight_8 = -90;
                        weight_9 = 21;
                    end
                12: begin px_row0 = 38;  px_row1 = 65;  end
                13: begin 
                        px_row0 = 99;  
                        px_row1 = 14;  
    
                        // i=13일 때 weight 변경
                        weight_0 = 33;
                        weight_1 = -44;
                        weight_2 = 55;
                        weight_3 = -66;
                        weight_4 = 77;
                        weight_5 = -88;
                        weight_6 = 99;
                        weight_7 = -30;
                        weight_8 = 111;
                        weight_9 = -122;
                    end
                14: begin px_row0 = 1;   px_row1 = 124; end
                15: begin 
                        px_row0 = 41;  
                        px_row1 = 90;  
    
                        // i=15일 때 weight 변경
                        weight_0 = -13;
                        weight_1 = 26;
                        weight_2 = -39;
                        weight_3 = 52;
                        weight_4 = -65;
                        weight_5 = 78;
                        weight_6 = -91;
                        weight_7 = 104;
                        weight_8 = -117;
                        weight_9 = 120;
                    end
                16: begin px_row0 = 26;  px_row1 = 72;  end
                17: begin 
                        px_row0 = 85;  
                        px_row1 = 37;  
    
                        // i=17일 때 weight 변경
                        weight_0 = 7;
                        weight_1 = -14;
                        weight_2 = 21;
                        weight_3 = -28;
                        weight_4 = 35;
                        weight_5 = -42;
                        weight_6 = 49;
                        weight_7 = -56;
                        weight_8 = 63;
                        weight_9 = -70;
                    end
                18: begin px_row0 = 0;   px_row1 = 66;  end
                19: begin 
                        px_row0 = 73;  
                        px_row1 = 27;  
    
                        // i=19일 때 weight 변경
                        weight_0 = -1;
                        weight_1 = 2;
                        weight_2 = -3;
                        weight_3 = 4;
                        weight_4 = -5;
                        weight_5 = 6;
                        weight_6 = -7;
                        weight_7 = 8;
                        weight_8 = -9;
                        weight_9 = 10;
                    end
                20: begin px_row0 = 53;  px_row1 = 18;  end
                21: begin 
                        px_row0 = 17;  
                        px_row1 = 100; 
    
                        // i=21일 때 weight 변경
                        weight_0 = 15;
                        weight_1 = -30;
                        weight_2 = 45;
                        weight_3 = -60;
                        weight_4 = 75;
                        weight_5 = -90;
                        weight_6 = 105;
                        weight_7 = -20;
                        weight_8 = 7;
                        weight_9 = -14;
                    end
                22: begin px_row0 = 79;  px_row1 = 2;   end
                23: begin 
                        px_row0 = 34;  
                        px_row1 = 108; 
    
                        // i=23일 때 weight 변경
                        weight_0 = -21;
                        weight_1 = 42;
                        weight_2 = -63;
                        weight_3 = 84;
                        weight_4 = -105;
                        weight_5 = 126;
                        weight_6 = -127;
                        weight_7 = 118;
                        weight_8 = -109;
                        weight_9 = 100;
                    end
            endcase
        end


        @(posedge clk);
        valid_in = 0;

        // argmax valid 신호 대기
        wait(argmax_valid_out == 1);
        @(posedge clk);

        $display("=== ArgMax Result ===");
        $display("argmax_out = %d", argmax_out);

        #20;
        $stop;
    end

endmodule
