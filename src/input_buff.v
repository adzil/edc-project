/**
 *  Input buffer
 *
 */

`timescale 1ns/100ps

module input_buff(  din, cntin, clk, rst, ena,
                    doutRef, doutSigA, doutSigB, doutSigC);
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);

    input [3:0] din;
    input [NDATA_LOG-1:0] cntin;

    input clk;
    input rst;
    input ena;

    output [NDATA-1:0] doutRef;
    output [NDATA-1:0] doutSigA;
    output [NDATA-1:0] doutSigB;
    output [NDATA-1:0] doutSigC;

    // Data input buffer to improve stability with different clock
    reg [3:0] dinBuff [0:1] = {4'd0, 4'd0};

    serial_buff #(1'd1, NDATA) serialBuffInstA (
        .din (dinBuff[1][0]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (doutRef)
    );

    serial_buff #(1'd0, NDATA) serialBuffInstB (
        .din (dinBuff[1][1]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (doutSigA)
    );

    serial_buff #(1'd0, NDATA) serialBuffInstC (
        .din (dinBuff[1][2]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (doutSigB)
    );

    serial_buff #(1'd0, NDATA) serialBuffInstD (
        .din (dinBuff[1][3]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (doutSigC)
    );

    always @ (posedge clk or negedge rst) begin
        if (!rst)
            dinBuff <= {4'd0, 4'd0};
        else
            if (!ena) begin
                dinBuff[1] <= dinBuff[0];
                dinBuff[0] <= din;
            end
    end

endmodule
