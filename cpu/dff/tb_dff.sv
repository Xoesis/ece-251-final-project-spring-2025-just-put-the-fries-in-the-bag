///////////////////////////////////////////////////////////////////////////////
//
// tb_dff.sv
//
// module: tb_dff
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps
// ensure you note the scale (ns) below in $monitor

`include "./dff.sv"

module tb_dff;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //

    //inputs are reg for test bench - or use logic
    logic D, CLK, ENABLE, RST;
    
    //outputs are wire for test bench - or use logic
    wire Q;    
    
    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (DUT) ----------------
    //
    dff dut(.d(D), .clk(CLK), .rst(RST), .enable(ENABLE), .q(Q));
    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //
    initial begin : initialize_variables
        {D, CLK, ENABLE} <= 0;
        RST <= 1;
    end

    initial begin : dump_variables
      $dumpfile("tb_dff.vcd"); // for Makefile, make dump file same as module name
      $dumpvars(0, dut);
    end

    /*
    * display variables
    */
    initial begin: display_variables
        $monitor ($time, "ns\tClock=%b,\tReset=%b,\Enable=%b,\D=%b,\Q=%b", CLK, RST, ENABLE, D, Q);
    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    // note: following the keyword begin is the name of the block: apply_stimulus
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK; // 10ns period
    end

    initial begin : apply_stimuli
        #10 RST = 0;
        D = 1;
        ENABLE = 1;
        #10; 

        D = 0;
        ENABLE = 1;
        #10; 

        ENABLE = 0; 
        D = 1;
        #10;

        ENABLE = 1; 
        #10;
        $finish;
    end

endmodule

// `endif // tb_dff
