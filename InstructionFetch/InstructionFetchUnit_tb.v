module InstructionFetchUnit_tb();

    reg clk, rst;
    reg PCSrcE;
    reg [31:0] PCTargetE;
    wire [31:0] InstrD;
    wire [31:0] PCD, PCPlus4D;

    InstructionFetchUnit uut(
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

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
        PCSrcE = 1'b0;
        PCTargetE = 32'h00000004;
        #10;
        PCSrcE = 1'b0;
        #10;
        PCSrcE = 1'b0;
        #10;
        PCSrcE = 1'b1;
        #10;
        PCSrcE = 1'b0;
        #40;
        rst = 1'b0;
        $finish;
    end

    initial
    begin
        $dumpfile("InstructionFetchUnit.vcd");
        $dumpvars(0);
    end

endmodule