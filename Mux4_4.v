`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:09:54 03/24/2015 
// Design Name: 
// Module Name:    Mux4_4 
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
module Mux4_4(
    input [3:0] numA,
	 input [3:0] numB,
	 input [3:0] numC,
	 input [3:0] numD,
    input [1:0] sw,
    output [3:0] out
    );
	 assign out = (sw[0] == 1) ? (sw[1] == 1 ? numD : numB) : (sw[1] == 1 ? numC : numA);
	 
endmodule
