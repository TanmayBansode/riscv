// ALUControl : ALU Operation 
// 000 -> Add
// 001 -> Subtract
// 010 -> Bitwise NOT
// 011 -> Shift left logical
// 100 -> Arithmetic shift right
// 101 -> Bitwise AND
// 110 -> Bitwise OR
// 111 -> Set Less Than


module ALU(
    input [31:0] a, b,
    input [2:0] ALUControl,
    output reg [31:0] result,
    output Zero, Overflow, Negative, Carry
);

    wire [31:0] add_result;
    wire [31:0] sub_result;
    wire add_carry_out;
    wire sub_carry_out;

    assign {add_carry_out, add_result} = a + b;            
    assign {sub_carry_out, sub_result} = a + (~b) + 1;  

    always @(*) begin
        case (ALUControl)
            3'b000: result = add_result;                      // Add
            3'b001: result = sub_result;                      // Subtract
            3'b010: result = ~a;                              // Bitwise NOT
            3'b011: result = a << b[4:0];                     // Shift left logical (limit shift to 5 bits)
            3'b100: result = $signed(a) >>> b[4:0];           // Arithmetic shift right (limit shift to 5 bits)
            3'b101: result = a & b;                           // Bitwise AND
            3'b110: result = a | b;                           // Bitwise OR
            3'b111: result = (a < b) ? 32'd1 : 32'd0;         // Set Less Than (SLT)
            default: result = 32'h00000000;                   // Default: Zero
        endcase
    end

    assign Zero = (result == 32'h00000000);               
    assign Negative = result[31];                   

    assign Overflow = ((ALUControl == 3'b000) && (a[31] == b[31]) && (result[31] != a[31])) ||  // Addition overflow
                      ((ALUControl == 3'b001) && (a[31] != b[31]) && (result[31] != a[31]));   // Subtraction overflow

    assign Carry = (ALUControl == 3'b000) ? add_carry_out :   
                   (ALUControl == 3'b001) ? ~sub_carry_out :  
                   1'b0;                                    

endmodule
