module SignExtend(Imm, ImmSrc, ImmExt);
    input [31:0] Imm;
    input [1:0] ImmSrc;
    output [31:0] ImmExt;

    //when ImmSrc is 00 -> 20 bit immediate | Jump-type & UI-type
    //when ImmSrc is 01 -> 12 bit immediate | I-type & Load-type
    //when ImmSrc is 10 -> 1 + 6 + 4 + 1 bit immediate | Branch-type
    //when ImmSrc is 11 -> 7 + 5 bit immediate | Store-type

    assign ImmExt = (ImmSrc == 2'b11) ? {{20{Imm[31]}},Imm[31:25],Imm[11:7]} :
                    (ImmSrc == 2'b10) ? {{20{Imm[31]}}, Imm[31],Imm[7],Imm[30:25],Imm[11:8],1'b0} :
                    (ImmSrc == 2'b01) ? {{20{Imm[31]}},Imm[31:20]} 
                                      : {{20{Imm[31]}},Imm[31:12]};

endmodule
