module VGA_tb;

  // Parámetros de simulación
  reg clk=0;
  reg reset=0;
  reg [7:0] red;
  reg [7:0] green;
  reg [7:0] blue;
  reg clk_25MHz;
  wire sync_n,h_sync,v_sync;
  wire blank_n;

  // Instancia del módulo de video_controller
  video_controller dutio(
    .clk(clk),
	 .reset(reset),
    .h_sync(h_sync),
    .v_sync(v_sync),
    .red(red),
    .green(green),
    .blue(blue),
    .clk_25MHz(clk_25MHz),
    .sync_n(sync_n),
    .blank_n(blank_n)
  );
  
 /* VGA_pll pkpk(
     .clk(clk),
	  .reset(reset), 
     .vga_clk(clk_25MHz)
);*/

  // Generador de clock
  always begin
    #5 clk = ~clk; // Invertir el reloj cada 5 unidades de tiempo
  end

  // Estímulos de prueba
  initial begin
  

	 #5 reset=1;
	 #5 reset=0;
	 #150000;
    $finish;
  end

endmodule