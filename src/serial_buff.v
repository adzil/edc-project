`timescale 1ns/100ps

module serial_buff(din, clk, rst, ena, dout);
    /* Parameter declaration */
    parameter NDATA = 128;
    localparam NDATA_LOG = $clog2(NDATA);
    
    /* Input/output declaration */
    // Input data line
    input din;
    // Control line
    input clk;
    input rst;
    input ena;
    // Output data line
    output reg [NDATA-1:0] dout;
    
    /* Wire/register declaration */
    wire [NDATA-1:0] buffer;
    //reg [NDATA-1:0] dout;
    reg [NDATA_LOG-1:0] counter;
    
    /* Module import declaration */
    shift_reg #(NDATA) shiftRegInst (
        .din (din),
        .clk (clk),
        .rst (rst),
        .ena (ena),
        .dout (buffer)
    );
    
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            dout <= 'd0;
            counter <= 'd0;
        end
        else begin
            if (!ena) begin
                if (counter == 'd0)
                    dout <= buffer;
                counter <= counter + {{(NDATA_LOG-1){1'd0}},{1'd1}};
            end
            else begin
                counter <= counter;
            end
        end
    end

endmodule
