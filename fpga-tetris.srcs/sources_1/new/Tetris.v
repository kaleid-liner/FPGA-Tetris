`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 23:56:31
// Design Name: 
// Module Name: Tetris
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


module Tetris(
    input clk, 
    input reset,
    input rotate,
    input left,
    input right,
    output A, B, C, D, G, DI, CLK, LAT
    );
    reg [255:0] fallen_blocks;
    
    wire clk_5mhz;
    wire clk_1khz;
    wire clk_10hz;
    wire clk_1hz;
    
    // not from 0 - 6, as my rng can only generate rn from 1 - 7
    parameter I = 1, O = 2, T = 3, S = 4, Z = 5, J = 6, L = 7; 
    
    // use state machine to avoid multiple assignment 
    parameter PLAYING = 0, STOPPING = 1, CLEARING = 2, NOTHING = 3;
    reg [1:0] cur_state;
    
    reg [2:0] cur_shape;
    // top left coordinates of the falling tetromino, 
    // may not in cur_xy1234
    // center of rotation
    reg [3:0] cur_tlx, cur_tly; 
    // bottom right coordinates of the falling tetromino, 
    // may not in cur_xy1234
    wire [3:0] cur_brx, cur_bry; 
    // angle of rotation of the falling tetromino
    reg [1:0] cur_rotate; 
    // coordinates of the tetromino
    wire [7:0] cur_xy1, cur_xy2,
                cur_xy3, cur_xy4;  

    // in case of overflow use 5 bits to hold it
    wire [4:0] next_tlx, next_tly;
    wire [4:0] next_brx, next_bry;
    wire [1:0] next_rotate;
    wire [7:0] next_xy1, next_xy2,
                next_xy3, next_xy4;
    
    // internal signal of state machine
    wire down;
    pulse_1hz pulse (clk_5mhz, down);
    
    reg [3:0] row;
    
    wire [7:0] row_start;
    assign row_start = row << 4;
    
    wire clear;
    assign clear = &fallen_blocks[row_start+:16];
    reg [3:0] row_to_clear;
    
    wire [7:0] row_to_clear_start;
    assign row_to_clear_start = row_to_clear << 4;

    wire collide_with_fallen_blocks;
    CollideWithFallenBlocks collideWithFallenBlocks 
        (next_xy1, next_xy2, next_xy3, next_xy4, fallen_blocks, collide_with_fallen_blocks);
    
    wire collide_with_left_wall;
    assign collide_with_left_wall = (cur_tlx == 0) && left;
    
    wire collide_with_right_wall;
    assign collide_with_right_wall = next_brx >= 16;
    
    wire collide_with_bottom_wall;
    assign collide_with_bottom_wall = next_bry >= 16;
    
    wire game_over;
    assign game_over = (cur_tly == 0) && collide_with_fallen_blocks;
    
    wire random_number;
    RandomNumberGenerator rng (clk_5mhz, random_number);
    
    task AddCurTetrominoToFallen;
    begin
    fallen_blocks[cur_xy1] <= 1;
    fallen_blocks[cur_xy2 ] <= 1;
    fallen_blocks[cur_xy3] <= 1;
    fallen_blocks[cur_xy4] <= 1;
    end
    endtask
    
    task GenerateNewTetromino;
    begin
    cur_shape <= random_number;
    // center the tetromino
    if (cur_shape == I) 
        cur_tlx <= 6;
    else cur_tlx <= 7;
    cur_tly <= 0;
    end
    endtask
    
    initial begin
    end
    
    clk_wiz_0 display_clock (.clk_out1(clk_5mhz), .reset(reset), .clk_in1(clk));
    clock_1khz update_clock (clk_5mhz, clk_1khz);
    clock_10hz input_clock(clk_5mhz, clk_10hz);
    
    GameDisplayer gameDisplayer (clk_5mhz, fallen_blocks, cur_xy1, cur_xy2, cur_xy3, cur_xy4, 
                                 A, B, C, D, G, DI, CLK, LAT);
    CalcNextBlocks calcNextBlocks (cur_tlx, cur_tly, cur_rotate, 
                                    left, right, down, 
                                     next_tlx, next_tly, next_rotate);
    CalcCurBlocks calcCurXy (cur_tlx, cur_tly, cur_shape, cur_rotate, 
                                 cur_xy1, cur_xy2, cur_xy3, cur_xy4,
                                 cur_brx, cur_bry);
    CalcNextXy calcNextXy (next_tlx, next_tly, cur_shape, next_rotate, 
                                  next_xy1, next_xy2, next_xy3, next_xy4,
                                  next_brx, next_bry);
    
    always @(posedge down or posedge clk_5mhz) begin
        if (cur_state == PLAYING) begin
            if (left) begin
                if (collide_with_left_wall || collide_with_fallen_blocks) begin
                end
                else cur_tlx <= cur_tlx - 1;
            end
            else if (right) begin
                if (collide_with_right_wall || collide_with_fallen_blocks) begin
                end
                else cur_tlx <= cur_tlx + 1;
            end
            else if (rotate) begin
                if (collide_with_right_wall || collide_with_bottom_wall || 
                    collide_with_fallen_blocks) begin
                end
                else cur_rotate <= cur_rotate + 1;
            end              
            else if (down) begin
                if (collide_with_bottom_wall || collide_with_fallen_blocks) begin
                    GenerateNewTetromino();
                    AddCurTetrominoToFallen();
                end
                else cur_tly <= cur_tly + 1;
            end
            else if (clear) begin
                row_to_clear <= row;
                cur_state <= CLEARING;
            end
        end
        else if (cur_state == CLEARING) begin
            if (row_to_clear == 0) begin
                fallen_blocks[0+:16] <= 0;
                cur_state <= PLAYING;
            end
            else begin
                fallen_blocks[row_to_clear_start+:16] <= fallen_blocks[(row_to_clear_start - 1)-:16];
                row_to_clear <= row_to_clear - 1;
            end
        end
    end
    
    //scan row to judge if filled
    always @(posedge clk_1khz) begin
        row <= row + 1;
    end
endmodule
