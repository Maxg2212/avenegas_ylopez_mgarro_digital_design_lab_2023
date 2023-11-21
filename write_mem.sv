module write_mem(
		input [2:0] btn,
		output logic enable,
		output logic [31:0] addr,
		output logic [31:0] data
);

always @ (btn) begin

	case(btn)
		3'b110: begin   //el numero representa un boton en especifico
			enable <= 1'b1;
			addr <= 15'd1;
			data <= 7'd1;
		end
		3'b101: begin	//el numero representa un boton en especifico
			enable <= 1'b1;
			addr <= 15'd1;
			data = 7'd2;
		end
		3'b011: begin 
			enable <= 1'b0;
			addr <= 15'd1;
		end
		default: begin
			enable <= 1'b0;
			addr <= 15'd15;
			//data = 7'd9;
		end
	endcase
end

endmodule 