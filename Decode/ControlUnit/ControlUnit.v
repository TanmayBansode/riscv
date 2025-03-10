// Imports done with respect to Pipelined.v
`include "./Decode/MainDecoder/MainDecoder.v"
`include "./Decode/ALUDecoder/ALUDecoder.v"

module ControlUnit(Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, Jump, funct3, funct7, ALUControl);

    input [6:0] Op, funct7;
    input [2:0] funct3;
    output RegWrite, ALUSrc, MemWrite, Jump, Branch;
    output [1:0] ResultSrc;
    output [1:0] ImmSrc;
    output [2:0] ALUControl;

    wire [1:0] ALUOp;

    MainDecoder MainDecoder(
                .Op(Op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .Jump(Jump),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    ALUDecoder ALUDecoder(
                            .ALUOp(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(Op),
                            .ALUControl(ALUControl)
    );


endmodule