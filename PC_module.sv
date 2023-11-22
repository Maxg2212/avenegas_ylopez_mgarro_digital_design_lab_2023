module PC_module(rd,RegW,Branch,PCs);
  input [3:0]rd;
  input RegW,Branch;
  output PCs;
  
  assign PCs=((rd==15)&&RegW)||Branch;
endmodule