`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2026 13:41:48
// Design Name: 
// Module Name: svm_top_modular
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module svm_top_modular (
    input clk,
    input rst,
    input valid_in,

    input signed [15:0] in_0,in_1,in_2,in_3,

    output reg valid_out,
    output [1:0] species
);

//////////////////////////////////////////////////////
// PARAMETERS (replace with trained values)
//////////////////////////////////////////////////////

parameter signed [15:0] MEAN_0=16'h05cf, INV_STD_0=16'h0138;
parameter signed [15:0] MEAN_1=16'h0310, INV_STD_1=16'h023c;
parameter signed [15:0] MEAN_2=16'h03ba, INV_STD_2=16'h0093;
parameter signed [15:0] MEAN_3=16'h012f, INV_STD_3=16'h0156;

// weights (example placeholders)
parameter signed [15:0] W0_0=16'hff92,W0_1=16'h0057,W0_2=16'hff1f,W0_3=16'hff15;
parameter signed [31:0] B0=32'hfffe96b8;

parameter signed [15:0] W1_0=16'hfff0,W1_1=16'h0024,W1_2=16'hff1f,W1_3=16'hff73;
parameter signed [31:0] B1=32'hffffbbea;

parameter signed [15:0] W2_0=16'h0035,W2_1=16'h00c9,W2_2=16'hfd97,W2_3=16'hfde3;
parameter signed [31:0] B2=32'h00031f47;

//////////////////////////////////////////////////////
// VALID PIPELINE
//////////////////////////////////////////////////////

reg [6:0] valid_pipe;

always @(posedge clk) begin
    if (rst)
        valid_pipe <= 0;
    else
        valid_pipe <= {valid_pipe[5:0], valid_in};
end

always @(posedge clk)
    valid_out <= valid_pipe[6];

//////////////////////////////////////////////////////
// SCALING
//////////////////////////////////////////////////////

wire signed [15:0] s0,s1,s2,s3;

scaler sc0(clk,in_0,MEAN_0,INV_STD_0,s0);
scaler sc1(clk,in_1,MEAN_1,INV_STD_1,s1);
scaler sc2(clk,in_2,MEAN_2,INV_STD_2,s2);
scaler sc3(clk,in_3,MEAN_3,INV_STD_3,s3);

//////////////////////////////////////////////////////
// CLASSIFIERS
//////////////////////////////////////////////////////

wire signed [31:0] sum0,sum1,sum2;

svm_classifier c0(clk,s0,s1,s2,s3,W0_0,W0_1,W0_2,W0_3,B0,sum0);
svm_classifier c1(clk,s0,s1,s2,s3,W1_0,W1_1,W1_2,W1_3,B1,sum1);
svm_classifier c2(clk,s0,s1,s2,s3,W2_0,W2_1,W2_2,W2_3,B2,sum2);

//////////////////////////////////////////////////////
// DECISION
//////////////////////////////////////////////////////

wire [1:0] v0,v1,v2;

decision_block db(clk,sum0,sum1,sum2,v0,v1,v2);

//////////////////////////////////////////////////////
// VOTING
//////////////////////////////////////////////////////

voting_block vb(clk,v0,v1,v2,species);

endmodule 
