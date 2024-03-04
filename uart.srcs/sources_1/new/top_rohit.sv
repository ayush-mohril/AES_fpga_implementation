`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2024 14:14:12
// Design Name: 
// Module Name: top_rohit
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


module top_rohit(
input  logic clk, reset,
    input logic [10:0]dvsr,
     input logic rx,
    output logic rx_done_tick,
    output logic [7:0] d_out,
    
    input logic tx_start,
     input logic [7:0] din,
     output logic tx_done_tick,
     output logic tx,
     output [127:0] data_out,
    output pkt_done
    );
    logic tick;
    baud_gen BAUD (.*,.tick(tick));
    rx_uart RX (.*,.s_tick(tick));
    tx_uart TX(.*,.s_tick(tick));
    sipo_128_bit SIPO (.serial_in(d_out),.en(rx_done_tick),.*);
endmodule
