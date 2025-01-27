module InstructionMemory(rst, clk, addr, instr);
    input rst, clk;
    input [31:0] addr;
    output [31:0] instr;

    reg [31:0] mem[1023:0];

    assign instr = (!rst) ? 32'h00000000 : mem[addr[31:2]];

    initial
    begin
        $readmemh("instructions.hex", mem);
    end

endmodule
