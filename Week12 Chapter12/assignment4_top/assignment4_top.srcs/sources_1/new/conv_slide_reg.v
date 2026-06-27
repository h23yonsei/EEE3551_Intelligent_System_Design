module conv_slide_reg #(
    parameter INPUT_WIDTH   =   28,
    parameter INPUT_HEIGHT  =   3*INPUT_WIDTH,  // = 84
    parameter OUTPUT_WIDTH  =   26,
    parameter OUTPUT_HEIGHT =   3*OUTPUT_WIDTH, // = 78
    parameter REG_DEPTH     =   72              // FIXED
)(
    input  wire clk,
    input  wire resetn,
    input  wire en,
    input  wire [7:0] din,

    output reg is_full,
    output wire is_valid,

    output reg [7:0] dout0,
    output reg [7:0] dout1,
    output reg [7:0] dout2,
    output reg [7:0] dout3,
    output reg [7:0] dout4,
    output reg [7:0] dout5,
    output reg [7:0] dout6,
    output reg [7:0] dout7,
    output reg [7:0] dout8
);

    // main register
    reg [7:0] shift_reg [0:REG_DEPTH-1];
    
    integer i;
    
    // counters and pointers
    reg [$clog2(REG_DEPTH+1):0] din_counter = 0;
    reg [$clog2(INPUT_WIDTH):0] col_pointer = 0;
    reg [$clog2(INPUT_HEIGHT):0] row_pointer = 0;

    // shift and count pixels
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            for (i = 0; i < REG_DEPTH; i = i + 1)
                shift_reg[i] <= 8'd0;
            din_counter <= 0;
            col_pointer <= 0;
            row_pointer <= 0;
            is_full <= 0;
        end
        else if (en) begin
            // always shifting
            for (i = 0; i < REG_DEPTH - 1; i = i + 1)
                shift_reg[i] <= shift_reg[i + 1];
            // inputs data to last slot
            shift_reg[REG_DEPTH - 1] <= din;
            // before full, manage data counter
            if (!is_full) begin
            // count each new data
                din_counter <= din_counter + 1;
                if (din_counter == REG_DEPTH - 1)
                    is_full <= 1;
            end
            // after full, manage pointers
            if (is_full) begin
                if (col_pointer < INPUT_WIDTH - 1)
                    col_pointer <= col_pointer + 1;
                else if (col_pointer == INPUT_WIDTH -1) begin
                    col_pointer <= 0;
                    if (row_pointer < INPUT_HEIGHT - 1)
                        row_pointer <= row_pointer + 1;
                end
            end
        end
        else begin
            for (i = 0; i < REG_DEPTH; i = i + 1)
                shift_reg[i] <= 8'd0;
            din_counter <= 0;
            col_pointer <= 0;
            row_pointer <= 0;
            is_full <= 0;
        end
    end

    // manage is_valid
    assign is_valid = !((!is_full) || 
                    (col_pointer > OUTPUT_WIDTH - 1) || 
                    (row_pointer == (INPUT_HEIGHT/3) - 2) || 
                    (row_pointer == (INPUT_HEIGHT/3) - 1) || 
                    (row_pointer == (INPUT_HEIGHT*2/3) - 2) || 
                    (row_pointer == (INPUT_HEIGHT*2/3) - 1) || 
                    (row_pointer == INPUT_HEIGHT - 2) || 
                    (row_pointer == INPUT_HEIGHT - 1));

    // Extract 3x3 window from shift register
    always @(*) begin
        if (is_valid) begin
            dout0 = shift_reg[INPUT_WIDTH * 0 + 0];
            dout1 = shift_reg[INPUT_WIDTH * 0 + 1];
            dout2 = shift_reg[INPUT_WIDTH * 0 + 2];

            dout3 = shift_reg[INPUT_WIDTH * 1 + 0];
            dout4 = shift_reg[INPUT_WIDTH * 1 + 1];
            dout5 = shift_reg[INPUT_WIDTH * 1 + 2];

            dout6 = shift_reg[INPUT_WIDTH * 2 + 0];
            dout7 = shift_reg[INPUT_WIDTH * 2 + 1];
            dout8 = shift_reg[INPUT_WIDTH * 2 + 2];
        end
        else begin
            dout0 = 0; dout1 = 0; dout2 = 0;
            dout3 = 0; dout4 = 0; dout5 = 0;
            dout6 = 0; dout7 = 0; dout8 = 0;
        end
    end

endmodule



