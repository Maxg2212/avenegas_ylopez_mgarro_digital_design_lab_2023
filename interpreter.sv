module interpreter(input logic [31:0] next_x, next_y,
						 input logic [31:0] pixel_value_original, pixel_value_new,
						 
						 output logic [15:0] adr_original,
						 output logic [31:0] adr_new,
						 output logic [23:0] pixel_color);

	logic [7:0] color;
	logic [31:0] address;
		
	assign pixel_color[23:16] = color;
	assign pixel_color[15:8] = color;
	assign pixel_color[7:0] = color;
	
	assign adr_original = address[15:0];
	assign adr_new = address;
	
	always_comb begin
		
		// Imagen Original
		if (next_x >= 0 & next_x < 100 & next_y >= 0 & next_y < 100) 
		begin
			color = pixel_value_original[7:0];
			address = (next_y * 100) + next_x;
		end
		
		// Imagen Nueva
		else if (next_x >= 110 & next_x < 210 & next_y >= 0 & next_y < 100) 
		begin
			color = pixel_value_new[7:0];
			address = (next_y * 100) + next_x - 110;
		end
		
		else 
		begin
			color = 8'd_0;
			address = 32'd_0;
		end
		
	end
	
endmodule
