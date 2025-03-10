module WriteBack_tb();

    reg clk, rst, ResultSrcW;
    reg [31:0] PCPlus4W, ALUResultW, ReadDataW;

    wire [31:0] ResultW;

    WriteBack writeback(clk, rst, ResultSrcW, PCPlus4W, ALUResultW, ReadDataW, ResultW);

    initial begin
        clk = 1'b0;
        forever 
            #5 clk = ~clk;
    end

    initial
        begin
            rst = 1'b0;
            #10 
            rst = 1'b1;
            PCPlus4W = 32'h00000004;
            ALUResultW = 32'h00000008;
            ReadDataW = 32'h0000000C;
            ResultSrcW = 1'b0;
            #10
            ResultSrcW = 1'b1;
            #20

            $finish;
        end

    initial
        begin  
            $monitor("clk=%b, rst=%b, ResultSrcW=%b, PCPlus4W=%h, ALUResultW=%h, ReadDataW=%h, ResultW=%h", clk, rst, ResultSrcW, PCPlus4W, ALUResultW, ReadDataW, ResultW);
        end

    initial
        begin
            $dumpfile("WriteBack.vcd");
            $dumpvars(0);
        end

endmodule
