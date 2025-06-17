`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:45:12
// Design Name: 
// Module Name: ScalarRF
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

// Scalar Register File Module (ScalarRF)
// This module implements a scalar register file for a RISC-V vector processor.
// It supports reading from two source registers and writing to a destination register.
module ScalarRF#(
    parameter REG_ADDR_WIDTH = 5,
    parameter REG_NUMBER = 2^REG_ADDR_WIDTH, // Number of scalar registers
    parameter REG_DATA_WIDTH = 32
 )(
    input clk,
    input rst_n,
    input [REG_ADDR_WIDTH-1:0] rs1_addr,
    input [REG_ADDR_WIDTH-1:0] rs2_addr,
    input [REG_ADDR_WIDTH-1:0] rd_addr, // reg destination address
    input [REG_DATA_WIDTH-1:0] rd_data, // reg data to write
    input ScalarRegWriteEn,
    output reg [REG_DATA_WIDTH-1:0] rs1_data,
    output reg [REG_DATA_WIDTH-1:0] rs2_data
);
    reg [REG_DATA_WIDTH-1:0] rf [REG_NUMBER-1:0];
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rs1_data <= 0;
            rs2_data <= 0;
        end
        else begin
            rs1_data <= (rs1_addr == 0) ? 0 : rf[rs1_addr];
            rs2_data <= (rs2_addr == 0) ? 0 : rf[rs2_addr];
        end
    end
    integer i;
    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < REG_NUMBER; i = i + 1) begin
                rf[i] <= 0;
            end
        end
        else if (ScalarRegWriteEn && rd_addr != 0) begin
            rf[rd_addr] <= rd_data;
        end
    end
endmodule