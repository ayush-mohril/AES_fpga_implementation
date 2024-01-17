`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2024 02:55:35 PM
// Design Name: 
// Module Name: tb_keyexpansion
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


module tb_keyexpansion();

    logic [127:0] key;
    logic  [127:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10;
    logic clk,reset;
    
    key_expansion DUT (.*);
    always #5 clk = ~clk;
    initial
    begin
    clk = 'b0;
    reset = 1;
    key = 128'h000102030405060708090a0b0c0d0e0f;
    
    #20 reset = 0;
    
    #390 $finish(); 
    end
endmodule
