`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//////////////////////////////////////////////////////////////////////////////////

module GTV(
    input	clk, rst,
	output reg iguales,
	output [1:0] sel
	);


// bloque contador
parameter [19:0] YY = 100000000;
reg [19:0] CuentaCada20ns;
always @ (posedge rst or posedge clk) begin
  if (rst) CuentaCada20ns <= 0;  
  else if (iguales) CuentaCada20ns <= 0;
   else CuentaCada20ns <= CuentaCada20ns +1;
end

// bloque comparador
always @ (CuentaCada20ns) begin
	if (CuentaCada20ns == YY) iguales = 'b1; 
	else iguales = 0;
end

assign sel = CuentaCada20ns[10:9];

endmodule
