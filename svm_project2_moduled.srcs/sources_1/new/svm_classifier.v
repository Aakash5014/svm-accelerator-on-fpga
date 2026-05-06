`timescale 1ns / 1ps
module svm_classifier (
    input clk,
    input signed [15:0] s0,s1,s2,s3,

    input signed [15:0] w0,w1,w2,w3,
    input signed [31:0] b,

    output reg signed [31:0] sum
);

(* use_dsp="yes" *) reg signed [31:0] m0,m1,m2,m3;
reg signed [31:0] sum_stage;

always @(posedge clk) begin
    m0 <= s0 * w0;
    m1 <= s1 * w1;
    m2 <= s2 * w2;
    m3 <= s3 * w3;
end

always @(posedge clk) begin
    sum_stage <= m0 + m1 + m2 + m3;
end

always @(posedge clk) begin
    sum <= sum_stage + b;
end

endmodule