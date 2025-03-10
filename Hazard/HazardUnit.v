module HazardUnit(rst, RS1E, RS2E, ForwardAE, ForwardBE,RegWriteW, RegWriteM, RDW, RDM);
    input [4:0] RS1E, RS2E;
    input rst, RegWriteW, RegWriteM;
    input [4:0] RDW, RDM;
    output [1:0] ForwardAE, ForwardBE;

    assign ForwardAE = (rst == 1'b0) ? 2'b00 :
                       (RegWriteW && (RDW != 5'b00000) && (RDW == RS1E)) ? 2'b10 :
                       (RegWriteM && (RDM != 5'b00000) && (RDM == RS1E)) ? 2'b01 :
                       2'b00;

    assign ForwardBE = (rst == 1'b0) ? 2'b00 :
                       (RegWriteW && (RDW != 5'b00000) && (RDW == RS2E)) ? 2'b10 :
                       (RegWriteM && (RDM != 5'b00000) && (RDM == RS2E)) ? 2'b01 :
                       2'b00;

endmodule

