module top_Ram_module(input logic clk, reset, switch,
								input logic [2:0] btn, 
								output [31:0] q,
								output [15:0] address);
								
			logic wrenable;
			logic seconds;
			logic [31:0] data;
			logic [15:0] addressRead, addressWrite;
			
			RAM4 ram(address, seconds, data, wrenable, q);
			
			counter contador(switch, seconds, reset, addressRead);
			
			write_mem escribir_memoria(btn, wrenable, addressWrite, data);
			
			mux2entradas mux2e(addressWrite, addressRead, reset, address);
			
			hhclock hhclock(clk, seconds);
			


endmodule 