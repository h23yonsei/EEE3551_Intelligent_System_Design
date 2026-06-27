`timescale 1ns / 1ps

module tb_74LS138;

    reg A, B, C;        
    reg G1, G2A, G2B;    
    wire [7:0] Gate_Y, Verilog_Y;  


    Gate_74LS138 dut_Gate (
        .A(A), .B(B), .C(C),
        .G1(G1), .G2A(G2A), .G2B(G2B),
        .Y(Gate_Y)
    );

    Verilog_74LS138 dut_Verilog (
        .A(A), .B(B), .C(C),
        .G1(G1), .G2A(G2A), .G2B(G2B),
        .Y(Verilog_Y)
    );

    initial begin

        $display("/--------------------------------/");
        $display("Hello EEE3551");
        $display("Start Simulation for 74LS138 Decoder/Demux");
        $display("/--------------------------------/");

        
        {C, B, A} = 3'b111;
        {G2A, G2B, G1} = 3'b101;
        #10
        
        #10
        {G2A, G2B, G1} = 3'b011;
        #10
        {G2A, G2B, G1} = 3'b000;

        #10
        {A, B, C} = 3'b000;
        {G2A, G2B, G1} = 3'b001;
        #10
        {C, B, A} = 3'b001;
        #10
        {C, B, A} = 3'b010;
        #10
        {C, B, A} = 3'b011;
        #10
        {C, B, A} = 3'b100;
        #10
        {C, B, A} = 3'b101;
        #10
        {C, B, A} = 3'b110;
        #10
        {C, B, A} = 3'b111;
        #100

        $display("/--------------------------------/");
        $display("This is the end of simulation");
        $display("Good Luck");
        $display("/--------------------------------/");

        $finish();
    end


    initial begin
        $monitor($time, " Change of I/O Signal : G2A = %b G2B = %b G1 = %b C = %b B = %b A = %b | Gate_Y = %b Verilog_Y = %b", G2A, G2B, G1, A, B, C, Gate_Y, Verilog_Y);
    end


endmodule
