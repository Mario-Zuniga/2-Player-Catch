`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:56 02/04/2015 
// Design Name: 
// Module Name:    bin_to_hex 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bin_to_hex(
    input w,
    input x,
    input y,
    input z,
    output [6:0] num
    );
		assign num[6]= (~w&~x&~y&z)| (~w&x&~y&~z)| (w&x&~y&z)| (w&~x&y&z);
		assign num[5]= (w&x&y&z)| (w&x&y&~z)| (w&x&~y&~z)| (w&~x&y&z)|(~w&x&y&~z)|(~w&x&~y&z);
		assign num[4]= (~w&~x&y&~z)| (w&x&~y&~z)| (w&x&y);
		assign num[3]= (x&y&z)| (~x&~y&z)| (w&~x&y&~z)| (~w&x&~y&~z);
		assign num[2]= (~w&z)| (~x&~y&z)| (~w&x&~y);
		assign num[1] = (~w&~x&~y&z)| (~w&~x&y&z)| (~w&~x&y&~z)| (~w&x&y&z)| (w&x&~y&z);
		assign num[0]= (~w&~x&~y)| (~w&x&y&z)| (w&x&~y&~z);


endmodule
