`timescale 1ns / 1ps

module week2_discussion;

    reg A, B, C;
    reg D, G2A, G2B;
    wire [7:0] Gate_Y1, Gate_Y2;
    wire [15:0] Output;
    
    assign Output = {Gate_Y2, Gate_Y1};  

    Gate_74LS138 Gate1 (
        .A(A), .B(B), .C(C),
        .G1(~D), .G2A(G2A), .G2B(G2B),
        .Y(Gate_Y1)
    );

    Gate_74LS138 Gate2 (
        .A(A), .B(B), .C(C),
        .G1(D), .G2A(G2A), .G2B(G2B),
        .Y(Gate_Y2)
    );
    
    initial begin

        $display("/--------------------------------/");
        $display("Hello Professor");
        $display("Start Simulation for 4-to-16 Decoder");
        $display("/--------------------------------/");

        {D, C, B, A} = 4'b0000;
        {G2A, G2B} = 2'b11;
        
        #10 {G2A, G2B} = 2'b10;
        #10 {G2A, G2B} = 2'b01;
        #10 {G2A, G2B} = 2'b00;

        #10 {D, C, B, A} = 4'b0001;
        #10 {D, C, B, A} = 4'b0010;
        #10 {D, C, B, A} = 4'b0011;
        #10 {D, C, B, A} = 4'b0100;
        #10 {D, C, B, A} = 4'b0101;
        #10 {D, C, B, A} = 4'b0110;
        #10 {D, C, B, A} = 4'b0111;
        #10 {D, C, B, A} = 4'b1000;
        #10 {D, C, B, A} = 4'b1001;
        #10 {D, C, B, A} = 4'b1010;
        #10 {D, C, B, A} = 4'b1011;
        #10 {D, C, B, A} = 4'b1100;
        #10 {D, C, B, A} = 4'b1101;
        #10 {D, C, B, A} = 4'b1110;
        #10 {D, C, B, A} = 4'b1111;
        #100;

        $display("/--------------------------------/");
        $display("This is the end of simulation");
        $display("Whew!");
        $display("/--------------------------------/");

        $finish();
    end
    
    initial begin
        $monitor($time, " I/O Signal Change: G2A=%b G2B=%b D=%b C=%b B=%b A=%b | Output = %b", G2A, G2B, D, C, B, A, Output);
    end

endmodule
