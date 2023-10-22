module barrel_shifter (
	input logic [31:0] input_data, //Ingreso de datos
	input logic [1:0] input_mode, //Ingreso de modo (left o right)
	input logic [4:0] input_shift_count, //Contador de shifts
	output logic [31:0] output_data //Salida de datos
);


	logic [63:0] left_shift;
	logic [63:0] right_shift;
	
	assign left_shift = {input_data, input_data} << input_shift_count;
	assign right_shift = {input_data, input_data} >> input_shift_count;
	
	always_comb begin
		case (input_mode)
				2'b00:
					begin 
						output_data = left_shift[31:0]; //left logico
					end
				2'b01:
					begin 
						output_data = right_shift[63:32]; //right logico
					end
				2'b10:
					begin 
						output_data = left_shift[63:32];	//left ciclico
					end
				2'b11:
					begin 
						output_data = right_shift[31:0];	//right ciclico
					end
				default:
					begin 
						output_data = {32{1'bx}};	//Estado X (Estado No importa)
					end
		endcase 
	end
	
endmodule 