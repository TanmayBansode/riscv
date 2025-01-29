module Memory_tb();

    reg clk, rst, RegWriteM, MemWriteM, ResultSrcM;
    reg [4:0] RDM;
    reg [31:0] PCPlus4M, WriteDataM, ALUResultM;

    wire RegWriteW, ResultSrcW;
    wire [4:0] RDW;
    wire [31:0] PCPlus4W, ALUResultW, ReadDataW;

    Memory Memory(clk, rst, RegWriteM, MemWriteM, ResultSrcM, RDM, PCPlus4M, WriteDataM, ALUResultM, RegWriteW, ResultSrcW, RDW, PCPlus4W, ALUResultW, ReadDataW);
                  
    initial
        begin 
            clk = 0;
            forever #5 clk = ~clk;
        end
    
    initial
        begin
            rst = 0;
            #20
            rst = 1;
            RegWriteM = 0;
            MemWriteM = 0;
            ResultSrcM = 0;
            RDM = 5'b00000;
            PCPlus4M = 32'h00000000;
            WriteDataM = 32'h00000000;
            ALUResultM = 32'h00000000;
            #10
            // Test for RegWriteW, ResultSrcW, ALUResultW, RDW, PCPlus4W
            RegWriteM = 1;
            ResultSrcM = 1;
            RDM = 5'b00001;
            PCPlus4M = 32'h00000004;
            ALUResultM = 32'h00000008;
            // Test for ReadDataW
            #10
            ALUResultM = 32'h00000003;
            WriteDataM = 32'h00001010;
            MemWriteM = 0;
            #10
            MemWriteM = 1;
            #20

            $finish;

        end

    initial
        begin
            $dumpfile("Memory.vcd");
            $dumpvars(0);
        end

endmodule