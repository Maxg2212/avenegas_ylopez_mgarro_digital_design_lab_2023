module extend_module (
	input logic [23:0] Instruccion,
	input logic [1:0] ImmSrc,
	output logic [31:0] ExtImm
);

	always_comb 
		case(ImmSrc)
				// 8-bit
				2'b00: ExtImm = {24'b0, Instruccion[7:0]};
				// 12-bit
				2'b01: ExtImm = {20'b0, Instruccion[11:0]};
				//24-bit
				2'b10: ExtImm = {{6{Instruccion[23]}}, Instruccion[23:0], 2'b00};
				
				default: ExtImm = 32'bx;
		
		
		endcase
	


endmodule 