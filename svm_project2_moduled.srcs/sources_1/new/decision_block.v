`timescale 1ns / 1ps

module decision_block (
    input clk,
    input signed [31:0] sum0,sum1,sum2,
    output reg [1:0] v0,v1,v2
);

always @(posedge clk) begin
    v0 <= (sum0 >= 0) ? 2'd0 : 2'd1; // 0 vs 1
    v1 <= (sum1 >= 0) ? 2'd0 : 2'd2; // 0 vs 2
    v2 <= (sum2 >= 0) ? 2'd1 : 2'd2; // 1 vs 2
end

endmodule
