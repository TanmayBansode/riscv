module SignExtend(
    input [31:0] Imm,
    input [1:0] ImmSrc,
    output [31:0] ImmExt
);

    assign ImmExt = (ImmSrc == 2'b00) ? {Imm[11],Imm[11:0]} :
                    (ImmSrc == 2'b01) ? {{Imm[11],Imm[11],Imm[11],Imm[11],Imm[11]},Imm} :
                                        {Imm[31],Imm};

endmodule