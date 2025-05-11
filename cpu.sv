//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Prof Rob Marano
// 
// Create Date: 2023-02-07
// Module Name: cpu
// Description: 32-bit RISC-based CPU (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "../Controller/Controller.sv"
`include "../Datapath/Datapath.sv"

module cpu #(parameter n = 32)(
    input  logic           clk, reset,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic           memwrite,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    // Internal control signals
    logic       memtoreg, alusrc, regdst, regwrite, jump, pcsrc;
    logic [3:0] alucontrol;

    // Internal zero flag (not from datapath output)
    logic       zero;

    // Instantiate controller
    CONTROLLER c(
        .op(instr[31:26]), 
        .funct(instr[5:0]), 
        .zero(zero),  // Controller gets zero flag
        .memtoreg(memtoreg), 
        .memwrite(memwrite), 
        .pcsrc(pcsrc),
        .alusrc(alusrc), 
        .regdst(regdst), 
        .regwrite(regwrite), 
        .jump(jump),
        .alucontrol(alucontrol)
    );

    // Instantiate datapath ( zero is NOT connected to datapath)
    datapath dp(
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol[2:0]),
        // NO .zero connection here
        .pc(pc),
        .instr(instr),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata)
    );

    // Manually compute zero flag from ALU output
    assign zero = (aluout == 0);

endmodule

`endif // CPU
