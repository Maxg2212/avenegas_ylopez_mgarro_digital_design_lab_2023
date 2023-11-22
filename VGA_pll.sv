// clock divider 
module VGA_pll  (
    input logic clk, // 50 MHz
	 input logic reset,
    output logic vga_clk // 25 MHz
);

    // Valor de división = (entrada / (2*salida deseada)) - 1
    // Contador
    integer counter = 0;
	 
	 

    always_ff @(posedge clk)
    begin
	 
	 if (reset) begin
      counter <= 0;
		vga_clk <= 0;
    end else begin
      if (counter == 10'b1) begin
        counter <= 10'b0;
        vga_clk = ~vga_clk;
      end else begin
        counter <= counter + 1;
      end
    end
	 
	 end
        

endmodule