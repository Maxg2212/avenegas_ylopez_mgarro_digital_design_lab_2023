module ram_tb();

logic clock, wren, rst;

logic [7:0] address, data, q;

ram1 mem(address, clock, data, wren, q);
//Counter cont(clock, rst, 1'b1, address);

endmodule