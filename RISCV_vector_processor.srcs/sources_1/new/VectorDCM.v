`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:45:12
// Design Name: 
// Module Name: VectorDCM
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

// Vector Data Cache Module (VectorDCM)
// This module is responsible for managing the vector data cache in the RISC-V vector processor.
// It supports reading and writing to vector registers, which are used for vector data storing and reading.
module VectorDCM #(
    parameter ADDR_WIDTH = 10,              // memory address width
    parameter DATA_WIDTH = 32,              // data width
    parameter VECTOR_LENGTH = 8,            // number of elements in a vector register
    parameter INIT_FILE  = "D:/Vivado Workplace/RISCV_vector_processor/RISCV_vector_processor.srcs/sim_1/new/VectorDCM.vmem"
)(
    input wire clk,
    // input wire rst_n,

    input wire VectorMemRead,
    input wire VectorMemWrite,

    input wire [ADDR_WIDTH-1:0] addr,
    input wire [DATA_WIDTH * VECTOR_LENGTH - 1:0] write_data,
    output reg [DATA_WIDTH * VECTOR_LENGTH - 1:0] read_data
);

    reg [DATA_WIDTH * VECTOR_LENGTH - 1:0] memory [0:(1<<ADDR_WIDTH)-1];

    initial begin
        if (INIT_FILE != "") begin
            $display("Loading data memory from file: %s", INIT_FILE);
            $readmemh(INIT_FILE, memory);
        end
    end

    always @(posedge clk) begin
        if (VectorMemWrite) begin
            memory[addr] <= write_data;
        end
    end
    always @(posedge clk) begin
        if (VectorMemRead) begin
            read_data <= memory[addr];
        end
        else begin
            read_data <= 0;
        end
    end

endmodule