//////////////////////////////////////////////////////////////////////////////
//
// Module: Controller
//
// Controller
//
// module: Controller
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com> 
// Code inspired by Prof. Marano
//
///////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`include "../Main_Decoder/Main_Decoder.sv"
`include "../ALU_decoder/aludec.sv"

`timescale 1ns/100ps
module CONTROLLER #(parameter n = 32)(
    input  logic [5:0] op, funct,
    input  logic       zero,
    output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [3:0] alucontrol,
    output logic       branch  // Explicitly expose branch signal
);
    logic [1:0] aluop;
    
    MAINDEC md(
        .op(op),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .branch(branch),  // branch=1 for BEQ, 0 otherwise
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .aluop(aluop)
    );
    
    aludec ad(
        .funct(funct),
        .aluop(aluop),
        .alucontrol(alucontrol)
    );

    assign pcsrc = branch & zero;  // pcsrc = 1 only if branch=1 and zero=1
endmodule
`endif
