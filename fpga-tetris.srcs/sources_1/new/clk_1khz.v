`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 23:52:33
// Design Name: 
// Module Name: clock_1khz
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


module clock_1khz(
    input clk,
    output reg Q
    );
    reg [11:0]cnt;
    initial 
    begin
        Q<=0;
        cnt=12'd0; 
    end
    always @ (posedge clk)
    begin
        if (cnt>=12'd2499)
        begin
            Q<=~Q;
            cnt<=12'd0;
        end
        else 
            cnt<=cnt+12'd1;
    end
endmodule
