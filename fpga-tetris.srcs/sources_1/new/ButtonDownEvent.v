`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 12:42:09
// Design Name: 
// Module Name: ButtonDownEvent
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

// only when you press a button down is a button_down signal emitted
// 10hz
// in fact a 01 sequence detector implemented by finite state machine
module ButtonDownEvent(
    input clk_5mhz,
    input button,
    output btn_down
    );
    reg [22:0] count;
    
    reg cur_button;
    // is button pressed or released in last cycle
    reg prev_button;
    assign btn_down = (~prev_button) & cur_button;
    
    initial 
    begin
        count = 0;
        prev_button = 0;
    end
    
    always @ (posedge clk_5mhz) begin
        prev_button <= cur_button;
    end
    
    always @ (posedge clk_5mhz) begin
        if (count >= 23'd49999) begin
            count <= 0;
            cur_button <= button;
        end 
        else count <= count + 1;
    end
    
endmodule
