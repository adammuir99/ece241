
module PS2_Keyboard (
	// Inputs
	CLOCK_50,
	reset,

	// Bidirectionals
	PS2_CLK,
	PS2_DAT,
	
	// Outputs
	pressed_key,
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input				CLOCK_50;
input				reset;

// Bidirectionals
inout				PS2_CLK;
inout				PS2_DAT;

// Outputs
output		[7:0] 	pressed_key;


/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire 		ps2_key_pressed;
wire		[7:0]	ps2_key_data;
wire		idle, pressed, unpressed;


/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/
control_ps2 c (.clk(CLOCK_50), .resetn(reset), .idle(idle), .pressed(pressed), .unpressed(unpressed), .is_key_pressed(ps2_key_pressed), .ps2_key_data(ps2_key_data));
datapath_ps2 d (.clk(CLOCK_50), .resetn(reset), .idle(idle), .pressed(pressed), .unpressed(unpressed), .pressed_key(pressed_key), .ps2_key_data(ps2_key_data));
/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/
/*
always @(posedge CLOCK_50)
begin
	if (reset == 1'b0)
		pressed_key <= 8'h0;
	else if (ps2_key_pressed == 1'b1 && ps2_key_data == 8'hF0)	//if the key is released
		pressed_key <= 8'h0;
	else if (ps2_key_pressed == 1'b1 && ps2_key_data != 8'hF0)	//if the key is pressed
		pressed_key <= ps2_key_data;
	
end
*/
/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

PS2_Controller PS2 (
	// Inputs
	.CLOCK_50			(CLOCK_50),
	.reset				(~reset),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
);

endmodule

module control_ps2 (clk, resetn, idle, pressed, unpressed, is_key_pressed, ps2_key_data);
	input clk, resetn, is_key_pressed;
	input [7:0] ps2_key_data;
	output reg idle, pressed, unpressed;
	reg [2:0] current_state, next_state;
	
	localparam 	S_IDLE			=	3'd0,
					S_PRESSED		=	3'd1,
					S_UNPRESSED		=	3'd2;
					
	// state table
	always @(*) begin
		case (current_state)
			S_IDLE:			next_state = is_key_pressed ? S_PRESSED: S_IDLE;
			S_PRESSED:		next_state = (is_key_pressed == 1'b0 && ps2_key_data == 8'hF0) ? S_UNPRESSED : S_PRESSED;
			S_UNPRESSED:	next_state = S_IDLE;
			default: next_state = S_IDLE;
		endcase
	end
	
	// enable signals
	always @(*) begin
		idle = 1'b0;
		pressed = 1'b0;
		unpressed = 1'b0;
		
		case (current_state)
			S_IDLE:			idle = 1'b1;
			S_PRESSED:		pressed = 1'b1;
			S_UNPRESSED:	unpressed = 1'b1;
		endcase
	end
	
	// current_state registers
   always@(posedge clk)
   begin: state_FFs
       if(!resetn)
           current_state <= S_IDLE;
       else
           current_state <= next_state;
   end // state_FFS
endmodule

module datapath_ps2 (clk, resetn, idle, pressed, unpressed, pressed_key, ps2_key_data);
	input clk, resetn, idle, pressed, unpressed;
	input [7:0] ps2_key_data;
	output reg [7:0] pressed_key;
	
	always @(posedge clk) begin
		if (idle) begin
			pressed_key <= 8'h0;
		end
		else if (pressed) begin
			pressed_key <= ps2_key_data;
		end
		else if (unpressed) begin
			pressed_key <= 8'h0;
		end
	end
	
endmodule 