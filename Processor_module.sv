module Processor_module(
		input logic		clk, reset,
		output logic [31:0] WriteData, DataAdr,
		output logic	MemWrite);
		
		logic [31:0] Instr, ReadData, PC;
		
		
		// Procesador ARM uniciclo
		arm arm(clk, reset, PC, Instr, MemWrite, DataAdr,
					WriteData, ReadData);
		
		// RAM con las instrucciones del algoritmo ecualizador
		imem imem(PC, Instr);
		
		// RAM para guardar la imagen ecualizada y los datos de las operaciones
		dmem dmem(clk, MemWrite,DataAdr, WriteData, ReadData);

endmodule 