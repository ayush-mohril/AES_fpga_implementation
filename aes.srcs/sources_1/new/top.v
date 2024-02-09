`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2024 12:53:03
// Design Name: 
// Module Name: top
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


module top(
 input [127:0] data_in,
 input [127:0] key,
 input clk,reset,
 output reg [127:0] message
    );
    reg [127:0] round_key[0:10];
    reg en;
    reg [4:0] a;
    key_expansion K1 (.key(key), .k0(round_key[0]), .k1(round_key[1]), .k2(round_key[2]), .k3(round_key[3]), .k4(round_key[4]), .k5(round_key[5]),.k6(round_key[6]),
                      .k7(round_key[7]), .k8(round_key[8]), .k9(round_key[9]), .k10(round_key[10]),.en(en), .clk(clk) , .reset(reset));
    
    always@(posedge clk)
    begin
    if(reset)
    a <= 'b0;
    else
    begin
    if (en == 1)
    begin
        a <= a+1; 
    end
    end
    end
endmodule
