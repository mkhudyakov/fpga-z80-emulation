module uart_rx #(parameter CLK_FREQ = 12_000_000, parameter BAUD = 9600)(
    input clk,
    input rst,
    input rx,
    output reg [7:0] data_out,
    output reg data_ready
);

    localparam SAMPLE_RATE = 8;
    localparam TICKS_PER_BIT = CLK_FREQ / (BAUD * SAMPLE_RATE);
    localparam MID_SAMPLE = SAMPLE_RATE / 2;

    reg [2:0] rx_samples = 3'b111;
    wire rx_stable = (rx_samples[2] & rx_samples[1]) |
                     (rx_samples[2] & rx_samples[0]) |
                     (rx_samples[1] & rx_samples[0]);

    always @(posedge clk)
        rx_samples <= {rx_samples[1:0], rx};

    reg [$clog2(TICKS_PER_BIT)-1:0] clk_div = 0;
    wire sample_tick = (clk_div == TICKS_PER_BIT - 1);
    always @(posedge clk)
        clk_div <= sample_tick ? 0 : clk_div + 1;

    reg [3:0] bit_idx = 0;
    reg [7:0] rx_shift = 0;
    reg [2:0] sample_cnt = 0;
    reg [1:0] state = 0;

    always @(posedge clk) begin
        if (rst) begin
            state <= 0;
            data_ready <= 0;
        end else if (sample_tick) begin
            case (state)
                0: begin
                    data_ready <= 0;
                    if (!rx_stable) begin
                        sample_cnt <= 0;
                        bit_idx <= 0;
                        state <= 1;
                    end
                end

                1: begin
                    sample_cnt <= sample_cnt + 1;
                    if (sample_cnt == MID_SAMPLE) begin
                        if (!rx_stable)
                            state <= 2;
                        else
                            state <= 0;
                        sample_cnt <= 0;
                    end
                end

                2: begin
                    sample_cnt <= sample_cnt + 1;
                    if (sample_cnt == SAMPLE_RATE - 1) begin
                        rx_shift[bit_idx] <= rx_stable;
                        bit_idx <= bit_idx + 1;
                        sample_cnt <= 0;
                        if (bit_idx == 7)
                            state <= 3;
                    end
                end

                3: begin
                    sample_cnt <= sample_cnt + 1;
                    if (sample_cnt == SAMPLE_RATE - 1) begin
                        if (rx_stable) begin
                            data_out <= rx_shift;
                            data_ready <= 1;
                        end
                        state <= 0;
                        sample_cnt <= 0;
                    end
                end
            endcase
        end
    end
endmodule