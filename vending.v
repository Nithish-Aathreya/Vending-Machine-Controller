`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 16:05:12
// Design Name: 
// Module Name: vending
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


module vending(coin_in,refund,push,coin_value);
input coin_in;
input [3:0]coin_value;

output wire [3:0]refund;
output reg [3:0] push;


reg [1:0] state;

parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
parameter idle=4'b1000,item_sel=4'b0100,dispense=4'b0010,refund_sig=4'b0001;



assign refund = (coin_value > 4'b0101) ? (coin_value - 4'b0101 ) : 4'b0000;



always @(posedge coin_in)
begin
case(state)
s0 : state<=s1;
s1 : state<=s2;
s2 : state<=s3;
s3 : state<=s0;
default:state<=s0;
endcase
 end
 
 always @(state)
 begin
 case(state)
 s0 : push = idle;
s1 : push = item_sel;
s2 : push = dispense;
s3 :push = refund_sig;
 default: push = idle;
 endcase
 end
 
 
endmodule
