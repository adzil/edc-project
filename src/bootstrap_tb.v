/**
 *  Bootstrap module for testbenching in ModelSim
 */

`timescale 1ns/100ps

module bootstrap_tb(clk, rst, ena, cntin);
    parameter RSTSIZE = 4;
    parameter ENASIZE = 2;
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    output reg clk = 1'd1;
    output rst;
    output ena;
    output [NDATA_LOG-1:0] cntin;

    reg erst;

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

    // Clock generation
    always begin
        #10
        clk <= ~clk;
    end

    // External reset assert
    initial begin
        erst <= 1'd0;
        #10
        erst <= 1'd1;
    end

endmodule
