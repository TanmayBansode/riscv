`include "Counter.v"
`include "InstructionMemory.v"
`include "Mux_2to1.v"
`include "Adder.v"

module InstructionFetchUnit(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);

    input clk, rst;
    input PCSrcE;
    input [31:0] PCTargetE;
    output [31:0] InstrD;
    output [31:0] PCD, PCPlus4D;

    wire [31:0] PCFin, PCFout, PCPlus4;
    wire [31:0] InstrF;

    // Pipeline registers
    reg [31:0] InstrFReg, PCFReg, PCPlus4FReg;

    Mux_2to1 MuxPC(
        .a(PCPlus4),
        .b(PCTargetE),
        .sel(PCSrcE),
        .y(PCFin)
    );

    Counter PC(
        .clk(clk),
        .rst(rst),
        .count_next(PCFin),
        .count(PCFout)
    );

    InstructionMemory IM(
        .rst(rst),
        .clk(clk),
        .addr(PCFout),
        .instr(InstrF)
    );

    Adder PCAdder(
        .a(PCFout),
        .b(32'h00000004),
        .sum(PCPlus4)
    );

    always@(posedge clk or negedge rst)
    begin
        if(!rst) begin
            InstrFReg <= 32'h00000000;
            PCFReg <= 32'h00000000;
            PCPlus4FReg <= 32'h00000000;
        end
        else begin
            InstrFReg <= InstrF;
            PCFReg <= PCFout;
            PCPlus4FReg <= PCPlus4;
        end
    end

    assign InstrD = (!rst) ? 32'h00000000 : InstrFReg;
    assign PCD = (!rst) ? 32'h00000000 : PCFReg;
    assign PCPlus4D = (!rst) ? 32'h00000000 : PCPlus4FReg;

endmodule