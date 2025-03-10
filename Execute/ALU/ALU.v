// ALUControl : ALU Operation 
// Sign is MSB of ALUControl

// 000 -> if (Sign) Subtract else Add
// 001 -> Shift Left Logical
// 010 -> Set Less Than
// 011 -> Set Less Than Unsigned
// 100 -> XOR
// 101 -> if (Sign) Shift Right Arithmetic else Shift Right Logical
// 110 -> Bitwise OR
// 111 -> AND

module ALU(
    input [31:0] a, b,
    input [3:0] ALUControl,
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
        case (ALUControl[2:0])
            3'b000: result = (ALUControl[3]) ? sub_result : add_result ;                // Add or Subtract
            3'b001: result = a << b[4:0];                                               // Shift left logical (limit shift to 5 bits) 
            3'b010: result = (sub_carry_out) ? 32'd1 : 32'd0;                           // Set Less Than (SLT)
            3'b011: result = (a < b) ? 32'd1 : 32'd0;                                   // Set Less Than Unsigned (SLTU)            
            3'b100: result = a ^ b;                                                     // Bitwise XOR
            3'b101: result = (ALUControl[3]) ? ($signed(a) >>> b[4:0]) : (a >> b[4:0]); // Shift right arithmetic or logical
            3'b110: result = a & b;                                                     // Bitwise AND
            3'b111: result = a | b;                                                     // Bitwise OR
            default: result = 32'h00000000;                                          
        endcase
    end

    assign Zero = (result == 32'h00000000);               
    assign Negative = result[31];                   

    assign Overflow = ((ALUControl[3] == 1'b0) && (a[31] == b[31]) && (result[31] != a[31])) ||  // Addition overflow
                      ((ALUControl[3] == 1'b1) && (a[31] != b[31]) && (result[31] != a[31]));   // Subtraction overflow

    assign Carry = (ALUControl[3] == 1'b0) ? add_carry_out :   
                   (ALUControl[3] == 1'b1) ? ~sub_carry_out :  
                   1'b0;                                    

endmodule
