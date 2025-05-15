module top (
    input clk,
    output tx
);
    wire reset = 0;
    wire [15:0] address;
    wire [7:0] dout;
    wire [7:0] din;
    wire mreq_n, rd_n, wr_n;

    tv80_core cpu (
        .clk(clk),
        .reset_n(~reset),
        .cen(1'b1),           // required input
        .wait_n(1'b1),
        .int_n(1'b1),
        .nmi_n(1'b1),
        .busrq_n(1'b1),
        .A(address),
        .di(din),
        .dout(dout),
        .dinst(8'h00),        // dummy instruction
        // leave unused outputs unconnected
        .m1_n(), .iorq(), .no_read(), .write(),
        .rfsh_n(), .halt_n(), .busak_n(),
        .mc(), .ts(), .intcycle_n(), .IntE(), .stop()
    );

    assign din = 8'h42;     // placeholder data input
    assign tx = address[0]; // test signal output
endmodule
