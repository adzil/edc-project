`timescale 1ns/100ps

module rst_synch(clk, erst, rst, ena);
    /* Parameter declaration */
    parameter RSTSIZE = 4;
    parameter ENASIZE = 2;
    /* Control line input declaration */
    input clk;
    input erst;
    /* Control line output declaration */
    output rst;
    output ena;

    reg [RSTSIZE+ENASIZE-1:0] buff = {(RSTSIZE+ENASIZE){1'd0}};

    assign rst = buff[RSTSIZE-1];
    assign ena = ~buff[RSTSIZE+ENASIZE-1];

    always @ (posedge clk or negedge erst) begin
        if (!erst)
            buff <= {(RSTSIZE+ENASIZE){1'd0}};
        else begin
            buff[RSTSIZE+ENASIZE-1:1] <= buff[RSTSIZE+ENASIZE-2:0];
            buff[0] <= 1'd1;
        end
    end

endmodule
