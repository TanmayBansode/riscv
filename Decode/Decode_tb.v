module Decode_tb();

    reg clk, rst, RegWrite;
    reg [31:0] InstrD, PCD, PCPlus4D, ResultW;
    reg [4:0] RDW;

    wire RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    wire [2:0] ALUControlE;
    wire [31:0] RD1E, RD2E, ImmExtE, PCE, PCPlus4E;
    wire [4:0] RS1E, RS2E, RDE;

    Decode dut(clk, rst, InstrD, PCD, PCPlus4D, RegWrite, RDW, ResultW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, ALUControlE, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, RS1E, RS2E, RDE);

    initial
    begin
        clk = 1'b0;
        forever
        begin
            #5;
            clk = ~clk;
        end
    end

    initial
    begin 
        rst = 1'b0;
        #20;
        rst = 1'b1;

    end

    initial
    begin
        $dumpfile("Decode.vcd");
        $dumpvars(0);
    end

endmodule