module Pipelined_tb();
    reg clk, rst;

    Pipelined uut(
        .clk(clk),
        .rst(rst)
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
        #300;
        $finish;
    end

    initial
    begin
        $dumpfile("Pipelined.vcd");
        $dumpvars(0);
    end

endmodule
