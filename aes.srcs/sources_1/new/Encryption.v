`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2024 09:19:00 PM
// Design Name: 
// Module Name: Encryption
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


module Encryption(
    input [127:0] data_in,
    input [127:0] key,
    output [127:0] cipher
    );
    
    wire [127:0]s[0:9];
    wire [127:0]k[0:9];
   
    assign s[0] = data_in;
    assign k[0] = key;
    
    wire [31:0] w0,w1,w2,w3;
    
    sbox s1 (.sboxw(s[i][31:0]), .new_sboxw(w0));
    sbox s2 (.sboxw(s[i][63:32]), .new_sboxw(w1));
    sbox s3 (.sboxw(s[i][95:64]), .new_sboxw(w2));
    sbox s4 (.sboxw(s[i][127:96]), .new_sboxw(w3));
    
    
endmodule
