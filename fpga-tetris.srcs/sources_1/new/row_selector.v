`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/09 14:37:49
// Design Name: 
// Module Name: row_selector
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


module row_selector(
    input [3:0] select,
    output A, B, C, D
    );
    assign D = select[3];
    assign C = select[2];
    assign B = select[1];
    assign A = select[0];
endmodule
