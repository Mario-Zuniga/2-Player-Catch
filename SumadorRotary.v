`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:01:57 04/30/2015 
// Design Name: 
// Module Name:    SumadorRotary 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SumadorRotary(
	input clk,
	input [11:0] resetValue,
	input reset,
	input inc,
	input dec,
	output reg [15:0] result
    );
	 
parameter increase = 15;

	always @ (posedge reset or posedge clk)
		begin
		if(reset) result <= resetValue;
		else if(inc)
		begin
			result <= result+increase;
		end
		else if(dec)
		begin
				result <= result-increase;
		end
		end
	

endmodule
