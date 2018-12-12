`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 17:08:04
// Design Name: 
// Module Name: CalcCurBlocks
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
//   15 - 14 - 13 - 12 - ...... - 0
//   31 - ..................... - 16
//   ...............................
//   ...............................
//   ...............................
//   ...............................
//   ...............................
//   ...............................
//   255 - 254 - .............. - 240 

module CalcCurBlocks(
    input [3:0] tlx, tly,
    input [2:0] shape,
    input [1:0] rotate,
    output reg [7:0] xy1, xy2, xy3, xy4,
    output reg [3:0] brx, bry
    );
    parameter I = 1, O = 2, T = 3, S = 4, Z = 5, J = 6, L = 7;
    
    wire [7:0] topleft_block;
    assign topleft_block = (tly << 4) + 15 - tlx;
    
    always @(*) begin
        if (shape == I) begin
            if ((rotate == 1) || (rotate == 3)) begin
                xy1 = topleft_block;
                xy2 = topleft_block + 16;
                xy3 = topleft_block + 32;
                xy4 = topleft_block + 48;
                brx = tlx;
                bry = tly + 3;
            end
            else begin
                xy1 = topleft_block;
                xy2 = topleft_block - 1;
                xy3 = topleft_block - 2;
                xy4 = topleft_block - 3;
                brx = tlx + 3;
                bry = tly;
            end       
        end
        else if (shape == O) begin
            xy1 = topleft_block;
            xy2 = topleft_block - 1;
            xy3 = topleft_block + 16;
            xy4 = topleft_block + 15;
            brx = tlx + 1;
            bry = tly + 1;
        end
        else if (shape == T) begin
            if (rotate == 0) begin
                xy1 = topleft_block;
                xy2 = topleft_block - 1;
                xy3 = topleft_block - 2;
                xy4 = topleft_block + 15;
                brx = tlx + 2;
                bry = tly + 1;
            end
            else if (rotate == 1) begin
                xy1 = topleft_block - 1;
                xy2 = topleft_block + 16;
                xy3 = topleft_block + 15;
                xy4 = topleft_block + 31;
                brx = tlx + 1;
                bry = tly + 2;
            end
            else if (rotate == 2) begin
                xy1 = topleft_block - 1;
                xy2 = topleft_block + 16;
                xy3 = topleft_block + 15;
                xy4 = topleft_block + 14;
                brx = tlx + 2;
                bry = tly + 1;
            end
            else if (rotate == 3) begin
                xy1 = topleft_block;
                xy2 = topleft_block + 16;
                xy3 = topleft_block + 15;
                xy4 = topleft_block + 32;
                brx = tlx + 1;
                bry = tly + 2;
            end
        end
        else if (shape == S) begin
            if (rotate == 0 || rotate == 2) begin
                xy1 = topleft_block - 1;
                xy2 = topleft_block - 2;
                xy3 = topleft_block + 16;
                xy4 = topleft_block + 15;
                brx = tlx + 2;
                bry = tly + 1;
            end
            else begin
                xy1 = topleft_block;
                xy2 = topleft_block + 16;
                xy3 = topleft_block + 15;
                xy4 = topleft_block + 31;
                brx = tlx + 1;
                bry = tly + 2;
            end
        end
        else if (shape == Z) begin
            if (rotate == 0 || rotate == 2) begin
                xy1 = topleft_block;
                xy2 = topleft_block - 1;
                xy3 = topleft_block + 15;
                xy4 = topleft_block + 14;
                brx = tlx + 2;
                bry = tly + 1;
            end
            else begin
                xy1 = topleft_block - 1;
                xy2 = topleft_block + 15;
                xy3 = topleft_block + 16;
                xy4 = topleft_block + 32;
                brx = tlx + 1;
                bry = tly + 2;
            end
        end
        else if (shape == J) begin
            if (rotate == 0) begin
                xy1 = topleft_block - 1;
                xy2 = topleft_block + 15;
                xy3 = topleft_block + 32;
                xy4 = topleft_block + 31;
                brx = tlx + 1; 
                bry = tly + 2; 
            end
            else if (rotate == 1) begin
                xy1 = topleft_block;
                xy2 = topleft_block + 16;
                xy3 = topleft_block + 15;
                xy4 = topleft_block + 14;
                brx = tlx + 2;
                bry = tly + 1;
            end
            else if (rotate == 2) begin
                xy1 = topleft_block;
                xy2 = topleft_block - 1;
                xy3 = topleft_block + 16;
                xy4 = topleft_block + 32;
                brx = tlx + 1;
                bry = tly + 2;
            end
            else if (rotate == 3) begin
                xy1 = topleft_block;
                xy2 = topleft_block - 1;
                xy3 = topleft_block - 2;
                xy4 = topleft_block + 14;
                brx = tlx + 2;
                bry = tly + 1;
            end
        end
        else if (shape == L) begin
            if (rotate == 0) begin
                xy1 = topleft_block;
                xy2 = topleft_block + 16;
                xy3 = topleft_block + 32;
                xy4 = topleft_block + 31;
                brx = tlx + 1; 
                bry = tly + 2; 
            end
            else if (rotate == 1) begin
                xy1 = topleft_block;
                xy2 = topleft_block - 1;
                xy3 = topleft_block - 2;
                xy4 = topleft_block + 16;
                brx = tlx + 2;
                bry = tly + 1;
            end
            else if (rotate == 2) begin
                xy1 = topleft_block;
                xy2 = topleft_block - 1;
                xy3 = topleft_block + 15;
                xy4 = topleft_block + 31;
                brx = tlx + 1;
                bry = tly + 2;
            end
            else if (rotate == 3) begin
                xy1 = topleft_block - 2;
                xy2 = topleft_block + 16;
                xy3 = topleft_block + 15;
                xy4 = topleft_block + 14;
                brx = tlx + 2;
                bry = tly + 1;
            end
        end        
    end
    
endmodule
