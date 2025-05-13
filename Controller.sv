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
// need to account for R, I, J type instructions
//
///////////////////////////////////////////////////////////////////////////////

`ifndef CONTROLLER
`define CONTROLLER

`include "../Main_Decoder/Main_Decoder.sv"
`include "../ALU_decoder/aludec.sv"

`timescale 1ns/100ps


module CONTROLLER(
    input  logic [5:0] op, funct,
    input  logic zero,
    output logic memtoreg, memwrite,
    output logic pcsrc, alusrc,
    output logic regdst, regwrite,
    output logic jump,
    output logic [2:0] alucontrol
);
    logic [1:0] aluop;
    logic branch;

    // Main decoder
    always_comb begin
        case (op)
            6'b000000: begin // R-type
                regwrite = 1; regdst = 1;
                alusrc = 0; memwrite = 0;
                memtoreg = 0; jump = 0;
                aluop = 2'b10;
            end
            6'b100011: begin // lw
                regwrite = 1; regdst = 0;
                alusrc = 1; memwrite = 0;
                memtoreg = 1; jump = 0;
                aluop = 2'b00;
            end
            6'b101011: begin // sw
                regwrite = 0; regdst = 0;
                alusrc = 1; memwrite = 1;
                memtoreg = 0; jump = 0;
                aluop = 2'b00;
            end
            6'b000100: begin // beq
                regwrite = 0; regdst = 0;
                alusrc = 0; memwrite = 0;
                memtoreg = 0; jump = 0;
                aluop = 2'b01;
            end
            6'b001000: begin // addi
                regwrite = 1; regdst = 0;
                alusrc = 1; memwrite = 0;
                memtoreg = 0; jump = 0;
                aluop = 2'b00;
            end
            default: begin
                regwrite = 0; regdst = 0;
                alusrc = 0; memwrite = 0;
                memtoreg = 0; jump = 0;
                aluop = 2'b00;
            end
        endcase
    end

    // ALU decoder
    always_comb begin
        case (aluop)
            2'b00: alucontrol = 3'b000; // add
            2'b01: alucontrol = 3'b001; // sub
            2'b10: begin // R-type
                case (funct)
                    6'b100000: alucontrol = 3'b000; // add
                    6'b100010: alucontrol = 3'b001; // sub
                    6'b100100: alucontrol = 3'b010; // and
                    6'b011000: alucontrol = 3'b011; // mult
                    6'b010010: alucontrol = 3'b100; // mflo
                    6'b010000: alucontrol = 3'b101; // mfhi
                    default:   alucontrol = 3'b000;
                endcase
            end
            default: alucontrol = 3'b000;
        endcase
    end

    assign branch = (op == 6'b000100) & zero;
    assign pcsrc = branch | jump;
endmodule
`endif
