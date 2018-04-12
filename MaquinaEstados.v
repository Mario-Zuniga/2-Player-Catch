`timescale 1ns / 1ps
///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////



module MaquinaEstados(
	input A,
	input B,
	input clk,
	input reset,
	output reg inc,
	output reg dec
);
	 
parameter espera = 'b0000;
parameter a_0    = 'b0001; 
parameter a_1    = 'b0010; 
parameter b_0    = 'b0011; 
parameter b_1    = 'b0100; 

reg [2:0] estado;

always @ (posedge clk, posedge reset)
begin
	if(reset)
		estado <= 0;
	else
	begin
		case(estado)
		espera:
		begin
			if(A == 1 && B == 0) estado <= a_0;
			else if(B == 1 && A == 0) estado <= b_0;
		end
		a_0:
		begin
			if(B)	estado <= a_1;
		end
		b_0:
		begin
			if(A) estado <= b_1;
		end
		a_1:
		begin
			estado <= espera;
		end
		b_1:
		begin
			estado <= espera;
		end
		default:	estado <= espera;
		endcase
	end
end

always @ (estado)
begin
	case(estado)
	espera:
	begin
		inc = 0;
		dec = 0;
	end
	a_0:
	begin
		inc = 0;
		dec = 0;
	end
	b_0:
	begin
		inc = 0;
		dec = 0;
	end
	a_1:
	begin
		inc = 1;
		dec = 0;
	end
	b_1:
	begin
		inc = 0;
		dec = 1;
	end
	default:
	begin
		inc = 0;
		dec = 0;
	end
	endcase
end
endmodule
