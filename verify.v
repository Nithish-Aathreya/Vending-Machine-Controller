`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 16:33:54
// Design Name: 
// Module Name: verify
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


module verify();
reg coin_in;
wire [3:0]refund;
wire [3:0] push;
reg [3:0]coin_value;


reg [1:0] state;


vending uut(coin_in,refund,push,coin_value);

initial
begin
$monitor("coin_in=%b,refund=%b,push=%b,coin_value=%b",coin_in,refund,push,coin_value);
coin_in = 1'b0;

forever
#5 coin_in = ~coin_in;
end

initial
begin
#10 coin_value = 4'b1010;
#20 coin_value = 4'b1000;

#200 $finish;


end
endmodule
