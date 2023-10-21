module ALU #(parameter N = 32)(
	input logic [N-1:0] a, b,
	input logic [2:0] ALU_control,
	input logic [4:0] cantidad_shifts,
	input logic [1:0] tipo_shift,
	output logic [N-1:0] Resultado,
	output logic [3:0] ALU_flags

);

	logic [N-1:0] resultADD, resultSUB, resultAND, resultOR, resultSHIFT;
	logic carry_out, carry_out_ADD, carry_out_SUB;
	
	adder_ALU #(32) adder_instancia (a, b, 1'b0, resultADD, carry_out_ADD);
	adder_ALU #(32) subtractor_instancia (a, ~b, 1'b1, resultSUB, carry_out_SUB);
	
	
	assign resultAND = a & b;
	assign resultOR = a | b;
	
	always_comb begin
			case (ALU_control)
				3'b000: //Add
				begin
						Resultado = resultADD;
						carry_out = carry_out_ADD;
				end
				
				3'b001: //Substract
				begin
						Resultado = resultSUB;
						carry_out = carry_out_SUB;
				end
				
				3'b010: //AND
				begin
						Resultado = resultAND;
						carry_out = 0;
				end
				
				3'b011: //OR
				begin
						Resultado = resultOR;
						carry_out = 0;
				end
				
				3'b100: //SHIFT
				begin
						Resultado = resultSHIFT;
						carry_out = 0;
				end
				
				default:
				begin
						Resultado = 32'b0;
						carry_out = 0;
						
				end
				
		endcase				
	end
	
	// ALU_flags: [3] = Negativo	[2] = Zero_flag	[1] = Carry out	[0] = OverFlow
assign ALU_flags[3] = Resultado[N-1];
assign ALU_flags[2] = &(~Resultado);
assign ALU_flags[1] = ((~ALU_control[1]) & carry_out);
assign ALU_flags[0] = ~(a[N-1] ^ b[N-1] ^ ALU_control[0]) & (a[N-1] ^ Resultado[N-1]) & (~ALU_control[1]);
	

endmodule