`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2024 15:33:18
// Design Name: 
// Module Name: top
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


module top(
    input   clk, reset,
    input  [10:0]dvsr,
    input  rx,
    input tx_start,         
    input [7:0] din,
    output  tx,
    //output [127:0] cipher  
        output [127:0] message  

    );
   reg [127:0] cipher, data_reg;
    reg  rx_done_tick;
    reg  [7:0] d_out;
   
    reg  tx_done_tick;
    reg  [127:0] data_out;
    reg  pkt_done;
    reg [127:0] uart_ip [0:1]; 
    int count;
    reg en1,en2;
    reg valid,countstart;
    reg valid_reg;
    integer en2count;
     reg key_en;
    top_rohit UART(.*);
   
//always@(posedge clk , posedge reset)
//begin
//    if(reset)
//    begin
//        en2<= 'b0;
//        en2count <= 0;
//       // countstart <=0;
//    end
//    @(posedge en1)
//    begin
//        //en2count <= en2count +1;
//        //countstart <= 1;
//        if(en2count == 9)
//        begin
//            en2 <= 1;
//            en2count <= en2count +1;
//        end
//        else begin 
//        if(en2count == 18)
//        begin
//            en2 <= 0;
//          //  countstart <=0;
//        end
//        else
//        en2count<= en2count+1;
//        end
        
//    end
  
// always @ (posedge clk, posedge reset)
//    begin
//        case (en2count)
//            0 : begin
//                en2count <= en2count + 1;
//                en2 <= 0;
//            end
//            1 : begin
//                en2count <= en2count + 1;
//                en2 <= 1;
//            end
//            2 : begin
//                en2count <= en2count + 1;
//                en2 <= 1;
//            end
//            3 : begin
//                en2count <= en2count + 1;
//                en2 <= 1;
//            end
//            4 : begin
//                en2count <= en2count + 1;
//                en2 <= 1;
//            end
//            5 : begin
//                en2count <= en2count + 1;
//                en2 <= 1;
//            end
//            6 : begin
//                en2count <= en2count + 1;
//                en2 <= 1;
//            end
//            7 : begin
//                en2count <= en2count + 1;
//                en2 <= 1;
//            end
//            8 : begin
//                en2count <= en2count + 1;
//                en2 <= 1;
//            end
            
//        endcase
//    end 
always @ (posedge clk, posedge reset)
    begin
        if (reset)
            valid_reg <= 0;
        else
            if(valid) begin
            valid_reg <= valid;
            data_reg <= cipher;
            end
            else if(en2count == 10 )
            valid_reg <= 0;
            
    end

always @ (posedge clk, posedge reset)
    begin
        if (reset)
            en2count <= 0;
        else
            if(en2count <= 9 && valid_reg)
                en2count <= en2count + 1;
            else
                en2count <= 0;
            
                
    end

always @ *
    begin
        if (reset)
            begin
                en2 = 'b0;
                //en2count = 'b0;
            end
        else
//            if (valid) en2count <= en2count + 1;
            //en2count <= en2count + 1;
            if(en2count <= 9 && valid_reg)
                begin
                    //en2count = en2count + 1;
                    en2 = 'b1;
                end
            else if (en2count == 10)
                begin
                    en2 = 'b0;
                    //en2count = 'b0;
                end
            else
                en2 = 0;
    end
  integer key_en_count;
  always@(posedge clk, posedge reset)
  begin
  if (reset)
  begin
    key_en_count <= 0; 
  end
  
  else
  begin
    if(count%2 == 0)
    begin
       
        
    if(key_en_count < 61)
    begin
    key_en <= 1;
    key_en_count <= key_en_count + 1;
    end
    else if (key_en_count > 60)
    begin
     key_en_count <= key_en_count + 1;   
     key_en <= 0;
     end 
    end
  else
  begin
    key_en_count <= 0;
    key_en <= 0;
  end
  end
  
  end
    
//   begin
//   if(countstart == 1)
//    en2count<= en2count+1;
//    else
//    en2count <=0;
//    end

//end
   
    always@(posedge rx_done_tick,posedge reset)
    begin
    if(reset)
    {uart_ip[0],uart_ip[1],count} <= 'b0;
    else
           begin
                if(pkt_done)
                begin
                if(count%2 == 0)
                    begin
                        uart_ip[0]<= data_out;
                        count <= count + 1;
                    end
                else
                 begin
                        uart_ip[1]<= data_out;
                        count <= count + 1;
                    end
                end
                
                else
                
                 begin
                uart_ip[0]<=uart_ip[0];
                uart_ip[1]<= uart_ip[1];
                count <= count;
                end
                
           end
    
    
    end
   
    reg [127:0] data_in_temp,key_temp,cipher_temp;
    //assign cipher = (count)?uart_ip[0]:uart_ip[1];
    always@(posedge clk,posedge reset)
    begin
        if(reset)
    {data_in_temp,key_temp,cipher_temp}<= 'b0;
    else
    begin
    if (count != 0 && count%2 == 0)
    begin
    {data_in_temp,key_temp,cipher_temp}<= {uart_ip[1],uart_ip[0],cipher};
    end
    else
    {data_in_temp,key_temp,cipher_temp}<= 'b0;
    end
    
    end
    
     wire [127:0] round_key[0:10];
     key_expansion K1 (.key_en(key_en),.key(key_temp), .k0(round_key[0]), .k1(round_key[1]), .k2(round_key[2]), .k3(round_key[3]), .k4(round_key[4]), .k5(round_key[5]),.k6(round_key[6]),
                       .k7(round_key[7]), .k8(round_key[8]), .k9(round_key[9]), .k10(round_key[10]),.en(en1), .clk(clk) , .reset(reset));
    
    reg [127:0] cipher_sel;
    assign cipher = (uart_ip[0] && uart_ip[1])? cipher_sel:'b0;
   // Encryption EN(.*,.data_in(data_in_temp),.key(key_temp),.cipher(cipher_sel));
     Encryption EN (.clk(clk), .reset(reset),
                    .data_in(data_in_temp),.en(en1),.round_key_0(round_key[0]),
                    .round_key_1(round_key[1]),.round_key_2(round_key[2]),
                    .round_key_3(round_key[3]),.round_key_4(round_key[4]),
                    .round_key_5(round_key[5]),.round_key_6(round_key[6]),
                    .round_key_7(round_key[7]),.round_key_8(round_key[8]),
                    .round_key_9(round_key[9]),.round_key_10(round_key[10]),
                    .cipher(cipher_sel),.valid(valid));
 //Encryption EN (.*,.data_in(data_in_temp),.en(en1),.cipher(cipher_sel));
     decryption DEC (.clk(clk), .reset(reset),
                     .cipher(data_reg),.en(en2),.round_key_0(round_key[0]),
                     .round_key_1(round_key[1]),.round_key_2(round_key[2]),
                     .round_key_3(round_key[3]),.round_key_4(round_key[4]),
                     .round_key_5(round_key[5]),.round_key_6(round_key[6]),
                     .round_key_7(round_key[7]),.round_key_8(round_key[8]),
                     .round_key_9(round_key[9]),.round_key_10(round_key[10]),
                     .message(message));
                    
endmodule

