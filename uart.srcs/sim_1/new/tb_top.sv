`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2024 16:37:52
// Design Name: 
// Module Name: tb_top
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


module tb_top();

logic          Clk             ; // Clock
logic          Rst_n           ; // Reset
logic          Rx              ; // RS232 RX line.
//logic          Tx              ; // RS232 TX line.
logic [7:0]    RxData ;

TOP DUT(.*);

always #5 Clk = ~Clk;
always #104us Rx = ~Rx;

initial begin
Clk = 'b0;
Rx = 1'b1;
Rst_n = 'b0;

#100 Rst_n = 'b1;

#1000 $finish();
end

endmodule
