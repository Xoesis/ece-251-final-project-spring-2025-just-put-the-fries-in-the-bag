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
    parameter WIDTH = 32 
)(
    input wire [WIDTH-1:0] in,  // Input 
    output wire [WIDTH-1:0] out  // Output
);

    // Shift left 2 bits 
    assign out = in << 2;

endmodule
`endif 
