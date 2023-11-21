module comparator(input int a, b, output eq, output leq);
	
	assign eq = (a == b);
	assign leq = (a <= b);
	
endmodule