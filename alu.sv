//////////////////////////////////////////////////////////////////////////////
//
// Module: ALU
//
// ALU
//
// module: ALU
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU
`timescale 1ns/100ps

module alu #(parameter WIDTH = 32) (
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic [3:0]   alucontrol,
    output logic [WIDTH-1:0] result
);

    always @(a,b,alucontrol) begin
        case (alucontrol)
            4'b0000: result = a + b;               // ADD
            4'b0001: result = a - b;               // SUB
            4'b0010: result = a & b;               // AND
            4'b0011: result = a | b;               // OR
            4'b0100: result = a ^ b;               // XOR
            4'b0101: result = ~(a | b);            // NOR
            4'b0110: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; // SLT
            4'b0111: result = b << a[4:0];         // SLL (use lower 5 bits for shift)
            4'b1000: result = b >> a[4:0];         // SRL
            4'b1001: result = $signed(b) >>> a[4:0]; // SRA
            4'b1010: result = b << 16;             // LUI
            4'b1011: result = a * b;               // MUL
            4'b1100: result = a / b;               // DIV 
            default: result = 32'b0;
        endcase
    end

endmodule
`endif
