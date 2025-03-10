module MainDecoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp);
    input [6:0] Op;
    output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    output [1:0] ImmSrc, ALUOp;
    
    //RegWrite when Load, R-Type, I-Type 
    assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011 | Op == 7'b0010011 ) ? 1'b1 : 1'b0 ;
    //ImmSrc when I-type as 1 and when Store-Type, Branch-Type as 2 
    assign ImmSrc = (Op == 7'b0000011) ? 2'b01 : (Op == 7'b1100011 || Op == 7'b0100011) ? 2'b10 :  2'b00 ;
    //ALUSrc when Load-Type, Store-Type, I-Type
    assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011 | Op == 7'b0010011) ? 1'b1 : 1'b0 ;
    //MemWrite when Store-Type
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0 ;
    //ResultSrc when Load-Type
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0 ;
    //Branch when Branch-Type
    assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0 ;
    //ALUOp R-Type -> 2 if I-Type -> 1 else 0 
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 : (Op == 7'b1100011) ? 2'b01 : 2'b00 ;

endmodule