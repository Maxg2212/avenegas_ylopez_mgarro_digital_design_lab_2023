module main(
		input logic		clk, reset,
		output logic [31:0] WriteData, DataAdr,
		output logic	MemWrite);



	//logic [31:0] PC = 32'd_0; 
	
	logic [14:0] address;
	
	Processor_module processor(clk, reset, WriteData, DataAdr, MemWrite);

	
	
	
	
	
	
endmodule 