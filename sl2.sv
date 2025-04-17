//////////////////////////////////////////////////////////////////////////////
//
// Module: Shift Left 2
//
// Shift Left 2
//
// module: Shift Left 2
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
///////////////////////////////////////////////////////////////////////////////
`ifndef Shift_Left_2
`define Shift_Left_2

module Shift_Left_2 #(
    parameter WIDTH = 32  // Default width of 1 bit (can be parameterized)
)(
    input wire [WIDTH-1:0] in,  // Input 0
    output wire [WIDTH-1:0] out  // Output
);
    // Shift left 2 bits
    assign out = in << 2;

endmodule

`endif 
