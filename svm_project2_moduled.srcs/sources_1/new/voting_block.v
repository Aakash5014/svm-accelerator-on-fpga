`timescale 1ns / 1ps

module voting_block (
    input clk,
    input [1:0] v0,v1,v2,
    output reg [1:0] species
);

always @(posedge clk) begin
    if (v0==2'd0 && v1==2'd0)
        species <= 2'd0;
    else if (v0==2'd1 && v2==2'd1)
        species <= 2'd1;
    else
        species <= 2'd2;
end

endmodule