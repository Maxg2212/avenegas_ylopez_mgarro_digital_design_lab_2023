module main_decoder(op,func,RegW,MemW,MemtoReg,ALUSrc,ImmSrc,RegSrc,ALUop,branch);
  input [1:0]op;
  input [5:0]func;
  output RegW,MemW,MemtoReg,ALUSrc,ALUop,branch;
  output [1:0]ImmSrc,RegSrc;
	
	always@* begin
        if(op == 2'b00&&func[5] == 1'b0)begin
          branch=1'b0;
          MemtoReg=1'b0;
          MemW=1'b0;
          ALUSrc=1'b0;
          ImmSrc=2'bxx;
          RegW=1'b1;
          RegSrc=2'b00;
          ALUop=1'b1;
          
        end
        else if(op == 2'b00&&func[5] == 1'b1)begin
          branch=1'b0;
          MemtoReg=1'b0;
          MemW=1'b0;
          ALUSrc=1'b1;
          ImmSrc=2'b00;
          RegW=1'b1;
          RegSrc=2'bx0;
          ALUop=1'b1;
          
        end
        else if(op == 2'b01&&func[0] == 1'b0)begin
          branch=1'b0;
          MemtoReg=1'bx;
          MemW=1'b1;
          ALUSrc=1'b1;
          ImmSrc=2'b01;
          RegW=1'b0;
          RegSrc=2'b10;
          ALUop=1'b0;
          
        end
        else if(op == 2'b01&&func[5] == 1'b1)begin
          branch=1'b0;
          MemtoReg=1'b1;
          MemW=1'b0;
          ALUSrc=1'b1;
          ImmSrc=2'b01;
          RegW=1'b1;
          RegSrc=2'bx0;
          ALUop=1'b0;
          
        end
      
      else if(op == 2'b10)begin
        branch=1'b1;
        MemtoReg=1'b0;
        MemW=1'b0;
        ALUSrc=1'b1;
        ImmSrc=2'b10;
        RegW=1'b0;
        RegSrc=2'bx1;
        ALUop=1'b0;
      end
		else begin
        branch=1'b1;
        MemtoReg=1'b1;
        MemW=1'b1;
        ALUSrc=1'b1;
        ImmSrc=2'b11;
        RegW=1'b1;
        RegSrc=2'b11;
        ALUop=1'b1;
      end

  end
endmodule