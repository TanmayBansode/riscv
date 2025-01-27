module InstructionMemory_tb();
    reg clk, rst;
    reg [31:0] addr;
    wire [31:0] instr;

    InstructionMemory uut(
        .rst(rst),
        .clk(clk),
        .addr(addr),
        .instr(instr)
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
        rst = 1'b1;
        addr = 32'h00000000;
        #10;
        addr = 32'h00000004;
        #10;
        addr = 32'h00000008;
        #10;
        addr = 32'h0000000C;
        #10;

        rst = 1'b0;
        #10;
        $finish;
    end

    initial
    begin
        $dumpfile("InstructionMemory.vcd");
        $dumpvars(0);
    end

endmodule