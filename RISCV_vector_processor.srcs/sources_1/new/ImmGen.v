`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:45:12
// Design Name: 
// Module Name: ImmGen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ImmGen #(
    parameter WIDTH = 32
)(
    input clk,
    input rst_n,
    input [WIDTH-1:0] InstImm, // RISC-V instruction
    output reg [WIDTH-1:0]Imm // Immediate value
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            Imm <= 0;
        end else begin
            Imm <= InstImm;
        end
    end
endmodule
