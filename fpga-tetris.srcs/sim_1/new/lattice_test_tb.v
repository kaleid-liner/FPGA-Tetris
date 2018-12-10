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
    parameter [255:0] lattice = {16{16'b1010101010101010}};
    always #1 clk = ~clk;
    initial begin reset = 0; clk = 0; end
    LatticeDisplayer DUT (lattice, clk, A, B, C, D, G, DI, CLK, LAT);
endmodule
