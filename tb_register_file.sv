///////////////////////////////////////////////////////////////////////////////
//
// tb_register_file.sv
//
// module: tb_register_file
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/10ps

`include "./register_file.sv"
`include "../clock/Clock.sv"

module tb_register_file;

    parameter WIDTH = 32;
    parameter ADDR_WIDTH = 5;

    // Clock signals
    logic enable;
    logic clk;

    // Register file signals
    logic rst, we;
    logic [ADDR_WIDTH-1:0] wa, ra1, ra2;
    logic [WIDTH-1:0] wd;
    wire [WIDTH-1:0] rd1, rd2;

    // Instantiate clock generator
    CLOCK uut1 (.ENABLE(enable), .CLOCK(clk));

    // Instantiate register file
    register_file dut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Initialize variables
    initial begin
        {enable, rst, we, wa, ra1, ra2, wd} = 0;
    end

    // Dump for waveform viewing
    initial begin
        $dumpfile("tb_register_file.vcd");
        $dumpvars(0, dut);
    end

    // Display variables
    initial begin
        $monitor ($time, "ns\tclk=%b rst=%b enable=%b wa=%h wd=%h we=%b ra1=%h rd1=%h ra2=%h rd2=%h",
                  clk, rst, enable, wa, wd, we, ra1, rd1, ra2, rd2);
    end

    // Apply stimulus
    initial begin
        #5 rst = 1;     // reset asserted
        #5 enable = 1; // start clock
        #10;
        #5 rst = 0;    // deassert reset
        #5 we = 1;
        #5 wa = 2; wd = $random;
        #20 we = 0;

        #5 ra1 = 2;
        #20;

        #5 we = 1;
        #5 wa = 3; wd = $random;
        #20 we = 0;

        #5 ra2 = 3;
        #20;

        #5 rst = 1; // reset again
        #20;
        #5 rst = 0;
        #5 enable = 0; // stop clock
        #50;

        $finish;
    end

endmodule
