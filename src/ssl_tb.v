`timescale 1ns/100ps

module ssl_tb;
    /* Parameter declaration */
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);

    /* Input/output declaration */
    // Input data line
    reg [3:0] din;
    // Control line
    reg clk;
    reg erst;

    reg [9:0] rndval = 10'd0;
    // Output data line
    wire [NDATA_LOG-1:0] dIdA;
    wire [NDATA_LOG-1:0] dIdB;
    wire [NDATA_LOG-1:0] dIdC;

    ssl dut (
        .clk (clk),
        .erst (erst),
        .din (din),
        .dIdA (dIdA),
        .dIdB (dIdB),
        .dIdC (dIdC)
    );

    initial begin
        clk <= 1'd1;
        erst <= 1'd0;
        #20
        erst <= 1'd1;
        #50000
        $stop();
    end

    integer isloop = 0;
    always begin
        if (!isloop)
            #3
            isloop <= 1;
        else begin
            #20
            rndval[9:1] <= rndval[8:0];
            rndval[0] <= $random();
            din[0] <= rndval[0];
            din[1] <= rndval[9];
            din[2] <= rndval[6];
            din[3] <= rndval[3];
        end
    end

    // Clock generation
    always begin
        #10
        clk <= ~clk;
    end

endmodule
