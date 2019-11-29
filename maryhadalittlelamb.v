//Uses four notes : C D E G
module maryhadalittlelamb (clock, load, mhall_keys);
	input clock;
	input load;
	output [6:0] mhall_keys;
	reg [293:0]shiftreg;
	wire enable;
	rateDivider (.clock(clock), .enable(enable));
	
	always @(posedge clock) begin
		if (load) begin
			shiftreg <= {
							7'h4D,
							7'h44,
							7'h43,
							7'h44,
							7'h4D,
							7'd0,
							7'h4D,
							7'd0,
							7'h4D,
							7'h4D,
							7'h44,
							7'd0,
							7'h44,
							7'd0,
							7'h44,
							7'h44,
							7'h4D,
							7'h5B,
							7'd0,
							7'h5B,
							7'h5B,
							7'd0,
							7'd0,
							7'h4D,
							7'h44,
							7'h43,
							7'h44,
							7'h4D,
							7'd0,
							7'h4D,
							7'd0,
							7'h4D,
							7'h4D,
							7'h44,
							7'd0,
							7'h44,
							7'h4D,
							7'h44,
							7'h43,
							7'h43,
							7'h43,
							7'h43
							};
		end
		else begin
			if (enable) begin
				shiftreg <= shiftreg << 7;
			end
		end
	end
	
	assign mhall_keys = shiftreg[293:287];
	
endmodule

module rateDivider (clock, enable);
	input clock;
	output enable;
	reg [26:0] Q;
	assign enable = ~|Q;

	always @(posedge clock) begin
		if (Q == 27'b0)
			Q <= 27'd16666666; // 4Hz
		else
			Q <= Q - 1;
	end
endmodule