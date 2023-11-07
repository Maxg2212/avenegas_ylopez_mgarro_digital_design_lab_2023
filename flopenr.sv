module flopenr #(parameter WIDTH = 8) ( //WIDTH es utilizado para definir ancho de datos del flip-flop
	input logic clk, reset, en,
	input logic [WIDTH-1:0] d, //datos de entrada con un ancho WIDTH
	output logic [WIDTH-1:0] q); //salida del Flip-flop
					  
  always_ff @(posedge clk, posedge reset)
    if (reset)   q <= 0; //Si reset esta en el alto, se asigna 0 a la salida
    else if (en) q <= d; //si reset esta en bajo y "en" en alto, se asigna valor de d a q.
endmodule