`timescale 1ns/100ps

module serial_buff(din, cntin, clk, rst, ena, dout);
    /* Parameter declaration */
    parameter MOVIN = 1'd0;
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);

    /* Input/output declaration */
    // Input data line
    input din;
    input [NDATA_LOG-1:0] cntin;
    // Control line
    input clk;
    input rst;
    input ena;
    // Output data line
    output reg [NDATA-1:0] dout;

    /* Wire/register declaration */
    wire [NDATA-1:0] buffer;
    //reg [NDATA-1:0] dout;

    /* Module import declaration */
    shift_reg shiftRegInst (
        .din (din),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (buffer)
    );

    always @ (posedge clk or negedge rst) begin
        if (!rst)
            dout <= 'd0;
        else begin
            if (!ena) begin
                if (cntin == 'd0)
                    dout <= buffer;
                else if (!MOVIN && cntin[1:0] == 'd0) begin
                    dout[NDATA-1:4] <= dout[NDATA-5:0]
                    dout[3:0] <= dout[NDATA-1:NDATA-4];
                end
                else
                    dout <= dout;
            end
        end
    end

endmodule
