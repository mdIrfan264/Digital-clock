`timescale 1ns / 1ps

module tb_digital_clock;

    reg clk;
    reg rst;
    wire [7:0] seg;
    wire [3:0] an;

    // Instantiate the DUT (Device Under Test)
    digital_clock uut (
        .clk(clk),
        .rst(rst),
        .seg(seg),
        .an(an)
    );

    // Simulated fast clock (10ns period = 100MHz)
    always #5 clk = ~clk;

    initial begin
        $display("Starting simulation...");
        $dumpfile("digital_clock.vcd"); // for GTKWave
        $dumpvars(0, tb_digital_clock);

        // Initialize signals
        clk = 0;
        rst = 1;

        // Hold reset for some time
        #20 rst = 0;

        // Let simulation run for a simulated 2 minutes (~120 "ticks")
        #2000;

        // Assert reset again mid-way
        rst = 1;
        #20 rst = 0;

        #1000;

        $display("Simulation complete!");
        $finish;
    end

endmodule
