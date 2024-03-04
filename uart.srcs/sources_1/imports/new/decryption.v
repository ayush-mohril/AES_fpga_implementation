`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2024 11:57:51
// Design Name: 
// Module Name: decryption
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


module decryption(
input [127:0] cipher,
input [127:0]round_key_0,round_key_1,round_key_2,round_key_3,round_key_4,round_key_5,round_key_6,round_key_7,round_key_8,round_key_9,round_key_10,
input clk,reset,
input en,
output reg [127:0]message
);



    
    reg [127:0]s[0:9];
    reg  [127:0]state_round[0:9];
    reg [127:0] round_key_ip,round_key_op;
    wire [127:0]round_key[0:10];
    //wire en;
    reg [127:0]shift_rows_ip, shift_rows_op;
//    reg [127:0] mix_columns_const = {8'h02,8'h01,8'h01,8'h03,
//                                     8'h03,8'h02,8'h01,8'h01,
//                                     8'h01,8'h03,8'h02,8'h01,
//                                     8'h01,8'h01,8'h03,8'h02};
    wire [127:0] temp;
    reg [127:0] mix_columns_op;
    integer i,j;
     reg [7:0] mul_temp;
     
     assign round_key[0]=round_key_0;
    assign round_key[1]=round_key_1;
    assign round_key[2]=round_key_2;
    assign round_key[3]=round_key_3;
    assign round_key[4]=round_key_4;
    assign round_key[5]=round_key_5;
    assign round_key[6]=round_key_6;
    assign round_key[7]=round_key_7;
    assign round_key[8]=round_key_8;
    assign round_key[9]=round_key_9;
    assign round_key[10]=round_key_10;
    
   function [7:0] mul2(input [7:0]data_in);
        mul2 = (data_in<<1'b1) ^ (8'h1b &{8{data_in[7]}});
   endfunction
   function [7:0] mul4(input [7:0]data_in);
       // mul4 = (data_in<<2) ^ (8'h1b &{8{data_in[7]}});
       begin
        for (j=0;j<2;j=j+1)
        begin
            if(j == 0)
            mul_temp = mul2(data_in);
            else
            mul_temp = mul2(mul_temp); 
        end
      //  if(j=>2)
        mul4 = mul_temp;
        end
   endfunction
//    function [7:0] mul8(input [7:0]data_in);
//        mul8 = (data_in<<3) ^ (8'h1b &{8{data_in[7]}});
//   endfunction
   
   function [7:0] mul8(input [7:0]data_in);
   begin
        for (j=0;j<3;j=j+1)
        begin
            if(j == 0)
            mul_temp = mul2(data_in);
            else
            mul_temp = mul2(mul_temp); 
        end
      //  if(j=>2)
        mul8 = mul_temp;
        end
   endfunction
   
   function [7:0] mule (input [7:0]data_in);
        mule = mul8(data_in)^mul4(data_in)^mul2(data_in);
   endfunction
   
   function [7:0] mulb (input [7:0]data_in);
        mulb = mul8(data_in)^mul2(data_in)^data_in;
   endfunction
   
   function [7:0] muld (input [7:0]data_in);
        muld = mul8(data_in)^mul4(data_in)^data_in;
   endfunction
   function [7:0] mul9 (input [7:0]data_in);
        mul9 = mul8(data_in)^data_in;
   endfunction
//   function [7:0] mul3(input [7:0]data_in);
//        mul3 = (mul2(data_in)^data_in);
//   endfunction
   
   
    //initial s[0] = data_in ^ key;
    assign temp = cipher ^ round_key[0];
//    key_expansion Kd (.key(key), .k0(round_key[0]), .k1(round_key[1]), .k2(round_key[2]), .k3(round_key[3]), .k4(round_key[4]), .k5(round_key[5]),.k6(round_key[6]),
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
                    s[0] = cipher ^ round_key[10];
                    state_round[i] = s[i];
                    
                    //Shift_Rows Function
                   shift_rows_ip = {state_round[i][127:96],state_round[i][95:64],state_round[i][63:32],state_round[i][31:0]};
                        {shift_rows_op[127:120],shift_rows_op[95:88],shift_rows_op[63:56],shift_rows_op[31:24]} = 
                        {shift_rows_ip[127:120],shift_rows_ip[95:88],shift_rows_ip[63:56],shift_rows_ip[31:24]};
                        
                        {shift_rows_op[119:112],shift_rows_op[87:80],shift_rows_op[55:48],shift_rows_op[23:16]} =
                        
                        {shift_rows_ip[23:16],shift_rows_ip[119:112],shift_rows_ip[87:80],shift_rows_ip[55:48]};
                        
                        {shift_rows_op[111:104],shift_rows_op[79:72],shift_rows_op[47:40],shift_rows_op[15:8]} =
                        {shift_rows_ip[47:40],shift_rows_ip[15:8],shift_rows_ip[111:104],shift_rows_ip[79:72]};
                        
                        {shift_rows_op[103:96],shift_rows_op[71:64],shift_rows_op[39:32],shift_rows_op[7:0]} = 
                        {shift_rows_ip[71:64],shift_rows_ip[39:32],shift_rows_ip[7:0],shift_rows_ip[103:96]};
           
           
                    //Sub_Bytes Function
                           
                        sboxw1 = shift_rows_op[127:96];
                        sboxw2 = shift_rows_op[95:64];
                        sboxw3 = shift_rows_op[63:32];
                        sboxw4 = shift_rows_op[31:0];
                   
                    round_key_ip = {new_sboxw1,new_sboxw2,new_sboxw3,new_sboxw4};
                     round_key_op = round_key_ip ^ round_key[(10-i)-1];
           
                        mix_columns_op[127:120] = mule(round_key_op[127:120]) ^ mulb(round_key_op[119:112]) ^ muld(round_key_op[111:104]) ^ mul9(round_key_op[103:96]); 
                        mix_columns_op[119:112] = mul9(round_key_op[127:120]) ^ mule(round_key_op[119:112]) ^ mulb(round_key_op[111:104]) ^ muld(round_key_op[103:96]);
                        mix_columns_op[111:104] = muld(round_key_op[127:120]) ^ mul9(round_key_op[119:112]) ^ mule(round_key_op[111:104]) ^ mulb(round_key_op[103:96]);
                        mix_columns_op[103:96]  = mulb(round_key_op[127:120]) ^ muld(round_key_op[119:112]) ^ mul9(round_key_op[111:104]) ^ mule(round_key_op[103:96]);
                        
                        mix_columns_op[95:88]   = mule(round_key_op[95:88]) ^ mulb(round_key_op[87:80]) ^ muld(round_key_op[79:72]) ^ mul9(round_key_op[71:64]);
                        mix_columns_op[87:80]   = mul9(round_key_op[95:88]) ^ mule(round_key_op[87:80]) ^ mulb(round_key_op[79:72]) ^ muld(round_key_op[71:64]);
                        mix_columns_op[79:72]   = muld(round_key_op[95:88]) ^ mul9(round_key_op[87:80]) ^ mule(round_key_op[79:72]) ^ mulb(round_key_op[71:64]);
                        mix_columns_op[71:64]   = mulb(round_key_op[95:88]) ^ muld(round_key_op[87:80]) ^ mul9(round_key_op[79:72]) ^ mule(round_key_op[71:64]);
                        
                        mix_columns_op[63:56]   = mule(round_key_op[63:56]) ^ mulb(round_key_op[55:48]) ^ muld(round_key_op[47:40]) ^ mul9(round_key_op[39:32]);
                        mix_columns_op[55:48]   = mul9(round_key_op[63:56]) ^ mule(round_key_op[55:48]) ^ mulb(round_key_op[47:40]) ^ muld(round_key_op[39:32]);
                        mix_columns_op[47:40]   = muld(round_key_op[63:56]) ^ mul9(round_key_op[55:48]) ^ mule(round_key_op[47:40]) ^ mulb(round_key_op[39:32]);
                        mix_columns_op[39:32]   = mulb(round_key_op[63:56]) ^ muld(round_key_op[55:48]) ^ mul9(round_key_op[47:40]) ^ mule(round_key_op[39:32]);
                        
                        mix_columns_op[31:24]   = mule(round_key_op[31:24]) ^ mulb(round_key_op[23:16]) ^ muld(round_key_op[15:8]) ^ mul9(round_key_op[7:0]);
                        mix_columns_op[23:16]   = mul9(round_key_op[31:24]) ^ mule(round_key_op[23:16]) ^ mulb(round_key_op[15:8]) ^ muld(round_key_op[7:0]);
                        mix_columns_op[15:8]    = muld(round_key_op[31:24]) ^ mul9(round_key_op[23:16]) ^ mule(round_key_op[15:8]) ^ mulb(round_key_op[7:0]);
                        mix_columns_op[7:0]     = mulb(round_key_op[31:24]) ^ muld(round_key_op[23:16]) ^ mul9(round_key_op[15:8]) ^ mule(round_key_op[7:0]);
                    //Add_Round_Key
                    s[i+1] = mix_columns_op;
                    message = 0;
                end
            else
                begin
//                    state_round[i] = s[i];
//                    //Sub_Bytes Function
//                    //fork        
//                        sboxw1 = state_round[i][127:96];
//                        sboxw2 = state_round[i][95:64];
//                        sboxw3 = state_round[i][63:32];
//                        sboxw4 = state_round[i][31:0];
//                    //join
//                    shift_rows_ip = {new_sboxw1,new_sboxw2,new_sboxw3,new_sboxw4};
//                    //Shift_Rows Function
//                    //fork
//                         {shift_rows_op[127:120],shift_rows_op[95:88],shift_rows_op[63:56],shift_rows_op[31:24]} = 
//                        {shift_rows_ip[127:120],shift_rows_ip[95:88],shift_rows_ip[63:56],shift_rows_ip[31:24]};
                        
//                        {shift_rows_op[119:112],shift_rows_op[87:80],shift_rows_op[55:48],shift_rows_op[23:16]} =
                        
//                        {shift_rows_ip[23:16],shift_rows_ip[119:112],shift_rows_ip[87:80],shift_rows_ip[55:48]};
                        
//                        {shift_rows_op[111:104],shift_rows_op[79:72],shift_rows_op[47:40],shift_rows_op[15:8]} =
//                        {shift_rows_ip[47:40],shift_rows_ip[15:8],shift_rows_ip[111:104],shift_rows_ip[79:72]};
                        
//                        {shift_rows_op[103:96],shift_rows_op[71:64],shift_rows_op[39:32],shift_rows_op[7:0]} = 
//                        {shift_rows_ip[71:64],shift_rows_ip[39:32],shift_rows_ip[7:0],shift_rows_ip[103:96]};
//                   // join
                    
//                    message = shift_rows_op ^ round_key[0];

                    state_round[i] = s[i];
                    
                    //Shift_Rows Function
                   shift_rows_ip = {state_round[i][127:96],state_round[i][95:64],state_round[i][63:32],state_round[i][31:0]};
                        {shift_rows_op[127:120],shift_rows_op[95:88],shift_rows_op[63:56],shift_rows_op[31:24]} = 
                        {shift_rows_ip[127:120],shift_rows_ip[95:88],shift_rows_ip[63:56],shift_rows_ip[31:24]};
                        
                        {shift_rows_op[119:112],shift_rows_op[87:80],shift_rows_op[55:48],shift_rows_op[23:16]} =
                        
                        {shift_rows_ip[23:16],shift_rows_ip[119:112],shift_rows_ip[87:80],shift_rows_ip[55:48]};
                        
                        {shift_rows_op[111:104],shift_rows_op[79:72],shift_rows_op[47:40],shift_rows_op[15:8]} =
                        {shift_rows_ip[47:40],shift_rows_ip[15:8],shift_rows_ip[111:104],shift_rows_ip[79:72]};
                        
                        {shift_rows_op[103:96],shift_rows_op[71:64],shift_rows_op[39:32],shift_rows_op[7:0]} = 
                        {shift_rows_ip[71:64],shift_rows_ip[39:32],shift_rows_ip[7:0],shift_rows_ip[103:96]};
           
           
                    //Sub_Bytes Function
                           
                        sboxw1 = shift_rows_op[127:96];
                        sboxw2 = shift_rows_op[95:64];
                        sboxw3 = shift_rows_op[63:32];
                        sboxw4 = shift_rows_op[31:0];
                   
                    round_key_ip = {new_sboxw1,new_sboxw2,new_sboxw3,new_sboxw4};
                     round_key_op = round_key_ip ^ round_key[(10-i)-1];
                      message = round_key_op;
                     mix_columns_op = 0;
                end
            end
            
            
            else
            
            begin
            message = 0;
            sboxw1 =  0;
            sboxw2 =  0;
            sboxw3 =  0;
             sboxw4 = 0;
            shift_rows_op = 0;
            mix_columns_op = 0;
            
            
            end
            end
    
    inv_sbox sw1 (.sboxw(sboxw1), .new_sboxw(new_sboxw1)); 
    inv_sbox sw2 (.sboxw(sboxw2), .new_sboxw(new_sboxw2));
    inv_sbox sw3 (.sboxw(sboxw3), .new_sboxw(new_sboxw3));
    inv_sbox sw4 (.sboxw(sboxw4), .new_sboxw(new_sboxw4));  


endmodule
