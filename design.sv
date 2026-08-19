// Code your design here
`timescale 1ns/1ps
`include "SystolicArray.sv"
module TopDesign #(parameter W=8, ACC_W=32)(
    input logic clk,rst,
    input logic signed [W-1:0] A0,A1,A2,A3,
    input logic signed [W-1:0] B0,B1,B2,B3,
    output logic signed [ACC_W-1:0] C00,C01,C02,C03,
                                   C10,C11,C12,C13,
                                   C20,C21,C22,C23,
                                   C30,C31,C32,C33
);
    SystolicArray4x4 #(W,ACC_W) dut(clk,rst,
        A0,A1,A2,A3,B0,B1,B2,B3,
        C00,C01,C02,C03,
        C10,C11,C12,C13,
        C20,C21,C22,C23,
        C30,C31,C32,C33);
endmodule
