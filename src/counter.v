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
    output reg [NDATA_LOG-1:0] dout = {NDATA_LOG{1'd0}};
    
    wire [NDATA_LOG-1:0] dout_next;
    
    assign dout_next = dout + {{(NDATA_LOG-1){1'd0}}, 1'd1};

    /* Sequential processes */
    // Set counter advancement
    always @ (posedge clk or negedge rst) begin
        if (!rst)
            dout <= {NDATA_LOG{1'd0}};
        else
            if (!ena)
                dout <= dout_next;
    end

endmodule
