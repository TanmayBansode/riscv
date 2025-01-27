module Counter(clk, rst, count, count_next);
    input clk, rst;
    input [31:0] count_next;
    output reg [31:0] count;

    always@(posedge clk)
    begin
        if(!rst)
            count <= 32'h00000000;
        else
            count <= count_next;
    end

endmodule