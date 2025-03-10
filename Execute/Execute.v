// Imports done with respect to Pipelined.v
// `include "./General/Adder/Adder.v"
`include "./Execute/ALU/ALU.v"
`include "./General/Mux_3to1/Mux_3to1.v"
// `include "./General/Mux_2to1/Mux_2to1.v"

module Execute(clk, rst, RegWriteE, ALUSrcE, MemWriteE, ForwardAE, ForwardBE, ResultSrcE, BranchE, JumpE, ALUControlE, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, ResultW, RS1E, RS2E, RDE, RegWriteM, ResultSrcM, MemWriteM, PCSrcE, ALUResultM, WriteDataM, PCPlus4M, PCTargetE, RDM);

    input clk, rst;
    input RegWriteE, ALUSrcE, MemWriteE, BranchE, JumpE;
    input [1:0]  ForwardAE, ForwardBE;
    input [1:0] ResultSrcE;
    input [3:0] ALUControlE;
    input [31:0] RD1E, RD2E, ImmExtE, PCE, PCPlus4E, ResultW;
    input [4:0] RS1E, RS2E, RDE;
    
    output RegWriteM, MemWriteM, PCSrcE;
    output [1:0] ResultSrcM;
    output [31:0] ALUResultM, WriteDataM, PCPlus4M, PCTargetE, MuxBE;
    output [4:0] RDM;

    wire [31:0] SrcAE, SrcBE, ALUResultE;
    wire ZeroE, OverflowE, NegativeE, CarryE;

    reg RegWriteEReg, MemWriteEReg;
    reg [1:0] ResultSrcEReg;
    reg [31:0]  ALUResultEReg, WriteDataEReg, PCPlus4EReg; 
    reg [4:0] RDEReg;


    ALU alu(.a(SrcAE), 
            .b(SrcBE), 
            .ALUControl(ALUControlE), 
            .result(ALUResultE), 
            .Zero(ZeroE), 
            .Overflow(OverflowE), 
            .Negative(NegativeE), 
            .Carry(CarryE));

    Mux_3to1 MuxA(.a(RD1E),
                   .b(ResultW),
                   .c(ALUResultM),
                   .y(SrcAE),
                   .sel(ForwardAE));

    Mux_3to1 MuxB(.a(RD2E),
                  .b(ResultW),
                  .c(ALUResultM),
                  .y(MuxBE),
                  .sel(ForwardBE));

    Mux_2to1 mux(.y(SrcBE),
                 .a(MuxBE),
                 .b(ImmExtE),
                 .sel(ALUSrcE));

    Adder branchadder(.c(PCTargetE),
                        .a(PCE),
                        .b(ImmExtE));

    always @(posedge clk or negedge rst)
    begin
        if(!rst) begin
            RegWriteEReg <= 1'b0;
            ResultSrcEReg <= 2'b00;
            MemWriteEReg <= 1'b0;
            ALUResultEReg <= 32'h00000000;
            WriteDataEReg <= 32'h00000000;
            RDEReg <= 32'b00000;
            PCPlus4EReg <= 32'h00000000;
        end
        else begin
            RegWriteEReg <= RegWriteE;
            ResultSrcEReg <= ResultSrcE;
            MemWriteEReg <= MemWriteE;
            ALUResultEReg <= ALUResultE;
            WriteDataEReg <= MuxBE;
            RDEReg <= RDE;
            PCPlus4EReg <= PCPlus4E;
        end
    end    

    assign PCSrcE = JumpE | (BranchE & ZeroE);
    assign RegWriteM = RegWriteEReg;
    assign ResultSrcM = ResultSrcEReg;
    assign MemWriteM = MemWriteEReg;
    assign ALUResultM = ALUResultEReg;
    assign WriteDataM = WriteDataEReg;
    assign RDM = RDEReg;
    assign PCPlus4M = PCPlus4EReg;

endmodule