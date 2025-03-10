// Imports done with respect to Pipelined.v
// `include "./General/Adder/Adder.v"
`include "./Execute/ALU/ALU.v"
// `include "./General/Mux_2to1/Mux_2to1.v"

module Execute(clk, rst, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, ALUControlE, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, RS1E, RS2E, RDE, RegWriteM, ResultSrcM, MemWriteM, PCSrcE, ALUResultM, WriteDataM, PCPlus4M, PCTargetE, RDM);

    input clk, rst;
    input RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    input [2:0] ALUControlE;
    input [31:0] RD1E, RD2E, ImmExtE, PCE, PCPlus4E;
    input [4:0] RS1E, RS2E, RDE;
    
    output RegWriteM, ResultSrcM, MemWriteM, PCSrcE;
    output [31:0] ALUResultM, WriteDataM, PCPlus4M, PCTargetE;
    output [4:0] RDM;

    wire [31:0] SrcBE, ALUResultE;
    wire ZeroE, OverflowE, NegativeE, CarryE;

    reg RegWriteEReg, ResultSrcEReg, MemWriteEReg;
    reg [31:0]  ALUResultEReg, WriteDataEReg, PCPlus4EReg; 
    reg [4:0] RDEReg;


    ALU alu(.a(RD1E), 
            .b(SrcBE), 
            .ALUControl(ALUControlE), 
            .result(ALUResultE), 
            .Zero(ZeroE), 
            .Overflow(OverflowE), 
            .Negative(NegativeE), 
            .Carry(CarryE));

    Mux_2to1 mux(.y(SrcBE),
                 .a(RD2E),
                 .b(ImmExtE),
                 .sel(ALUSrcE));

    Adder branchadder(.c(PCTargetE),
                        .a(PCE),
                        .b(ImmExtE));

    always @(posedge clk or negedge rst)
    begin
        if(!rst) begin
            RegWriteEReg <= 1'b0;
            ResultSrcEReg <= 1'b0;
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
            WriteDataEReg <= RD2E;
            RDEReg <= RDE;
            PCPlus4EReg <= PCPlus4E;
        end
    end    

    assign PCSrcE = BranchE & ZeroE;
    assign RegWriteM = RegWriteEReg;
    assign ResultSrcM = ResultSrcEReg;
    assign MemWriteM = MemWriteEReg;
    assign ALUResultM = ALUResultEReg;
    assign WriteDataM = WriteDataEReg;
    assign RDM = RDEReg;
    assign PCPlus4M = PCPlus4EReg;

endmodule