`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/09 16:13:30
// Design Name: 
// Module Name: LatticeTest
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


module LatticeTest(
    input clk, 
    input reset,
    output A, B, C, D, G, DI, CLK, LAT
    );
    reg [255:0] lattice;
    wire clk_5mhz;
    initial  lattice = {16{16'b1010101010101010}};
    clk_wiz_0 main_clock (.clk_out1(clk_5mhz), .reset(reset), .clk_in1(clk));
    LatticeDisplayer display (lattice, clk_5mhz, A, B, C, D, G, DI, CLK, LAT);
    
endmodule
