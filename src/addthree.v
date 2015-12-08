`timescale 1ns/100ps

module addthree(din, dout);

    input [3:0] din;
    output reg [3:0] dout;

    always @ (*) begin
        case (din)
            4'd0: dout = 4'd0;
            4'd1: dout = 4'd1;
            4'd2: dout = 4'd2;
            4'd3: dout = 4'd3;
            4'd4: dout = 4'd4;
            4'd5: dout = 4'd8;
            4'd6: dout = 4'd9;
            4'd7: dout = 4'd10;
            4'd8: dout = 4'd11;
            4'd9: dout = 4'd12;
            default: dout = 4'd0;
        endcase
    end

endmodule
