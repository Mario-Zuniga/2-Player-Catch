`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module Contado_Decadas(
    input Clock,
    input Enable,
    input Reset,
    output reg [3:0] Q
    );
	 
	 always @ (posedge Reset or posedge Clock) 
	 
	 begin 
	 
		if(Reset)
		begin
			Q <= 'b00;
		end
	
	 else
	 
		if (Enable)	
			if (Q + 'b1 == 'b1010)
			Q <= 'b0000;
			else
			Q <= Q + 'b1;
	 end

endmodule
