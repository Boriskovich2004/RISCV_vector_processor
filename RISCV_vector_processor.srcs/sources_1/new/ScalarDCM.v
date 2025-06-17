`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:45:12
// Design Name: 
// Module Name: ScalarDCM
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

// Scalar Data Cache Module (ScalarDCM)
module ScalarDCM #(
    parameter ADDR_WIDTH = 10,              // memory address width
    parameter DATA_WIDTH = 32,              // data width
    parameter INIT_FILE  = "D:/Vivado Workplace/RISCV_vector_processor/RISCV_vector_processor.srcs/sim_1/new/ScalarDCM.vmem"
)(
    input wire clk,
    // input wire rst_n,

    input wire ScalarMemRead,
    input wire ScalarMemWrite,

    input wire [ADDR_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0] write_data,
    output reg [DATA_WIDTH-1:0] read_data
);

    reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];

    initial begin
        if (INIT_FILE != "") begin
            $display("Loading data memory from file: %s", INIT_FILE);
            $readmemh(INIT_FILE, memory);
        end
    end

    always @(posedge clk) begin
        if (ScalarMemWrite) begin
            memory[addr] <= write_data;
        end
    end
    always @(posedge clk) begin
        if (ScalarMemRead) begin
            read_data <= memory[addr];
        end
        else begin
            read_data <= 0;
        end
    end

endmodule