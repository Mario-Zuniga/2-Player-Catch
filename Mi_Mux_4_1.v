`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module Mi_Mux_4_1(
    input [3:0] A_t,
    input [3:0] B_t,
    input [3:0] C_t,
    input [3:0] D_t,
    input [1:0] Sel,
    output [3:0] Y_t
    );
	 
	 assign Y_t = (Sel[0] == 0) ? (Sel[1] == 0 ? A_t : C_t) : (Sel[1] == 0 ? B_t : D_t);


endmodule
