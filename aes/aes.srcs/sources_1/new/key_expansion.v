`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2024 09:53:57 PM
// Design Name: 
// Module Name: key_expansion
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

`include "sbox.v"

module key_expansion(
    input [127:0] key,
    output [127:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10,
    output reg en,
    input clk,reset
);

integer i, j, k;
reg [31:0] w[0:43];
reg [31:0]rot_word, temp_word;
reg [31:0]sub_word;
reg [31:0]s_box_rot;
wire [31:0]s_box_sub;
reg [31:0]r_con; 
//wire [31:0] nw[];
//assign en = ();


always@(posedge clk)
begin
if(reset)
begin
i <= 4;
en<= 0;
end
else
begin
i <= i+1;
if (i == 44)
en <= 'b1; 
end
end
//000102030405060708090a0b0c0d0e0f

always@*

    begin
        {w[0],w[1],w[2],w[3]} = key;
      // for (i = 4; i<44; i=i+1)
            //i = 4;
            begin
                if (i%4 != 0)
                    begin
                        j = i - 4;
                        k = i - 1;
                        w[i] = w[j] ^ w[k];
                    end
                else
                    begin
                        k = i - 1;
                        temp_word = w[k];
                        rot_word = {temp_word[23:16],temp_word[15:8],temp_word[7:0],temp_word[31:24]};
                        //sbox sw (.sboxw(rot_word), .new_sboxw(sub_word));
                        s_box_rot = rot_word;
                        sub_word = s_box_sub;
                        case(i/4)
                            1 : 
                            begin
                                r_con[31:24] = sub_word[31:24] ^ 8'h01;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                
                            end
                            2 : 
                            begin
                                r_con[31:24] = sub_word[31:24] ^ 8'h02;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                
                            end
                            3 : 
                            begin
                                r_con[31:24] = sub_word[31:24] ^ 8'h04;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                            
                            end
                            4 : 
                            begin
                                r_con[31:24] = sub_word[31:24] ^ 8'h08;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                               
                            end
                            5 : 
                            begin
                               r_con[31:24] = sub_word[31:24] ^ 8'h10;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                             
                            end
                            6 : 
                            begin
                                r_con[31:24] = sub_word[31:24] ^ 8'h20;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                         
                            end
                            7 : 
                            begin
                                r_con[31:24] = sub_word[31:24] ^ 8'h40;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                             
                            end
                            8 : 
                            begin
                                 r_con[31:24] = sub_word[31:24] ^ 8'h80;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                           
                            end
                            9 : 
                            begin
                                 r_con[31:24] = sub_word[31:24] ^ 8'h1b;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                       
                            end
                            10 : 
                            begin
                                 r_con[31:24] = sub_word[31:24] ^ 8'h36;
                                r_con[23:0] = sub_word[23:0];
                                w[i] = r_con^w[i-4];                            
                            end
                        endcase              
                    end
            end
    end

//initial
//    begin
//        {w[3],w[2],w[1],w[0]} = key;
//        for (i=4; i<44; i=i+1)
//            begin
//                if (i%4 != 0)
//                    begin
//                        j = i - 4;
//                        k = i - 1;
//                        w[i] = w[j] ^ w[k];
//                    end
//                else
//                    begin
//                        k = i - 1;
//                        temp_word = w[k];
//                        rot_word = {temp_word[23:16],temp_word[15:8],temp_word[7:0],temp_word[31:24]};
//                        //sbox sw (.sboxw(rot_word), .new_sboxw(sub_word));
//                        s_box_rot = rot_word;
//                        sub_word = s_box_sub;
//                        case(i/4)
//                            1 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h01;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            2 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h02;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            3 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h04;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            4 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h08;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            5 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h10;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            6 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h20;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            7 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h40;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            8 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h80;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            9 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h1b;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                            10 : 
//                            begin
//                                r_con[7:0] = sub_word[7:0] ^ 8'h36;
//                                r_con[31:8] = sub_word[31:8];
//                                w[i] = r_con;                
//                            end
//                        endcase              
//                    end
//            end
//    end
//sbox(.s)
sbox sw (.sboxw(s_box_rot), .new_sboxw(s_box_sub));

assign k0 = {w[0],w[1],w[2],w[3]};
assign k1 = {w[4],w[5],w[6],w[7]};
assign k2 = {w[8],w[9],w[10],w[11]};
assign k3 = {w[12],w[13],w[14],w[15]};
assign k4 = {w[16],w[17],w[18],w[19]};
assign k5 = {w[20],w[21],w[22],w[23]};
assign k6 = {w[24],w[25],w[26],w[27]};
assign k7 = {w[28],w[29],w[30],w[31]};
assign k8 = {w[32],w[33],w[34],w[35]};
assign k9 = {w[36],w[37],w[38],w[39]};
assign k10 = {w[40],w[41],w[42],w[43]};

endmodule