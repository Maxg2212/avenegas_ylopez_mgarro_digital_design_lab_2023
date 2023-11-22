// Code your design here
module unidad_control( clk, reset,cond,op,func,rd,ALUflags,PCSrc,MemtoReg,MemWrite,ALUControl,ALUSrc,ImmSrc,RegWrite,RegSrc);
  input [3:0]cond;
  input [1:0]op;
  input [5:0]func;
  input [3:0]rd;
  input [3:0]ALUflags;
  input clk;
  input reset;
  output PCSrc;
  output MemtoReg;
  output MemWrite;
  output [1:0]ALUControl;
  output ALUSrc;
  output [1:0]ImmSrc;
  output RegWrite;
  output [1:0]RegSrc;
  
  
  wire rgw,mmw,alop,brc,pcs,c_chk;
  wire [1:0] fw;

  main_decoder principal(
	.op(op),
	.func(func),
	.RegW(rgw),
	.MemW(mmw),
	.MemtoReg(MemtoReg),
	.ALUSrc(ALUSrc),
	.ImmSrc(ImmSrc),
	.RegSrc(RegSrc),
	.ALUop(alop),
	.branch(brc)
			  );

	Deco_ALU d_alu(
	.ALUOp(alop),
	.Func(func),
	.ALUControl(ALUControl),
	.FlagW(fw)
	);
	
	PC_module pcl(
	.rd(rd),
	.RegW(rgw),
	.Branch(brc),
	.PCs(pcs)
	);
	
	condlogic clogic(
	.clk(clk),
	.reset(reset),
	.FlagW(fw),
	.PCS(pcs),
	.MemW(mmw),
	.RegW(rgw),
	.ALUFlags(ALUflags),
	.Cond(cond),
	.PCSrc(PCSrc),
	.MemWrite(MemWrite),
	.RegWrite(RegWrite)
	);


endmodule
