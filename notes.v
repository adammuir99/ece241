module notes (note_select, clock, reset, sound, ps2_key_pressed);
	input [7:0] note_select;
	input clock, reset;
	input ps2_key_pressed;
	output sound;
	reg [17:0] Q;
	reg snd;
	assign enable = ~|Q;
	wire [31:0] sound = snd ? 32'd10000000 : -32'd10000000;

	
	always @(posedge clock) begin
	
		if (reset == 1'b1) begin
		 Q <= 18'b0;
		end
		if (Q == 18'b0)
			snd <= !snd;
		
//		if (ps2_key_pressed) begin
		case (note_select)
			7'h49:	//. 
			begin
				if (Q == 18'd25309)		//B5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h4B:	//L
			begin
				if (Q == 18'd26815)		//Bb5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h41:	//,
			begin
				if (Q == 18'd28409)		//A5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h42:	//K
			begin
				if (Q == 18'd30099)		//Ab5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h3A:	//M 
			begin
				if (Q == 18'd31888)		//G5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h3B:	//J
			begin
				if (Q == 18'd33784)		//Gb5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h31:	//N 
			begin
				if (Q == 18'd35791)		//F5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h32:	//B
			begin
				if (Q == 18'd37919)		//E5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h34:	//G
			begin
				if (Q == 18'd40174)		//Eb5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h2A:	//V
			begin
				if (Q == 18'd42568)		//D5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h2B:	//F 
			begin
				if (Q == 18'd45094)		//Db5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h21:	//C
			begin
				if (Q == 18'd47774)		//C5
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h22:	//X
			begin
				if (Q == 18'd50618)		//E4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h1B:	//S
			begin
				if (Q == 18'd53625)		//Bb4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h1A:	//Z
			begin
				if (Q == 18'd56818)		//A4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h1C:	//A
			begin
				if (Q == 18'd60197)		//Ab4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h5B:	//]
			begin
				if (Q == 18'd63776)		//G4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h55:	//=
			begin
				if (Q == 18'd67568)		//Gb4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h54:	//[
			begin
				if (Q == 18'd71592)		//F4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h4D:	//P 
			begin
				if (Q == 18'd75850)		//E4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h45:	//0 zero
			begin
				if (Q == 18'd80360)		//Eb4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h44:	//O
			begin
				if (Q == 18'd85120)		//D4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h46:	//9 
			begin
				if (Q == 18'd90188)		//Db4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h43:	//I 
			begin
				if (Q == 18'd95566)		//C4
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h3C:	//U 
			begin
				if (Q == 18'd101256)		//B3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h3D:	//7 
			begin
				if (Q == 18'd107250)		//Bb3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h35:	//Y  
			begin
				if (Q == 18'd113636)		//A3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h36:	//6  
			begin
				if (Q == 18'd120395)		//Ab3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h2C:	//T 
			begin
				if (Q == 18'd127551)		//G3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h2E:	//5
			begin
				if (Q == 18'd135135)		//Gb3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h2D:	//R
			begin
				if (Q == 18'd143184)		//F3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h24:	//E
			begin
				if (Q == 18'd151699)		//E3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h26:	//3
			begin
				if (Q == 18'd160668)		//Eb3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h1D:	//W
			begin
				if (Q == 18'd170300)		//D3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h1E:	//2
			begin
				if (Q == 18'd180375)		//Db3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			7'h15:	//Q
			begin
				if (Q == 18'd191131)		//C3
					Q <= 18'b0;
				else
					Q <= Q + 1'b1;
			end
			default:;
		endcase
//		end
	end
endmodule