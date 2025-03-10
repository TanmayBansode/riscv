// Imports done with respect to Pipelined.v
`include "./Memory/DataMemory/DataMemory.v"

module Memory(clk, rst, RegWriteM, MemWriteM, ResultSrcM, RDM, PCPlus4M, WriteDataM, ALUResultM, RegWriteW, ResultSrcW, RDW, PCPlus4W, ALUResultW, ReadDataW);

    input clk, rst, RegWriteM, MemWriteM, ResultSrcM;
    input [4:0] RDM;
    input [31:0] PCPlus4M, WriteDataM, ALUResultM;

    output RegWriteW, ResultSrcW;
    output [4:0] RDW;
    output [31:0] PCPlus4W, ALUResultW, ReadDataW;

    wire [31:0] ReadDataM;

    reg RegWriteMReg, ResultSrcMReg;
    reg [4:0] RDMReg;
    reg [31:0] PCPlus4MReg, ALUResultMReg, ReadDataMReg;

    DataMemory dataMemory(.clk(clk), 
                          .rst(rst), 
                          .writeEnable(MemWriteM), 
                          .address(ALUResultM), 
                          .writeData(WriteDataM), 
                          .readData(ReadDataM));

    always @(posedge clk or negedge rst)
    begin 
        if(!rst) begin
            RegWriteMReg <= 1'b0;
            ResultSrcMReg <= 1'b0;
            RDMReg <= 5'b00000;
            PCPlus4MReg <= 32'h00000000;
            ALUResultMReg <= 32'h00000000;
            ReadDataMReg <= 32'h00000000;
        end
        else begin
            RegWriteMReg <= RegWriteM;
            ResultSrcMReg <= ResultSrcM;
            RDMReg <= RDM;
            PCPlus4MReg <= PCPlus4M;
            ALUResultMReg <= ALUResultM;
            ReadDataMReg <= ReadDataM;
        end
    end

    assign RegWriteW = RegWriteMReg;
    assign ResultSrcW = ResultSrcMReg;
    assign RDW = RDMReg;
    assign PCPlus4W = PCPlus4MReg;
    assign ALUResultW = ALUResultMReg;
    assign ReadDataW = ReadDataMReg;

endmodule