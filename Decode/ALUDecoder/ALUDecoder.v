module ALUDecoder(ALUOp, funct3, funct7, op, ALUControl);
// ALUOp : ALU Domain
// 00 -> Else
// 01 -> Branch Type
// 10 -> R-Type
// 11 -> I-Type


// ALUControl : ALU Operation 
// 000 -> Add
// 001 -> Subtract
// 010 -> Bitwise NOT
// 011 -> Shift left logical
// 100 -> Arithmetic shift right
// 101 -> Bitwise AND
// 110 -> Bitwise OR
// 111 -> Set Less Than


    input [1:0] ALUOp;
    input [2:0] funct3;
    input [6:0] funct7, op;
    output [2:0] ALUControl;

    assign ALUControl = // else case
                        (ALUOp == 2'b00) ? 3'b000 :
                        // Branch Type
                        (ALUOp == 2'b01) ? 3'b001 :
                        // R-type instructions
                        // Add
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} == 2'b01)) ? 3'b000 : 
                        // Sub
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} == 2'b11)) ? 3'b001 : 
                        // Set Less Than
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b111 : 
                        // Or
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b110 : 
                        // And
                        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b101 : 
                        // Else
                        3'b000 ;
endmodule