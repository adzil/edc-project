/**
 *  Electronics Design Competition 2015
 *  Sound Source Localization
 *
 *  Top Level Design: ssl.v
 *  @brief  This module contains the top level design that will be implemented
 *          the FPGA board.
 */

`timescale 1ns/100ps

module ssl(clk, erst, din);
    /* Parameter declaration */
    parameter RSTSIZE = 4;
    parameter ENASIZE = 2;
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    /* Input/output declaration */
    input clk;
    input erst;
    input [3:0] din;

    /* Global control wire declaration */
    wire rst;
    wire ena;

    /* Module declaration */
    // Master reset synchronizer module
    rst_synch #(RSTSIZE, ENASIZE) rstSynchInst (
        .clk (clk),
        .erst (erst),
        .rst (rst),
        .ena (ena)
    );

    wire [NDATA_LOG-1:0] cntin;

    counter #(NDATA) counterInst (
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (cntin)
    );

    // Input buffer module
    wire [NDATA-1:0] dinRef;
    wire [NDATA-1:0] dinSigA;
    wire [NDATA-1:0] dinSigB;
    wire [NDATA-1:0] dinSigC;

    input_buff #(NDATA) inputBuffInst (
        .din (din),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .doutRef (dinRef),
        .doutSigA (dinSigA),
        .doutSigB (dinSigB),
        .doutSigC (dinSigC)
    );

endmodule
