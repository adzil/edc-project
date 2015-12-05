// Cross-correlation discrete processor
`timescale 1ns/100ps

module xcorr_proc(dinA, dinB, dout);
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);
    
    input [NDATA-1:0]           dinA;
    input [NDATA-1:0]           dinB;
    output [NDATA_LOG:0]        dout;
    
    wire [NDATA-1:0]            dproc;
    
    assign dproc = dinA ^ dinB;
    
    bintree #(NDATA) bintreeInst (
        .din                    (dproc),
        .dout                   (dout)
    );

endmodule
