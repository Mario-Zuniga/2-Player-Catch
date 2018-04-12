`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module Display_Multiplexado(
	 input [3:0] A,
    input [3:0] B,
    input [3:0] C,
    input [3:0] D,
    input [1:0] Sel,
    output [6:0] Dis,
    output [3:0] T
    );
	 
	 wire [3:0] W_Mux;
	 
	 Deco_Display Dec (.w(W_Mux[3]), .x(W_Mux[2]), .y(W_Mux[1]), .z(W_Mux[0]), .a(Dis[0]), .b(Dis[1]), .c(Dis[2]), .d(Dis[3]), .e(Dis[4]), .f(Dis[5]), .g(Dis[6]));
	 
	 One_Cold Col (.A(Sel), .Y(T));
	 
	 Mi_Mux_4_1 Mux (.A_t(A), .B_t(B), .C_t(C), .D_t(D), .Sel(Sel), .Y_t(W_Mux));


endmodule
