///////////////////////////////////////////////////////////////////////////////
//
// dff.sv
//
// module: d-flip-flop
// hdl: Verilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef DFF
`define DFF

module dff(d, clk, rst, enable, q);
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic d, clk, rst, enable;
    output logic q;
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always_ff @(posedge clk)begin
        if (rst) 
            q <= 0;
        else if (enable) 
            q <= d;
    end

endmodule
`endif // DFF
