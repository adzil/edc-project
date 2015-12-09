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
    reg [7:0] dinBuff = 8'd0;

    serial_buff #(1'd1, NDATA) serialBuffInstA (
        .din (dinBuff[4]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (doutRef)
    );

    serial_buff #(1'd0, NDATA) serialBuffInstB (
        .din (dinBuff[5]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (doutSigA)
    );

    serial_buff #(1'd0, NDATA) serialBuffInstC (
        .din (dinBuff[6]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (doutSigB)
    );

    serial_buff #(1'd0, NDATA) serialBuffInstD (
        .din (dinBuff[7]),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (doutSigC)
    );

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            dinBuff <= 8'd0;
        end
        else
            if (!ena) begin
                dinBuff[7:4] <= dinBuff[3:0];
                dinBuff[3:0] <= din;
            end
    end

endmodule
