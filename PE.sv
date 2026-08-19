`timescale 1ns/1ps
module PE #(parameter W=8, ACC_W=32)(
    input  logic clk, rst,
    input  logic signed [W-1:0] in_a, in_b,
    output logic signed [W-1:0] out_a, out_b,
    output logic signed [ACC_W-1:0] acc_out
);
    logic signed [ACC_W-1:0] acc;
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin acc<=0; out_a<=0; out_b<=0; end
        else begin acc<=acc+(in_a*in_b); out_a<=in_a; out_b<=in_b; end
    end
    assign acc_out = acc;
endmodule
