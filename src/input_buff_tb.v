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
    wire [NDATA-1:0] dout0;
    wire [NDATA-1:0] dout1;
    wire [NDATA-1:0] dout2;
    wire [NDATA-1:0] dout3;

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
        .dout0 (dout0),
        .dout1 (dout1),
        .dout2 (dout2),
        .dout3 (dout3)
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
