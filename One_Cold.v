`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module One_Cold(
    input [1:0] A,
    output [3:0] Y
    );
	 
	 assign Y = 	(A == 3) ? (4'b0111): 
						(A == 2) ? (4'b1011):
						(A == 1) ? (4'b1101):
									  (4'b1110);
					

endmodule
