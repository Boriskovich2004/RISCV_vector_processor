`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:45:12
// Design Name: 
// Module Name: ICM
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

// Instruction Cache Module (ICM)
// This module is responsible for managing the instruction cache in the RISC-V vector processor.
module ICM #(
    parameter ADDR_WIDTH = 10,             // addr width
    parameter INST_WIDTH = 32,             // instruction width
    parameter INIT_FILE  = "D:/Vivado Workplace/RISCV_vector_processor/RISCV_vector_processor.srcs/sim_1/new/instruction.vmem"   // instruction memory initialization file
)(
    input wire clk,
    input write,
    input wire [ADDR_WIDTH-1:0] addr,      // read/write address
    input [INST_WIDTH-1:0] instruction_in,      // input instruction for write operation [31:0]
    output reg [INST_WIDTH-1:0] instr      // output instruction
);

    // Memory declaration
    reg [INST_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];

    // Initialize memory from file
    initial begin
        $display("Loading instruction memory from file: %s", INIT_FILE);
        $readmemb(INIT_FILE, memory);  // 
    end

    // Synchronous read
    always @(posedge clk) begin
        if(!write) begin
            instr <= memory[addr];
        end
        else begin
            instr <= 0;
        end
    end

    always @(posedge clk) begin
        if(write) begin
            memory[addr] <= instruction_in;
        end
    end

endmodule
