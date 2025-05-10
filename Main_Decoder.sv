//////////////////////////////////////////////////////////////////////////////
//
// Module: Main Decoder
//
// Main Decoder
//
// module: Main Decoder
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com> 
// Code inspired by Prof. Marano
//
///////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module MAINDEC (
    input  logic [5:0] op,
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [1:0] aluop
);

    always_comb begin
        // Default values
        memtoreg = 0;
        memwrite = 0;
        branch   = 0;
        alusrc   = 0;
        regdst   = 0;
        regwrite = 0;
        jump     = 0;
        aluop    = 2'b00;

        case (op)
            6'b000000: begin  // R-type
                regdst   = 1;
                regwrite = 1;
                aluop    = 2'b11; // ✅ FIX: use funct field decoding
            end
            6'b100011: begin  // lw
                memtoreg = 1;
                memwrite = 0;
                alusrc   = 1;
                regdst   = 0;
                regwrite = 1;
                aluop    = 2'b00; // ADD
            end
            6'b101011: begin  // sw
                memtoreg = 0;
                memwrite = 1;
                alusrc   = 1;
                regdst   = 0;
                regwrite = 0;
                aluop    = 2'b00; // ADD
            end
            6'b000100: begin  // beq
                branch   = 1;
                aluop    = 2'b01; // SUB
            end
            6'b000010: begin  // jump
                jump = 1;
            end
            default: begin
                // Do nothing or handle other instructions
            end
        endcase
    end

endmodule

`endif
