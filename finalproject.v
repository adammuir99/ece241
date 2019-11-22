
module finalproject (
	// Inputs
	CLOCK_50,
	KEY,

	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,

	FPGA_I2C_SCLK,
	SW,
	//VGA
	VGA_CLK,   						//	VGA Clock
	VGA_HS,							//	VGA H_SYNC
	VGA_VS,							//	VGA V_SYNC
	VGA_BLANK_N,						//	VGA BLANK
	VGA_SYNC_N,						//	VGA SYNC
	VGA_R,   						//	VGA Red[9:0]
	VGA_G,	 						//	VGA Green[9:0]
	VGA_B,   						//	VGA Blue[9:0]
	//PS2 Keyboard
	PS2_CLK,
	PS2_DAT
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input				CLOCK_50;
input		[3:0]	KEY;
input		[9:0]	SW;

input				AUD_ADCDAT;

// Bidirectionals
inout				AUD_BCLK;
inout				AUD_ADCLRCK;
inout				AUD_DACLRCK;

inout				FPGA_I2C_SDAT;

// Outputs
output				AUD_XCK;
output				AUD_DACDAT;

output				FPGA_I2C_SCLK;


//VGA
	output	VGA_CLK;   				//	VGA Clock
	output	VGA_HS;					//	VGA H_SYNC
	output	VGA_VS;					//	VGA V_SYNC
	output	VGA_BLANK_N;				//	VGA BLANK
	output	VGA_SYNC_N;				//	VGA SYNC
	output	[7:0] VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0] VGA_G;	 				//	VGA Green[7:0]
	output	[7:0] VGA_B;   				//	VGA Blue[7:0]
// PS2 Keyboard
inout				PS2_CLK;
inout				PS2_DAT;
/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires
wire				audio_in_available;
wire		[31:0]	left_channel_audio_in;
wire		[31:0]	right_channel_audio_in;
wire				read_audio_in;

wire				audio_out_allowed;
wire		[31:0]	left_channel_audio_out;
wire		[31:0]	right_channel_audio_out;
wire				write_audio_out;
wire		[7:0]	pressed_key;
wire 				ps2_key_pressed;

// Internal Registers

reg [18:0] delay_cnt;
wire [18:0] delay;

wire [31:0]sound;
reg snd;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

//always @(posedge CLOCK_50)
//	if(delay_cnt == delay) begin
//		delay_cnt <= 0;
//		snd <= !snd;
//	end else delay_cnt <= delay_cnt + 1;

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

//assign delay = {SW[3:0], 15'd3000};

//wire [31:0] sound = (SW == 0) ? 0 : snd ? 32'd10000000 : -32'd10000000;


assign read_audio_in			= audio_in_available & audio_out_allowed;

assign left_channel_audio_out	= left_channel_audio_in+sound;
assign right_channel_audio_out	= right_channel_audio_in+sound;
assign write_audio_out			= audio_in_available & audio_out_allowed;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/
PS2_Keyboard (
	// Inputs
	.CLOCK_50(CLOCK_50),
	.reset(KEY[0]),

	// Bidirectionals
	.PS2_CLK(PS2_CLK),
	.PS2_DAT(PS2_DAT),
	
	// Outputs
	.pressed_key(pressed_key),
	.ps2_key_pressed(ps2_key_pressed)
);

notes notes (
	.note_select(pressed_key),
	.clock(CLOCK_50),
	.reset(~KEY[0]), //active high reset
	.sound(sound),
	.ps2_key_pressed(ps2_key_pressed)
);

visual visual (
	.CLOCK_50(CLOCK_50),
	.reset(KEY[0]),	//active low reset		
	.VGA_CLK(VGA_CLK),   						//	VGA Clock
	.VGA_HS(VGA_HS),							//	VGA H_SYNC
	.VGA_VS(VGA_VS),							//	VGA V_SYNC
	.VGA_BLANK_N(VGA_BLANK_N),						//	VGA BLANK
	.VGA_SYNC_N(VGA_SYNC_N),						//	VGA SYNC
	.VGA_R(VGA_R),   						//	VGA Red[9:0]
	.VGA_G(VGA_G),	 						//	VGA Green[9:0]
	.VGA_B(VGA_B)   						//	VGA Blue[9:0]
);
	
Audio_Controller Audio_Controller (
	// Inputs
	.CLOCK_50						(CLOCK_50),
	.reset						(~KEY[0]),

	.clear_audio_in_memory		(),
	.read_audio_in				(read_audio_in),
	
	.clear_audio_out_memory		(),
	.left_channel_audio_out		(left_channel_audio_out),
	.right_channel_audio_out	(right_channel_audio_out),
	.write_audio_out			(write_audio_out),

	.AUD_ADCDAT					(AUD_ADCDAT),

	// Bidirectionals
	.AUD_BCLK					(AUD_BCLK),
	.AUD_ADCLRCK				(AUD_ADCLRCK),
	.AUD_DACLRCK				(AUD_DACLRCK),


	// Outputs
	.audio_in_available			(audio_in_available),
	.left_channel_audio_in		(left_channel_audio_in),
	.right_channel_audio_in		(right_channel_audio_in),

	.audio_out_allowed			(audio_out_allowed),

	.AUD_XCK					(AUD_XCK),
	.AUD_DACDAT					(AUD_DACDAT)

);

avconf #(.USE_MIC_INPUT(0)) avc (
	.FPGA_I2C_SCLK					(FPGA_I2C_SCLK),
	.FPGA_I2C_SDAT					(FPGA_I2C_SDAT),
	.CLOCK_50					(CLOCK_50),
	.reset						(~KEY[0])
);

endmodule

