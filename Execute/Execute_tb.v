module Execute_tb();

    reg clk, rst;
    reg RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    reg [2:0] ALUControlE;
    reg [31:0] RD1E, RD2E, ImmExtE, PCE, PCPlus4E;
    reg [4:0] RS1E, RS2E, RDE;
    
    wire RegWriteM, ResultSrcM, MemWriteM, PCSrcE;
    wire [31:0] ALUResultM, WriteDataM, PCPlus4M, PCTargetE;
    wire [4:0] RDM;

    Execute dut(clk, rst, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, ALUControlE, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, RS1E, RS2E, RDE, RegWriteM, ResultSrcM, MemWriteM, PCSrcE, ALUResultM, WriteDataM, PCPlus4M, PCTargetE, RDM);

    initial
    begin
        clk = 1'b0;
        forever
        begin
            #5;
            clk = ~clk;
        end
    end

    initial begin
        // Forward Control Signals
        rst = 1'b0;
        #20;
        //initialization
        rst = 1'b1;
        RegWriteE = 1'b0;
        MemWriteE = 1'b0;
        ResultSrcE = 1'b0;
        ALUControlE = 3'b000;
        RD1E = 32'h00000000;
        RD2E = 32'h00000000;
        ImmExtE = 32'h00000000;
        PCE = 32'h00000000;
        PCPlus4E = 32'h00000000;
        ALUSrcE = 1'b0;
        BranchE = 1'b0;
        RS1E = 5'h00;
        RS2E = 5'h00;
        RDE = 5'h00;
        #10;
        RegWriteE = 1'b1;
        MemWriteE = 1'b1;
        ResultSrcE = 1'b1;
        #10;
        //PCSrcE Test
        BranchE = 1'b0;
        ALUControlE = 3'b001;
        RD1E = 32'h0000000a;
        RD2E = 32'h0000000a;
        #10;
        BranchE = 1'b1;
        ALUControlE = 3'b001;
        RD1E = 32'h0000000a;
        RD2E = 32'h0000000a;
        #10;
        BranchE = 1'b0;
        ALUControlE = 3'b001;
        RD1E = 32'h0000000a;
        RD2E = 32'h0000000b;
        #10;
        BranchE = 1'b1;
        ALUControlE = 3'b001;
        RD1E = 32'h0000000a;
        RD2E = 32'h0000000b;
        #10;
        // PCTargetE Test
        PCE = 32'h00000101;
        ImmExtE = 32'h00001010;
        #10;
        PCE = 32'hFFFFFFFF;
        ImmExtE = 32'h0000000F;
        #10;
        // WriteDataM, RDM & PCPlus4 Test
        RD2E = 32'h0000000a;
        RDE = 5'h0a;
        PCPlus4E = 32'h0000000a;
        #10;
        RD2E = 32'hfffffffa;
        RDE = 5'h1f;
        PCPlus4E = 32'hfffffffa;
        #10;
        // ALUSrcE Test
        ALUSrcE = 1'b0;
        RD1E = 32'h00000001;
        RD2E = 32'haaaaaaa9;
        ALUControlE = 3'b000;
        ImmExtE = 32'hbbbbbbba;
        #10;
        ALUSrcE = 1'b1;
        #10;
        // ALUResultM Test
        ALUControlE = 3'b000;
        ALUSrcE = 1'b0;
        RD1E = 32'h00000001;
        RD2E = 32'h00000002;
        #10;
        ALUControlE = 3'b001;
        #10;
        ALUControlE = 3'b010;
        #10;
        ALUControlE = 3'b011;
        #10;
        ALUControlE = 3'b100;
        #10;
        ALUControlE = 3'b101;
        #10;
        ALUControlE = 3'b110;
        #10;
        ALUControlE = 3'b111;
        #20;

        $finish;

    end

    initial
        begin
            $dumpfile("Execute.vcd");
            $dumpvars(0);
        end
    
endmodule
