module imem(input logic [31:0] a,
				output logic [31:0] rd);
				
	
	logic [31:0] INST_RAM[63:0];
	initial
		$readmemh("C:\\Users\\maxga\\OneDrive\\Documentos\\TDD_Labs2\\ylopez_mgarro_digital_design_lab_2023\\memfile.dat",INST_RAM);
	
	assign rd = INST_RAM[a[31:2]]; // word aligned
	
endmodule