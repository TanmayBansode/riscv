module MainDecoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch, Jump, ALUOp);
    input [6:0] Op;
    output RegWrite, ALUSrc, MemWrite, Branch, Jump;
    output [1:0] ResultSrc;
    output [1:0] ImmSrc, ALUOp;
    
    //RegWrite when Load, R-Type, I-Type 
    assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011 | Op == 7'b0010011 ) ? 1'b1 : 1'b0 ;
    //ImmSrc when I-type, Load-Type as 01, Branch-Type as 10, Store-Type as 11 and else 00
    assign ImmSrc = (Op == 7'b0100011) ? 2'b11 : (Op == 7'b1100011) ? 2'b10 : (Op == 7'b0010011 | Op == 7'b0000011) ? 2'b01 : 2'b00 ;
    //ALUSrc when Load-Type, Store-Type, I-Type (1 -> a + imm | 0 -> a + b )
    assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011 | Op == 7'b0010011) ? 1'b1 : 1'b0 ;
    //MemWrite when Store-Type (1 -> You can write to memory)
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0 ;
    //ResultSrc when Load-Type (1 -> final result is from memory | 0 -> final result is from ALU) 
    assign ResultSrc = (Op == 7'b0000011) ? 2'b01 : 2'b00 ;
    //Branch when Branch-Type
    assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0 ;
    //Jump when Jump-Type (JAL and JALR)
    assign Jump = (Op == 7'b1101111 | Op == 7'b1100111) ? 1'b1 : 1'b0 ;
    //ALUOp (I-type -> 11, R-Type -> 10 if Branch-Type -> 01 else (incl. Store-Type, Load-Type) -> 00 
    assign ALUOp = (Op == 7'b0010011) ? 2'b11 : (Op == 7'b0110011) ? 2'b10 : (Op == 7'b1100011) ? 2'b01 : 2'b00 ;

endmodule