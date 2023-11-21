module counter (
    input switch,
    input clk,
    input rst,
    output logic [14:0] count
);

always_ff @(negedge clk or posedge rst) begin
    if (rst) begin
        // Resetear el contador a 0 cuando rst es activado
        count = 14'd0;
    end 
	 else begin
        if (switch) begin
            // Contar de 0 a 9999
            if (count == 14'd9999) begin
                count = 14'd0;
            end 
				else begin
                count = count + 1'b1;
            end
		  end
	 end
end
endmodule