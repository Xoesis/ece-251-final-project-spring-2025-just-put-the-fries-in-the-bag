`timescale 1ns/100ps
`include "sl2.sv"

module tb_Shift_Left_2;
    parameter WIDTH = 32;
    
    reg [WIDTH-1:0] in;
    wire [WIDTH-1:0] out;
    
    Shift_Left_2 #(.WIDTH(WIDTH)) dut (.in(in), .out(out));
    
    initial begin
        $dumpfile("shift.vcd");
        $dumpvars(0, tb_sl2);
        
        // Test case 1: Basic shift
        in = 32'b00000001; 
        #10;
        $display("Input: %b, Output: %b", in, out);
        
        $finish;
    end
endmodule
