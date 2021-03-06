`timescale 1ns/100ps

module input_buff_tb;
    /* Parameter declaration */
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);

    /* Input/output declaration */
    // Input data line
    reg [3:0] din;
    wire [NDATA_LOG-1:0] cntin;
    // Control line
    reg clk;
    reg rst;
    reg ena;
    // Output data line
    wire [NDATA-1:0] doutRef;
    wire [NDATA-1:0] doutSigA;
    wire [NDATA-1:0] doutSigB;
    wire [NDATA-1:0] doutSigC;

    counter cnt (
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (cntin)
    );

    input_buff dut (
        .din (din),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .doutA (doutRef),
        .doutB (doutSigA),
        .doutC (doutSigB),
        .doutD (doutSigC)
    );

    initial begin
        clk <= 1'd1;
        ena <= 1'd1;
        rst <= 1'd0;
        #3
        #100
        rst <= 1'd1;
        #20
        ena <= 1'd0;
        #5130
        $stop();
    end

    integer isloop = 0;
    always begin
        if (!isloop)
            #3
            isloop <= 1;
        else
            #20
            din <= $random();
    end

    // Clock generation
    always begin
        #10
        clk <= ~clk;
    end

endmodule
