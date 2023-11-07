module flopr #(parameter WIDTH = 8)( //WIDTH es utilizado para definir ancho de datos del flip-flop
		input logic clk, reset,
		input logic [WIDTH-1:0] d, //datos de entrada con un ancho WIDTH
		output logic [WIDTH-1:0] q); //salida del Flip-flop
					
  always_ff @(posedge clk, posedge reset)
    if (reset) q <= 0; //si reset esta en alto, se asigna 0 a q
	 else q <= d;//si reset esta en bajo, se asigna d a q
	 
endmodule 