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
module ALU #(
    parameter WIDTH = 32
) (
    input  wire [WIDTH-1:0] a,          
    input  wire [WIDTH-1:0] b,          
    input  wire [3:0] alucontrol,  
    output reg  [WIDTH-1:0] result,      
    output wire zero        
);

    always @(*) begin
        case (alucontrol)
            4'b0000: result = a + b;                                    // ADD
            4'b0001: result = a - b;                                    // SUB
            4'b0010: result = a & b;                                    // AND
            4'b0011: result = a | b;                                    // OR
            4'b0100: result = a ^ b;                                    // XOR
            4'b0101: result = ~(a | b);                                 // NOR
            4'b0110: result = ($signed(a) < $signed(b)) ? 1 : 0;        // SLT (signed)
            4'b0111: result = b << a[$clog2(N)-1:0];                    // SLL
            4'b1000: result = b >> a[$clog2(N)-1:0];                    // SRL
            4'b1001: result = $signed(b) >>> a[$clog2(N)-1:0];          // SRA
            4'b1010: result = {b[N/2-1:0], {N/2{1'b0}}};                // LUI
            default: result = {N{1'b0}};                                // Default to 0
        endcase
    end

    assign zero = (result == {N{1'b0}});

endmodule
