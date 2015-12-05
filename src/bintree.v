/**
 *  Electronics Design Competition 2015
 *  Sound Source Localization
 *
 *  The binary tree adder module - bintree.v
 */

`timescale 1ns/100ps

module bintree(din, dout);
    /* Parameter definition */
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);
    
    /* Input/output definition */
    input [NDATA-1:0] din;
    output [NDATA_LOG:0] dout;

    /* Generator definition */
    genvar i,x;
    generate
        // Iterate to Log2(N) binary tree adder
        for(i=1; i<NDATA_LOG;i = i+1) begin: bAdd
            // Get the number of adder in one level
            localparam j = (NDATA >> i);
            // Create new data wire
            wire [i:0] data [0:j-1];

            for(x=0; x<j; x = x + 1) begin: bAdder
                localparam nx = x*2;
                if (i == 1)
                    // Wiring from input wire
                    assign bAdd[i].data[x] = din[nx:nx] + din[nx+1:nx+1];
                else
                    // Wiring from last data wire
                    assign bAdd[i].data[x] = bAdd[i-1].data[nx] + bAdd[i-1].data[nx+1];
            end
        end

        // Wire output to the last data wire
        assign dout = bAdd[i-1].data[0] + bAdd[i-1].data[1];
    endgenerate
    
endmodule
