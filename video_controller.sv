module video_controller 
(
    input logic clk,reset,
	 input logic [7:0] pixel,
    output logic h_sync,
    output logic v_sync,
    output logic [7:0] red,
    output logic [7:0] green,
    output logic [7:0] blue,
    output logic clk_25MHz,
    output logic sync_n,
    output logic blank_n
);



    // VGA variables de control
    logic enable;
    logic [15:0] V_horizontal;
    logic [15:0] V_vertical;
	 integer ancho = 640;
	 integer alto = 480;
	 
    // pll
    VGA_pll vga_clock_gen(clk,reset, clk_25MHz);

    // contadores pata sincronizadores
    sincronizador_horizontal vga_h (clk_25MHz, enable, V_horizontal);
    sincronizador_vertical vga_v (clk_25MHz, enable, V_vertical);

    // Sincronización vertical y horizontal 
    assign h_sync = (V_horizontal < 96) ? 1'b1 : 1'b0;
    assign v_sync = (V_vertical < 2) ? 1'b1 : 1'b0;

    

    // Zona activa de la pantalla (pantalla en blanco)
    assign blank_n = (V_horizontal >= 96) && (V_horizontal < 799) && (V_vertical >= 2) && (V_vertical < 524);
	 assign sync_n = h_sync && v_sync;
    

	  always@(posedge clk_25MHz) begin
	  
	  //rebir el pixel y mostralo
		  red <= 2'h00;
		  green <= 2'h00;
		  blue <= 2'hFF;
    end


	 

endmodule