`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2024 13:05:20
// Design Name: 
// Module Name: baud_gen
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


module baud_gen(
    input  logic clk, reset,
    input logic [10:0]dvsr,
    output logic tick
    );
    
//declaration
logic [10:0]r_reg;
logic [10:0]r_next;

//body
//register
always_ff@(posedge clk, posedge reset)
    begin
        if(reset)
            r_reg <= 'b0;
        else
            r_reg <= r_next;
    end

//next state logic  
assign r_next = (r_reg == dvsr) ? 0 : r_reg + 1;

//output logic
assign tick = (r_reg==1);
endmodule
