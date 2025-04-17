///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for Adder
//
// Testbench for Adder
//
// module: Adder
// hdl: SystemVerilog
///////////////////////////////////////////////////////////////////////////////
`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "adder.sv"

module tb_adder;
    parameter WIDTH = 32;
    logic [WIDTH-1:0] a, b, y;

    initial begin : dump_variables
        $dumpfile("tb_ADDER.vcd"); // for Makefile, make dump file same as module name
        $dumpvars(0, dut);
    end

    reg [WIDTH-1:0] A;    // n-bit input A
    reg [WIDTH-1:0] B;    // n-bit input B
    wire [WIDTH-1:0] Sum; // n-bit Sum output

    // Instantiate the n-bit full adder with the parameterized bit length
    FULL_ADDER #(n) dut (
        .A(A),
        .B(B),
        .Sum(Sum),
    );
       initial begin
        a <= #n'hFFFFFFFF;
        b <= #n'hFFFFFFFF;
    end

endmodule
`endif // TB_ADDER
