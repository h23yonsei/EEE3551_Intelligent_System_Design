`timescale 1ns / 1ps
module conv1 #(
    parameter IMG_WIDTH     =   28,
    parameter IMG_HEIGHT    =   3 * 28,
    parameter OUT_WIDTH     =   26,
    parameter OUT_HEIGHT    =   3 * 26,
    parameter OUT_DEPTH     =   OUT_WIDTH * OUT_HEIGHT
)(
    input  wire clk,
    input  wire resetn,
    input  wire valid_in,

    input  wire [7:0] image_bram_dout,
    input  wire [7:0] filter_bram_dout,
    input wire  [6:0] filter_bram_addr,

    output reg valid_out,
    output wire [7:0] out_data0,
    output wire [7:0] out_data1,
    output wire [7:0] out_data2,
    output wire [7:0] out_data3,
    output wire [7:0] out_data4,
    output wire [7:0] out_data5,
    output wire [7:0] out_data6,
    output wire [7:0] out_data7,

    output reg done
);

    wire slide_is_full;
    wire slide_is_valid;
    wire [7:0] dout0, dout1, dout2, dout3, dout4, dout5, dout6, dout7, dout8;

    conv_slide_reg slide0 (
        .clk(clk), .resetn(resetn), .en(valid_in), .din(image_bram_dout),
        
        .is_full(slide_is_full), .is_valid(slide_is_valid),
        .dout0(dout0), .dout1(dout1), .dout2(dout2),
        .dout3(dout3), .dout4(dout4), .dout5(dout5),
        .dout6(dout6), .dout7(dout7), .dout8(dout8)
    );

    wire [7:0] w [0:71];
    wire signed [7:0] r0, r1, r2, r3, r4, r5, r6, r7;

    assign out_data0 = r0;
    assign out_data1 = r1;
    assign out_data2 = r2;
    assign out_data3 = r3;
    assign out_data4 = r4;
    assign out_data5 = r5;
    assign out_data6 = r6;
    assign out_data7 = r7;

    filter_window fw0 (.clk(clk), .resetn(resetn), .en(filter_bram_addr > 0  && filter_bram_addr <= 9),    .data_in(filter_bram_dout), .weight0(w[0]),  .weight1(w[1]),  .weight2(w[2]),  .weight3(w[3]),  .weight4(w[4]),  .weight5(w[5]),  .weight6(w[6]),  .weight7(w[7]),  .weight8(w[8]));
    filter_window fw1 (.clk(clk), .resetn(resetn), .en(filter_bram_addr > 9  && filter_bram_addr <= 18),  .data_in(filter_bram_dout), .weight0(w[9]),  .weight1(w[10]), .weight2(w[11]), .weight3(w[12]), .weight4(w[13]), .weight5(w[14]), .weight6(w[15]), .weight7(w[16]), .weight8(w[17]));
    filter_window fw2 (.clk(clk), .resetn(resetn), .en(filter_bram_addr > 18 && filter_bram_addr <= 27), .data_in(filter_bram_dout), .weight0(w[18]), .weight1(w[19]), .weight2(w[20]), .weight3(w[21]), .weight4(w[22]), .weight5(w[23]), .weight6(w[24]), .weight7(w[25]), .weight8(w[26]));
    filter_window fw3 (.clk(clk), .resetn(resetn), .en(filter_bram_addr > 27 && filter_bram_addr <= 36), .data_in(filter_bram_dout), .weight0(w[27]), .weight1(w[28]), .weight2(w[29]), .weight3(w[30]), .weight4(w[31]), .weight5(w[32]), .weight6(w[33]), .weight7(w[34]), .weight8(w[35]));
    filter_window fw4 (.clk(clk), .resetn(resetn), .en(filter_bram_addr > 36 && filter_bram_addr <= 45), .data_in(filter_bram_dout), .weight0(w[36]), .weight1(w[37]), .weight2(w[38]), .weight3(w[39]), .weight4(w[40]), .weight5(w[41]), .weight6(w[42]), .weight7(w[43]), .weight8(w[44]));
    filter_window fw5 (.clk(clk), .resetn(resetn), .en(filter_bram_addr > 45 && filter_bram_addr <= 54), .data_in(filter_bram_dout), .weight0(w[45]), .weight1(w[46]), .weight2(w[47]), .weight3(w[48]), .weight4(w[49]), .weight5(w[50]), .weight6(w[51]), .weight7(w[52]), .weight8(w[53]));
    filter_window fw6 (.clk(clk), .resetn(resetn), .en(filter_bram_addr > 54 && filter_bram_addr <= 63), .data_in(filter_bram_dout), .weight0(w[54]), .weight1(w[55]), .weight2(w[56]), .weight3(w[57]), .weight4(w[58]), .weight5(w[59]), .weight6(w[60]), .weight7(w[61]), .weight8(w[62]));
    filter_window fw7 (.clk(clk), .resetn(resetn), .en(filter_bram_addr > 63 && filter_bram_addr <= 72), .data_in(filter_bram_dout), .weight0(w[63]), .weight1(w[64]), .weight2(w[65]), .weight3(w[66]), .weight4(w[67]), .weight5(w[68]), .weight6(w[69]), .weight7(w[70]), .weight8(w[71]));

    conv1_math mm0 (.pixel0(dout0), .pixel1(dout1), .pixel2(dout2), .pixel3(dout3), .pixel4(dout4), .pixel5(dout5), .pixel6(dout6), .pixel7(dout7), .pixel8(dout8), .weight0(w[0]),  .weight1(w[1]),  .weight2(w[2]),  .weight3(w[3]),  .weight4(w[4]),  .weight5(w[5]),  .weight6(w[6]),  .weight7(w[7]),  .weight8(w[8]),  .result(r0));
    conv1_math mm1 (.pixel0(dout0), .pixel1(dout1), .pixel2(dout2), .pixel3(dout3), .pixel4(dout4), .pixel5(dout5), .pixel6(dout6), .pixel7(dout7), .pixel8(dout8), .weight0(w[9]),  .weight1(w[10]), .weight2(w[11]), .weight3(w[12]), .weight4(w[13]), .weight5(w[14]), .weight6(w[15]), .weight7(w[16]), .weight8(w[17]), .result(r1));
    conv1_math mm2 (.pixel0(dout0), .pixel1(dout1), .pixel2(dout2), .pixel3(dout3), .pixel4(dout4), .pixel5(dout5), .pixel6(dout6), .pixel7(dout7), .pixel8(dout8), .weight0(w[18]), .weight1(w[19]), .weight2(w[20]), .weight3(w[21]), .weight4(w[22]), .weight5(w[23]), .weight6(w[24]), .weight7(w[25]), .weight8(w[26]), .result(r2));
    conv1_math mm3 (.pixel0(dout0), .pixel1(dout1), .pixel2(dout2), .pixel3(dout3), .pixel4(dout4), .pixel5(dout5), .pixel6(dout6), .pixel7(dout7), .pixel8(dout8), .weight0(w[27]), .weight1(w[28]), .weight2(w[29]), .weight3(w[30]), .weight4(w[31]), .weight5(w[32]), .weight6(w[33]), .weight7(w[34]), .weight8(w[35]), .result(r3));
    conv1_math mm4 (.pixel0(dout0), .pixel1(dout1), .pixel2(dout2), .pixel3(dout3), .pixel4(dout4), .pixel5(dout5), .pixel6(dout6), .pixel7(dout7), .pixel8(dout8), .weight0(w[36]), .weight1(w[37]), .weight2(w[38]), .weight3(w[39]), .weight4(w[40]), .weight5(w[41]), .weight6(w[42]), .weight7(w[43]), .weight8(w[44]), .result(r4));
    conv1_math mm5 (.pixel0(dout0), .pixel1(dout1), .pixel2(dout2), .pixel3(dout3), .pixel4(dout4), .pixel5(dout5), .pixel6(dout6), .pixel7(dout7), .pixel8(dout8), .weight0(w[45]), .weight1(w[46]), .weight2(w[47]), .weight3(w[48]), .weight4(w[49]), .weight5(w[50]), .weight6(w[51]), .weight7(w[52]), .weight8(w[53]), .result(r5));
    conv1_math mm6 (.pixel0(dout0), .pixel1(dout1), .pixel2(dout2), .pixel3(dout3), .pixel4(dout4), .pixel5(dout5), .pixel6(dout6), .pixel7(dout7), .pixel8(dout8), .weight0(w[54]), .weight1(w[55]), .weight2(w[56]), .weight3(w[57]), .weight4(w[58]), .weight5(w[59]), .weight6(w[60]), .weight7(w[61]), .weight8(w[62]), .result(r6));
    conv1_math mm7 (.pixel0(dout0), .pixel1(dout1), .pixel2(dout2), .pixel3(dout3), .pixel4(dout4), .pixel5(dout5), .pixel6(dout6), .pixel7(dout7), .pixel8(dout8), .weight0(w[63]), .weight1(w[64]), .weight2(w[65]), .weight3(w[66]), .weight4(w[67]), .weight5(w[68]), .weight6(w[69]), .weight7(w[70]), .weight8(w[71]), .result(r7));

    reg [10:0] output_count;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            output_count <= 0;
            done <= 0;
            valid_out <= 0;
        end
        else begin
            if (slide_is_valid && slide_is_full && output_count < OUT_DEPTH) begin
                valid_out <= 1;
                output_count <= output_count + 1;
            end
            else begin
                valid_out <= 0;
            end

            if (output_count == OUT_DEPTH) begin
                done <= 1;
                output_count <= 0;
            end
            else
                done <= 0;
        end
    end

endmodule
