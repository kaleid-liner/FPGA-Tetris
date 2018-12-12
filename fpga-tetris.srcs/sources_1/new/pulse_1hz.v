`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 22:08:21
// Design Name: 
// Module Name: pulse_1hz
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


module pulse_1hz(
    input clk,
    output reg Q
    );
    reg [22:0] cnt;
    initial 
    begin
        Q = 0;
        cnt = 23'd0; 
    end
    always @ (posedge clk)
    begin
        if (cnt>=23'd2499999)
        begin
            Q <= 1;
            cnt <= 23'd0;
        end
        else begin
            cnt <= cnt + 23'd1;
            Q <= 0;
        end
    end
endmodule
