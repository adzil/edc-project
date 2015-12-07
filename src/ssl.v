/**
 *  Electronics Design Competition 2015
 *  Sound Source Localization
 *
 *  Top Level Design: ssl.v
 *  @brief  This module contains the top level design that will be implemented
 *          the FPGA board.
 */

`timescale 1ns/100ps

module ssl(clk, erst, din, dIdA, dIdB, dIdC);
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

    wire [NDATA_LOG-1:0] cntin;

    wire [NDATA-1:0] dinRef;
    wire [NDATA-1:0] dinSigA;
    wire [NDATA-1:0] dinSigB;
    wire [NDATA-1:0] dinSigC;


    output [NDATA_LOG-1:0] dIdA;
    output [NDATA_LOG-1:0] dIdB;
    output [NDATA_LOG-1:0] dIdC;

    /* Module declaration */
    // Master reset synchronizer module
    rst_synch #(RSTSIZE, ENASIZE) rstSynchInst (
        .clk (clk),
        .erst (erst),
        .rst (rst),
        .ena (ena)
    );

    // Master counter module
    counter #(NDATA) counterInst (
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (cntin)
    );

    // Input buffer module
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

    // Processor array module
    proc_array procArrayA (
        .dinRef (dinRef),
        .dinSig (dinSigA),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .cntin (cntin),
        .dout (dIdA)
    );

    proc_array procArrayB (
        .dinRef (dinRef),
        .dinSig (dinSigB),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .cntin (cntin),
        .dout (dIdB)
    );

    proc_array procArrayC (
        .dinRef (dinRef),
        .dinSig (dinSigC),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .cntin (cntin),
        .dout (dIdC)
    );

endmodule
