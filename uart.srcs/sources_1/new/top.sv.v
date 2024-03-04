`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2024 15:33:18
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
input   clk, reset,
    input  [10:0]dvsr,
     input  rx,
   output  tx,
   output [127:0] cipher  
   
    );
    reg  rx_done_tick            ;
    reg  [7:0] d_out             ;
    reg tx_start                 ;
    reg [7:0] din                ;
    reg  tx_done_tick            ;
    reg  [127:0] data_out        ;
    reg  pkt_don                 ;
     
    top_rohit ();
    Encryption ();
endmodule
