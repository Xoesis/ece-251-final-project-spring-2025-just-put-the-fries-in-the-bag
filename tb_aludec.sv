`timescale 1ns/100ps
`include "aludec.sv"

module tb_aludec;
    // Test signals
    logic [5:0] funct;
    logic [1:0] aluop;
    logic [3:0] alucontrol;
    
    // Instantiate ALU decoder
    aludec dut (
        .funct(funct),
        .aluop(aluop),
        .alucontrol(alucontrol)
    );
    
    initial begin
        $dumpfile("aludec.vcd");
        $dumpvars(0, tb_aludec);
        
        $display("Time\tALUOp\tFunct\tALUControl\tOperation");
        $display("-------------------------------------------");
        
        //I-type instructions
        aluop = 2'b00; funct = 6'bxxxxxx; #10; // lw/sw/addi 
        $display("%0t\t%b\t%b\t%b\t\tADD", $time, aluop, funct, alucontrol);
        
        aluop = 2'b01; funct = 6'bxxxxxx; #10; // beq 
        $display("%0t\t%b\t%b\t%b\t\tSUB", $time, aluop, funct, alucontrol);
        
        aluop = 2'b10; funct = 6'bxxxxxx; #10; 
        $display("%0t\t%b\t%b\t%b\t\tOR", $time, aluop, funct, alucontrol);
        
        //R-type instructions
        aluop = 2'b11;
        funct = 6'b100000; #10; // add
        $display("%0t\t%b\t%b\t%b\t\tADD", $time, aluop, funct, alucontrol);
        
        funct = 6'b100010; #10; // sub
        $display("%0t\t%b\t%b\t%b\t\tSUB", $time, aluop, funct, alucontrol);
        
        funct = 6'b100100; #10; // and
        $display("%0t\t%b\t%b\t%b\t\tAND", $time, aluop, funct, alucontrol);
        
        funct = 6'b100101; #10; // or
        $display("%0t\t%b\t%b\t%b\t\tOR", $time, aluop, funct, alucontrol);
        
        funct = 6'b100110; #10; // xor
        $display("%0t\t%b\t%b\t%b\t\tXOR", $time, aluop, funct, alucontrol);
        
        funct = 6'b100111; #10; // nor
        $display("%0t\t%b\t%b\t%b\t\tNOR", $time, aluop, funct, alucontrol);
        
        funct = 6'b101010; #10; // slt
        $display("%0t\t%b\t%b\t%b\t\tSLT", $time, aluop, funct, alucontrol);
        
        funct = 6'b000000; #10; // sll
        $display("%0t\t%b\t%b\t%b\t\tSLL", $time, aluop, funct, alucontrol);
        
        funct = 6'b000010; #10; // srl
        $display("%0t\t%b\t%b\t%b\t\tSRL", $time, aluop, funct, alucontrol);
        
        // Test default case
        funct = 6'b111111; #10; // undefined
        $display("%0t\t%b\t%b\t%b\t\tDEFAULT (ADD)", $time, aluop, funct, alucontrol);
        
        $finish;
    end
endmodule
