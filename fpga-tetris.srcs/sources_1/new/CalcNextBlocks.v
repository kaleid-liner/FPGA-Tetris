`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/11 17:20:06
// Design Name: 
// Module Name: CalcNextBlocks
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


module CalcNextBlocks(
    input [2:0] state,
    input [3:0] cur_x, cur_y,
    input [1:0] rotation,
    input left, right, down, rot,
    output reg [4:0] next_x, next_y,
    output reg [1:0] next_rotation
    );
    parameter PLAYING = 0, STOPPING = 1, CLEARING = 2, NOTHING = 3, DROPPING = 4;
    
    always @ (cur_x, cur_y, left, right, down, rot, rotation, state) begin
        if (state == PLAYING) begin
            if (down) begin next_x  = cur_x; next_y = cur_y + 1; next_rotation = rotation; end
            else if (left) begin next_x = cur_x - 1; next_y = cur_y; next_rotation = rotation; end
            else if (right) begin next_x = cur_x + 1; next_y = cur_y; next_rotation = rotation; end
            else if (rot) begin next_x = cur_x; next_y = cur_y; next_rotation = rotation + 1; end
            else begin next_x = cur_x; next_y = cur_y; next_rotation = rotation; end
        end
        else if (state == DROPPING) begin
            next_x = cur_x; next_y = cur_y + 1; next_rotation = rotation;
        end
        else begin
            next_x = cur_x; next_y = cur_y; next_rotation = rotation;
        end
    end
endmodule
