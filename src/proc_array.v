`timescale 1ns/100ps

module proc_array(dinRef, dinSig, clk, rst, ena, cntin, dout);
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    input [NDATA-1:0] dinRef;
    input [NDATA-1:0] dinSig;

    input clk;
    input rst;
    input ena;
    input [NDATA_LOG-1:0] cntin;

    output reg [NDATA_LOG-1:0] dout = {NDATA_LOG{1'd0}};

    reg [NDATA_LOG-1:0] doutId = {NDATA_LOG{1'd0}};
    reg [NDATA_LOG:0] doutVal = {(NDATA_LOG+1){1'd0}};

    reg [NDATA_LOG-1:0] cntstore = {(NDATA_LOG-2){1'd0}};

    wire [1:0] doutLocal;
    wire [NDATA_LOG:0] doutLocalVal;
    wire isReplace;

    //output reg [1:0] dout = 2'd0;
    //output reg [NDATA_LOG:0] doutVal = {(NDATA_LOG+1){1'd0}};

    //wire [1:0] dout_next;
    //wire [NDATA_LOG:0] doutVal_next;

    wire [NDATA_LOG:0] doutA;
    wire [NDATA_LOG:0] doutB;
    wire [NDATA_LOG:0] doutC;
    wire [NDATA_LOG:0] doutD;

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

    proc_comp #(NDATA) procCompInst (
        .dinA (doutA),
        .dinB (doutB),
        .dinC (doutC),
        .dinD (doutD),
        .dout (doutLocal),
        .doutVal (doutLocalVal)
    );

    assign isReplace = (doutLocalVal > doutVal);

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            dout <= {NDATA_LOG{1'd0}};
            doutId <= {NDATA_LOG{1'd0}};
            doutVal <= {(NDATA_LOG+1){1'd0}};
        end
        else begin
            if (!ena) begin
                if (cntin == {(NDATA_LOG){1'd0}}) begin
                    cntstore <= {(NDATA_LOG-2){1'd0}};
                    dout <= doutId;
                    doutId <= {NDATA_LOG{1'd0}};
                    doutVal <= {(NDATA_LOG+1){1'd0}};
                end
                else if (cntin[1:0] == 2'd0) begin
                    if (isReplace) begin
                        doutId <= {cntstore[NDATA_LOG-1:2], doutLocal};
                        doutVal <= doutLocalVal;
                    end
                    cntstore <= cntin;
                end
            end
        end
    end

endmodule
