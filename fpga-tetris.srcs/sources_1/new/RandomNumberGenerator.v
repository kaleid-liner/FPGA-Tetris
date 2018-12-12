`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 00:24:29
// Design Name: 
// Module Name: RandomNumberGenerator
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


module RandomNumberGenerator(
    input clk,
    output reg [2:0] rn
    );
    // LFSR
    // Generate a random number between 1 and 7
    initial rn = 1;
    always @ (posedge clk) begin 
        rn <= { rn[1:0], rn[2] ^ rn[1] };
    end
endmodule
