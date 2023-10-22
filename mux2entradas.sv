module mux2entradas #(parameter WIDTH = 8)(
	input logic [WIDTH-1:0] d0, d1,
	input logic selector,
	output logic [WIDTH-1:0] y

);

	assign y = selector ? d1 : d0;
endmodule 