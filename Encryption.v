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
    input clk,reset,
    output [127:0] cipher
    );
    
    wire [127:0]s[0:9];
    reg  [127:0]state_round[0:9];
    wire [127:0]round_key[0:10];
    reg [127:0]shift_rows_ip, shift_rows_op;
    integer i;
   
    assign s[0] = data_in ^ round_key[0];
    
    key_expansion K1 (key, round_key[0], round_key[1], round_key[2], round_key[3], round_key[4], round_key[5],round_key[6],
                      round_key[7], round_key[8], round_key[9], round_key[10], clk , reset);
    
    reg [31:0] w0,w1,w2,w3;
    
    //w0 = s[0][127:96];
    //w1 = s[0][95:64];
    //w2 = s[0][63:32];
    //w3 = s[0][31:0];
    
    reg  [31:0]sboxw1,sboxw2,sboxw3,sboxw4;
    wire [31:0]new_sboxw1,new_sboxw2,new_sboxw3,new_sboxw4;
    
    always @ (posedge clk)
        begin
            if (reset)
                i <= 'b0;
            else
                i <= i+1;
        end
        
    always @ *
        begin
            if (i!=10)
                begin
                    state_round[i] = s[i];
                    //Sub_Bytes Function
                    fork        
                        sboxw1 = state_round[i][127:96];
                        sboxw2 = state_round[i][95:64];
                        sboxw3 = state_round[i][63:32];
                        sboxw4 = state_round[i][31:0];
                    join
                    shift_rows_ip = {new_sboxw1,new_sboxw2,new_sboxw3,new_sboxw4};
                    //Shift_Rows Function
                    fork
                        {shift_rows_op[127:120],shift_rows_op[95:88],shift_rows_op[63:56],shift_rows_op[31:24]} = 
                        {shift_rows_ip[127:120],shift_rows_ip[95:88],shift_rows_ip[63:56],shift_rows_ip[31:24]};
                        
                        {shift_rows_op[119:112],shift_rows_op[87:80],shift_rows_op[55:48],shift_rows_op[23:16]} =
                        {shift_rows_ip[87:80],shift_rows_ip[55:48],shift_rows_ip[23:16],shift_rows_ip[119:112]};
                        
                        {shift_rows_op[111:104],shift_rows_op[79:72],shift_rows_op[47:40],shift_rows_op[15:8]} =
                        {shift_rows_ip[47:40],shift_rows_ip[15:8],shift_rows_ip[111:104],shift_rows_ip[79:72]};
                        
                        {shift_rows_op[103:96],shift_rows_op[71:64],shift_rows_op[39:32],shift_rows_op[7:0]} = 
                        {shift_rows_ip[7:0],shift_rows_ip[103:96],shift_rows_ip[71:64],shift_rows_ip[39:32]};
                    join
                    
                    //Mix_Columns_Function
                end
            else
                begin
                end
        end
    
    sbox sw1 (.sboxw(sboxw1), .new_sboxw(new_sboxw1)); 
    sbox sw2 (.sboxw(sboxw2), .new_sboxw(new_sboxw2));
    sbox sw3 (.sboxw(sboxw3), .new_sboxw(new_sboxw3));
    sbox sw4 (.sboxw(sboxw4), .new_sboxw(new_sboxw4));  
endmodule
