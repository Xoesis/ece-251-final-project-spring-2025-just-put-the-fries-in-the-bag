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

module alu (
    input logic [31:0] a, b,
    input logic [2:0] alucontrol,
    output logic [31:0] aluout,
    output logic zero,
    output logic overflow
);
    logic [31:0] result;
    logic carry_out;
    logic [63:0] HILO;
    
    always @(*) begin
	HILO = a * b;
	case (alucontrol)
            3'b000: result <= a & b;  // AND
            3'b001: result <= a | b;  // OR
	    3'b011: result <= ~(a|b); // NOR
            3'b010: {carry_out, result} = {1'b0,a} + {1'b0,b};  // ADD
            3'b100: result <= a - b;  // SUB
	    3'b101: result <= HILO[63:32]; // MFHI
	    3'b110: result <= HILO[31:0]; // MFLO
            3'b111: result <= ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;  // SLT
            default: result <= 32'd0;
        endcase
    end
    
    assign aluout = result;
    assign zero = (result == 32'd0);
    
    // Overflow detection
    assign overflow = (alucontrol == 3'b010) ? (a[31] == b[31] && result[31] != a[31]) :
                     (alucontrol == 3'b110) ? (a[31] != b[31] && result[31] != a[31]) :
                     1'b0;
endmodule

`endif
