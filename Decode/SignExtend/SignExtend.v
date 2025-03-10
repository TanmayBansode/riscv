module SignExtend(Imm, ImmSrc, ImmExt);
    input [31:0] Imm;
    input [1:0] ImmSrc;
    output [31:0] ImmExt;

    //when ImmSrc is 00 -> 12 bit immediate | I-type & Load-type
    //when ImmSrc is 01 -> 7 + 5 bit immediate | Store-type &  Branch-type
    //else set to 0

    assign ImmExt =  (ImmSrc == 2'b01) ? {{20{Imm[31]}},Imm[31:20]} : 
                     (ImmSrc == 2'b10) ? {{20{Imm[31]}},Imm[31:25],Imm[11:7]} : 32'h00000000;

endmodule
