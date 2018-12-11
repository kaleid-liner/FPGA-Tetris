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
    initial  lattice = {16'b1010101010101010,
                        16'b0010010010010010,
                        16'b1011111110000010,
                        16'b0101011111111111,
                        16'b0000000000000110,
                        16'b0111111111111111,
                        16'b0000000000000111,
                        16'b1111111111111111,
                        16'b0000000000000111,
                        16'b0000111111100101,
                        16'b1010111111111111,
                        16'b0000000111111111,
                        16'b0100000000011111,
                        16'b0000000000000000,
                        16'b1111111100000000,
                        16'b1010000011110010
                        };
    clk_wiz_0 main_clock (.clk_out1(clk_5mhz), .reset(reset), .clk_in1(clk));
    LatticeDisplayer display (lattice, clk_5mhz, A, B, C, D, G, DI, CLK, LAT);
    
endmodule
