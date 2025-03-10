module Decode_tb();

    reg clk, rst, RegWriteW;
    reg [31:0] InstrD, PCD, PCPlus4D, ResultW;
    reg [4:0] RDW;

    wire RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, JumpE;
    wire [2:0] ALUControlE;
    wire [31:0] RD1E, RD2E, ImmExtE, PCE, PCPlus4E;
    wire [4:0] RS1E, RS2E, RDE;

    Decode Decode(clk,  rst, InstrD, PCD, PCPlus4D, RegWriteW, RDW, ResultW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, JumpE, ALUControlE, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, RS1E, RS2E, RDE);

    initial
    begin   
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial
    begin
        rst = 0;
        #10 rst = 1;
        RegWriteW = 1;
        InstrD = 32'hA4A4A4A4;
        PCD = 32'h00000008;
        PCPlus4D = 32'h0000000C;
        RDW = 5'h04;
        ResultW = 32'h00000001;
        #20
        $finish;
    end


    initial
    begin
    $dumpfile("Decode.vcd");
    $dumpvars(0);
    end

endmodule