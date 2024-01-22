`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2024 17:23:56
// Design Name: 
// Module Name: shifter
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


module shifter(
input [127:0] inp,
output [127:0]op
    );
    
   // assign op = inp << 1'b1;
    function mul2(input [7:0]data_in);
        mul2 = (data_in<<1'b1)^ (8'h1b&{8{data_in[7]}});
   endfunction
   
   function mul3(input [7:0]data_in);
        mul3 = (mul2(data_in)^data_in);
   endfunction
   
                       assign op[127:120] = mul2(inp[127:120]) ^ mul3(inp[119:112]) ^ inp[111:104] ^ inp[103:96]; 
                       assign op[119:112] = inp[127:120] ^ mul2(inp[119:112]) ^ mul3(inp[111:104]) ^ inp[103:96];
                       assign op[111:104] = inp[127:120] ^ inp[119:112] ^ mul2(inp[111:104]) ^ mul3(inp[103:96]);
                       assign op[103:96]  = mul3(inp[127:120]) ^ inp[119:112] ^ inp[111:104] ^ mul2(inp[103:96]);
                        
                       assign op[95:88]   = mul2(inp[95:88]) ^ mul3(inp[87:80]) ^ inp[79:72] ^ inp[71:64];
                       assign op[87:80]   = inp[95:88] ^ mul2(inp[87:80]) ^ mul3(inp[79:72]) ^ inp[71:64];
                       assign op[79:72]   = inp[95:88] ^ inp[87:80] ^ mul2(inp[79:72]) ^ mul3(inp[71:64]);
                       assign op[71:64]   = mul3(inp[95:88]) ^ inp[87:80] ^ inp[79:72] ^ mul2(inp[71:64]);
                        
                       assign op[63:56]   = mul2(inp[63:56]) ^ mul3(inp[55:48]) ^ inp[47:40] ^ inp[39:32];
                       assign op[55:48]   = inp[63:56] ^ mul2(inp[55:48]) ^ mul3(inp[47:40]) ^ inp[39:32];
                       assign op[47:40]   = inp[63:56] ^ inp[55:48] ^ mul2(inp[47:40]) ^ mul3(inp[39:32]);
                       assign op[39:32]   = mul3(inp[63:56]) ^ inp[55:48] ^ inp[47:40] ^ mul2(inp[39:32]);
                      
                       assign op[31:24]   = mul2(inp[31:24]) ^ mul3(inp[23:16]) ^ inp[15:8] ^ inp[7:0];
                       assign op[23:16]   = inp[31:24] ^ mul2(inp[23:16]) ^ mul3(inp[15:8]) ^ inp[7:0];
                       assign op[15:8]    = inp[31:24] ^ inp[23:16] ^ mul2(inp[15:8]) ^ mul3(inp[7:0]);
                       assign op[7:0]     = mul3(inp[31:24]) ^ inp[23:16] ^ inp[15:8] ^ mul2(inp[7:0]);
   
endmodule
