`timescale 1ns / 1ps

module Matrix_gen #(
    parameter DATA_WIDTH = 8,
    parameter ROW = 102,
    parameter COL = 102
    )(
    input   wire                            clk,
    input   wire                            resetn,
    input   wire    [DATA_WIDTH-1:0]        data_in0,
    input   wire    [DATA_WIDTH-1:0]        data_in1,
    input   wire    [DATA_WIDTH-1:0]        data_in2,   
    input   wire                            ready,
    output  wire    [DATA_WIDTH-1:0]        result_S,
    output  wire                            valid
    );

    reg [7:0] matrix [2:0][2:0];
    wire signed [8:0] ex_matrix [2:0][2:0];
    
    reg signed [8:0] Gx [0:2][0:2];
    reg signed [8:0] Gy [0:2][0:2];
    
    wire signed [11:0] Sx [0:2][0:2];
    wire signed [11:0] Sy [0:2][0:2];
    
    wire signed [15:0] Sx_sum;
    wire signed [15:0] Sy_sum;
    
    wire [15:0] Abs_Sx_sum;
    wire [15:0] Abs_Sy_sum;
    
    reg [6:0] count;
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            count <= 0;
        else
        begin
            if(ready)
                count <= count + 1;
            else
                count <= 0;
        end
    end
    
    assign valid = (count >= 4) ? 1 : 0; //FIFO delay 1 + data validation 3
    
    always @(posedge clk or negedge resetn) begin //계산할 3x3 만들기
        if(!resetn) begin
            matrix[0][0] <= 8'd0; matrix[0][1] <= 8'd0; matrix[0][2] <= 8'd0;
            matrix[1][0] <= 8'd0; matrix[1][1] <= 8'd0; matrix[1][2] <= 8'd0;
            matrix[2][0] <= 8'd0; matrix[2][1] <= 8'd0; matrix[2][2] <= 8'd0;
        end
        else begin
            if(ready) begin
                matrix[0][0] <= matrix[0][1]; matrix[0][1] <= matrix[0][2]; matrix[0][2] <= data_in0;
                matrix[1][0] <= matrix[1][1]; matrix[1][1] <= matrix[1][2]; matrix[1][2] <= data_in1;
                matrix[2][0] <= matrix[2][1]; matrix[2][1] <= matrix[2][2]; matrix[2][2] <= data_in2;
            end
            else begin
                matrix[0][0] <= matrix[0][0]; matrix[0][1] <= matrix[0][1]; matrix[0][2] <= matrix[0][2];
                matrix[1][0] <= matrix[1][0]; matrix[1][1] <= matrix[1][1]; matrix[1][2] <= matrix[1][2];
                matrix[2][0] <= matrix[2][0]; matrix[2][1] <= matrix[2][1]; matrix[2][2] <= matrix[2][2];
            end          
         end
     end  
     
     always @(posedge clk or negedge resetn) begin //Gx cal
        if(!resetn) begin //G_x kernel gen
            Gx[0][0] <= -1; Gx[0][1] <= 0; Gx[0][2] <= 1;
            Gx[1][0] <= -2; Gx[1][1] <= 0; Gx[1][2] <= 2;
            Gx[2][0] <= -1; Gx[2][1] <= 0; Gx[2][2] <= 1;          
        end
        else begin //G_x cal
            
        end
     end         
     
     always @(posedge clk or negedge resetn) begin //Gy cal
        if(!resetn) begin //G_y kernel gen
            Gy[0][0] <= -1; Gy[0][1] <= -2; Gy[0][2] <= -1;
            Gy[1][0] <=  0; Gy[1][1] <=  0; Gy[1][2] <=  0;
            Gy[2][0] <=  1; Gy[2][1] <=  2; Gy[2][2] <=  1;    
        end
        else begin //G_y cal
            
        end
     end       
     
     
    PixelSignExt Ext00( .us_pixel_8(matrix[0][0]), .s_pixel_9(ex_matrix[0][0]));     
    PixelSignExt Ext01( .us_pixel_8(matrix[0][1]), .s_pixel_9(ex_matrix[0][1]));     
    PixelSignExt Ext02( .us_pixel_8(matrix[0][2]), .s_pixel_9(ex_matrix[0][2]));     
    PixelSignExt Ext10( .us_pixel_8(matrix[1][0]), .s_pixel_9(ex_matrix[1][0]));     
    PixelSignExt Ext11( .us_pixel_8(matrix[1][1]), .s_pixel_9(ex_matrix[1][1]));     
    PixelSignExt Ext12( .us_pixel_8(matrix[1][2]), .s_pixel_9(ex_matrix[1][2]));     
    PixelSignExt Ext20( .us_pixel_8(matrix[2][0]), .s_pixel_9(ex_matrix[2][0]));     
    PixelSignExt Ext21( .us_pixel_8(matrix[2][1]), .s_pixel_9(ex_matrix[2][1]));     
    PixelSignExt Ext22( .us_pixel_8(matrix[2][2]), .s_pixel_9(ex_matrix[2][2]));
    
    SignedMult Sx00( .s_pixel_9(ex_matrix[0][0]), .s_coeff_3(Gx[0][0]), .s_mult_12(Sx[0][0]));
    SignedMult Sx01( .s_pixel_9(ex_matrix[0][1]), .s_coeff_3(Gx[0][1]), .s_mult_12(Sx[0][1]));
    SignedMult Sx02( .s_pixel_9(ex_matrix[0][2]), .s_coeff_3(Gx[0][2]), .s_mult_12(Sx[0][2]));
    SignedMult Sx10( .s_pixel_9(ex_matrix[1][0]), .s_coeff_3(Gx[1][0]), .s_mult_12(Sx[1][0]));
    SignedMult Sx11( .s_pixel_9(ex_matrix[1][1]), .s_coeff_3(Gx[1][1]), .s_mult_12(Sx[1][1]));
    SignedMult Sx12( .s_pixel_9(ex_matrix[1][2]), .s_coeff_3(Gx[1][2]), .s_mult_12(Sx[1][2]));
    SignedMult Sx20( .s_pixel_9(ex_matrix[2][0]), .s_coeff_3(Gx[2][0]), .s_mult_12(Sx[2][0]));
    SignedMult Sx21( .s_pixel_9(ex_matrix[2][1]), .s_coeff_3(Gx[2][1]), .s_mult_12(Sx[2][1]));
    SignedMult Sx22( .s_pixel_9(ex_matrix[2][2]), .s_coeff_3(Gx[2][2]), .s_mult_12(Sx[2][2]));
    
    SignedMult Sy00( .s_pixel_9(ex_matrix[0][0]), .s_coeff_3(Gy[0][0]), .s_mult_12(Sy[0][0]));
    SignedMult Sy01( .s_pixel_9(ex_matrix[0][1]), .s_coeff_3(Gy[0][1]), .s_mult_12(Sy[0][1]));
    SignedMult Sy02( .s_pixel_9(ex_matrix[0][2]), .s_coeff_3(Gy[0][2]), .s_mult_12(Sy[0][2]));
    SignedMult Sy10( .s_pixel_9(ex_matrix[1][0]), .s_coeff_3(Gy[1][0]), .s_mult_12(Sy[1][0]));
    SignedMult Sy11( .s_pixel_9(ex_matrix[1][1]), .s_coeff_3(Gy[1][1]), .s_mult_12(Sy[1][1]));
    SignedMult Sy12( .s_pixel_9(ex_matrix[1][2]), .s_coeff_3(Gy[1][2]), .s_mult_12(Sy[1][2]));
    SignedMult Sy20( .s_pixel_9(ex_matrix[2][0]), .s_coeff_3(Gy[2][0]), .s_mult_12(Sy[2][0]));
    SignedMult Sy21( .s_pixel_9(ex_matrix[2][1]), .s_coeff_3(Gy[2][1]), .s_mult_12(Sy[2][1]));
    SignedMult Sy22( .s_pixel_9(ex_matrix[2][2]), .s_coeff_3(Gy[2][2]), .s_mult_12(Sy[2][2]));
    
        // Gx 방향 합산
    AllAdd add_Sx (
        .resetn     (resetn),
        .s_in1_12   (Sx[0][0]), .s_in2_12   (Sx[0][1]), .s_in3_12   (Sx[0][2]),
        .s_in4_12   (Sx[1][0]), .s_in5_12   (Sx[1][1]), .s_in6_12   (Sx[1][2]),
        .s_in7_12   (Sx[2][0]), .s_in8_12   (Sx[2][1]), .s_in9_12   (Sx[2][2]),
        .s_out_16   (Sx_sum)      // 3x3 Gx 곱셈 누적 결과
    );

    // Gy 방향 합산
    AllAdd add_Sy (
        .resetn     (resetn),
        .s_in1_12   (Sy[0][0]), .s_in2_12   (Sy[0][1]), .s_in3_12   (Sy[0][2]),
        .s_in4_12   (Sy[1][0]), .s_in5_12   (Sy[1][1]), .s_in6_12   (Sy[1][2]),
        .s_in7_12   (Sy[2][0]), .s_in8_12   (Sy[2][1]), .s_in9_12   (Sy[2][2]),
        .s_out_16   (Sy_sum)      // 3x3 Gy 곱셈 누적 결과
    );
    
    Absolute Abs_Sx( .s_in_16(Sx_sum), .abs_in_16(Abs_Sx_sum));
    Absolute Abs_Sy( .s_in_16(Sy_sum), .abs_in_16(Abs_Sy_sum));
    
    MakePixel Pixel(.abs_in1_16(Abs_Sx_sum),.abs_in2_16(Abs_Sy_sum),.us_resultpixel_8(result_S));
    
    
endmodule
