module adder_ALU #(parameter WIDTH = 8)(
	input logic [WIDTH-1:0] a, b,
	//input logic carry_in,
	//output logic [N-1:0] operacion,
	//output logic carry_out
	output logic [WIDTH-1:0] y
);

		//assign {carry_out, operacion} = a + b + carry_in;
		assign y = a + b;
		
endmodule