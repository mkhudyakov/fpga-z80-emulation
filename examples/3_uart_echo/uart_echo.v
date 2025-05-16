module uart_echo (
    input clk,             // 12 MHz clock
    input uart_rx_i,       // UART RX input
    output uart_tx_o,      // UART TX output
    output reg LED         // Blinks on valid RX
);

    wire [7:0] rx_data;
    wire rx_ready;
    reg tx_start = 0;
    reg [7:0] tx_data;
    wire tx_busy;

    // Blink control
    reg [23:0] blink_timer = 0;
    reg blink = 0;

    // TX state latch
    reg sending = 0;

    // Instantiate RX (oversampled)
    uart_rx #(.CLK_FREQ(12_000_000), .BAUD(9600)) uart_rx_inst (
        .clk(clk),
        .rst(1'b0),
        .rx(uart_rx_i),
        .data_out(rx_data),
        .data_ready(rx_ready)
    );

    // Instantiate TX (standard FSM)
    uart_tx #(.CLKS_PER_BIT(1250)) uart_tx_inst (
        .clk(clk),
        .rst(1'b0),
        .tx_start(tx_start),
        .data_in(tx_data),
        .tx(uart_tx_o),
        .busy(tx_busy)
    );

    // Echo FSM
    always @(posedge clk) begin
        tx_start <= 0;

        if (rx_ready && !sending) begin
            tx_data <= rx_data;
            tx_start <= 1;
            sending <= 1;
            blink <= 1;
            blink_timer <= 0;
        end

        if (sending && !tx_busy) begin
            sending <= 0;
        end

        if (blink) begin
            blink_timer <= blink_timer + 1;
            if (blink_timer > 1_000_000)
                blink <= 0;
        end

        LED <= blink;
    end

endmodule