`timescale 1ns / 1ps
module memory_control #(
    parameter MEMORY_DEPTH = 100
)(
    input   wire        rst,
    input   wire        clk,
    input   wire        rx_switch,
    input   wire        tx_switch,
    output  wire        led,

    // UART RX
    input   wire [7:0]  uart_rx_data,
    input   wire        uart_rx_ready,

    // UART TX
    output  reg  [7:0]  uart_tx_data,
    input   wire        uart_tx_pop,
    output  wire        uart_tx_on,

    // Memory
    output  wire        memory_en,
    output  wire        memory_write_en,
    output  reg  [13:0] memory_addr,
    output  wire [7:0]  memory_data_in,
    input   wire [7:0]  memory_data_out
);

    reg [13:0] rx_counter;
    reg [13:0] tx_counter;
    reg led_reg;
    reg read_delay;
    reg memory_en_reg;
    reg memory_write_en_reg;
    reg [7:0] memory_data_in_reg;
    reg uart_tx_on_reg;

    assign memory_en = memory_en_reg;
    assign memory_write_en = memory_write_en_reg;
    assign memory_data_in = memory_data_in_reg;
    assign uart_tx_on = uart_tx_on_reg;
    assign led = led_reg;

    wire uart_rx_ready_edge;
    posedge_detector pd_rx_ready (
        .clk(clk),
        .rst(rst),
        .in(uart_rx_ready),
        .out(uart_rx_ready_edge)
    );
    
    wire uart_tx_pop_edge;
    posedge_detector pd_tx_pop (
        .clk(clk),
        .rst(rst),
        .in(uart_tx_pop),
        .out(uart_tx_pop_edge)
    );

    reg [1:0] state;
    localparam IDLE = 2'b00, RX   = 2'b01, TX   = 2'b10;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            read_delay <= 0;
            led_reg <= 0;
            rx_counter <= 0;
            tx_counter <= 0;
            
            memory_en_reg <= 0;
            memory_write_en_reg <= 0;
            memory_addr <= 0;
            memory_data_in_reg <= 0;
            
            uart_tx_data <= 0;
            uart_tx_on_reg <= 0;
            
            state <= IDLE;
        end
        else begin
            case (state)
                IDLE: begin
                    memory_en_reg <= 0;
                    memory_write_en_reg <= 0;
                    uart_tx_on_reg <= 0;

                    if (rx_switch) begin
                        memory_en_reg <= 1;
                        memory_write_en_reg <= 1;
                        rx_counter <= 0;
                        state <= RX;
                    end
                end

                RX: begin
                    if (uart_rx_ready_edge && (rx_counter < MEMORY_DEPTH)) begin
                        memory_addr <= rx_counter;
                        rx_counter <= rx_counter + 1;
                        memory_data_in_reg <= uart_rx_data;
                    end
                    if (rx_counter == MEMORY_DEPTH) begin
                            led_reg  <= 1;
                        end
                    if (tx_switch && led_reg) begin
                        tx_counter <= 0;
                        memory_write_en_reg <= 0;
                        state <= TX;
                    end
                end

            TX: begin
                if (tx_counter < MEMORY_DEPTH + 1) begin
                    uart_tx_on_reg <= 1;
                    memory_addr <= tx_counter;

                    if (uart_tx_pop_edge && !read_delay) begin
                        read_delay <= 1;
                    end
                    else if (read_delay) begin
                        uart_tx_data <= memory_data_out;
                        tx_counter <= tx_counter + 1;
                        read_delay <= 0;
                    end
                end
                else begin
                    uart_tx_on_reg <= 0;
                end
            end
            endcase
        end
    end
endmodule
