// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module tb;
    logic clk,rst;
    logic signed [7:0] A0,A1,A2,A3,B0,B1,B2,B3;
    logic signed [31:0] C00,C01,C02,C03,
                        C10,C11,C12,C13,
                        C20,C21,C22,C23,
                        C30,C31,C32,C33;

    TopDesign dut(clk,rst,A0,A1,A2,A3,B0,B1,B2,B3,
                  C00,C01,C02,C03,C10,C11,C12,C13,
                  C20,C21,C22,C23,C30,C31,C32,C33);
  
      initial begin
        $dumpfile("systolic4x4.vcd");   // name of VCD file
        $dumpvars(0, tb);               // dump all signals in tb
    end


    initial begin clk=0; forever #5 clk=~clk; end

    initial begin
        rst=1; {A0,A1,A2,A3,B0,B1,B2,B3}=0; #12; rst=0;

        // Stream inputs for 4 cycles
        @(posedge clk); A0=1;A1=5;A2=9;A3=13; B0=1;B1=0;B2=0;B3=0;
        @(posedge clk); A0=2;A1=6;A2=10;A3=14;B0=0;B1=1;B2=0;B3=0;
        @(posedge clk); A0=3;A1=7;A2=11;A3=15;B0=0;B1=0;B2=1;B3=0;
        @(posedge clk); A0=4;A1=8;A2=12;A3=16;B0=0;B1=0;B2=0;B3=1;

        repeat(20) @(posedge clk);

        $display("C Matrix:");
        $display("%0d %0d %0d %0d",C00,C01,C02,C03);
        $display("%0d %0d %0d %0d",C10,C11,C12,C13);
        $display("%0d %0d %0d %0d",C20,C21,C22,C23);
        $display("%0d %0d %0d %0d",C30,C31,C32,C33);

        $finish;
    end
endmodule
