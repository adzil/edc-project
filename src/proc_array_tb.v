`timescale 1ns/100ps

module proc_array_tb;
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    reg [3:0] din;

    wire clk;
    wire rst;
    wire ena;
    wire [NDATA_LOG-1:0] cntin;

    wire [NDATA-1:0] dinRef;
    wire [NDATA-1:0] dinSig;

    wire [NDATA_LOG:0] doutA;
    wire [NDATA_LOG:0] doutB;
    wire [NDATA_LOG:0] doutC;
    wire [NDATA_LOG:0] doutD;

    // Simulation bootstrap module
    bootstrap_tb boot (
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .cntin (cntin)
    );

    // Fetch source data from input buffer
    input_buff srcdata (
        .din (din),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .doutRef (dinRef),
        .doutSigA (dinSig)
    );

    // Processor array (DUT)
    proc_array dut (
        .dinRef (dinRef),
        .dinSig (dinSig),
        .doutA (doutA),
        .doutB (doutB),
        .doutC (doutC),
        .doutD (doutD)
    );

    integer isloop = 0;
    always begin
        if (!isloop)
            #3
            isloop <= 1;
        else
            #20
            din <= $random();
    end

    initial begin
        #6000
        $stop();
    end

endmodule
