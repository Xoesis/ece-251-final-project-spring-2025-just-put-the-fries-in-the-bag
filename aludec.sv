//////////////////////////////////////////////////////////////////////////////
//
// Module: ALU decoder
//
// ALU decoder
//
// module: ALU decoder
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec (
    input  logic [5:0] funct,
    input  logic [1:0] aluop,
    output logic [3:0] alucontrol
);

    typedef enum logic [3:0] {
        ALU_ADD  = 4'b0000,
        ALU_SUB  = 4'b0001,
        ALU_AND  = 4'b0010,
        ALU_OR   = 4'b0011,
        ALU_XOR  = 4'b0100,
        ALU_NOR  = 4'b0101,
        ALU_SLT  = 4'b0110,
        ALU_SLL  = 4'b0111,
        ALU_SRL  = 4'b1000,
        ALU_SRA  = 4'b1001,
        ALU_LUI  = 4'b1010,
        ALU_MUL  = 4'b1011,
        ALU_DIV  = 4'b1100
    } alu_op_t;

    always_comb begin
        case (aluop)
            2'b00: alucontrol = ALU_ADD;
            2'b01: alucontrol = ALU_SUB;
            2'b10: alucontrol = ALU_OR;
            default: case (funct)
                6'b100000: alucontrol = ALU_ADD; // ADD
                6'b100010: alucontrol = ALU_SUB; // SUB
                6'b100100: alucontrol = ALU_AND; // AND
                6'b100101: alucontrol = ALU_OR;  // OR
                6'b100110: alucontrol = ALU_XOR; // XOR
                6'b100111: alucontrol = ALU_NOR; // NOR
                6'b101010: alucontrol = ALU_SLT; // SLT
                6'b000000: alucontrol = ALU_SLL; // SLL
                6'b000010: alucontrol = ALU_SRL; // SRL
                6'b000011: alucontrol = ALU_SRA; // SRA
                6'b011000: alucontrol = ALU_MUL; // MULT
                6'b011010: alucontrol = ALU_DIV; // DIV
                default:   alucontrol = ALU_ADD;
            endcase
        endcase
    end

endmodule

`endif
