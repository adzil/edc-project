`timescale 1ns/100ps

module proc_comp(dinA, dinB, dinC, dinD, dout, doutVal);
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    input [NDATA_LOG:0] dinA;
    input [NDATA_LOG:0] dinB;
    input [NDATA_LOG:0] dinC;
    input [NDATA_LOG:0] dinD;

    output [1:0] dout;
    output reg [NDATA_LOG:0] doutVal;

    wire dgtA, dgtB, dgtAll;

    assign dgtA = (dinB > dinA);
    assign dgtB = (dinD > dinC);
    assign dgtAll = ((dgtB ? dinD : dinC) > (dgtA ? dinB : dinA));

    assign dout = {dgtAll, (dgtAll ? dgtB : dgtA)};

    always @ (*) begin
        case (dout)
            2'd0: doutVal = dinA;
            2'd1: doutVal = dinB;
            2'd2: doutVal = dinC;
            2'd3: doutVal = dinD;
        endcase
    end

endmodule
