`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2024 11:03:53 PM
// Design Name: 
// Module Name: tb_encryption
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


module tb_encryption();
logic [127:0] data_in;
logic [127:0] key;
logic clk,reset;
logic [127:0] cipher;

Encryption E (.*);

always #5 clk = ~clk;

initial
    begin
        clk = 'b0;
        reset = 'b1;
        data_in = 128'h3243f6a8885a308d313198a2e0370734;
        key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        #20 reset = 'b0;
        #500 $finish();
    end
endmodule
