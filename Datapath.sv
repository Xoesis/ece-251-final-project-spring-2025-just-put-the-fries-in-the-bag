//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 
// Kenneth Chan
// Code inspired by Prof. Rob Marano
// 
// Module Name: Datapath
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../register_file/register_file.sv"
`include "../ALU/ALU.sv"
`include "../dff/dff.sv"
`include "../Adder/adder.sv"
`include "../sl2/Shift_Left_2.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"

module datapath #(parameter n = 32) (
    input clk, reset,
    input memtoreg, pcsrc, alusrc, regdst, regwrite, jump,
    input [2:0] alucontrol,
    input [n-1:0] instr, readdata,
    output [n-1:0] pc, aluout, writedata
);
    // Internal wires
    wire [n-1:0] pcnext, pcplus4, pcbranch;
    wire [n-1:0] srca, srcb;
    wire [n-1:0] signimm, signimmsh;
    wire [n-1:0] alu_result;
    wire [n-1:0] result;
    wire [4:0] writereg;
    wire zero_flag;
    
    // Register file connections
    wire [n-1:0] rd1, rd2;
    
    // Registers
    reg [n-1:0] pc_reg, aluout_reg;
    
    // Register file
    register_file rf (
        .clk(clk),
        .rst(reset),
        .we(regwrite),
        .ra1(instr[25:21]),  // rs
        .ra2(instr[20:16]),  // rt
        .wa(writereg),      // destination register
        .wd(result),         // data to write
        .rd1(rd1),           // output 1
        .rd2(rd2)            // output 2
    );
    
    // Output assignments
    assign pc = pc_reg;
    assign aluout = aluout_reg;
    assign writedata = rd2;
    
    // ALU operand selection
    assign srca = rd1;
    assign srcb = (alucontrol == 3'b110) ? rd2 :  // For SUB operation
                 (alusrc) ? signimm : rd2;       // For other operations
    
    // Destination register selection
    assign writereg = regdst ? instr[15:11] : instr[20:16];
    
    // Result selection
    assign result = memtoreg ? readdata : alu_result;
    
    // ALU
    alu alu_unit (
        .a(srca),
        .b(srcb),
        .alucontrol(alucontrol),
        .aluout(alu_result),
        .zero(zero_flag),
        .overflow()
    );
    
    // PC+4
    assign pcplus4 = pc_reg + 4;
    
    // Sign extension
    signext se (
        .A(instr[15:0]),
        .Y(signimm)
    );
    
    // Shift left 2
    Shift_Left_2 immsh (
        .in(signimm),
        .out(signimmsh)
    );
    
    // Branch target
    assign pcbranch = pcplus4 + signimmsh;
    
    // Next PC
    assign pcnext = (pcsrc && zero_flag) ? pcbranch : pcplus4;
    
    // Update registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_reg <= 0;
            aluout_reg <= 0;
        end else begin
            pc_reg <= pcnext;
            aluout_reg <= alu_result;
        end
    end
    
    // Debug monitor
    initial begin
        $monitor("Time=%0t: PC=%h Instr=%h ALUa=%h ALUb=%h ALUOut=%h Zero=%b",
                $time, pc, instr, srca, srcb, aluout, zero_flag);
    end
endmodule

`endif
