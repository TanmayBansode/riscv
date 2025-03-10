module Mux_2to1 (y, a, b, sel);
    input [31:0] a, b;
    input sel;
    output [31:0] y;

    assign y = (sel == 1'b0) ? a : b;
endmodule