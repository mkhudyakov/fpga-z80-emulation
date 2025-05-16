module uart_tx #(parameter CLKS_PER_BIT = 1250)(
    input clk,
    input rst,
    input tx_start,
    input [7:0] data_in,
    output reg tx = 1'b1,
    output reg busy = 0
);

    reg [9:0] shift = 10'b1111111111;
    reg [3:0] bit_idx = 0;
    reg [15:0] clk_cnt = 0;
    reg tx_active = 0;

    always @(posedge clk) begin
        if (rst) begin
            tx <= 1'b1;
            busy <= 0;
            tx_active <= 0;
        end else begin
            if (!tx_active) begin
                if (tx_start) begin
                    shift <= {1'b1, data_in, 1'b0};  // stop, data[7:0], start
                    tx_active <= 1;
                    bit_idx <= 0;
                    clk_cnt <= 0;
                    busy <= 1;
                end
            end else begin
                clk_cnt <= clk_cnt + 1;
                if (clk_cnt == CLKS_PER_BIT - 1) begin
                    clk_cnt <= 0;
                    tx <= shift[bit_idx];
                    bit_idx <= bit_idx + 1;

                    if (bit_idx == 9) begin
                        tx_active <= 0;
                        busy <= 0;
                        tx <= 1'b1;
                    end
                end
            end
        end
    end
endmodule