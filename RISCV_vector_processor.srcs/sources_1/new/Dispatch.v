`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:45:12
// Design Name: 
// Module Name: Dispatch
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


module Dispatch #(
    parameter INST_WIDTH = 32
)(
    input clk,
    input rst_n,
    input [INST_WIDTH - 1:0] instruction,
    output reg [31:0] InstImm,
    output reg [4:0]  rs1,
    output reg [4:0]  rs2,
    output reg [4:0]  rd,
    output reg [4:0]  vrs1,
    output reg [4:0]  vrs2,
    output reg [4:0]  vrd,
    output reg mode
);
    // inst set: |       func7        |                             | func3  |           |   opcode    |
    // type       31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
    // MOV       |                            imm                            |    rd     |   0110111   |   imm -> ScalarRF[rd]
    // LOAD      |               imm                 |      rs1     |  010   |    rd     |   0000011   |   ScalarDCM[ScalarRF[rs1] + imm] -> ScalarRF[rd]
    // VLOAD     |               imm                 |      rs1     |  011   |    vrd    |   0000011   |   VectorDCM[ScalarRF[rs1] + imm] -> VectorRF[vrd]
    // VMAC      |  0000001/0100001   |      rs1     |      vrs1    |  000   |    vrd    |   0010011   |   func7==0 ? (Scalar[rs1] * VectorRF[vrs1] + VectorRF[vrd(vrs2)] -> VectorRF[vrd]) : (VectorRF[vrs1] -> VectorRF[vrd])
    // STORE     |     imm[11:5]      |      rs2     |      rs1     |  010   |  imm[4:0] |   0100011   |   ScalarRF[rs2]  -> ScalarDCM[ScalarRF[rs1] + imm]
    // VSTORE    |     imm[11:5]      |      vrs1    |      rs1     |  011   |  imm[4:0] |   0100011   |   VectorRF[vrs1] -> VectorDCM[ScalarRF[rs1] + imm]
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] func3  = instruction[14:12];
    wire [6:0] func7  = instruction[31:25];
    always @(*) begin  // dispatch comb logic
        if(opcode == 7'b0000011 && func3 == 3'b010) begin    // LOAD
            InstImm <= {20'b0, instruction[31:20]};
            rs1 <= instruction[19:15];
            rs2 <= 5'b0; // Not used in LOAD
            vrs1 <= 5'b0; // Not used in LOAD
            vrs2 <= 5'b0; // Not used in LOAD
        end
        else if(opcode == 7'b0000011 && func3 == 3'b011) begin    // VLOAD
            InstImm <= {20'b0, instruction[31:20]};
            rs1 <= instruction[19:15];
            rs2 <= 5'b0; // Not used in VLOAD
            vrs1 <= 5'b0; // Not used in VLOAD
            vrs2 <= 5'b0; // Not used in VLOAD
        end
        else if(opcode == 7'b0100011 && func3 == 3'b010) begin   // STORE
            InstImm <= {20'b0, instruction[31:25], instruction[11:7]};
            rs1 <= instruction[19:15];
            rs2 <= instruction[24:20];
            vrs1 <= 5'b0; // Not used in STORE
            vrs2 <= 5'b0; // Not used in STORE
        end
        else if(opcode == 7'b0100011 && func3 == 3'b011) begin    // VSTORE
            InstImm <= {20'b0, instruction[31:25], instruction[11:7]};
            rs1 <= instruction[19:15];
            rs2 <= 5'b0; // Not used in VSTORE
            vrs1 <= instruction[24:20];
            vrs2 <= 5'b0; // Not used in VSTORE
        end
        else if(opcode == 7'b0110111) begin    // MOV
            InstImm <= {12'b0, instruction[31:12]}; // Assuming imm is the upper part of the instruction
            rs1 <= 5'b0; // Not used in MOV
            rs2 <= 5'b0; // Not used in MOV
            vrs1 <= 5'b0; // Not used in MOV
            vrs2 <= 5'b0; // Not used in MOV
        end
        else if(opcode == 7'b0010011 && func3 == 3'b000) begin    // VMAC
            InstImm <= 32'b0; // Not used in VMAC
            rs1 <= instruction[24:20];
            rs2 <= 5'b0; // Not used in VMAC
            vrs1 <= instruction[19:15];
            vrs2 <= instruction[11:7];  // vrd
        end
        else begin // Default case, no valid instruction
            InstImm <= 32'b0;
            rs1 <= 5'b0;
            rs2 <= 5'b0;
            vrs1 <= 5'b0;
            vrs2 <= 5'b0;
        end
    end

    // mode logic
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            mode <= 1'b1;
        end
        else if(opcode == 7'b0010011 && func3 == 3'b000) begin
            mode <= func7[5];
        end
        else begin
            mode <= 1'b1;
        end
    end

    // rd logic
        // MOV: rd arives immediately
        // LOAD: rd arrives after 2 cycles
        reg [4:0] rd_d, rd_q;
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                rd_d <= 5'b0;
            end
            else if(opcode == 7'b0000011 && func3 == 3'b010) begin
                rd_d <= instruction[11:7];
            end
            else begin
                rd_d <= 5'b0;
            end
        end
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                rd_q <= 5'b0;
            end
            else begin
                rd_q <= rd_d;
            end
        end
        always @(*) begin
            if(rd_q != 'b0) begin
                rd <= rd_q;
            end
            else if(opcode == 7'b0110111) begin
                rd <= instruction[11:7];
            end
            else begin
                rd <= 5'b0;
            end
        end

    // vrd logic
        // VMAC & VLOAD: vrd arrives after 2 cycles
        reg [4:0] vrd_d;
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                vrd_d <= 5'b0;
            end
            else if((opcode == 7'b0000011 && func3 == 3'b011) || (opcode == 7'b0010011 && func3 == 3'b000)) begin
                vrd_d <= instruction[11:7];
            end
            else begin
                vrd_d <= 5'b0;
            end
        end
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                vrd <= 5'b0;
            end
            else begin
                vrd <= vrd_d;
            end
        end

endmodule
