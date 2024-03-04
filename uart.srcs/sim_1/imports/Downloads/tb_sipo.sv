`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2024 10:27:45
// Design Name: 
// Module Name: tb_sipo
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


module tb_sipo();
    logic [7:0] serial_in;
    bit clk;
    bit reset;
    logic[127:0] data_out;
    sipo_128_bit DUT(.*);
    
    always #5 clk = ~clk;
    always #10 serial_in = $urandom();
    
    initial
        begin
            serial_in = 'b0;
            reset = 'b1;
            #20 reset = 'b0;
            #2000 $finish;                    
        end
endmodule
