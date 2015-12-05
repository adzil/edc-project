`timescale 1ns/100ps

module bintree_tb;
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);
    
    reg [NDATA-1:0]     din;
    wire [NDATA_LOG:0]  dout;

    bintree dut (
        .din            (din),
        .dout           (dout)
    );

    initial begin
        din <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        #50
        din <= 128'hF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0;
        #50
        din <= 128'h0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F;
        #50
        din <= 128'h0;
        #50
        // Stop the simulation process
        $stop();
    end

endmodule
