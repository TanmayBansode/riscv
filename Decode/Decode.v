// Imports done with respect to Pipelined.v
`include "./Decode/ControlUnit/ControlUnit.v"
`include "./Decode/RegisterFile/RegisterFile.v"
`include "./Decode/SignExtend/SignExtend.v"

module Decode(clk,  rst, InstrD, PCD, PCPlus4D, RegWriteW, RDW, ResultW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, JumpE, ALUControlE, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, RS1E, RS2E, RDE);

    input clk, rst, RegWriteW;
    input [31:0] InstrD, PCD, PCPlus4D, ResultW;
    input [4:0] RDW;

    output RegWriteE, ALUSrcE, MemWriteE, BranchE, JumpE;
    output [1:0] ResultSrcE;
    output [2:0] ALUControlE;
    output [31:0] RD1E, RD2E, ImmExtE, PCE, PCPlus4E;
    output [4:0] RS1E, RS2E, RDE;

    wire RegWriteD, ALUSrcD, MemWriteD, BranchD , JumpD;
    wire [1:0] ResultSrcD;
    wire [2:0] ALUControlD;
    wire [1:0] ImmSrcD;
    wire [31:0] RD1D, RD2D, ImmExtD;

    reg RegWriteDReg, ALUSrcDReg, MemWriteDReg, BranchDReg, JumpDReg;
    reg [1:0] ResultSrcDReg;
    reg [2:0] ALUControlDReg;
    reg [31:0] RD1DReg, RD2DReg, ImmExtDReg, PCDReg, PCPlus4DReg;
    reg [4:0] RS1DReg, RS2DReg, RDDReg;

    ControlUnit ControlUnit(
                            .Op(InstrD[6:0]),
                            .RegWrite(RegWriteD),
                            .ImmSrc(ImmSrcD),
                            .ALUSrc(ALUSrcD),
                            .MemWrite(MemWriteD),
                            .ResultSrc(ResultSrcD),
                            .Branch(BranchD),
                            .Jump(JumpD),
                            .funct3(InstrD[14:12]),
                            .funct7(InstrD[31:25]),
                            .ALUControl(ALUControlD)
    );

    RegisterFile RegisterFile(.clk(clk), 
                              .rst(rst),
                              .addr1(InstrD[19:15]), 
                              .addr2(InstrD[24:20]), 
                              .writeAddr(RDW), 
                              .writeData(ResultW), 
                              .writeEnable(RegWriteW), 
                              .readData1(RD1D), 
                              .readData2(RD2D));

    SignExtend SignExtend(.Imm(InstrD[31:0]), 
                          .ImmSrc(ImmSrcD), 
                          .ImmExt(ImmExtD));

    always @(posedge clk or negedge rst)
    begin 
        if(!rst) begin
            RegWriteDReg <= 1'b0;
            ALUSrcDReg <= 1'b0;
            MemWriteDReg <= 1'b0;
            ResultSrcDReg <= 2'b00;
            BranchDReg <= 1'b0;
            JumpDReg <= 1'b0;
            ALUControlDReg <= 3'b000;
            RD1DReg <= 32'h00000000;
            RD2DReg <= 32'h00000000;
            ImmExtDReg <= 32'h00000000;
            PCDReg <= 32'h00000000;
            PCPlus4DReg <= 32'h00000000;
            RS1DReg <= 5'h00;
            RS2DReg <= 5'h00;
            RDDReg <= 5'h00;
        end
        else begin
            RegWriteDReg <= RegWriteD;
            ALUSrcDReg <= ALUSrcD;
            MemWriteDReg <= MemWriteD;
            ResultSrcDReg <= ResultSrcD;
            BranchDReg <= BranchD;
            JumpDReg <= JumpD;
            ALUControlDReg <= ALUControlD;
            RD1DReg <= RD1D;
            RD2DReg <= RD2D;
            ImmExtDReg <= ImmExtD;
            PCDReg <= PCD;
            PCPlus4DReg <= PCPlus4D;
            RS1DReg <= InstrD[19:15];
            RS2DReg <= InstrD[24:20];
            RDDReg <= InstrD[11:7];
        end
    end

    assign RegWriteE = RegWriteDReg;
    assign ALUSrcE = ALUSrcDReg;
    assign MemWriteE = MemWriteDReg;
    assign ResultSrcE = ResultSrcDReg;
    assign BranchE = BranchDReg;
    assign JumpE = JumpDReg;
    assign ALUControlE = ALUControlDReg;
    assign RD1E = RD1DReg;
    assign RD2E = RD2DReg;
    assign ImmExtE = ImmExtDReg;
    assign PCE = PCDReg;
    assign PCPlus4E = PCPlus4DReg;
    assign RS1E = RS1DReg;
    assign RS2E = RS2DReg;
    assign RDE = RDDReg;

endmodule

    