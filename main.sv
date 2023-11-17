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
	
	// ROM que guarda los datos de la imagen (256x256 tamaño máximo)
	//ROM2 image_rom(pixelAdrOriginalA, pixelAdrOriginalB, 
	//					clk_25Mhz, 
	//					pixelOriginalA, pixelOriginalB);
	
	
	
	// Interprete para ayudarle al Driver VGA a dibujar las dos imagenes
	interpreter inter(next_x, next_y,
						   pixelOriginalB, ReadDataB,
							pixelAdrOriginalB, DataAdrB,
						   pixel_color);
	
	// Driver VGA (para mostrar las dos imagenes en pantalla)
	vga_driver draw(clk_25Mhz, reset_vga, pixel_color,
						 VGA_HS, VGA_VS,
						 VGA_R, VGA_G, VGA_B, 
						 VGA_SYNC_N, VGA_CLK, VGA_BLANK_N,
						 next_x, next_y);
	
	// Reloj para la salida VGA
	always_ff @ (posedge clk_50Mhz_in)
		clk_25Mhz <= ~clk_25Mhz;
	
	
	// Detiene el procesador cuando termina la tarea de ecualizacion
	always_comb begin
		
		if(PC > 32'd_408) begin 
			clk_ARM = 0;
			led_success = 1;
		end
		else begin
			clk_ARM = clk_25Mhz;
			led_success = 0;
		end
	end
	
	
endmodule 