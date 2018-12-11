`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 17:28:40
// Design Name: 
// Module Name: CollideWithFallenBlocks
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


module CollideWithFallenBlocks(
    input [7:0] xy1, xy2, xy3, xy4,
    input [255:0] fallen_blocks,
    output collide_with_fallen_blocks
    );
    assign collide_with_fallen_blocks = 
        fallen_blocks[xy1] | fallen_blocks[xy2] | fallen_blocks[xy3] | fallen_blocks[xy4];
endmodule
