`include "./InstructionFetch/InstructionFetchUnit.v"
`include "./Decode/Decode.v"
`include "./Execute/Execute.v"
`include "./Memory/Memory.v"
`include "./WriteBack/WriteBack.v"

module Pipelined(clk, rst);
    input clk, rst;

    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, RegWriteM, MemWriteM, ResultSrcM, ResultSrcW;
    wire [2:0] ALUControlE;
    wire [4:0] RDE, RDM, RDW;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALUResultM;
    wire [31:0] PCPlus4W, ALUResultW, ReadDataW;
    wire [4:0] RS1E, RS2E;
    wire [1:0] ForwardBE, ForwardAE;



    InstructionFetchUnit IFU(.clk(clk), .rst(rst), .PCSrcE(PCSrcE), .PCTargetE(PCTargetE), .InstrD(InstrD), .PCD(PCD), .PCPlus4D(PCPlus4D));
    Decode DU(.clk(clk),  .rst(rst), .InstrD(InstrD), .PCD(PCD), .PCPlus4D(PCPlus4D), .RegWriteW(RegWriteW), .RDW(RDW), .ResultW(ResultW), .RegWriteE(RegWriteE), .ALUSrcE(ALUSrcE), .MemWriteE(MemWriteE), .ResultSrcE(ResultSrcE), .BranchE(BranchE), .ALUControlE(ALUControlE), .RD1E(RD1E), .RD2E(RD2E), .ImmExtE(ImmExtE), .PCE(PCE), .PCPlus4E(PCPlus4E), .RS1E(RS1E), .RS2E(RS2E), .RDE(RDE));
    Execute EU(.clk(clk), .rst(rst), .RegWriteE(RegWriteE), .ALUSrcE(ALUSrcE), .MemWriteE(MemWriteE), .ResultSrcE(ResultSrcE), .BranchE(BranchE), .ALUControlE(ALUControlE), .RD1E(RD1E), .RD2E(RD2E), .ImmExtE(ImmExtE), .PCE(PCE), .PCPlus4E(PCPlus4E), .RS1E(RS1E), .RS2E(RS2E), .RDE(RDE), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .MemWriteM(MemWriteM), .PCSrcE(PCSrcE), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM), .PCPlus4M(PCPlus4M), .PCTargetE(PCTargetE), .RDM(RDM));
    Memory MU(.clk(clk), .rst(rst), .RegWriteM(RegWriteM), .MemWriteM(MemWriteM), .ResultSrcM(ResultSrcM), .RDM(RDM), .PCPlus4M(PCPlus4M), .WriteDataM(WriteDataM), .ALUResultM(ALUResultM), .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW), .RDW(RDW), .PCPlus4W(PCPlus4W), .ALUResultW(ALUResultW), .ReadDataW(ReadDataW));
    WriteBack WBU(.clk(clk), .rst(rst), .ResultSrcW(ResultSrcW), .PCPlus4W(PCPlus4W), .ALUResultW(ALUResultW), .ReadDataW(ReadDataW), .ResultW(ResultW));
    

endmodule
