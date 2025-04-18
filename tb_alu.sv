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
`include "ALU.sv"

module tb_ALU;
`timescale 1ns/1ps


    parameter N = 32;

    reg  [N-1:0] a, b;
    reg  [3:0]   alucontrol;
    wire [N-1:0] result;
    wire         zero;

    // Instantiate ALU
    alu #(N) dut (
        .a(a),
        .b(b),
        .alucontrol(alucontrol),
        .result(result),
        .zero(zero)
    );

    // Task to display binary output
    task show;
        input [255:0] name;
        begin
            #1 $display("%s\n  a        = %b\n  b        = %b\n  result   = %b\n  zero     = %b\n", 
                        name, a, b, result, zero);
        end
    endtask

    initial begin
        $display("Starting ALU Testbench (Binary Output)...\n");

        // ADD
        a = 32'b00000000000000000000000000001010;
        b = 32'b00000000000000000000000000000101;
        alucontrol = 4'b0000;
        show("ADD");

        // SUB
        a = 32'b00000000000000000000000000001010;
        b = 32'b00000000000000000000000000001010;
        alucontrol = 4'b0001;
        show("SUB");

        // AND
        a = 32'b11111111000000001111111100000000;
        b = 32'b00001111000011110000111100001111;
        alucontrol = 4'b0010;
        show("AND");

        // OR
        a = 32'b00000000111111110000000011111111;
        b = 32'b00001111000011110000111100001111;
        alucontrol = 4'b0011;
        show("OR");

        // XOR
        a = 32'b10101010101010100101010101010101;
        b = 32'b01010101010101011010101010101010;
        alucontrol = 4'b0100;
        show("XOR");

        // NOR
        a = 32'b11111111111111111111111111111111;
        b = 32'b00000000000000000000000000000000;
        alucontrol = 4'b0101;
        show("NOR");

        // SLT
        a = -32'sd5;
        b = 32'sd3;
        alucontrol = 4'b0110;
        show("SLT");

        // SLL
        a = 32'd3;
        b = 32'b00000000000000000000000000000001;
        alucontrol = 4'b0111;
        show("SLL");

        // SRL
        a = 32'd3;
        b = 32'b00000000000000000000000000001000;
        alucontrol = 4'b1000;
        show("SRL");

        // SRA
        a = 32'd3;
        b = -32'sd32;
        alucontrol = 4'b1001;
        show("SRA");

        // LUI
        b = 32'b00000000000000000001001000110100; // 0x00001234
        alucontrol = 4'b1010;
        show("LUI");

        $display("ALU Testbench complete.");
        $finish;
    end
endmodule




