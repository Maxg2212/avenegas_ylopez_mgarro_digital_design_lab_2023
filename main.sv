module main(input logic clk, reset, switch,
			input logic [2:0] btn,
			output logic h_sync,
			output logic v_sync,
			output logic [7:0] red,
			output logic [7:0] green,
			output logic [7:0] blue,
			output logic clk_25MHz,
			output logic sync_n,
			output logic blank_n,
			output logic [31:0] q,
			output logic [31:0] WriteData, DataAdr,
			output logic MemWrite
);
			
	
		logic [15:0]  address;
	
	
		Processor_module proce(clk, reset, WriteData, DataAdr, MemWrite);
		
		top_Ram_module topR(clk, reset, switch, btn, q, address);

		video_controller vc(clk, reset, q, h_sync,
		v_sync, red, green, blue, clk_25MHz, sync_n, blank_n);
    
	
endmodule