`timescale 1ns / 1ps

module tb_top_memory_ctrlr;

    // Clock and Reset
    reg clk;
    reg resetn;

    // Control Signals
    reg start;
    wire done;

    // BRAM1 interface (Input Image)
    reg         s1_clka;
    reg         s1_ena;
    reg         s1_wea;
    reg [13:0]  s1_addra;
    reg [7:0]   s1_dina;
    wire [7:0]  s1_douta;

    // BRAM2 interface (Filtered Output)
    reg         s2_clka;
    reg         s2_ena;
    reg         s2_wea;
    reg [13:0]  s2_addra;
    reg [7:0]   s2_dina;
    wire [7:0]  s2_douta;

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 100MHz clock

    initial s1_clka = 0;
    always #5 s1_clka = ~s1_clka;

    initial s2_clka = 0;
    always #5 s2_clka = ~s2_clka;

    // Memory Model (BRAM substitute)
    reg [7:0] bram1_mem [0:10403];
    reg [7:0] bram2_mem [0:9999];

    // Simple memory behavior
    //assign s1_douta = (s1_ena && !s1_wea) ? bram1_mem[s1_addra] : 8'd0;
    //assign s2_douta = (s2_ena && !s2_wea) ? bram2_mem[s2_addra] : 8'd0;

    // DUT
    top_memory_ctrlr dut (
        .clk(clk),
        .resetn(resetn),
        .start(start),
        .done(done),
        .s1_clka(s1_clka),
        .s1_ena(s1_ena),
        .s1_wea(s1_wea),
        .s1_addra(s1_addra),
        .s1_dina(s1_dina),
        .s1_douta(s1_douta),
        .s2_clka(s2_clka),
        .s2_ena(s2_ena),
        .s2_wea(s2_wea),
        .s2_addra(s2_addra),
        .s2_dina(s2_dina),
        .s2_douta(s2_douta)
    );

    // Simulation Procedure
    integer i;

 initial begin
    $display("Start Simulation");
    $readmemh("C:/Xilinx/Vivado/IntelligentSystemDesign/Assignment3/assignment3_top/fake_image.hex", bram1_mem); 
    // 기본 초기화
    clk = 0;
    resetn = 0;
    start = 0;
    s1_ena = 0;
    s1_wea = 0;
    s2_ena = 0;
    s2_wea = 0;
    s1_addra = 0;
    s2_addra = 0;
    s1_dina = 0;
    s2_dina = 0;

    // Reset Pulse
    #20 resetn = 1;

    // Step 1: SRAM1에 데이터 쓰기 (102x102 = 10404 픽셀)
    @(posedge clk);
    for (i = 0; i < 10404; i = i + 1) begin
        @(posedge clk);
        s1_ena   <= 1;
        s1_wea   <= 1;
        s1_addra <= i;
        s1_dina  <= bram1_mem[i];
    end

    // Step 2: SRAM1 write 완료 후 disable
    @(posedge clk);
    s1_ena   <= 0;
    s1_wea   <= 0;

    // Step 3: start 신호 주기
    @(posedge clk);
    start <= 1;
    @(posedge clk);
    start <= 0;

    // Step 4: 완료 기다림
    wait (done == 1);
    $display("Done signal detected.");

    // Step 5: 결과 일부 출력
    for (i = 0; i < 10000; i = i + 1) begin
        @(posedge clk);
        s2_ena <= 1;
        s2_addra <= i;
        $display("Output[%0d] = %0d", i, s2_douta);
    end

    //$finish;
end

    // Write to BRAM2 simulation memory
    always @(posedge clk) begin
        if (s2_ena && s2_wea) begin
            bram2_mem[s2_addra] <= s2_dina;
        end
    end
    
endmodule