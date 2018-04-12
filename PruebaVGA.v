`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:21:50 05/14/2015
// Design Name:   vga640x480
// Module Name:   C:/Users/usuario/Documents/Mario/BallGameDeluxe/PruebaVGA.v
// Project Name:  NERP_demo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga640x480
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaVGA;

	// Inputs
	reg dclk;
	reg clr;
	reg [15:0] posx;
	reg [15:0] posy;
	reg [15:0] posx2;
	reg [15:0] posy2;

	// Outputs
	wire hsync;
	wire vsync;
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire [3:0] score1;
	wire [3:0] score2;

	// Instantiate the Unit Under Test (UUT)
	vga640x480 uut (
		.dclk(dclk), 
		.clr(clr), 
		.posx(posx), 
		.posy(posy), 
		.posx2(posx2), 
		.posy2(posy2), 
		.hsync(hsync), 
		.vsync(vsync), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.score1(score1), 
		.score2(score2)
	);

	initial begin
		// Initialize Inputs
		dclk = 0;
		clr = 1;
		posx = 0;
		posy = 0;
		posx2 = 0;
		posy2 = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here

	end
	
		always
		begin
		#10 dclk = ~dclk;
		clr = 0;
		end
		
		always
		begin
		#20 posx = posx + 1;
		end
		
		always
		begin
		#30 posy = posy + 1;
		end
		
		always
		begin
		#50 posx = posx + 2;
		end
		
		always
		begin
		#70 posy = posy + 2;
		end
      
		
endmodule

