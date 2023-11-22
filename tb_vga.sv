module tb_vga();

  logic vgaclk, hsync, vsync, sync_b, blank_b, clk;
  logic [7:0] r, g, b;

  vga_top pintar(
    clk,
	 8'b10010110,
    vgaclk, hsync, vsync, sync_b, blank_b, r, g, b
  );
  
  initial begin
    clk = 0;
    // Repite el bucle 250 veces
    repeat (250) begin
      #20 clk = ~clk;
    end
    $stop; // Termina la simulación después del bucle
  end

endmodule