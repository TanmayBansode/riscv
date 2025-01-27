module RegisterFile(clk, rst, addr1, addr2, writeAddr, writeData, writeEnable, readData1, readData2);
    input clk, rst;
    input [4:0] addr1, addr2, writeAddr;
    input [31:0] writeData;
    input writeEnable;
    output [31:0] readData1, readData2;

    reg [31:0] registers [31:0];
    integer i;

    always @(posedge clk )
    begin
        if(writeEnable & writeAddr != 5'h00)
        begin
            registers[writeAddr] <= writeData;
        end
    end

    assign readData1 = (!rst) ? 32'd0 : registers[addr1];
    assign readData2 = (!rst) ? 32'd0 : registers[addr2];

    initial
    begin
        for (i = 0; i < 32; i = i + 1)
        begin
            registers[i] = i;
        end
    end

endmodule