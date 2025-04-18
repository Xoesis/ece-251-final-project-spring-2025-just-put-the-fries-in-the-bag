//////////////////////////////////////////////////////////////////////////////
//
// Module: ALU decoder
//
// ALU decoder
//
// module: ALU decoder
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
///////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec (
    input  logic [5:0] funct,    
    input  logic [1:0] aluop,    // ALU opcode
    output logic [3:0] alucontrol // ALU control signals
);
    // ALU control encoding
    typedef enum logic [3:0] {
        ALU_ADD  = 4'b0000,  // Addition
        ALU_SUB  = 4'b0001,  // Subtraction
        ALU_AND  = 4'b0010,  // AND
        ALU_OR   = 4'b0011,  // OR
        ALU_XOR  = 4'b0100,  // XOR
        ALU_NOR  = 4'b0101,  // NOR
        ALU_SLT  = 4'b0110,  // Set less than
        ALU_SLL  = 4'b0111,  // Shift left logical
        ALU_SRL  = 4'b1000,  // Shift right logical
        ALU_SRA  = 4'b1001,  // Shift right arithmetic
        ALU_LUI  = 4'b1010   // Load upper immediate
    } alu_op_t;

    always_comb begin
        // I type 
        case(aluop)
            2'b00: alucontrol = ALU_ADD;  
            2'b01: alucontrol = ALU_SUB;  
            2'b10: alucontrol = ALU_OR;   
        // R type
            default: case(funct)         
                6'b100000: alucontrol = ALU_ADD;  // add
                6'b100010: alucontrol = ALU_SUB;  // sub
                6'b100100: alucontrol = ALU_AND;  // and
                6'b100101: alucontrol = ALU_OR;   // or
                6'b100110: alucontrol = ALU_XOR;  // xor
                6'b100111: alucontrol = ALU_NOR;  // nor
                6'b101010: alucontrol = ALU_SLT;  // slt
                6'b000000: alucontrol = ALU_SLL;  // sll
                6'b000010: alucontrol = ALU_SRL;  // srl
                6'b000011: alucontrol = ALU_SRA;  // sra
                default:   alucontrol = ALU_ADD;  // default to add
            endcase
        endcase
    end
endmodule

`endif 
