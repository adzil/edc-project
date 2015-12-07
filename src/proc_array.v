`timescale 1ns/100ps

module proc_array(dinRef, dinSig, doutA, doutB, doutC, doutD);
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    input [NDATA-1:0] dinRef;
    input [NDATA-1:0] dinSig;

    output [NDATA_LOG:0] doutA;
    output [NDATA_LOG:0] doutB;
    output [NDATA_LOG:0] doutC;
    output [NDATA_LOG:0] doutD;

    wire [NDATA-1:0] dinSigA;
    wire [NDATA-1:0] dinSigB;
    wire [NDATA-1:0] dinSigC;
    wire [NDATA-1:0] dinSigD;

    assign dinSigA = dinSig;
    assign dinSigB = {dinSig[NDATA-2:0], dinSig[NDATA-1]};
    assign dinSigC = {dinSig[NDATA-3:0], dinSig[NDATA-1:NDATA-2]};
    assign dinSigD = {dinSig[NDATA-4:0], dinSig[NDATA-1:NDATA-3]};

    xcorr_proc #(NDATA) xcorrProcInstA (
        .dinA (dinRef),
        .dinB (dinSigA),
        .dout (doutA)
    );

    xcorr_proc #(NDATA) xcorrProcInstB (
        .dinA (dinRef),
        .dinB (dinSigB),
        .dout (doutB)
    );

    xcorr_proc #(NDATA) xcorrProcInstC (
        .dinA (dinRef),
        .dinB (dinSigC),
        .dout (doutC)
    );

    xcorr_proc #(NDATA) xcorrProcInstD (
        .dinA (dinRef),
        .dinB (dinSigD),
        .dout (doutD)
    );

endmodule
