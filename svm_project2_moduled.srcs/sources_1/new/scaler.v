`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2026 13:41:12
// Design Name: 
// Module Name: scaler
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


module scaler (
    input clk,
    input signed [15:0] x,
    input signed [15:0] mean,
    input signed [15:0] inv_std,
    output reg signed [15:0] s
);

always @(posedge clk) begin
    s <= ((x - mean) * inv_std) >>> 8;
end

endmodule
