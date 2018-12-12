`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 18:30:47
// Design Name: 
// Module Name: tetris_tb
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


module tetris_tb(

    );
    reg clk, reset, rotate, right, left;
    wire A, B, C, D, G, DI, CLK, LAT;
    
    initial begin
        clk = 0;
        reset = 0;
        rotate = 0;
        right = 0;
        left = 1;
    end
    
    always #1 clk = ~clk;
    
    Tetris tetris (.clk(clk),
                   .reset(reset),
                   .rotate(rotate),
                   .left(left),
                   .right(right),
                   .A(A),
                   .B(B),
                   .C(C),
                   .D(D),
                   .G(G),
                   .DI(DI),
                   .CLK(CLK),
                   .LAT(LAT));
    
endmodule
