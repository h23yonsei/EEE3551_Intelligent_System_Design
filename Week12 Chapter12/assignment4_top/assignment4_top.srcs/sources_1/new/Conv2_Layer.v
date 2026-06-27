`timescale 1ns / 1ps

module Conv2_Layer#(
    parameter OUT_WIDTH     =   24,
    parameter OUT_HEIGHT    =   3 * OUT_WIDTH,
    parameter OUT_DEPTH     =   OUT_WIDTH * OUT_HEIGHT
)(
    input  wire clk,
    input  wire resetn,
    input  wire valid_in,

    input  wire signed [7:0] image_bram_dout_0,
    input  wire signed[7:0] image_bram_dout_1,
    input  wire signed[7:0] image_bram_dout_2,
    input  wire signed[7:0] image_bram_dout_3,
    input  wire signed[7:0] image_bram_dout_4,
    input  wire signed[7:0] image_bram_dout_5,
    input  wire signed[7:0] image_bram_dout_6,
    input  wire signed[7:0] image_bram_dout_7,
    
    input  wire signed[7:0] filter_bram_dout,

    output reg [2:0] SRAM_CONV2_RESULT_wea,
    output wire [23:0] ext_conv2_result,
    
    
    output wire valid_out,
    output wire done

    /*,
    
    output wire [7:0] check_dout0,
    output reg [3:0] input_filter_ch,
    output wire check_weight_valid,
    output  wire signed [7:0] check_r,
    output reg [10:0] output_count*/
);
    //------------------------WEIGHT---------------------------------------
    wire signed [7:0]  w[0:71];
    reg [3:0] filter_element_counter;
    reg [3:0] input_filter_ch;
    reg done_ff;
    
    always @(posedge clk or negedge resetn) begin
        if(!resetn)                                 filter_element_counter <= 4'd0;
        else begin
            if(valid_in && !done_ff) begin
                if(filter_element_counter == 4'd8)  filter_element_counter <= 4'd0;
                else                                filter_element_counter <= filter_element_counter + 4'd1;
            end                                     
            else                                    filter_element_counter <= 4'd0;
        end
    end
    
    always @(posedge clk or negedge resetn) begin
        if(!resetn)                                     input_filter_ch <= 4'd0;
        else begin
            if(valid_in && !done_ff) begin
                if(filter_element_counter == 4'd8) begin
                    if(input_filter_ch == 4'd8)         input_filter_ch <= input_filter_ch;
                    else                                input_filter_ch <= input_filter_ch + 1;
                end
                else                                    input_filter_ch <= input_filter_ch;
            end
            else                                        input_filter_ch <= 4'd0;
        end
    end
                
    filter_window fw0 (
        .clk(clk), .resetn(resetn),
        .en((input_filter_ch == 4'd0) && valid_in),
        .data_in(filter_bram_dout),
        .weight0(w[0]),  .weight1(w[1]),  .weight2(w[2]),
        .weight3(w[3]),  .weight4(w[4]),  .weight5(w[5]),
        .weight6(w[6]),  .weight7(w[7]),  .weight8(w[8])
    );
    
    filter_window fw1 (
        .clk(clk), .resetn(resetn),
        .en((input_filter_ch == 4'd1) && valid_in),
        .data_in(filter_bram_dout),
        .weight0(w[9]),  .weight1(w[10]), .weight2(w[11]),
        .weight3(w[12]), .weight4(w[13]), .weight5(w[14]),
        .weight6(w[15]), .weight7(w[16]), .weight8(w[17])
    );
    
    filter_window fw2 (
        .clk(clk), .resetn(resetn),
        .en((input_filter_ch == 4'd2) && valid_in),
        .data_in(filter_bram_dout),
        .weight0(w[18]), .weight1(w[19]), .weight2(w[20]),
        .weight3(w[21]), .weight4(w[22]), .weight5(w[23]),
        .weight6(w[24]), .weight7(w[25]), .weight8(w[26])
    );
    
    filter_window fw3 (
        .clk(clk), .resetn(resetn),
        .en((input_filter_ch == 4'd3) && valid_in),
        .data_in(filter_bram_dout),
        .weight0(w[27]), .weight1(w[28]), .weight2(w[29]),
        .weight3(w[30]), .weight4(w[31]), .weight5(w[32]),
        .weight6(w[33]), .weight7(w[34]), .weight8(w[35])
    );
    
    filter_window fw4 (
        .clk(clk), .resetn(resetn),
        .en((input_filter_ch == 4'd4) && valid_in),
        .data_in(filter_bram_dout),
        .weight0(w[36]), .weight1(w[37]), .weight2(w[38]),
        .weight3(w[39]), .weight4(w[40]), .weight5(w[41]),
        .weight6(w[42]), .weight7(w[43]), .weight8(w[44])
    );
    
    filter_window fw5 (
        .clk(clk), .resetn(resetn),
        .en((input_filter_ch == 4'd5) && valid_in),
        .data_in(filter_bram_dout),
        .weight0(w[45]), .weight1(w[46]), .weight2(w[47]),
        .weight3(w[48]), .weight4(w[49]), .weight5(w[50]),
        .weight6(w[51]), .weight7(w[52]), .weight8(w[53])
    );
    
    filter_window fw6 (
        .clk(clk), .resetn(resetn),
        .en((input_filter_ch == 4'd6) && valid_in),
        .data_in(filter_bram_dout),
        .weight0(w[54]), .weight1(w[55]), .weight2(w[56]),
        .weight3(w[57]), .weight4(w[58]), .weight5(w[59]),
        .weight6(w[60]), .weight7(w[61]), .weight8(w[62])
    );
    
    filter_window fw7 (
        .clk(clk), .resetn(resetn),
        .en((input_filter_ch == 4'd7) && valid_in),
        .data_in(filter_bram_dout),
        .weight0(w[63]), .weight1(w[64]), .weight2(w[65]),
        .weight3(w[66]), .weight4(w[67]), .weight5(w[68]),
        .weight6(w[69]), .weight7(w[70]), .weight8(w[71])
    );
     //------------------------------------------------------------------------
    
    //-------------------------DATA-------------------------------------------
    wire slide_is_full[0:7];
    wire all_slide_is_full;
    assign all_slide_is_full = 
    slide_is_full[0] && slide_is_full[1] &&
    slide_is_full[2] && slide_is_full[3] &&
    slide_is_full[4] && slide_is_full[5] &&
    slide_is_full[6] && slide_is_full[7];

    wire slide_is_valid[0:7];
    wire all_slide_is_valid;
    assign all_slide_is_valid = 
    slide_is_valid[0] && slide_is_valid[1] &&
    slide_is_valid[2] && slide_is_valid[3] &&
    slide_is_valid[4] && slide_is_valid[5] &&
    slide_is_valid[6] && slide_is_valid[7];
    wire signed [7:0] dout0[0:7], dout1[0:7], dout2[0:7], dout3[0:7], dout4[0:7], dout5[0:7], dout6[0:7], dout7[0:7], dout8[0:7];
    
    wire signed [7:0] conv2_result;

    wire signed [7:0] image_bram_dout [0:7];
    
    assign image_bram_dout[0] = image_bram_dout_0;
    assign image_bram_dout[1] = image_bram_dout_1;
    assign image_bram_dout[2] = image_bram_dout_2;
    assign image_bram_dout[3] = image_bram_dout_3;
    assign image_bram_dout[4] = image_bram_dout_4;
    assign image_bram_dout[5] = image_bram_dout_5;
    assign image_bram_dout[6] = image_bram_dout_6;
    assign image_bram_dout[7] = image_bram_dout_7;
    
    always @(posedge clk or negedge resetn) begin
        if(!resetn) done_ff <= 1'd0;
        else done_ff <= done;
    end
    
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_slide
            conv_slide_reg#(
                .INPUT_WIDTH(26),
                .OUTPUT_WIDTH(24),
                .REG_DEPTH(78)
                ) slide(
                .clk(clk),
                .resetn(resetn),
                .en(valid_in && !done_ff),
                .din(image_bram_dout[i]),
    
                .is_full(slide_is_full[i]),   // ??  ?   ? slide_is_full[i]  ? ?  ??  ?   ?
                .is_valid(slide_is_valid[i]), // ??  ?   ? slide_is_valid[i]  ? ?  ??  ?   ?
    
                .dout0(dout0[i]), .dout1(dout1[i]), .dout2(dout2[i]),
                .dout3(dout3[i]), .dout4(dout4[i]), .dout5(dout5[i]),
                .dout6(dout6[i]), .dout7(dout7[i]), .dout8(dout8[i])
            );
        end
    endgenerate
    //------------------------------------------------------------------
    //assign check_dout0 = w[1]; 
    
    //----------------------------CONV-----------------------------------    
    wire signed [19:0] r[0:7];
    wire signed [23:0] sum;
    //assign check_r = r[0];

    assign sum = r[0] + r[1] + r[2] + r[3] + r[4] + r[5] + r[6] + r[7];
    
    genvar j;
    generate
        for (j = 0; j < 8; j = j + 1) begin : gen_math
            conv2_math_module mm (
                .pixel0(dout0[j]), .pixel1(dout1[j]), .pixel2(dout2[j]),
                .pixel3(dout3[j]), .pixel4(dout4[j]), .pixel5(dout5[j]),
                .pixel6(dout6[j]), .pixel7(dout7[j]), .pixel8(dout8[j]),
    
                .weight0(w[9*j + 0]), .weight1(w[9*j + 1]), .weight2(w[9*j + 2]),
                .weight3(w[9*j + 3]), .weight4(w[9*j + 4]), .weight5(w[9*j + 5]),
                .weight6(w[9*j + 6]), .weight7(w[9*j + 7]), .weight8(w[9*j + 8]),
    
                .result(r[j])
            );
        end
    endgenerate
    
    wire signed [7:0] relu_result;
    RELU #(
        .data_in_width(24)  // sum[]??   ?     ? (    : 14:0)
    ) relu_inst (
        .data_in(sum),
        .data_out(relu_result)
    );
    
    assign conv2_result  = (all_slide_is_valid && all_slide_is_full && (output_count < OUT_DEPTH)) ? relu_result: 0;
    
    assign ext_conv2_result  = (SRAM_CONV2_RESULT_wea == 3'b001) ? {16'd0, conv2_result} :
                         (SRAM_CONV2_RESULT_wea == 3'b010) ? {8'd0, conv2_result, 8'd0} :
                         (SRAM_CONV2_RESULT_wea == 3'b100) ? {conv2_result, 16'd0} :
                         24'd0;
    //-----------------------------------------------------------------------------------------
    
    //-----------------------------Control signal-------------------------------------------
    
    reg [10:0] output_count;
    assign valid_out = all_slide_is_valid && all_slide_is_full && (output_count < OUT_DEPTH);
    assign done = (output_count == OUT_DEPTH);
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            output_count <= 0;
            //done <= 0;
            //valid_out <= 0;
        end
        else begin
            if (all_slide_is_valid && all_slide_is_full && (output_count < OUT_DEPTH)) begin
                //valid_out <= 1;
                output_count <= output_count + 1;
            end
            else begin
                //valid_out <= 0;
            end

            if (output_count == OUT_DEPTH) begin
                //done <= 1;
                output_count <= 0;
            end
            else begin end
                //done <= 0;
        end
    end
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            SRAM_CONV2_RESULT_wea <= 3'b000;
        else begin
            if(valid_in) begin
                if (output_count < OUT_WIDTH * OUT_WIDTH - 1)
                    SRAM_CONV2_RESULT_wea <= 3'b001;
                else if ((output_count >= OUT_WIDTH * OUT_WIDTH - 1) &&
                         (output_count < 2 * OUT_WIDTH * OUT_WIDTH - 1))
                    SRAM_CONV2_RESULT_wea <= 3'b010;
                else if ((output_count >= 2 * OUT_WIDTH * OUT_WIDTH - 1) &&
                         (output_count < 3 * OUT_WIDTH * OUT_WIDTH - 1 ))
                    SRAM_CONV2_RESULT_wea <= 3'b100;
                else
                    SRAM_CONV2_RESULT_wea <= 3'b000;  // default case for safety
            end
            else SRAM_CONV2_RESULT_wea <= 3'b000;
        end
    end
    //------------------------------------------------------------------------------------

endmodule

