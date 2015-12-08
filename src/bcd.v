`timescale 1ns/100ps

module bcd(din, dout);

    input [8:0] din;
    output [11:0] dout;

    wire [3:0] dat [0:8];

    addthree at0 ({1'd0, din[8:6]}, dat[0]);
    addthree at1 ({dat[0][2:0], din[5]}, dat[1]);
    addthree at2 ({dat[1][2:0], din[4]}, dat[2]);
    addthree at3 ({dat[2][2:0], din[3]}, dat[3]);
    addthree at4 ({dat[3][2:0], din[2]}, dat[4]);
    addthree at5 ({dat[4][2:0], din[1]}, dat[5]);
    addthree at6 ({1'd0, dat[0][3], dat[1][3], dat[2][3]}, dat[6]);
    addthree at7 ({dat[6][2:0], dat[4][3]}, dat[7]);
    addthree at8 ({dat[7][2:0], dat[5][3]}, dat[8]);

    assign dout = {1'd0, dat[6][3], dat[7][3], dat[8], dat[5], din[0]};

endmodule
