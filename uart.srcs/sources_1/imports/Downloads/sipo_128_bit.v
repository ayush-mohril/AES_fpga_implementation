`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2024 10:20:05
// Design Name: 
// Module Name: sipo_128_bit
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


module sipo_128_bit(
    input[7:0] serial_in,
    input clk,
    input reset,
    input en,
    output[127:0] data_out,
    output pkt_done
    );
    
    integer count;
    reg [127:0] temp;

    always @ (posedge clk, posedge reset)
        begin
            if (reset)
                begin
                    temp <= 'b0;
                    count <= 'b0;
                end
            else
                begin
                if(en)
                begin
                    if (count == 16)
                    begin
                        count <= 'b0;
                        temp <= 'b0;
                        
                        end
                    else
                        begin
                            count <= count + 1;
//                            temp <= {temp[127:1],serial_in};
                               temp <= {serial_in,temp[127:8]};
                        end
                        end
                  else
                  begin
                       temp <= temp;  
                       count <= count; 
                  end   
                end
        end
        
    assign {data_out,pkt_done} = (count == 16) ? {temp,1'b1}: 'b0;
   
        //assign data_out = temp ;

endmodule
