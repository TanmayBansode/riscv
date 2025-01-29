module DataMemory(clk, rst, writeEnable, address, writeData, readData);
     input clk, rst, writeEnable;
     input [31:0] address, writeData;
     output [31:0] readData;
     
     reg [31:0] memory[1023:0];
     
     always @(posedge clk)
     begin
             if(writeEnable) memory[address] <= writeData;
     end

    assign readData = (~rst) ? 32'h00000000 : memory[address];
    
    initial
    begin
        $readmemh("data.hex", memory);
    end

endmodule