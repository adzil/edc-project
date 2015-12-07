`timescale 1ns/100ps

module counter(clk, rst, ena, dout);
    /* Parameter definition */
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);

    /* Input/output definition */
    // Control input line
    input clk;
    input rst;
    input ena;
    // Output data line
    output reg [NDATA_LOG-1:0] dout = {(NDATA_LOG-2){1'd0}};

    /* Sequential processes */
    // Set counter advancement
    always @ (posedge clk or negedge rst) begin
        if (!rst)
            dout <= {(NDATA_LOG-2){1'd0}};
        else
            if (!ena)
                dout <= dout + {{(NDATA_LOG-1){1'd0}},{1'd1}};
            else
                dout <= dout;
    end

endmodule
