//////////////////////////////////////////////////////////////////////////////
//
// Module: register_file
//
// register File
//
// hdl: SystemVerilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu
//
///////////////////////////////////////////////////////////////////////////////
`ifndef REGISTER_FILE
`define REGISTER_FILE

module register_file
    //
    // ---------------- DECLARATIONS OF PORT IN/OUT & DATA TYPES ----------------
    //
#(
    parameter WIDTH = 32,   // Width of each register (inherited or specified)
    parameter ADDR_WIDTH = 5 // Width of addr of registers
) (
    input logic clk, rst, we,

    input logic [ADDR_WIDTH-1:0] ra1, ra2, wa, // Read Reg 1, Read Reg 2, Write address
    input logic [WIDTH-1:0] wd, // Write data
    output logic [WIDTH-1:0] rd1, rd2 // Read data
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    // Array of registers
    logic [WIDTH-1:0] regfile[2**ADDR_WIDTH-1:0];

    always @(posedge clk)begin
      if(we) regfile[wa] <= wd;
      for (int i = 0; i < 2**ADDR_WIDTH; i++)begin
        if(rst) regfile[i] <= 0;
      end
    end
      
    assign rd1 = (ra1 != 0) ? regfile[ra1] : 0;
    assign rd2 = (ra2 != 0) ? regfile[ra2] : 0;
endmodule
`endif // register_file
