module counter (
    input switch,
    input clk,
    input rst,
    output logic [15:0] count
);

logic [15:0] memAddress = 0;


always_ff @(posedge clk) begin
		if (rst) begin
			memAddress <= 0;
		end else if (memAddress >= 9999) begin
			memAddress <= 0;
		end else if (switch) begin
			if (memAddress < 9999) begin
				memAddress <= memAddress + 1;
			end
		end
	end
	
	
assign count = memAddress;
endmodule 