`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 00:10:32
// Design Name: 
// Module Name: clock_10hz
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


module clock_10hz(
    input clk,
    output reg Q
    );
    reg [17:0]cnt;
        initial 
        begin
            Q<=0;
            cnt=17'd0; 
        end
        always @ (posedge clk)
        begin
            if (cnt>=18'd249999)
            begin
                Q<=~Q;
                cnt<=17'd0;
            end
            else 
                cnt<=cnt+17'd1;
        end
endmodule
