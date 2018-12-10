`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 13:49:59
// Design Name: 
// Module Name: bcd_decoder
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


module bcd_decoder(
    input clock,
    input [3:0] x0,
    input [3:0] x1,
    input [3:0] x2,
    input [3:0] x3,
    output reg [7:0]an,
    output reg [6:0]seg,
    output reg dp
    );
    initial an[7:4]=4'b1111;
    wire [6:0] seg0, seg1, seg2, seg3;
    integer cnt = 0;
    wire clk;
    clock_500hz U (clock,clk);
    display_number D0 (x0, seg0);
    display_number D1 (x1, seg1);
    display_number D2 (x2, seg2);
    display_number D3 (x3, seg3);
    always @ (posedge clk) begin
        if (cnt == 3) cnt <= 0;
        else cnt <= cnt + 1;
    end
    always @ (cnt or seg0 or seg1 or seg2 or seg3)
    begin
    if (cnt == 0) begin seg <= seg0; an[3:0] <= 4'b1110; dp <= 1; end
    else if (cnt == 1) begin seg <= seg1; an[3:0] <= 4'b1101; dp <= 0; end
    else if (cnt == 2) begin seg <= seg2; an[3:0] <= 4'b1011; dp <= 1; end
    else begin seg <= seg3; an[3:0] <= 4'b0111; dp <= 0; end
    end
endmodule
