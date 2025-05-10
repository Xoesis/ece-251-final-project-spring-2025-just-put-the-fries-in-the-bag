//////////////////////////////////////////////////////////////////////////////
//
// Module: IMEM
//
// IMEM
//
// module: IMEM
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef IMEM
`define IMEM

`timescale 1ns/100ps

module IMEM
// n=bit length of register; r=bit length of addr to limit memory and not crash your verilog emulator
    #(parameter n = 32, parameter r = 6)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [(r-1):0] addr,
    output logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] RAM[0:(2**r-1)];

  initial
    begin
      // read memory in hex format from file 
      // $readmemh("program_exe",RAM);
      $readmemh("mult-prog_exe",RAM);
    end

  assign readdata = RAM[addr]; // word aligned

endmodule

`endif // IMEM
