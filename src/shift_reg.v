`timescale 1ns/100ps

module shift_reg(din, clk, rst, ena, dout);
    /* Parameter declaration */
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);
    
    /* Input/output declaration */
    // Input data line
    input din;
    // Control line
    input clk;
    input rst;
    input ena;
    // Output data line
    output [NDATA-1:0] dout;
    
    /* Wire/register declaration */
    reg [NDATA-1:0] dout;
    
    always @ (posedge clk or negedge rst) begin
        if (!rst)
            dout <= 'd0;
        else begin
            if (!ena) begin
                dout[NDATA-1:1] <= dout[NDATA-2:0];
                dout[0] <= din;
            end
        end
    end
    
endmodule
