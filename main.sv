module main(input logic clk_50Mhz_in, reset,

				output VGA_HS, VGA_VS, 
				output [7:0] VGA_R, VGA_G, VGA_B, 
				output VGA_SYNC_N, VGA_CLK, VGA_BLANK_N,
	
				output logic led_success);
	
	logic [31:0] WriteData, DataAdrA, DataAdrB;
	logic MemWriteEnable;
	
	logic [31:0] PC = 32'd_0;
	logic [31:0] Instr, ReadDataA, ReadDataB;
	logic clk_ARM;
	
	
	
	// Para acceder a los pixeles de la imagen en la ROM
	logic [31:0] pixelOriginalA, pixelOriginalB;
	logic [15:0] pixelAdrOriginalA, pixelAdrOriginalB;
	
	
	// Para controlar los puertos del Driver VGA
	logic [23:0] pixel_color;
	
	// Controla la posicion del siguiente pixel del DriverVGA
	logic [31:0] next_x = 32'd_0;
	logic [31:0] next_y = 32'd_0;
	
	logic clk_25Mhz = 0;
	logic reset_vga = 0;
	
	
	
	// Procesador ARM uniciclo
	arm arm(clk_ARM, reset, PC, Instr, MemWriteEnable, DataAdrA,
				WriteData, ReadDataA);
	
	// RAM con las instrucciones del algoritmo ecualizador
	imem imem(PC, Instr);
	
	// RAM para guardar la imagen ecualizada y los datos de las operaciones
	dmem dmem(clk_25Mhz, 
				 DataAdrA, DataAdrB, 
				 WriteData, MemWriteEnable,
				 ReadDataA, ReadDataB);
	
	
	
endmodule 