`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2024 18:20:24
// Design Name: 
// Module Name: combined
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

`include "sbox.v"
module combined(
input [127:0] data_in,key,
input clk,reset,
output [127:0] cipher
    );
    
    reg [127:0] s,k;
    
//    function [31:0] subword (input [31:0]o_word );
//    begin
//     sbox s1 (.sboxw(o_word), .new_sboxw(subword));
//    end
//    endfunction

wire [31:0] w0,w1,w2,w3;
wire [127:0] new_s;
reg [127:0] new_s_reg;
    
    always@(posedge clk,posedge reset)
    begin
    if(reset)
        begin
            s <=  'b0;
            k <= 'b0;
            new_s_reg <= 'b0;
        end
    else
        begin
            s<= data_in;
            k <= key;
            new_s_reg <= new_s;

        end    
    end
sbox s1 (.sboxw(s[31:0]), .new_sboxw(w0));
sbox s2 (.sboxw(s[63:32]), .new_sboxw(w1));
sbox s3 (.sboxw(s[95:64]), .new_sboxw(w2));
sbox s4 (.sboxw(s[127:96]), .new_sboxw(w3));
    
assign new_s = {w3,w2,w1,w0};
    
   assign cipher = new_s_reg; 
endmodule
