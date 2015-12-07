`timescale 1ns/100ps

module proc_comp_tb;
    parameter NDATA = 128;
    parameter NDATA_LOG = $clog2(NDATA);

    reg [NDATA_LOG:0] dinA;
    reg [NDATA_LOG:0] dinB;
    reg [NDATA_LOG:0] dinC;
    reg [NDATA_LOG:0] dinD;

    wire [1:0] dout;
    wire [NDATA_LOG:0] doutVal;

    proc_comp dut (
        .dinA (dinA),
        .dinB (dinB),
        .dinC (dinC),
        .dinD (dinD),
        .dout (dout),
        .doutVal (doutVal)
    );

    initial begin
        dinA <= $random();
        dinB <= $random();
        dinC <= $random();
        dinD <= $random();
        #50
        dinA <= $random();
        dinB <= $random();
        dinC <= $random();
        dinD <= $random();
        #50
        dinA <= $random();
        dinB <= $random();
        dinC <= $random();
        dinD <= $random();
        #50
        dinA <= $random();
        dinB <= $random();
        dinC <= $random();
        dinD <= $random();
        #50
        dinA <= $random();
        dinB <= $random();
        dinC <= $random();
        dinD <= $random();
        #50
        dinA <= $random();
        dinB <= $random();
        dinC <= $random();
        dinD <= $random();
        #50
        dinA <= $random();
        dinB <= $random();
        dinC <= $random();
        dinD <= $random();
        #50
        dinA <= $random();
        dinB <= $random();
        dinC <= $random();
        dinD <= $random();
        #50
        $stop();
    end

endmodule
