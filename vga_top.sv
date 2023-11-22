module vga_top(
	input logic clk,
	input logic [7:0] ram_data,
	output logic vgaclk,
	output logic hsync, vsync,
	output logic sync_b, blank_b,
	output logic [7:0] r, g, b
);
	logic [9:0] x, y;
	pll vgapll(
		.inclk0(clk),
		.c0(vgaclk)
	);
	
	vgaController vgaCont(
		.vgaclk(vgaclk),
		.hsync(hsync),
		.vsync(vsync),
		.sync_b(sync_b),
		.blank_b(blank_b),
		.x(x),
		.y(y)
	);
	
//	videoGen vgaVideoGen(
//		.x(x),
//		.y(y),
//		.ram_data(ram_data),
//		.r(r),
//		.g(g),
//		.b(b)
//	);
	
	generate_graphic generar_g(
		.x(x),
		.y(y),
		.ReadData(ram_data),
		.red(r),
		.green(g),
		.blue(b)
	);
	

endmodule