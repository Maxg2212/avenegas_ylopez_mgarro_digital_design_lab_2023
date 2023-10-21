module adder_ALU #(parameter N = 8)(
	input logic [N-1:0] a, b,
	input logic carry_in,
	output logic [N-1:0] operacion,
	output logic carry_out
);

		assign {carry_out, operacion} = a + b + carry_in;
		
endmodule