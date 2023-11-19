module ALU_tb;

  parameter N = 4;

  reg [N-1:0] a_i;
  reg [N-1:0] b_i;
  reg [2:0] opcode_i;

  // Salidas
  wire [N-1:0] result_o;
  wire [3:0] ALUFlags;

  //Instancia
  ALU #(N) uut (
    .a_i(a_i),
    .b_i(b_i),
    .opcode_i(opcode_i),
    .result_o(result_o),
    .ALUFlags(ALUFlags)
  );

  // Inicializar 
  initial begin
    a_i = 4'b1010; 
    b_i = 4'b1100; 
    opcode_i = 3'b010; 
	$display("a_i: %b, b_i: %b, Resultado: %b, ALUFlags: %b", a_i, b_i, result_o, ALUFlags);
	 #100 $finish;

    // Pruebas
    #10 a_i = 4'b1111;
    #10 b_i = 4'b0000;
    #10 opcode_i = 3'b011;

    #10 b_i = 4'b1100; 
    #10 opcode_i = 3'b010; 
	$display("a_i: %b, b_i: %b, Resultado: %b, ALUFlags: %b", a_i, b_i, result_o, ALUFlags);
    #10 a_i = 4'b1110; 
    #10 b_i = 4'b1000; 
    #10 opcode_i = 3'b111; 
	 
	 $display("a_i: %b, b_i: %b, Resultado: %b, ALUFlags: %b", a_i, b_i, result_o, ALUFlags);
	 #100 $finish;
  end

  // Resultados
endmodule
