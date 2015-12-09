`timescale 1ns/100ps

module output_proc(din, clk, rst, ena, cntin, dout);
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    input [NDATA_LOG-1:0] din;
    input clk;
    input rst;
    input ena;
    input [NDATA_LOG-1:0] cntin;

    output reg [20:0] dout = 21'd1;

    wire [8:0] lutout;
    wire [11:0] bcdout;
    wire [20:0] dout_next;

    output_lut #(NDATA) outputLutInst(din, clk, rst, ena, lutout);
    bcd bcdInst(lutout, bcdout);
    sevenseg sevensegInstA(bcdout[3:0], dout_next[6:0]);
    sevenseg sevensegInstB(bcdout[7:4], dout_next[13:7]);
    sevenseg sevensegInstC(bcdout[11:8], dout_next[20:14]);

    always @ (posedge clk or negedge rst) begin
        if (!rst)
            dout <= 21'd1;
        else
            if (!ena)
                if (cntin == {{(NDATA_LOG-3){1'd0}}, 3'd4})
                    dout <= dout_next;
    end

endmodule
