module videoGen(
	input logic [9:0] x, y,
	input logic [7:0] ram_data,
	output logic [7:0] r, g, b
);

	
	  always_comb begin
        r <= ram_data;
        g <= ram_data;
        b <= ram_data;
    end
	
endmodule