module ALUDecoder (
    input  [1:0]  ALUOp,       
    input  [2:0]  funct3,      
    input  [6:0]  funct7,      
    input  [6:0]  op,          
    output reg [3:0] ALUControl 
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0000;  // Load/Store (Add)
        2'b01: ALUControl = 4'b1000;  // Branch operations (Subtract)
        2'b10: ALUControl =  {funct7[5], funct3 }; // R-type operations
        2'b11: ALUControl = {1'b0, funct3}; // I-type operations
        default: ALUControl = 4'b0000; // Default case
    endcase
end

endmodule
