module Counter_tb();
    reg clk, rst;
    reg [31:0] count_next;
    wire [31:0] count;

    Counter uut(
        .clk(clk),
        .rst(rst),
        .count_next(count_next),
        .count(count)
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

    always begin
        rst = 1'b1;
        count_next = 32'h00000000;
        #10;
        count_next = 32'h00023001;
        #10;
        count_next = 32'h00646000;
        #10;
        rst = 1'b0;
        #10;
        $finish;
    end

        initial
    begin
        $dumpfile("Counter.vcd");
        $dumpvars(0);
    end

endmodule