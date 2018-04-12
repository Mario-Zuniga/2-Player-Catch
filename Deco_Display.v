`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module Deco_Display(
    input w,
    input x,
    input y,
    input z,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
    );
	 
	assign a = (~w & ~x & ~y & z) | (~w & x & ~y & ~z) | (w & x & ~y & z) | (w & ~x & y & z);
	
	assign b = (w & y & z) | (x & y & ~z) | (w & x & ~z) | (~w & x & ~y & z);
	
	assign c = (w & x & y) | (w & x & ~z) | (~w & ~x & y & ~z);
	
	assign d = (x & y & z) | (~w & ~x & ~y & z) | (~w & x & ~y & ~z) | (w & ~x & y & ~z);
	
	assign e = (~w & z) | (~x & ~y & z) | (~w & x & ~y);
	
	assign f = (~w & y & z) | (~w & ~x & z) | (~w & ~x & y) | (w & x & ~y & z);
	
	assign g = (~w & ~x & ~y) | (~w & x & y & z) | (w & x & ~y & ~z);



endmodule
