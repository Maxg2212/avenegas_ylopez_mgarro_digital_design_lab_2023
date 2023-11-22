module Deco_ALU(ALUOp,Func,ALUControl,FlagW);
  input ALUOp;
  input [4:0]Func;
  output [1:0]ALUControl,FlagW;
  
  
  always@* begin
	  if(ALUOp==0) begin 
		 ALUControl=2'b00;
		 FlagW=2'b00;
	  end
	  
	  
	  else begin

			  if(Func[4:1]==4'b0000 && Func[0]==1) begin
				 ALUControl=2'b10;
				 FlagW=2'b10;
			  end 
				 else if(Func[4:1]==4'b0000 && Func[0]==0) begin
					ALUControl=2'b10;
					FlagW=2'b00;
				 end 

			

			  if(Func[4:1]==4'b0100 && Func[0]==1) begin
				 ALUControl=2'b00;
				 FlagW=2'b11;
			  end 
				 else if(Func[4:1]==4'b0100 && Func[0]==0) begin
					ALUControl=2'b00;
					FlagW=2'b00;
				 end 

			

			  if(Func[4:1]==4'b0010 && Func[0]==1) begin
				 ALUControl=2'b10;
				 FlagW=2'b11;
			  end 
				 else if(Func[4:1]==4'b0010 && Func[0]==0) begin
					ALUControl=2'b10;
					FlagW=2'b00;
				 end 


			  if(Func[4:1]==4'b1100 && Func[0]==1) begin
				 ALUControl=2'b11;
				 FlagW=2'b10;
			  end 
				 else if(Func[4:1]==4'b1100 && Func[0]==0) begin
					ALUControl=2'b11;
					FlagW=2'b00;
				 end 
				 
				 else begin
					ALUControl=2'b00;
					FlagW=2'b00;
				 end 

	  
  end
  end
endmodule