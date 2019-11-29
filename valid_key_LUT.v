module valid_key_LUT (input [7:0] pressed_key_in, output reg [7:0] pressed_key_out);
	always @(*) begin
		if (
		pressed_key_in == 8'h49 ||
		pressed_key_in == 8'h4B ||
		pressed_key_in == 8'h41 ||
		pressed_key_in == 8'h42 ||
		pressed_key_in == 8'h3A ||
		pressed_key_in == 8'h3B ||
		pressed_key_in == 8'h31 ||
		pressed_key_in == 8'h32 ||
		pressed_key_in == 8'h34 ||
		pressed_key_in == 8'h2A ||
		pressed_key_in == 8'h2B ||
		pressed_key_in == 8'h21 ||
		pressed_key_in == 8'h22 ||
		pressed_key_in == 8'h1B ||
		pressed_key_in == 8'h1A ||
		pressed_key_in == 8'h1C ||
		pressed_key_in == 8'h5B ||
		pressed_key_in == 8'h55 ||
		pressed_key_in == 8'h54 ||
		pressed_key_in == 8'h4D ||
		pressed_key_in == 8'h45 ||
		pressed_key_in == 8'h44 ||
		pressed_key_in == 8'h46 ||
		pressed_key_in == 8'h43 ||
		pressed_key_in == 8'h3C ||
		pressed_key_in == 8'h3D ||
		pressed_key_in == 8'h35 ||
		pressed_key_in == 8'h36 ||
		pressed_key_in == 8'h2C ||
		pressed_key_in == 8'h2E ||
		pressed_key_in == 8'h2D ||
		pressed_key_in == 8'h24 ||
		pressed_key_in == 8'h26 ||
		pressed_key_in == 8'h1D ||
		pressed_key_in == 8'h1E ||
		pressed_key_in == 8'h15 
		)
			pressed_key_out <= pressed_key_in;
		else
			pressed_key_out <= 8'h0;
	end
endmodule