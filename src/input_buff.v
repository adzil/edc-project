/**
 *  Input buffer
 *
 */

`timescale 1ns/100ps

module input_buff(din, cntin, clk, rst, ena, dout0, dout1, dout2, dout3);
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);

    input [3:0] din;
    input [NDATA_LOG-1:0] cntin;

    input clk;
    input rst;
    input ena;

    output [NDATA-1:0] dout0;
    output [NDATA-1:0] dout1;
    output [NDATA-1:0] dout2;
    output [NDATA-1:0] dout3;

    serial_buff #(1'd1, NDATA) serialBuffInst0 (
        .din (din[0]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (dout0)
    );

    serial_buff #(1'd0, NDATA) serialBuffInst1 (
        .din (din[1]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (dout1)
    );

    serial_buff #(1'd0, NDATA) serialBuffInst2 (
        .din (din[2]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (dout2)
    );

    serial_buff #(1'd0, NDATA) serialBuffInst3 (
        .din (din[3]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (dout3)
    );

endmodule
