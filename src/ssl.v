/**
 *  Electronics Design Competition 2015
 *  Sound Source Localization
 *
 *  Top Level Design: ssl.v
 *  @brief  This module contains the top level design that will be implemented
 *          the FPGA board.
 */

`timescale 1ns/100ps

module ssl(eclk, erst, din, dIdA, dIdB, dIdC, dSsA);//, dSsB, dSsC);
    /* Parameter declaration */
    parameter RSTSIZE = 4;
    parameter ENASIZE = 2;
    parameter DIV = 50;
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    /* Input/output declaration */
    input eclk;
    input erst;
    input [3:0] din;

    output [NDATA_LOG-1:0] dIdA;
    output [NDATA_LOG-1:0] dIdB;
    output [NDATA_LOG-1:0] dIdC;
    output [20:0] dSsA;
    //output [20:0] dSsB;
    //output [20:0] dSsC;

    /* Global control wire declaration */
    wire frst;
    wire fena;
    wire clk;
    wire rst;
    wire ena;

    wire [NDATA_LOG-1:0] cntin;

    wire [NDATA-1:0] dinRef;
    wire [NDATA-1:0] dinSigA;
    wire [NDATA-1:0] dinSigB;
    wire [NDATA-1:0] dinSigC;

    /* Module declaration */
    // Master reset synchronizer module
    rst_synch #(RSTSIZE, ENASIZE) rstSynchInstA (
        .clk (eclk),
        .erst (erst),
        .rst (frst),
        .ena (fena)
    );

    // Clock division module
    clkdiv #(DIV) clkdivInst (
        .clk (eclk),
        .rst(frst),
        .ena(fena),
        .clkout (clk)
    );

    // Slow clock synchronizer module
    rst_synch #(RSTSIZE, ENASIZE) rstSynchInstB (
        .clk (clk),
        .erst (frst),
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
    proc_array #(NDATA) procArrayA (
        .dinRef (dinRef),
        .dinSig (dinSigA),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .cntin (cntin),
        .dout (dIdA)
    );

    proc_array #(NDATA) procArrayB (
        .dinRef (dinRef),
        .dinSig (dinSigB),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .cntin (cntin),
        .dout (dIdB)
    );

    proc_array #(NDATA) procArrayC (
        .dinRef (dinRef),
        .dinSig (dinSigC),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .cntin (cntin),
        .dout (dIdC)
    );

    output_proc #(NDATA) outputProcA (
        .din (dIdA),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .cntin (cntin),
        .dout (dSsA)
    );



endmodule
