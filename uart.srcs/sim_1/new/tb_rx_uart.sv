`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2024 14:06:36
// Design Name: 
// Module Name: tb_rx_uart
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


module tb_rx_uart();
 logic clk, reset;
 logic [10:0]dvsr;
 logic rx;
// logic [127:0] cipher;
 logic [127:0] message;

// logic rx_done_tick;
// logic [7:0] d_out;
 logic tx_start;
logic [7:0] din;
// logic tx_done_tick;
 logic tx;
// logic [127:0]data_out;logic pkt_done;
 task rx_data();
 
 
// #208us rx = 'b0;
// #104us rx = $urandom();
// #104us rx = $urandom();
// #104us rx = $urandom();
// #104us rx = $urandom();
// #104us rx = $urandom();
// #104us rx = $urandom();
// #104us rx = $urandom();
// #104us rx = $urandom();
// #104us rx = 'b1;

#2.16us rx = 'b0;
 #1.08us rx = $urandom();
 #1.08us rx = $urandom();
 #1.08us rx = $urandom();
 #1.08us rx = $urandom();
 #1.08us rx = $urandom();
 #1.08us rx = $urandom();
 #1.08us rx = $urandom();
 #1.08us rx = $urandom();
 #1.08us rx = 'b1;
 endtask
 always #5 clk  =  ~clk;
//always #104us rx = $urandom();
//top_rohit dut(.*);
top dut (.*);
 initial begin
 clk = 'b0;
 reset = 'b1;
 //s_tick = 'b0;
 //dvsr = 16'd650; 
  dvsr = 16'd6; 

 rx = 'b1;
 tx_start = 'b0;
 din = $urandom();
 #100 reset = 'b0;
 
 repeat(300)
 rx_data();
 
 
 tx_start = 'b1;
 
 #100 $finish();
 end
endmodule
