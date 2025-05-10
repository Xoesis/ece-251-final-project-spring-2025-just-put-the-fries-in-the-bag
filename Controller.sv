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

`timescale 1ns/100ps

`include "../Main_Decoder/Main_Decoder.sv"
`include "../ALU_decoder/aludec.sv"

module CONTROLLER
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [5:0] op, funct,
    input  logic       zero,
    output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [3:0] alucontrol
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [1:0] aluop;
    logic       branch;
    
    // CPU main decoder
    MAINDEC md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
    // CPU's ALU decoder
    aludec ad(funct, aluop, alucontrol);

  assign pcsrc = branch & zero;

endmodule

`endif // CONTROLLER
