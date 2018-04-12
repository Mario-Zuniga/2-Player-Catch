`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//////////////////////////////////////////////////////////////////////////////////

module Playe2(
	 input Clock,
	 input LeftA,
	 input LeftB,
	 input RightA,
	 input RightB,
	 input InReset,
	 output OLeftA,
	 output OLeftB,
	 output ORightA,
	 output ORightB,
	 output Reset,
	 output [6:0] Dis,
	 output [3:0] T
    );
	 
	 segdisplay sd (.segclk(Clock), .clr(InReset), .seg(Dis), .an(T));
	 
	 assign OLeftA = LeftA;
	 assign OLeftB = LeftB;
	 
	 assign ORightA = RightA;
	 assign ORightB = RightB;
	 
	 assign Reset = InReset;


endmodule
