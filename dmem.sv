module dmem(input logic clk, we,
				input logic [31:0] a, wd,
				output logic [31:0] rd);
	
	/*
	logic [31:0] DRAM[63:0];
	
	assign rd = DRAM[a[31:2]]; // word aligned
	
	always_ff @(posedge clk)
		if (we) DRAM[a[31:2]] <= wd;
	*/
	
	
	/*
	logic [16:0] _a;
	
	always_comb begin
		if(a[18:2] < 0 | a[18:2] >= 70000) _a = 17'd_0;
		else _a = a[18:2];
	end
	
	logic [31:0] wd_b = 32'd_0;
	logic we_b = 0;
	
	RAM2 iram(_a, b[16:0],
				 clk, 
				 wd_a, wd_b, 
				 we_a, we_b,
				 rd_a, rd_b);
	*/
	RAM4 ram(a, clk, wd, we, rd);
	
		
endmodule