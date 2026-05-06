`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2026 13:52:44
// Design Name: 
// Module Name: testbe
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


module testbe(

    );
    reg clk;
reg rst;
reg valid_in;

reg signed [15:0] in_0,in_1,in_2,in_3;

wire valid_out;
wire [1:0] species;

//////////////////////////////////////////////////////
// DUT (Device Under Test)
//////////////////////////////////////////////////////

svm_top_modular dut (
    .clk(clk),
    .rst(rst),
    .valid_in(valid_in),
    .in_0(in_0),
    .in_1(in_1),
    .in_2(in_2),
    .in_3(in_3),
    .valid_out(valid_out),
    .species(species)
);

//////////////////////////////////////////////////////
// CLOCK GENERATION
//////////////////////////////////////////////////////

always #5 clk = ~clk;   // 100 MHz clock

//////////////////////////////////////////////////////
// TEST SEQUENCE
//////////////////////////////////////////////////////

initial begin
    clk = 0;
    rst = 1;
    valid_in = 0;

    #20 rst = 0;

    //--------------------------------------------------
    // Sample 1 (example: setosa-like)
    //--------------------------------------------------
    @(posedge clk);
    valid_in = 1;
    in_0 = 16'd5;  // Q8.8 example
    in_1 = 16'd1;
    in_2 = 16'd3;
    in_3 = 16'd0;

    @(posedge clk);
    valid_in = 0;

    //--------------------------------------------------
    // Sample 2 (versicolor-like)
    //--------------------------------------------------
    repeat(10) @(posedge clk);

    @(posedge clk);
    valid_in = 1;
    in_0 = 16'd1500;
    in_1 = 16'd700;
    in_2 = 16'd1200;
    in_3 = 16'd400;

    @(posedge clk);
    valid_in = 0;
//verginica
 @(posedge clk);
    valid_in = 1;
    in_0 = 16'd2022;  // Q8.8 example
    in_1 = 16'd819;
    in_2 = 16'd1638;
    in_3 = 16'd512;

    @(posedge clk);
    valid_in = 0;
    //--------------------------------------------------
    // Wait for pipeline output
    //--------------------------------------------------
    repeat(20) @(posedge clk);

    $finish;
end

//////////////////////////////////////////////////////
// MONITOR OUTPUT
//////////////////////////////////////////////////////

initial begin
    $monitor("Time=%0t | valid_out=%b | species=%d",
              $time, valid_out, species);
end

endmodule

