`timescale 1ns/100ps

module serial_buff_tb;
    /* Parameter declaration */
    parameter NDATA = 128;

    /* Input/output declaration */
    // Input data line
    reg din;
    reg cntin;
    // Control line
    reg clk;
    reg rst;
    reg ena;
    // Output data line
    wire [NDATA-1:0] dout;

    counter cnt (
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (cntin)
    );

    serial_buff dut (
        .din (din),
        .cntin (cntin),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (dout)
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
