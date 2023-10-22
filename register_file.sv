module register_file (
	input logic clk,
	input logic we3, //indice si hay que realizar una escritura en el registro
	input logic [3:0] ra1, ra2, wa3,
	input logic [31:0] wd3, r15,
	output logic [31:0] rd1, rd2
);

	logic [31:0] rf[14:0]; //son 15 regsitros (en los que se puede leer o escribir) de 32 bits
	// Register file de tres puertos
	// Dos puertos combinatorios (ra1 y ra2)
	// El puerto wa3 se lee en el flanco ascendente o positivo del clk
	// r15 lee el PCplus8
	
	always_ff @(posedge clk)
	if (we3) rf[wa3] <= wd3; //Si we3 es true => se asigna el valor en wd3 al registro especificado por wa3, así se escribe
	
	assign rd1 = (ra1 == 4'b1111) ? r15 : rf[ra1];
	assign rd2 = (ra2 == 4'b1111) ? r15 : rf[ra2];

endmodule 