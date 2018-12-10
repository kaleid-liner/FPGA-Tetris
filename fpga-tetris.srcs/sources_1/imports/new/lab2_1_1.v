`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/23 19:36:41
// Design Name: 
// Module Name: display_number
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


module display_number(
    input [3:0] x,
    output wire [6:0] seg
    );        
    assign seg[0] = (x[0] & ~x[1] & ~x[2] & ~x[3]) | (~x[0] & ~x[1] & x[2] & ~x[3]);
    assign seg[1] = (x[0] & ~x[1] & x[2] & ~x[3]) | (~x[0] & x[1] & x[2] & ~x[3]);
    assign seg[2] = (~x[0] & x[1] & ~x[2] & ~x[3]);
    assign seg[3] = (x[0] & ~x[1] & ~x[2] & ~x[3]) | (~x[0] & ~x[1] & x[2] & ~x[3]) | (x[0] & x[1] & x[2] & ~x[3]);
    assign seg[4] = ~((~x[0] & ~x[1] & ~x[2] & ~x[3]) | (~x[0] & x[1] & ~x[2] & ~x[3]) | (~x[0] & x[1] & x[2] & ~x[3]) | (~x[0] & ~x[1] & ~x[2] & x[3]));
    assign seg[5] = (x[0] & ~x[1] & ~x[2] & ~x[3]) | (~x[0] & x[1] & ~x[2] & ~x[3]) | (x[0] & x[1] & ~x[2] & ~x[3]) | (x[0] & x[1] & x[2] & ~x[3]);
    assign seg[6] = (~x[0] & ~x[1] & ~x[2] & ~x[3]) | (x[0] & ~x[1] & ~x[2] & ~x[3]) | (x[0] & x[1] & x[2] & ~x[3]);

endmodule
