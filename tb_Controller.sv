`timescale 1ns/100ps

module CONTROLLER_tb;
  // Parameters
  parameter n = 32;

  // Inputs
  logic [5:0] op;
  logic [5:0] funct;
  logic       zero;

  // Outputs
  logic       memtoreg, memwrite;
  logic       pcsrc, alusrc;
  logic       regdst, regwrite;
  logic       jump;
  logic [3:0] alucontrol;

  // Instantiate the Unit Under Test (UUT)
  CONTROLLER #(n) uut (
    .op(op),
    .funct(funct),
    .zero(zero),
    .memtoreg(memtoreg),
    .memwrite(memwrite),
    .pcsrc(pcsrc),
    .alusrc(alusrc),
    .regdst(regdst),
    .regwrite(regwrite),
    .jump(jump),
    .alucontrol(alucontrol)
  );

  // Task to display outputs neatly
  task display_outputs;
    $display("Time: %0t | op: %b, funct: %b, zero: %b | memtoreg: %b, memwrite: %b, pcsrc: %b, alusrc: %b, regdst: %b, regwrite: %b, jump: %b, alucontrol: %b",
              $time, op, funct, zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
  endtask

  initial begin
    // Initialize Inputs
    op = 6'b000000; // R-type
    funct = 6'b100000; // ADD
    zero = 0;
    #10; display_outputs;

    zero = 1;
    #10; display_outputs;

    op = 6'b100011; // LW
    funct = 6'b000000; // Don't care
    zero = 0;
    #10; display_outputs;

    op = 6'b101011; // SW
    funct = 6'b000000; // Don't care
    zero = 0;
    #10; display_outputs;

    op = 6'b000100; // BEQ
    funct = 6'b000000; // Don't care
    zero = 1;
    #10; display_outputs;

    op = 6'b000010; // JUMP
    funct = 6'b000000; // Don't care
    zero = 0;
    #10; display_outputs;

    // You can add more tests for other instructions

    $stop;
  end

endmodule
