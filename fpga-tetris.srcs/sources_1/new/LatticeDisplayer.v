`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/09 14:34:06
// Design Name: 
// Module Name: LatticeDisplayer
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


module LatticeDisplayer(
    input [255:0] lattice,
    input clk_5mhz,
    output A, B, C, D,
    output reg G, DI, CLK, LAT
    );
    reg [15:0] cnt;
    reg [3:0] row;
    reg [3:0] column;
    wire [15:0] display_buffer;
    wire [7:0] row_start;
    integer i;
    
    assign row_start = (row << 4) + 16;
    assign display_buffer = lattice[row_start+:16];
    
    initial begin row = 0; column = 0; cnt = 0; LAT = 0; end
    always @ (posedge clk_5mhz) begin
        if (cnt >= 4999) begin
            cnt <= 0;
        end
        else cnt <= cnt + 1;
        if (cnt != 0 && (|cnt[6:0] == 0)) begin
            column <= column + 1;
        end
        if (cnt == 2048) G <= 1;
        if (cnt == 4999) begin
            row <= row + 1; column <= 0;
        end
        for (i = 0; i < 16; i = i + 1) begin
        if (cnt == 2 + i * 128) begin G <= 0; DI <= ~display_buffer[column]; end
        if (cnt == 42 + i * 128) CLK <= 1;
        if (cnt == 84 + i * 128) CLK <= 0; 
        end
        if (cnt == 2060) LAT <= 1;
        if (cnt == 2070) LAT <= 0;
    end
    
    row_selector sel (row, A, B, C, D);  
endmodule
