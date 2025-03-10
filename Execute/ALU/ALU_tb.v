module ALU_tb();

    reg [31:0] a, b;
    reg [2:0] ALUControl;
    wire [31:0] result;
    wire Zero, Overflow, Negative, Carry;

    ALU dut(a, b,  ALUControl,result, Zero, Overflow, Negative, Carry);

initial begin
    $display("Time | ALUControl | a          | b          | Result     | Zero | Overflow | Negative | Carry");
    $display("-----------------------------------------------------------------------------------------");

    // Test Addition (Normal Case)
    a = 32'd15; b = 32'd10; ALUControl = 3'b000;
    #10;

    // Test Addition with Carry
    a = 32'hFFFFFFFF; b = 32'd1; ALUControl = 3'b000;
    #10;

    // Test Subtraction (Positive Result)
    a = 32'd50; b = 32'd30; ALUControl = 3'b001;
    #10;

    // Test Subtraction (Negative Result)
    a = 32'd20; b = 32'd50; ALUControl = 3'b001;
    #10;

    // Test Subtraction with Zero Result
    a = 32'd100; b = 32'd100; ALUControl = 3'b001;
    #10;

    // Test NOT Operation
    a = 32'h0F0F0F0F; b = 32'h00000000; ALUControl = 3'b010;
    #10;

    // Test Logical Left Shift
    a = 32'd5; b = 32'd3; ALUControl = 3'b011;
    #10;

    // Test Arithmetic Right Shift (Positive Number)
    a = 32'd64; b = 32'd2; ALUControl = 3'b100;
    #10;

    // Test Arithmetic Right Shift (Negative Number)
    a = -32'd64; b = 32'd2; ALUControl = 3'b100;
    #10;

    // Test AND Operation
    a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; ALUControl = 3'b101;
    #10;

    // Test OR Operation
    a = 32'hAAAA5555; b = 32'h5555AAAA; ALUControl = 3'b110;
    #10;

    // Test Set Less Than (a < b)
    a = 32'd10; b = 32'd20; ALUControl = 3'b111;
    #10;

    // Test Set Less Than (a > b)
    a = 32'd30; b = 32'd20; ALUControl = 3'b111;
    #10;

    // Test Set Less Than (a == b)
    a = 32'd25; b = 32'd25; ALUControl = 3'b111;
    #10;

    // Edge Case: Zero Flag
    a = 32'd0; b = 32'd0; ALUControl = 3'b000;
    #10;

    // Edge Case: Large Inputs
    a = 32'h7FFFFFFF; b = 32'h7FFFFFFF; ALUControl = 3'b000; // Max positive addition
    #10;

    // Edge Case: Overflow Detection
    a = 32'h7FFFFFFF; b = 32'd1; ALUControl = 3'b000; // Positive Overflow
    #10;

    a = 32'h80000000; b = -32'd1; ALUControl = 3'b001; // Negative Overflow
    #10;

    // Edge Case: Negative Flag
    a = -32'd1; b = 32'd0; ALUControl = 3'b000;
    #10;

    $finish;
end


    initial
    begin 
        $display("ALU Testbench");
        $monitor("a=%h, b=%h, ALUControl=%h, result=%h, Zero=%b, Overflow=%b, Negative=%b, Carry=%b", a, b, ALUControl, result, Zero, Overflow, Negative, Carry);
    end

    initial
    begin
        $dumpfile("ALU.vcd");
        $dumpvars(0);
    end

endmodule



