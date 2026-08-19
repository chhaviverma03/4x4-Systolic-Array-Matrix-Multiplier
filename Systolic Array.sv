`timescale 1ns/1ps
`include "PE.sv"
module SystolicArray4x4 #(parameter W=8, ACC_W=32)(
    input logic clk, rst,
    input logic signed [W-1:0] A0,A1,A2,A3,
    input logic signed [W-1:0] B0,B1,B2,B3,
    output logic signed [ACC_W-1:0] C00,C01,C02,C03,
                                   C10,C11,C12,C13,
                                   C20,C21,C22,C23,
                                   C30,C31,C32,C33
);
    logic signed [W-1:0] a[0:3][0:4], b[0:4][0:3];
    logic signed [ACC_W-1:0] acc[0:3][0:3];

    assign a[0][0]=A0; assign a[1][0]=A1; assign a[2][0]=A2; assign a[3][0]=A3;
    assign b[0][0]=B0; assign b[0][1]=B1; assign b[0][2]=B2; assign b[0][3]=B3;

    genvar i,j;
    generate
        for(i=0;i<4;i++) begin: row
            for(j=0;j<4;j++) begin: col
                PE #(W,ACC_W) pe(
                    .clk(clk),.rst(rst),
                    .in_a(a[i][j]), .in_b(b[i][j]),
                    .out_a(a[i][j+1]), .out_b(b[i+1][j]),
                    .acc_out(acc[i][j])
                );
            end
        end
    endgenerate

    assign {C00,C01,C02,C03} = {acc[0][0],acc[0][1],acc[0][2],acc[0][3]};
    assign {C10,C11,C12,C13} = {acc[1][0],acc[1][1],acc[1][2],acc[1][3]};
    assign {C20,C21,C22,C23} = {acc[2][0],acc[2][1],acc[2][2],acc[2][3]};
    assign {C30,C31,C32,C33} = {acc[3][0],acc[3][1],acc[3][2],acc[3][3]};
endmodule
