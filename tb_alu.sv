///////////////////////////////////////////////////////////////////////////////
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

    parameter N = 32;

    reg  [N-1:0] a, b;
    reg  [3:0]   alucontrol;
    wire [N-1:0] result;

    alu #(N) dut (
        .a(a),
        .b(b),
        .alucontrol(alucontrol),
        .result(result)
    );

    initial begin
        // MUL
        a = 32'd6; b = 32'd7; alucontrol = 4'b1011;
        #1 $display("MUL: a = %b, b = %b, result = %b", a, b, result);

        // DIV
        a = 32'd21; b = 32'd7; alucontrol = 4'b1100;
        #1 $display("DIV: a = %b, b = %b, result = %b", a, b, result);

        // ADD
        a = 32'd3; b = 32'd2; alucontrol = 4'b0000;
        #1 $display("ADD: a = %b, b = %b, result = %b", a, b, result);

        // AND
        a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; alucontrol = 4'b0010;
        #1 $display("AND: a = %b, b = %b, result = %b", a, b, result);
        
        $finish;
    end

endmodule



endmodule



