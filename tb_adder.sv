`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "adder.sv"

module tb_adder;
    parameter WIDTH = 32;
    
    // Test signals
    logic [WIDTH-1:0] A, B;
    logic [WIDTH-1:0] Sum;
    
    // Instantiate the adder
    ADDER #(.WIDTH(WIDTH)) dut (
        .A(A),
        .B(B),
        .Sum(Sum)
    );
    
    // Initialize waveform dumping
    initial begin
        $dumpfile("tb_adder.vcd");
        $dumpvars(0, tb_adder);
    end
    
    // Test cases
    initial begin
        // Test case 1: Basic addition
        A = 32'h00000001;
        B = 32'h00000001;
        #10;
        $display("Test 1: %h + %h = %h (Expected: %h)", A, B, Sum, 32'h00000002);
        
        // Test case 2: Overflow case
        A = 32'hFFFFFFFF;
        B = 32'h00000001;
        #10;
        $display("Test 2: %h + %h = %h (Expected: %h)", A, B, Sum, 32'h00000000);
        
        $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("At time %t: A = %h, B = %h, Sum = %h", 
                 $time, A, B, Sum);
    end

endmodule
`endif // TB_ADDER
