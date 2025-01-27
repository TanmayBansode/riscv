module SignExtend_tb();

    reg [31:0] Imm;
    reg [1:0] ImmSrc;
    wire [31:0] ImmExt;

    SignExtend dut(Imm, ImmSrc, ImmExt);

    initial begin
        $display("Time\tImm\t\t\tImmSrc\tImmExt");
        $monitor("%0dns\t%h\t%b\t%h", $time, Imm, ImmSrc, ImmExt);

        Imm = 32'h32230322; 
        ImmSrc = 2'b00;
        #10;

        Imm = 32'hF752F800;  
        ImmSrc = 2'b00;
        #10;

        Imm = 32'h32230322; 
        ImmSrc = 2'b01;
        #10;

        Imm = 32'hF752F800;
        ImmSrc = 2'b01;
        #10;

        Imm = 32'h80000000; 
        ImmSrc = 2'b10;
        #10;

        Imm = 32'h0000000F;
        ImmSrc = 2'b10;
        #10;

        $finish;
    end

    initial
    begin
        $dumpfile("SignExtend.vcd");
        $dumpvars(0);
    end

endmodule

