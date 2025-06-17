`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:45:12
// Design Name: 
// Module Name: VectorRF
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


module VectorRF #(
    parameter VREG_ADDR_WIDTH = 5, 
    parameter VREG_NUMBER = 2^VREG_ADDR_WIDTH, // Number of vector registers
    parameter VREG_DATA_WIDTH = 32,
    parameter VECTOR_LENGTH = 8 // Number of elements in a vector register
 )(
    input clk,
    input rst_n,
    input [VREG_ADDR_WIDTH - 1:0] vrs1_addr,
    input [VREG_ADDR_WIDTH - 1:0] vrs2_addr,
    input [VREG_ADDR_WIDTH - 1:0] vrd_addr, // reg destination address
    input [VREG_DATA_WIDTH * VECTOR_LENGTH - 1:0] vrd_data, // reg data to write
    input VectorRegWriteEn,
    output reg [VREG_DATA_WIDTH * VECTOR_LENGTH - 1:0] vrs1_data,
    output reg [VREG_DATA_WIDTH * VECTOR_LENGTH - 1:0] vrs2_data
);
    reg [VREG_DATA_WIDTH * VECTOR_LENGTH-1:0] vrf [VREG_NUMBER-1:0];
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            vrs1_data <= 0;
            vrs2_data <= 0;
        end
        else begin
            vrs1_data <= (vrs1_addr == 0) ? 0 : vrf[vrs1_addr];
            vrs2_data <= (vrs2_addr == 0) ? 0 : vrf[vrs2_addr];
        end
    end
    integer i;
    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < VREG_NUMBER; i = i + 1) begin
                vrf[i] <= 0;
            end
        end
        else if (VectorRegWriteEn && vrd_addr != 0) begin
            vrf[vrd_addr] <= vrd_data;
        end
    end
endmodule
