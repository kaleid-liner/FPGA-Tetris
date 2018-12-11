`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 16:20:59
// Design Name: 
// Module Name: GameDisplayer
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


module GameDisplayer(
    input clk_5mhz,
    input [255:0] fallen_blocks,
    input [7:0] xy1, xy2, xy3, xy4,
    output A, B, C, D,
    output G, DI, CLK, LAT    
    );
    wire [255:0] lattice;
    wire [255:0] current_block_lattice_mask;
    
    generate
         genvar i;
         for (i = 0; i < 256; i = i + 1) 
         begin
             assign current_block_lattice_mask[i] = 
             (i == xy1) || (i == xy2) || (i == xy3) || (i == xy4);
         end
    endgenerate
    
    assign lattice = fallen_blocks | current_block_lattice_mask;
    
    LatticeDisplayer latticeDisplayer (lattice, clk_5mhz, A, B, C, D, G, DI, CLK, LAT);
endmodule
