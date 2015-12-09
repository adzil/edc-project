`timescale 1ns/100ps

module bcd_tb;

    reg [8:0] din;
    wire [11:0] dout;

    bcd dut (din, dout);

    initial begin
        din <= $random;
        #50
        din <= $random;
        #50
        din <= $random;
        #50
        din <= $random;
        #50
        din <= $random;
        #50
        din <= $random;
        #50
        din <= $random;
        #50
        din <= $random;
        #50
        din <= $random;
        #50
        $stop();
    end

endmodule
