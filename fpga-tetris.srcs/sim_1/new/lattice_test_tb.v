`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/09 17:16:32
// Design Name: 
// Module Name: lattice_test_tb
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


module lattice_test_tb(
    
    );
    reg clk, reset;
    wire A, B, C, D, G, DI, CLK, LAT;
    parameter [255:0] lattice = {16'b1010111010101010,
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
    always #1 clk = ~clk;
    initial begin reset = 0; clk = 0; end
    LatticeDisplayer DUT (lattice, clk, A, B, C, D, G, DI, CLK, LAT);
endmodule
