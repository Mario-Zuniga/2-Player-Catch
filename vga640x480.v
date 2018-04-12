`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
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
module vga640x480(
	input wire dclk,			     //pixel clock: 25MHz
	input wire clr,	          //asynchronous reset
	input [15:0] posx,
	input [15:0] posy,
	input [15:0] posx2,
	input [15:0] posy2,
	output wire hsync,		 //horizontal sync out
	output wire vsync,		//vertical sync out
	output reg[2:0] red,	     //red vga output
	output reg[2:0] green,   //green vga output
	output reg[1:0] blue,	   //blue vga output
	output [3:0] score1,
	output [3:0] score2
	);

//cursor size
parameter cursor_width  = 20;
parameter cursor_height = 20;

parameter ball_size = 10;
reg [15:0] ball_x = 300;
reg [15:0] ball_y = 300;

reg [6:0] cursor_size_player1 = 20;
reg [6:0] cursor_size_player2 = 20;


reg [3:0] player1_score = 0;
reg [3:0] player2_score = 0;

reg [7:0] player1_color = 8'b11100110;
reg [7:0] player2_color = 8'b00101011;



                                 // video structure constants
parameter hpixels  = 800;       // horizontal pixels per line
parameter vlines   = 521;      // vertical lines per frame
parameter hpulse   = 96; 	   // hsync pulse length
parameter vpulse   = 2; 	  // vsync pulse length
parameter hbp      = 144; 	 // end of horizontal back porch
parameter hfp      = 784; 	// beginning of horizontal front porch
parameter vbp      = 31;  // end of vertical back porch
parameter vfp      = 511;// beginning of vertical front porch
                        // active horizontal video is therefore: 784 - 144 = 640
                       // active vertical video is therefore: 511 - 31 = 480
                      //
                     // registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

                  // Horizontal & vertical counters --
                 // this is how we keep track of where we are on the screen.
                // ------------------------
               // Sequential "always block", which is a block that is
              // only triggered on signal transitions or "edges".
             // posedge = rising edge  &  negedge = falling edge
            // Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
  // reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end
// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

reg printOut;
reg printH_player1;
reg printV_player1;

reg printH_ball;
reg printV_ball;

reg printH_player2;
reg printV_player2;

//Checking for vertical printing
always @ (vc)
begin
	if(vc > vbp + posy && vc < vbp + posy + cursor_size_player1)
		printV_player1 = 1;
	else if(vc > vbp + posy2 && vc < vbp + posy2 + cursor_size_player2)
		printV_player2 = 1;
	else if(vc > vbp + ball_y && vc < vbp + ball_y + ball_size)
		printV_ball = 1;
	else
	begin
		printV_player1 = 0;
		printV_ball = 0;
		printV_player2 = 0;
	end
end

//Checking for horizontal printing
always @ (hc)
begin
	if(hc > hbp + posx && hc < hbp + posx + cursor_size_player1)
		printH_player1 = 1;
	else if(hc > hbp + posx2 && hc < hbp + posx2 + cursor_size_player2)
		printH_player2 = 1;
	else if(hc > hbp + ball_x && hc < hbp + ball_x + ball_size)
		printH_ball = 1;
	else
	begin
		printH_player1 = 0;
		printH_player2 = 0;
		printH_ball = 0;
	end
end

//if they are both enabled, send the printout signal
always @ (printH_player1, printV_player1, printH_player2, printV_player2, printH_ball, printV_ball)
begin
	if(printH_player1 && printV_player1 && printH_ball && printV_ball && printH_player2 && printV_player2)
	begin
		red = 3'b101;
		green = 3'b110;
		blue = 3'b01;
	end
	else if(printH_player1 && printV_player1)
	begin
		red = player1_color[7:5];
		green = player1_color[4:2];
		blue = player1_color[1:0];
	end
	else if(printH_player2 && printV_player2)
	begin
		red = player2_color[7:5];
		green = player2_color[4:2];
		blue = player2_color[1:0];
	end
	else if(printH_ball && printV_ball)
	begin
		red = 3'b001;
		green = 3'b111;
		blue = 2'b01;
	end
	else
	begin
		red = 3'b000;
		green = 3'b000;
		blue = 2'b00;
	end
end

wire [8:0] random;
nCounter #(400, 9) randomizer(.clk(dclk),.count(random), .enable(1'b1), .rst(1'b0), .overflow());

always @ (posx, posy, posx2, posy2)
begin
	if((ball_x >= posx && ball_x <= posx + cursor_size_player1) && (ball_y >= posy && ball_y <= posy + cursor_size_player1))
	begin
		ball_x = random[8:0] ;
		ball_y = random[8:0] ;
		player1_score = player1_score + 1;
		player1_color = player1_color+1;
	end
	else if((ball_x >= posx2 && ball_x <= posx2 + cursor_size_player2) && (ball_y >= posy2 && ball_y <= posy2 + cursor_size_player2))
	begin
		ball_x = random[8:0] ;
		ball_y = random[8:0] ;
		player2_score = player2_score + 1;
		player2_color = player2_color+1;
	end
end

assign score1 = player1_score;
assign score2 = player2_score;

endmodule














