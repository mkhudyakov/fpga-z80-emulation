module top(input clk, output reg led = 0);
    reg [24:0] counter = 0;

    always @(posedge clk) begin
        if (counter == 11_999_999) begin   // Every 1 second
            led <= ~led;                   // toggle the LED
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule