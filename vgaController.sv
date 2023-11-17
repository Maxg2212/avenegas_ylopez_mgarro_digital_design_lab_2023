module vgaController (input clk_in, reset,			//clk: 25MHz
						input [23:0] pixel_color, 	//RRRGGGBB (8 bits)
						output h_sync, v_sync,
						output [7:0] red_out, green_out, blue_out,	//Color del VGA DAC
						output sync_n_out, clk_out, blank_out,			//Señales del VGA DAC
						output [31:0] next_x, next_y						//posicion del pixel
						);
						
	
	//Valores de la señal horizontal (en pixeles)
	parameter ACTIVE_H_LIMIT = 635,
				 FRONT_H_LIMIT = 650,  	//635 + 15
				 PULSE_H_LIMIT = 745,	//650 + 95
				 BACK_H_LIMIT = 792,		//745 + 47
						 
	//Valores de la señal vertical (lineas)
				 ACTIVE_V_LIMIT = 479,
				 FRONT_V_LIMIT = 488,	//479 + 9
				 PULSE_V_LIMIT = 489,	//488 + 1
				 BACK_V_LIMIT = 521;		//489 + 32
	
	
	
	//Señales de los comparadores
	logic let_active_h, let_front_h, let_pulse_h, let_back_h;
	logic eq_active_h, eq_front_h, eq_pulse_h, eq_back_h;
	logic let_active_v, let_front_v, let_pulse_v, let_back_v;
	logic eq_active_v, eq_front_v, eq_pulse_v, eq_back_v;
	
	
	//Registros
	int counter_h = 0;
	int counter_v = 0;
	
	//Resets y control para las lineas
	logic reset_h;
	logic reset_v;
	logic h_line_completed;
	
	
	// Contadores
	
	counter horizontal_counter (clk_in, reset_h, counter_h);
	counter vertical_counter (h_line_completed, reset_v, counter_v);
	
	
	// Comparadores horizontales
	
	comparator h_active_comparator(counter_h, ACTIVE_H_LIMIT, eq_active_h, let_active_h);
	comparator h_front_comparator(counter_h, FRONT_H_LIMIT, eq_front_h, let_front_h);
	comparator h_pulse_comparator(counter_h, PULSE_H_LIMIT, eq_pulse_h, let_pulse_h);
	comparator h_back_comparator(counter_h, BACK_H_LIMIT, eq_back_h, let_back_h);
	
	
	// Comparadores verticales
	
	comparator v_active_comparator(counter_v, ACTIVE_V_LIMIT, eq_active_v, let_active_v);
	comparator v_front_comparator(counter_v, FRONT_V_LIMIT, eq_front_v, let_front_v);
	comparator v_pulse_comparator(counter_v, PULSE_V_LIMIT, eq_pulse_v, let_pulse_v);
	comparator v_back_comparator(counter_v, BACK_V_LIMIT, eq_back_v, let_back_v);
	
	
	//Logica
		
	//resets
	assign reset_h = reset | eq_back_h;
	assign reset_v = reset | eq_back_v;
	assign h_line_completed = eq_back_h;
	
		
	//señales de sincronizacion
	assign h_sync = let_front_h | (let_back_h & ~let_pulse_h);
	assign v_sync = let_front_v | (let_back_v & ~let_pulse_v);
		
			
	assign red_out = (let_active_h & let_active_v) ? pixel_color[23:16] : 8'd_0;
   assign green_out = (let_active_h & let_active_v) ? pixel_color[15:8] : 8'd_0;
   assign blue_out = (let_active_h & let_active_v) ? pixel_color[7:0] : 8'd_0;
	
	
	//Salidas
	
   assign clk_out = clk_in;
   assign sync_n_out = 0;
   assign blank_out = h_sync & v_sync;
	
	// Coordenadas x y del siguiente pixel
   assign next_x = let_active_h ? counter_h : 0;
   assign next_y = let_active_v ? counter_v : 0;

endmodule
