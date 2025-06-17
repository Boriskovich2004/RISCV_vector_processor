`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:45:12
// Design Name: 
// Module Name: MAC
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

// MAC Module (Multiply-Accumulate)
// This module implements a MAC operation for a RISC-V vector processor.
// It takes a scalar and two vectors, performs the operation: out[i] = scalar * vec_a[i] + vec_b[i]
module MAC #(
    parameter DATA_WIDTH = 32,
    parameter VECTOR_LENGTH = 8
)(
    input wire clk,
    input wire rst_n,
    input wire mode, // 1: reset, 0: mac

    input wire [DATA_WIDTH-1:0] scalar,
    input wire [DATA_WIDTH * VECTOR_LENGTH - 1:0] vec_a,
    input wire [DATA_WIDTH * VECTOR_LENGTH - 1:0] vec_b,

    output reg [DATA_WIDTH * VECTOR_LENGTH - 1:0] out
);

    integer i;

    // MAC operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out <= 0;
        end 
        else begin
            if(!rst_n) begin
                out <= 0;
            end
            else if (mode == 1'b0) begin
                // scalar * vec_a[index] + vec_b[index]
                for (i = 0; i < VECTOR_LENGTH; i = i + 1) begin
                    out[i * DATA_WIDTH +: DATA_WIDTH] <= scalar * vec_a[i * DATA_WIDTH +: DATA_WIDTH] + vec_b[i * DATA_WIDTH +: DATA_WIDTH];
                end
            end
            else if (mode == 1'b1) begin
                out <= vec_a; // Reset operation
            end
            else begin
                out <= out; // Hold output when not busy
            end
        end
    end

endmodule
