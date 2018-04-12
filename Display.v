`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:39:45 03/24/2015 
// Design Name: 
// Module Name:    Display 
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
module Display(
	 input clk,
	 input [3:0]A, 
	 input [3:0]B, 
	 input [3:0]C, 
	 input [3:0]D,
    output [6:0] numOut,
    output [3:0] transistor
    );
	 
	 wire tggl;
	 wire [1:0] switcher;
	 wire [3:0] currentNumber;
	 
	 Timer #(0.005, 250_000) dispTimer(.clk(clk), .enable(1'b1), .rst(1'b0), .toggle(tggl)); //0.5ms delay for display
	 nCounter #(4, 2) switch(.clk(clk),.count(switcher), .enable(tggl), .rst(1'b0), .overflow()); //switch generator
	 
	 Mux4_4 numbers(.sw(switcher), .numA(D), .numB(C), .numC(B), .numD(A), .out(currentNumber));
	 Mux4_4 oneCold(.sw(switcher), .numA(4'b0111), .numB(4'b1011), .numC(4'b1101), .numD(4'b1110), .out(transistor));
	 
	 bin_to_hex converter(.w(currentNumber[3]),.x(currentNumber[2]),.y(currentNumber[1]),.z(currentNumber[0]), .num(numOut));	 
endmodule
