module ControlUnit_tb();

    reg [6:0] Op, funct7;
    reg [2:0] funct3;
    wire RegWrite, ALUSrc,MemWrite,ResultSrc,Branch, Jump;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl;

    ControlUnit dut(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch, Jump,funct3,funct7,ALUControl);

    initial
    begin
        Op = 7'b0000011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        Op = 7'b0110011;
        #10
        Op = 7'b0010011;
        #10;
        Op = 7'b0100011;
        #10;
        Op = 7'b1100011;
        #10;
        Op = 7'b0000011;
        #10;
        Op = 7'b0100011;
        #10;
        Op = 7'b0010011;
        #10;
        Op = 7'b0100011;
        #10;
        Op = 7'b0000011;
        #10;
        Op = 7'b1100011;
        #10;
        Op = 7'b0110011;
        #10;
        Op = 7'b1100011;
        #50;
        Op = 7'b0000000;
        #10;
        Op = 7'b1100011;
        #10;
        Op = 7'b0110011;
        funct3 = 3'b000;
        {Op[5],funct7[5]} = 2'b11;
        #10;
        Op = 7'b0110011;
        funct3 = 3'b000;
        {Op[5],funct7[5]} = 2'b01;
        #10;
        Op = 7'b0110011;
        funct3 = 3'b010;
        #10;
        Op = 7'b0110011;
        funct3 = 3'b110;
        #10;
        Op = 7'b0110011;
        funct3 = 3'b111;   
        #10;
        Op = 7'b0110011;
        #50;
        $finish;

    end

    initial
    begin
        $dumpfile("ControlUnit.vcd");
        $dumpvars(0);
    end

endmodule