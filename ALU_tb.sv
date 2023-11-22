module ALU_tb();


  parameter N = 4;
  reg [N-1:0] a_i;
  reg [N-1:0] b_i;
  reg [2:0] opcode_i;


  wire [N-1:0] result_o;
  wire [3:0] ALUFlags;

  // Instancia 
  ALU #(N) uut (
    .a_i(a_i),
    .b_i(b_i),
    .opcode_i(opcode_i),
    .result_o(result_o),
    .ALUFlags(ALUFlags)
  );

  initial begin
    //AND 
    a_i = 4'b1100;
    b_i = 4'b1010;
    opcode_i = 3'b010;
    #40; 

    //OR 
    a_i = 4'b1100;
    b_i = 4'b1010;
    opcode_i = 3'b011;
    #40;

    //Suma/resta 
    a_i = 4'b1100;
    b_i = 4'b1010;
    opcode_i = 3'b000;
    #40;


    $finish;
  end

endmodule
