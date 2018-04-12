`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:25 03/19/2013 
// Design Name: 
// Module Name:    NERP_demo_top 
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
module SuperBallPickupMasterRotaryChampionDeluxe5(
	input LeftA,
	input LeftB,
	input RightA,
	input RightB,
	
	input LeftA2,
	input LeftB2,
	input RightA2,
	input RightB2,
	
	input wire clk,			//master clock = 50MHz
	input wire reset,			//right-most pushbutton for reset
	output wire [6:0] seg,	//7-segment display LEDs
	output wire [3:0] an,	//7-segment display anode enable
	output wire dp,			//7-segment display decimal point
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [1:0] blue,	//blue vga output - 2 bits
	output wire hsync,		//horizontal sync out
	output wire vsync,			//vertical sync out
	output resetOut
	);

// 7-segment clock interconnect
wire segclk;

// VGA display clock interconnect
wire dclk;

// disable the 7-segment decimal points
assign dp = 1;

wire [15:0] posx;
wire [15:0] posy;

wire [15:0] posx2;
wire [15:0] posy2;


//Rotary Controls
RotaryEncoders rot(.clk(clk),.reset(reset), .resetValue(100), .LeftA(LeftA),.LeftB(LeftB),.RightA(RightA),.RightB(RightB),.result(posx),.result2(posy));
RotaryEncoders rot2(.clk(clk),.reset(reset), .resetValue(400), .LeftA(LeftA2),.LeftB(LeftB2),.RightA(RightA2),.RightB(RightB2),.result(posx2),.result2(posy2));



// generate 7-segment clock & display clock
clockdiv U1(.clk(clk),.clr(reset),.segclk(segclk),.dclk(dclk));

// 7-segment display controller
//segdisplay U2(.segclk(segclk),.clr(reset),.seg(seg),.an(an));


wire [3:0] score1;
wire [3:0] score2;

// VGA controller
vga640x480 U3(.dclk(dclk),.clr(reset),.hsync(hsync),.vsync(vsync), .posx(posx), .posy(posy),  .posx2(posx2), .posy2(posy2), .red(red),.green(green),.blue(blue),.score1(score1),.score2(score2));

Display outputDisp(.clk(clk),.A('b0001),.B(score1),.C('b0010),.D(score2),.numOut(seg),.transistor(an));

assign resetOut = reset;

endmodule
