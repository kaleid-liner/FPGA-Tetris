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
`include "Constants.vh"

module Tetris(
    input clk, 
    input reset,
    input rotate,
    input left,
    input right,
    input drop,
    input stop,
    output A, B, C, D, G, DI, CLK, LAT,
    output [7:0] an,
    output [6:0] seg
    );
    reg [255:0] fallen_blocks;
    
    // score 
    reg [3:0] ones_score;
    reg [3:0] tens_score;
    reg [3:0] hundreds_score;
    reg [3:0] thousands_score;
    
    wire clk_5mhz;
    wire clk_1khz;
    wire clk_10hz;
    wire clk_1hz;
    
    // not from 0 - 6, as my rng can only generate rn from 1 - 7
    
    // use state machine to avoid multiple assignment 
    parameter PLAYING = 0, STOPPING = 1, CLEARING = 2, NOTHING = 3, DROPPING = 4, DEAD = 5;
    reg [2:0] cur_state;
    
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
    wire down_signal;
    pulse_1hz pulse (clk_5mhz, down_signal);
    
    wire right_signal;
    ButtonDownEvent btnr_down (clk_5mhz, right, right_signal);
    
    wire left_signal;
    ButtonDownEvent btnl_down (clk_5mhz, left, left_signal);
    
    wire rotate_signal;
    ButtonDownEvent btnu_down (clk_5mhz, rotate, rotate_signal);
    
    wire drop_signal;
    ButtonDownEvent btnd_down (clk_5mhz, drop, drop_signal);
    
    reg [3:0] row;
    
    wire [7:0] row_start;
    assign row_start = row << 4;
    
    wire clear_signal;
    assign clear_signal = &fallen_blocks[row_start+:16];
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
    
    wire [2:0] random_number;
    RandomNumberGenerator rng (clk_5mhz, random_number);
    
    task AddCurTetrominoToFallen;
    begin
    fallen_blocks[cur_xy1] <= 1;
    fallen_blocks[cur_xy2] <= 1;
    fallen_blocks[cur_xy3] <= 1;
    fallen_blocks[cur_xy4] <= 1;
    end
    endtask
    
    task GenerateNewTetromino;
    begin
    cur_shape <= random_number;
    cur_rotate <= 0;
    // center the tetromino
    if (random_number == `I) 
        cur_tlx = 6;
    else cur_tlx = 7;
    cur_tly <= 0;
    end
    endtask
    
    task ResetGame;
    begin
    ones_score <= 0;
    tens_score <= 0;
    hundreds_score <= 0;
    thousands_score <= 0;
    fallen_blocks <= 0;
    GenerateNewTetromino();
    end
    endtask
    
    task GetScore;
    begin
    if (ones_score == 9) begin
        if (tens_score == 9) begin
            if (hundreds_score == 9) begin
                if (thousands_score == 9) begin 
                end
                else begin thousands_score <= thousands_score + 1;
                hundreds_score <= 0;
                tens_score <= 0;
                ones_score <= 0;
                end
            end
            else begin hundreds_score <= hundreds_score + 1;
            tens_score <= 0;
            ones_score <= 0;
            end
        end
        else tens_score <= tens_score + 1;
        ones_score <= 0;
    end
    else ones_score <= ones_score + 1;
    end
    endtask
    
    initial begin
    cur_state = PLAYING;
    fallen_blocks = 0;
    cur_shape = `I;
    cur_tlx = 6;
    cur_tly = 0;
    cur_rotate = 0;
    ones_score = 0;
    tens_score = 0;
    hundreds_score = 0;
    thousands_score = 0;
    end
    
    clk_wiz_0 display_clock (.clk_out1(clk_5mhz), .reset(0), .clk_in1(clk));
    clock_1khz update_clock (clk_5mhz, clk_1khz);
    clock_10hz input_clock (clk_5mhz, clk_10hz);
    
    GameDisplayer gameDisplayer (clk_5mhz, cur_state, fallen_blocks, 
                                 cur_xy1, cur_xy2, cur_xy3, cur_xy4, 
                                 A, B, C, D, G, DI, CLK, LAT);
    CalcNextBlocks calcNextBlocks (cur_state, cur_tlx, cur_tly, cur_rotate, 
                                    left_signal, right_signal, down_signal, rotate_signal,
                                     next_tlx, next_tly, next_rotate);
    CalcCurBlocks calcCurXy (cur_tlx, cur_tly, cur_shape, cur_rotate, 
                             cur_xy1, cur_xy2, cur_xy3, cur_xy4,
                             cur_brx, cur_bry);
    CalcNextXy calcNextXy (next_tlx, next_tly, cur_shape, next_rotate, 
                           next_xy1, next_xy2, next_xy3, next_xy4,
                           next_brx, next_bry);
    bcd_decoder(.clock(clk_5mhz), .x0(ones_score), .x1(tens_score),
                .x2(hundreds_score), .x3(thousands_score),
                .an(an), .seg(seg));
    
    always @(posedge clk_5mhz) begin
        if (cur_state == PLAYING) begin
            if (game_over) begin
                cur_state <= DEAD;
            end
            else if (stop) begin
                cur_state <= STOPPING;
            end
            if (left_signal) begin
                if (collide_with_left_wall || collide_with_fallen_blocks) begin
                end
                else cur_tlx <= cur_tlx - 1;
            end
            else if (right_signal) begin
                if (collide_with_right_wall || collide_with_fallen_blocks) begin
                end
                else cur_tlx <= cur_tlx + 1;
            end
            else if (rotate_signal) begin
                if (collide_with_right_wall || collide_with_bottom_wall || 
                    collide_with_fallen_blocks) begin
                end
                else cur_rotate <= cur_rotate + 1;
            end
            else if (drop_signal) begin
                cur_state <= DROPPING;
            end              
            else if (down_signal) begin
                if (collide_with_bottom_wall || collide_with_fallen_blocks) begin
                    AddCurTetrominoToFallen();
                    GenerateNewTetromino();
                end
                else cur_tly <= cur_tly + 1;
            end
            else if (clear_signal) begin
                row_to_clear <= row;
                cur_state <= CLEARING;
            end
            else if (reset) begin
                ResetGame();
            end
        end
        else if (cur_state == CLEARING) begin
            if (row_to_clear == 0) begin
                fallen_blocks[0+:16] <= 0;
                cur_state <= PLAYING;
                GetScore();
            end
            else begin
                fallen_blocks[row_to_clear_start+:16] <= fallen_blocks[(row_to_clear_start - 1)-:16];
                row_to_clear <= row_to_clear - 1;
            end
        end
        else if (cur_state == DROPPING) begin
            if (collide_with_bottom_wall || collide_with_fallen_blocks) begin
                AddCurTetrominoToFallen();
                GenerateNewTetromino();
                cur_state <= PLAYING;
            end
            else cur_tly <= cur_tly + 1;
        end
        else if (cur_state == STOPPING) begin
            if (!stop)
                cur_state <= PLAYING;
        end
        else if (cur_state == DEAD) begin
            if (reset) begin
                ResetGame();
                cur_state <= PLAYING;
            end  
        end
    end
    
    //scan row to judge if filled
    always @(posedge clk_5mhz) begin
        row <= row + 1;
    end
endmodule
