`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Camarena
// Notes: The objective of this clock is to recieve the time in [seconds]
//			 and generate the appropiate clock, with toggle activating after n seconds.
//			 timeLimit is given IN SECONDS
//
//		    as of this version, it is necessary to manualy input the binTime following
//        binTime = (timeLimit) * 10E9 / 20; which is kind of sad
//
//        Documentation!!
//              the logb2 -> http://stackoverflow.com/questions/5269634/address-width-from-ram-depth
//              the instantiation parameters -> http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-884-complex-digital-systems-spring-2005/related-resources/parameter_models.pdf 
//////////////////////////////////////////////////////////////////////////////////

module Timer #(parameter timeLimit=1, parameter binTime = 50_000_000)(
    input clk, enable, rst,
    output reg toggle
    );
	 
	 //ajuste de buses & limites
	 parameter busSize = clogb2((timeLimit * 10E9) / 20);
	 
	 reg [busSize-1:0] localCount;
	 reg [busSize-1:0] limit;
	 
	 // bloque contador
	always @ (posedge rst, posedge clk) 
	begin
		if (rst) begin localCount <= 0; limit <= binTime; end
		else if (toggle) localCount <= 0;
		else if (enable) localCount <= localCount +1;
	end

	// bloque comparador
	always @ (limit, localCount) 
	begin
		if (localCount == limit) toggle <= 'b1; 
		else toggle <= 'b0;
	end
	
	function integer clogb2;
		input [31:0] value;
			begin
				value = value - 1;
					for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1) begin
						value = value >> 1;
					end
				end
	endfunction
	
endmodule
