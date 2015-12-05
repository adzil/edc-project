`timescale 1ns/100ps

module xcorr_proc_tb;
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);
    
    reg [NDATA-1:0]         dinA;
    reg [NDATA-1:0]         dinB;
    wire [NDATA_LOG:0]      dout;

    xcorr_proc dut (
        .dinA               (dinA),
        .dinB               (dinB),
        .dout               (dout)
    );

    initial begin
        dinA <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        dinB <= 128'h00000000000000000000000000000000;
        #50
        dinA <= 128'hF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0;
        dinB <= 128'hF0F0F0F0F0F0F0F00F0F0F0F0F0F0F0F;
        #50
        dinA <= 128'h00000000000000000000000000000000;
        dinB <= 128'h00000000000000000000000000000000;
        #50
        dinA <= 128'h0000000000000000FFFFFFFFFFFFFFFF;
        dinB <= 128'h0000000000000000F0F0F0F0F0F0F0F0;
        #50
        // Stop the simulation process
        $stop();
    end

endmodule
