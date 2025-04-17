`timescale 1ns/1ps
`include "sl2.sv"

module tb_Shift_Left_2;
    parameter WIDTH = 32;
    
    reg [WIDTH-1:0] in;
    wire [WIDTH-1:0] out;
    
    Shift_Left_2 #(.WIDTH(WIDTH)) dut (.in(in), .out(out));
    
    initial begin
        $dumpfile("shift.vcd");
        $dumpvars(0, tb_Shift_Left_2);
        
        // Test case 1: Basic shift
        in = 32'h00000003; // binary: ...0011
        #10;
        $display("Input: %h, Output: %h (Expected: %h)", in, out, 32'h0000000C);
        
        // Test case 2: Shift with overflow
        in = 32'hC0000000;
        #10;
        $display("Input: %h, Output: %h (Expected: %h)", in, out, 32'h00000000);
        
        // Test case 3: Random test
        in = $random;
        #10;
        $display("Input: %h, Output: %h", in, out);
        
        $finish;
    end
endmodule
