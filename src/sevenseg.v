`timescale 1ns/100ps

module sevenseg(din, dout);

    input [3:0] din;
    output reg [6:0] dout;

    always @ (*) begin
        case (din)
            0: dout = 7'b1000000;
            1: dout = 7'b1111001;
            2: dout = 7'b0100100;
            3: dout = 7'b0110000;
            4: dout = 7'b0011001;
            5: dout = 7'b0010010;
            6: dout = 7'b0000010;
            7: dout = 7'b1111000;
            8: dout = 7'b0000000;
            9: dout = 7'b0010000;
            default: dout = 7'b1111111;
        endcase
    end

endmodule
