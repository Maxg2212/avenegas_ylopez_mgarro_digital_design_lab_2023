`timescale 1 ns / 1 ns

module vga_tb();

	logic VGA_HS, VGA_VS;
	logic [7:0] VGA_R, VGA_G, VGA_B;
	logic VGA_SYNC_N, VGA_CLK, VGA_BLANK_N;
	
	logic [31:0] WriteData, DataAdrA, DataAdrB;
	logic MemWriteEnable;
	
	logic [31:0] PC = 32'd_0;
	logic [31:0] Instr, ReadDataA, ReadDataB;
	logic clk_ARM;
	
	logic [31:0] pixelOriginalA, pixelOriginalB;
	logic [15:0] pixelAdrOriginalA, pixelAdrOriginalB;
	
	logic [23:0] pixel_color;
	
	logic [31:0] next_x = 32'd_0;
	logic [31:0] next_y = 32'd_0;
	
	logic clk_25Mhz = 0;
	logic reset_vga = 0;
	
	
	RAM2 image_ram(pixelAdrOriginalA, 
					clk_25Mhz, 
					WriteData,
					MemWriteEnable,
					pixelOriginalA);
	
	interpreter inter(next_x, next_y,
						   pixelOriginalB, ReadDataB,
							pixelAdrOriginalB, DataAdrB,
						   pixel_color);
	
	
	vgaController draw(clk_25Mhz, reset_vga, pixel_color,
						 VGA_HS, VGA_VS,
						 VGA_R, VGA_G, VGA_B, 
						 VGA_SYNC_N, VGA_CLK, VGA_BLANK_N,
						 next_x, next_y);
	
	initial begin
		
		clk_25Mhz = 0; # 5;
		clk_25Mhz = 1; # 5;
		assert (pixelAdrOriginalB === 16'd_1) else begin
			$error("La direccion deberia ser 0x1");
			$stop;
		end
		clk_25Mhz = 0; # 5;
		clk_25Mhz = 1; # 5;
		assert (pixelAdrOriginalB === 16'd_2) else begin
			$error("La direccion deberia ser 0x2");
			$stop;
		end
		clk_25Mhz = 0; # 5;
		clk_25Mhz = 1; # 5;
		assert (pixelAdrOriginalB === 16'd_3) else begin
			$error("La direccion deberia ser 0x2");
			$stop;
		end
		clk_25Mhz = 0; # 5;
		clk_25Mhz = 1; # 5;
		
		$display("Simulacion del driver VGA y el interprete exitosa.");
	end
	
endmodule