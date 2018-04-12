`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:08:36 04/29/2015 
// Design Name: 
// Module Name:    RotaryEncoders 
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
module RotaryEncoders(
	input clk,
	input reset,
	input [11:0] resetValue,
	input LeftA,
	input LeftB,
	input RightA,
	input RightB,
	output [15:0] result,
	output [15:0] result2
    );
	 
	 wire LeftA_shot;
	 wire LeftB_shot;
	 
	 wire RightA_shot;
	 wire RightB_shot;
	 
	 wire increase;
	 wire decrease;
	 
	 wire [15:0] res;
	 
	 wire increase2;
	 wire decrease2;
	 
	 wire [15:0] res2;
	 
	 Debouncer deb1(.Clock(clk), .Reset(reset), .Switch(LeftA), .Sw_Clean(LeftA_shot));
	 Debouncer deb2(.Clock(clk), .Reset(reset), .Switch(LeftB), .Sw_Clean(LeftB_shot));
	 
	 MaquinaEstados maquina1(.A(LeftA_shot), .B(LeftB_shot), .clk(clk), .reset(reset), .inc(increase), .dec(decrease));
	 
	 SumadorRotary sumador(.clk(clk), .reset(reset), .resetValue(resetValue), .inc(increase), .dec(decrease), .result(res));
	 
	 Debouncer deb4(.Clock(clk), .Reset(reset), .Switch(RightA), .Sw_Clean(RightA_shot));
	 Debouncer deb3(.Clock(clk), .Reset(reset), .Switch(RightB), .Sw_Clean(RightB_shot));
	 
	 MaquinaEstados maquina2(.A(RightA_shot), .B(RightB_shot), .clk(clk), .reset(reset), .inc(increase2), .dec(decrease2));
	 
	 SumadorRotary sumador2(.clk(clk), .reset(reset), .resetValue(resetValue), .inc(increase2), .dec(decrease2), .result(res2));
	 
	 assign result = res;
	 assign result2 = res2;

endmodule
