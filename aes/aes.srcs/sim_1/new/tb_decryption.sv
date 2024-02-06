`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2024 12:28:54
// Design Name: 
// Module Name: tb_decryption
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


module tb_decryption();

reg [127:0] cipher,key;
reg clk,reset;
reg  [127:0]message;

always #5 clk = ~clk;

initial begin
    clk = 'b0;
    reset = 'b1;
    key = 128'h000102030405060708090a0b0c0d0e0f;
    cipher = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    #20 reset = 'b0;
    
    #2000 $finish();
end

decryption DUT (.*);
endmodule
