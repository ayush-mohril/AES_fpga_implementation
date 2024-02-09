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
    input [127:0]round_key[0],
    input en,
    output reg [127:0] cipher
    );
    
    reg [127:0]s[0:9];
    reg  [127:0]state_round[0:9];
   // wire [127:0]round_key[0:10];
    //wire en;
    reg [127:0]shift_rows_ip, shift_rows_op;
//    reg [127:0] mix_columns_const = {8'h02,8'h01,8'h01,8'h03,
//                                     8'h03,8'h02,8'h01,8'h01,
//                                     8'h01,8'h03,8'h02,8'h01,
//                                     8'h01,8'h01,8'h03,8'h02};
    wire [127:0] temp;
    reg [127:0] mix_columns_op;
    integer i;
   function [7:0] mul2(input [7:0]data_in);
        mul2 = (data_in<<1'b1) ^ (8'h1b &{8{data_in[7]}});
   endfunction
   
   function [7:0] mul3(input [7:0]data_in);
        mul3 = (mul2(data_in)^data_in);
   endfunction
   
   
    //initial s[0] = data_in ^ key;
    assign temp = data_in ^ round_key[0];
//    key_expansion K1 (.key(key), .k0(round_key[0]), .k1(round_key[1]), .k2(round_key[2]), .k3(round_key[3]), .k4(round_key[4]), .k5(round_key[5]),.k6(round_key[6]),
//                      .k7(round_key[7]), .k8(round_key[8]), .k9(round_key[9]), .k10(round_key[10]),.en(en), .clk(clk) , .reset(reset));
    
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
                begin
                    i <= 'b0;
//                    s[0] = data_in ^ round_key[0];
                end
            else
            if (en == 'b1)
                i <= i+1;
            else
                i<= 0;    
        end
        
    always @ *
        begin
            //s[0] = temp;
            if(en == 1)
            begin
            if (i!=9)
                begin
                    s[0] = data_in ^ key;
                    state_round[i] = s[i];
                    //Sub_Bytes Function
                    //fork        
                        sboxw1 = state_round[i][127:96];
                        sboxw2 = state_round[i][95:64];
                        sboxw3 = state_round[i][63:32];
                        sboxw4 = state_round[i][31:0];
                    //join
                    shift_rows_ip = {new_sboxw1,new_sboxw2,new_sboxw3,new_sboxw4};
                    //Shift_Rows Function
                    //fork
                        {shift_rows_op[127:120],shift_rows_op[95:88],shift_rows_op[63:56],shift_rows_op[31:24]} = 
                        {shift_rows_ip[127:120],shift_rows_ip[95:88],shift_rows_ip[63:56],shift_rows_ip[31:24]};
                        
                        {shift_rows_op[119:112],shift_rows_op[87:80],shift_rows_op[55:48],shift_rows_op[23:16]} =
                        {shift_rows_ip[87:80],shift_rows_ip[55:48],shift_rows_ip[23:16],shift_rows_ip[119:112]};
                        
                        {shift_rows_op[111:104],shift_rows_op[79:72],shift_rows_op[47:40],shift_rows_op[15:8]} =
                        {shift_rows_ip[47:40],shift_rows_ip[15:8],shift_rows_ip[111:104],shift_rows_ip[79:72]};
                        
                        {shift_rows_op[103:96],shift_rows_op[71:64],shift_rows_op[39:32],shift_rows_op[7:0]} = 
                        {shift_rows_ip[7:0],shift_rows_ip[103:96],shift_rows_ip[71:64],shift_rows_ip[39:32]};
                    //join
                    
                    //Mix_Columns_Function
                    //fork
//                        mix_columns_op[127:120] = (shift_rows_op[127:120]<<1) ^ (shift_rows_op[119:112]<<1 ^shift_rows_op[119:112]) ^ shift_rows_op[111:104] ^ shift_rows_op[103:96]; 
//                        mix_columns_op[119:112] = shift_rows_op[127:120] ^ (shift_rows_op[119:112]<<1) ^ (shift_rows_op[111:104]<<1 ^ shift_rows_op[111:104]) ^ shift_rows_op[103:96];
//                        mix_columns_op[111:104] = shift_rows_op[127:120] ^ shift_rows_op[119:112] ^ (shift_rows_op[111:104]<<1) ^ (shift_rows_op[103:96]<<1 ^ shift_rows_op[103:96]);
//                        mix_columns_op[103:96]  = (shift_rows_op[127:120]<<1 ^ shift_rows_op[127:120]) ^ shift_rows_op[119:112] ^ shift_rows_op[111:104] ^ (shift_rows_op[103:96]<<1);
                        
//                        mix_columns_op[95:88]   = (shift_rows_op[95:88]<<1) ^ (shift_rows_op[87:80]<<1 ^ shift_rows_op[87:80]) ^ shift_rows_op[79:72] ^ shift_rows_op[71:64];
//                        mix_columns_op[87:80]   = shift_rows_op[95:88] ^ (shift_rows_op[87:80]<<1) ^ (shift_rows_op[79:72]<<1 ^ shift_rows_op[79:72]) ^ shift_rows_op[71:64];
//                        mix_columns_op[79:72]   = shift_rows_op[95:88] ^ shift_rows_op[87:80] ^ (shift_rows_op[79:72]<<1) ^ (shift_rows_op[71:64]<<1 ^ shift_rows_op[71:64]);
//                        mix_columns_op[71:64]   = (shift_rows_op[95:88]<<1 ^ shift_rows_op[95:88]) ^ shift_rows_op[87:80] ^ shift_rows_op[79:72] ^ (shift_rows_op[71:64]<<1);
                        
//                        mix_columns_op[63:56]   = (shift_rows_op[63:56]<<1) ^ (shift_rows_op[55:48]<<1 ^ shift_rows_op[55:48]) ^ shift_rows_op[47:40] ^ shift_rows_op[39:32];
//                        mix_columns_op[55:48]   = shift_rows_op[63:56] ^ (shift_rows_op[55:48]<<1) ^ (shift_rows_op[47:40]<<1 ^ shift_rows_op[47:40]) ^ shift_rows_op[39:32];
//                        mix_columns_op[47:40]   = shift_rows_op[63:56] ^ shift_rows_op[55:48] ^ (shift_rows_op[47:40]<<1) ^ (shift_rows_op[39:32]<<1 ^ shift_rows_op[39:32]);
//                        mix_columns_op[39:32]   = (shift_rows_op[63:56]<<1 ^ shift_rows_op[63:56]) ^ shift_rows_op[55:48] ^ shift_rows_op[47:40] ^ (shift_rows_op[39:32]<<1);
                        
//                        mix_columns_op[31:24]   = (shift_rows_op[31:24]<<1) ^ (shift_rows_op[23:16]<<1 ^ shift_rows_op[23:16]) ^ shift_rows_op[15:8] ^ shift_rows_op[7:0];
//                        mix_columns_op[23:16]   = shift_rows_op[31:24] ^ (shift_rows_op[23:16]<<1) ^ (shift_rows_op[15:8]<<1 ^ shift_rows_op[15:8]) ^ shift_rows_op[7:0];
//                        mix_columns_op[15:8]    = shift_rows_op[31:24] ^ shift_rows_op[23:16] ^ (shift_rows_op[15:8]<<1) ^ (shift_rows_op[7:0]<<1 ^ shift_rows_op[7:0]);
//                        mix_columns_op[7:0]     = (shift_rows_op[31:24]<<1 ^ shift_rows_op[31:24]) ^ shift_rows_op[23:16] ^ shift_rows_op[15:8] ^ (shift_rows_op[7:0]<<1);
                    //join
                     mix_columns_op[127:120] = mul2(shift_rows_op[127:120]) ^ mul3(shift_rows_op[119:112]) ^ shift_rows_op[111:104] ^ shift_rows_op[103:96]; 
                        mix_columns_op[119:112] = shift_rows_op[127:120] ^ mul2(shift_rows_op[119:112]) ^ mul3(shift_rows_op[111:104]) ^ shift_rows_op[103:96];
                        mix_columns_op[111:104] = shift_rows_op[127:120] ^ shift_rows_op[119:112] ^ mul2(shift_rows_op[111:104]) ^ mul3(shift_rows_op[103:96]);
                        mix_columns_op[103:96]  = mul3(shift_rows_op[127:120]) ^ shift_rows_op[119:112] ^ shift_rows_op[111:104] ^ mul2(shift_rows_op[103:96]);
                        
                        mix_columns_op[95:88]   = mul2(shift_rows_op[95:88]) ^ mul3(shift_rows_op[87:80]) ^ shift_rows_op[79:72] ^ shift_rows_op[71:64];
                        mix_columns_op[87:80]   = shift_rows_op[95:88] ^ mul2(shift_rows_op[87:80]) ^ mul3(shift_rows_op[79:72]) ^ shift_rows_op[71:64];
                        mix_columns_op[79:72]   = shift_rows_op[95:88] ^ shift_rows_op[87:80] ^ mul2(shift_rows_op[79:72]) ^ mul3(shift_rows_op[71:64]);
                        mix_columns_op[71:64]   = mul3(shift_rows_op[95:88]) ^ shift_rows_op[87:80] ^ shift_rows_op[79:72] ^ mul2(shift_rows_op[71:64]);
                        
                        mix_columns_op[63:56]   = mul2(shift_rows_op[63:56]) ^ mul3(shift_rows_op[55:48]) ^ shift_rows_op[47:40] ^ shift_rows_op[39:32];
                        mix_columns_op[55:48]   = shift_rows_op[63:56] ^ mul2(shift_rows_op[55:48]) ^ mul3(shift_rows_op[47:40]) ^ shift_rows_op[39:32];
                        mix_columns_op[47:40]   = shift_rows_op[63:56] ^ shift_rows_op[55:48] ^ mul2(shift_rows_op[47:40]) ^ mul3(shift_rows_op[39:32]);
                        mix_columns_op[39:32]   = mul3(shift_rows_op[63:56]) ^ shift_rows_op[55:48] ^ shift_rows_op[47:40] ^ mul2(shift_rows_op[39:32]);
                        
                        mix_columns_op[31:24]   = mul2(shift_rows_op[31:24]) ^ mul3(shift_rows_op[23:16]) ^ shift_rows_op[15:8] ^ shift_rows_op[7:0];
                        mix_columns_op[23:16]   = shift_rows_op[31:24] ^ mul2(shift_rows_op[23:16]) ^ mul3(shift_rows_op[15:8]) ^ shift_rows_op[7:0];
                        mix_columns_op[15:8]    = shift_rows_op[31:24] ^ shift_rows_op[23:16] ^ mul2(shift_rows_op[15:8]) ^ mul3(shift_rows_op[7:0]);
                        mix_columns_op[7:0]     = mul3(shift_rows_op[31:24]) ^ shift_rows_op[23:16] ^ shift_rows_op[15:8] ^ mul2(shift_rows_op[7:0]);
                    //Add_Round_Key
                    s[i+1] = mix_columns_op ^ round_key[i+1];
                    cipher = 0;
                end
            else
                begin
                    state_round[i] = s[i];
                    //Sub_Bytes Function
                    //fork        
                        sboxw1 = state_round[i][127:96];
                        sboxw2 = state_round[i][95:64];
                        sboxw3 = state_round[i][63:32];
                        sboxw4 = state_round[i][31:0];
                    //join
                    shift_rows_ip = {new_sboxw1,new_sboxw2,new_sboxw3,new_sboxw4};
                    //Shift_Rows Function
                    //fork
                        {shift_rows_op[127:120],shift_rows_op[95:88],shift_rows_op[63:56],shift_rows_op[31:24]} = 
                        {shift_rows_ip[127:120],shift_rows_ip[95:88],shift_rows_ip[63:56],shift_rows_ip[31:24]};
                        
                        {shift_rows_op[119:112],shift_rows_op[87:80],shift_rows_op[55:48],shift_rows_op[23:16]} =
                        {shift_rows_ip[87:80],shift_rows_ip[55:48],shift_rows_ip[23:16],shift_rows_ip[119:112]};
                        
                        {shift_rows_op[111:104],shift_rows_op[79:72],shift_rows_op[47:40],shift_rows_op[15:8]} =
                        {shift_rows_ip[47:40],shift_rows_ip[15:8],shift_rows_ip[111:104],shift_rows_ip[79:72]};
                        
                        {shift_rows_op[103:96],shift_rows_op[71:64],shift_rows_op[39:32],shift_rows_op[7:0]} = 
                        {shift_rows_ip[7:0],shift_rows_ip[103:96],shift_rows_ip[71:64],shift_rows_ip[39:32]};
                   // join
                    
                    cipher = shift_rows_op ^ round_key[i+1];
                end
            end
            
            
            else
            
            begin
            cipher = 0;
            
            end
            end
    
    sbox sw1 (.sboxw(sboxw1), .new_sboxw(new_sboxw1)); 
    sbox sw2 (.sboxw(sboxw2), .new_sboxw(new_sboxw2));
    sbox sw3 (.sboxw(sboxw3), .new_sboxw(new_sboxw3));
    sbox sw4 (.sboxw(sboxw4), .new_sboxw(new_sboxw4));  
endmodule
