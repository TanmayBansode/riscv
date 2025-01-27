module RegisterFile_tb();
    reg clk, rst;
    reg [4:0] addr1, addr2, writeAddr;
    reg [31:0] writeData;
    reg writeEnable;
    wire [31:0] readData1, readData2;

    RegisterFile dut(clk, rst, addr1, addr2, writeAddr, writeData, writeEnable, readData1, readData2);

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
        addr1 = 5'b00100;
        addr2 = 5'b01100;
        writeAddr = 5'b00001;
        writeData = 32'h02312313;
        writeEnable = 1'b0;
        #10;
        writeEnable = 1'b1;
        #10;
        addr1 = 5'b00001;
        #20;

        $finish;
    end

    initial 
    begin
        $dumpfile("RegisterFile.vcd");
        $dumpvars(0);
    end

endmodule