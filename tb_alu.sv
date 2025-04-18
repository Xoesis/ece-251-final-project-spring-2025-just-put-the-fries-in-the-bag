///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for ALU
//
// Testbench for ALU
//
// module: ALU
// hdl: SystemVerilog
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "alu.sv"

module tb_ALU;

    parameter WIDTH = 32;

    reg  [WIDTH-1:0] a, b;
    reg  [3:0]   alucontrol;
    wire [WIDTH-1:0] result;

    ALU #(WIDTH) dut (
        .a(a),
        .b(b),
        .alucontrol(alucontrol),
        .result(result)
    );

    initial begin

        // ADD
        a = 32'b00000000000000000000000000001010;
        b = 32'b00000000000000000000000000000101;
        alucontrol = 4'b0000;
        #1 $display("ADD\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // SUB
        a = 32'b00000000000000000000000000001010;
        b = 32'b00000000000000000000000000001010;
        alucontrol = 4'b0001;
        #1 $display("SUB\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // AND
        a = 32'b11111111000000001111111100000000;
        b = 32'b00001111000011110000111100001111;
        alucontrol = 4'b0010;
        #1 $display("AND\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // OR
        a = 32'b00000000111111110000000011111111;
        b = 32'b00001111000011110000111100001111;
        alucontrol = 4'b0011;
        #1 $display("OR\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // XOR
        a = 32'b10101010101010100101010101010101;
        b = 32'b01010101010101011010101010101010;
        alucontrol = 4'b0100;
        #1 $display("XOR\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // NOR
        a = 32'b11111111111111111111111111111111;
        b = 32'b00000000000000000000000000000000;
        alucontrol = 4'b0101;
        #1 $display("NOR\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // SLT
        a = -32'sd5;
        b = 32'sd3;
        alucontrol = 4'b0110;
        #1 $display("SLT\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // SLL
        a = 32'd3;
        b = 32'b00000000000000000000000000000001;
        alucontrol = 4'b0111;
        #1 $display("SLL\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // SRL
        a = 32'd3;
        b = 32'b00000000000000000000000000001000;
        alucontrol = 4'b1000;
        #1 $display("SRL\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // SRA
        a = 32'd3;
        b = -32'sd32;
        alucontrol = 4'b1001;
        #1 $display("SRA\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        // LUI
        b = 32'b00000000000000000001001000110100; 
        alucontrol = 4'b1010;
        #1 $display("LUI\n  a        = %b\n  b        = %b\n  result   = %b\n", a, b, result);

        $finish;
    end

endmodule



