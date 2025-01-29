module DataMemory_tb();
     
    reg clk, rst, writeEnable;
    reg [31:0] address, writeData;
    wire [31:0] readData;

    DataMemory dataMemory(.clk(clk), 
                          .rst(rst), 
                          .writeEnable(writeEnable), 
                          .address(address), 
                          .writeData(writeData), 
                          .readData(readData));
                    
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
        #10;
        rst = 1'b1;
        writeEnable = 1'b1;
        address = 32'h00000002;
        writeData = 32'h0000ffff;
        #20;
        writeEnable = 1'b0;
        address = 32'h00000002;
        #10;
        $finish;
    end

    initial
    begin
        $dumpfile("DataMemory.vcd");
        $dumpvars(0);
    end

endmodule


