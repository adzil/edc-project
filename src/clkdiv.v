`timescale 1ns/100ps

module clkdiv(clk, rst, ena, clkout);
    parameter DIV = 50;
    localparam DIV2 = $ceil(DIV/2);
    localparam DIV_LOG = $clog2(DIV);
    localparam DIV_POW = $pow(2, DIV_LOG);

    input clk;
    input rst;
    input ena;
    output reg clkout = 1'd0;

    reg [DIV_LOG:0] counter = {(DIV_LOG+1){1'd0}};

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            clkout <= 1'd0;
            counter <= {(DIV_LOG+1){1'd0}};
        end
        else
            if (!ena)
                // Handle counter resets (posedge)
                if (counter == {(DIV_LOG+1){1'd0}}) begin
                    counter <= (DIV_POW - DIV);
                    clkout <= 1'd1;
                end
                // Handle negative edge
                else if (counter == (DIV_POW - DIV2)) begin
                    clkout <= 1'd0;
                end
    end

endmodule
