// Imports done with respect to Pipelined.v
// `include "./General/Mux_2to1/Mux_2to1.v"

module WriteBack(clk, rst, ResultSrcW, PCPlus4W, ALUResultW, ReadDataW, ResultW);

    input clk, rst, ResultSrcW;
    input [31:0] PCPlus4W, ALUResultW, ReadDataW;

    output [31:0] ResultW;

    Mux_2to1 result_mux(.a(ALUResultW),
                        .b(ReadDataW),
                        .sel(ResultSrcW),
                        .y(ResultW));

endmodule

