`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Camarena
// the nCounter will count the succesive integer numbers all the way to n (exclusive)
// such as n = 2, {0,1} , therefore, n > 1
//////////////////////////////////////////////////////////////////////////////////


module nCounter #(parameter integer limit=2, parameter busSize = 4)(
    input clk, enable, rst,
    output reg [busSize-1:0] count,
	 output reg overflow
    );
	 
	 always @ (posedge rst, posedge clk)
	 begin
		overflow <= 0;
		if(rst)
			count<='b0;
		else if(count == limit) //count has reached limit
			begin
				count<='b0;
				overflow <= 1;
			end
		else if(enable)
			count<=count+'b1;
	 end
	 
endmodule