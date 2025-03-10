module Mux_2to1_tb();
    reg [31:0] a, b;
    reg sel;
    wire [31:0] y;

    Mux_2to1 uut(
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        a = 32'h00000000;
        b = 32'h00000001;

        sel = 1'b0;
        #10;
        sel = 1'b1;
        #10;
    end

    initial begin
        $dumpfile("Mux_2to1.vcd");
        $dumpvars(0);
    end

endmodule