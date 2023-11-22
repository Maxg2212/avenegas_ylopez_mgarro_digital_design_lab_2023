module top_module(
		input logic clk, reset,
		input logic [2:0] btn,
		output [7:0] q, //salida de memoria
		output [7:0] address
);

logic wren, seconds;

logic [7:0] data, addr_wr, add_cont;

ram4 mem(address, seconds, data, wren, q);
Counter cont(seconds, rst, 1'b1, addr_cont);
hhclock div(seconds, clk);
write_mem escribir(btn, wren, addr_wr, data);
mux_21 mux_addr(addr_wr, addr_cont, reset, address);

endmodule