`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 13:49:28
// Design Name: 
// Module Name: Control
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


module Control #(
    parameter INST_WIDTH = 32
)(
    input clk,
    input rst_n,
    input [INST_WIDTH - 1:0] instruction,
    output ScalarRegWriteEn,     // ScalarRF write enable
    output ScalarRegRdSel,       // selects which data write to ScalarRF, 0: imm, 1: ScalarDCM output
    output reg ScalarMemRead,    // ScalarDCM read enable
    output reg ScalarMemWrite,   // ScalarDCM write enable
    output reg VectorRegWriteEn, // VectorRF write enable
    output reg VectorRegRdSel,   // selects which data write to VectorRF, 0: MACResult, 1: VectorDCM output
    output reg VectorMemRead,    // VectorDCM read enable
    output reg VectorMemWrite,   // VectorDCM write enable
    output reg MACScalarSel,     // selects data from ScalarDCM(1) or ScalarRF(0)
    output reg MACIn1MuxSel,     // selects data from VectorDCM(1) or VectorRF(0)
    output reg MACIn2MuxSel      // selects data from VectorDCM(1) or VectorRF(0)
);

    wire [6:0] opcode = instruction[6:0];
    wire [2:0] func3 = instruction[14:12];
    wire [6:0] func7 = instruction[31:25];

    wire is_load   = (opcode == 7'b0000011 && func3 == 3'b010);
    wire is_vload  = (opcode == 7'b0000011 && func3 == 3'b011);
    wire is_store  = (opcode == 7'b0100011 && func3 == 3'b010);
    wire is_vstore = (opcode == 7'b0100011 && func3 == 3'b011);
    wire is_mov    = (opcode == 7'b0110111);
    wire is_mac    = (opcode == 7'b0010011 && func3 == 3'b000 && (func7 == 7'b0000001 || func7 == 7'b0100001));

    reg [INST_WIDTH - 1:0] instruction_q;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            instruction_q <= 0;
        end
        else begin
            instruction_q <= instruction;
        end
    end
    reg [INST_WIDTH - 1:0] instruction_q_q;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            instruction_q_q <= 0;
        end
        else begin
            instruction_q_q <= instruction_q;
        end
    end

    reg RAW_hazard;
    always @(*) begin
        if((instruction_q[6:0] == 7'b0000011 && instruction_q[14:12] == 3'b011) && (instruction[6:0] == 7'b0010011)) begin // previous VLOAD and current VMAC
            if(instruction_q[11:7] == instruction[11:7] || instruction_q[11:7] == instruction[19:15]) begin // VLOAD's vrd == VMAC's vrs1 or vrs2
                RAW_hazard <= 1;
            end
            else begin
                RAW_hazard <= 0;
            end
        end
        else if((instruction_q_q[6:0] == 7'b0000011 && instruction_q_q[14:12] == 3'b010) && (instruction[6:0] == 7'b0010011)) begin // previous 2 cycle LOAD and current VMAC
            if(instruction_q_q[11:7] == instruction[24:20]) begin // LOAD's rd == VMAC's rs1
                RAW_hazard <= 1;
            end
            else begin
                RAW_hazard <= 0;
            end
        end
        else begin
            RAW_hazard <= 0;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            MACScalarSel <= 0;
        end
        else if(RAW_hazard) begin
            MACScalarSel <= 1;
        end
        else begin
            MACScalarSel <= 0;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            MACIn1MuxSel <= 0;
            MACIn2MuxSel <= 0;
        end
        else if(RAW_hazard) begin
            if(instruction_q[11:7] == instruction[11:7]) begin // VLOAD's vrd == VMAC's vrd(vrs2)
                MACIn1MuxSel <= 0;
                MACIn2MuxSel <= 1;
            end
            else begin // VLOAD's vrd == VMAC's vrs1
                MACIn1MuxSel <= 1;
                MACIn2MuxSel <= 0;
            end
        end
        else begin
            MACIn1MuxSel <= 0;
            MACIn2MuxSel <= 0;
        end
    end

    // ScalarRegRdSel logic
        // mov instruction, choose imm immediately
        // other instructions, choose ScalarDCM output after 2 cycles
        assign ScalarRegRdSel = !is_mov;

    // ScalarRegWriteEn logic
        // load instruction, write to ScalarRF after 2 cycles
        // mov instruction, write to ScalarRF immediately
        reg ScalarRegWriteEn_d;
        reg ScalarRegWriteEn_q;
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                ScalarRegWriteEn_d <= 0;
            end 
            else if(is_load) begin
                ScalarRegWriteEn_d <= 1'b1;
            end
            else begin
                ScalarRegWriteEn_d <= 1'b0;
            end
        end
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                ScalarRegWriteEn_q <= 0;
            end 
            else begin
                ScalarRegWriteEn_q <= ScalarRegWriteEn_d;
            end
        end
        assign ScalarRegWriteEn = is_mov | ScalarRegWriteEn_q;

    // ScalarMemRead logic
        // load instruction, read from ScalarDCM after 1 cycle
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                ScalarMemRead <= 0;
            end 
            else if(is_load) begin
                ScalarMemRead <= 1'b1;
            end
            else begin
                ScalarMemRead <= 1'b0;
            end
        end

    // ScalarMemWrite logic
        // store instruction, write to ScalarDCM after 1 cycle
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                ScalarMemWrite <= 0;
            end 
            else if(is_store) begin
                ScalarMemWrite <= 1'b1;
            end
            else begin
                ScalarMemWrite <= 1'b0;
            end
        end

    // VectorRegRdSel logic
        // VLOAD instruction, choose VectorDCM output after 2 cycles
        // MAC instruction, choose MACResult after 2 cycles
        reg VectorRegRdSel_d;
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                VectorRegRdSel_d <= 0;
            end 
            else if(is_vload) begin
                VectorRegRdSel_d <= 1'b1;
            end
            else if(is_mac) begin
                VectorRegRdSel_d <= 1'b0;
            end
            else begin
                VectorRegRdSel_d <= 1'b0;
            end
        end
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                VectorRegRdSel <= 0;
            end 
            else begin
                VectorRegRdSel <= VectorRegRdSel_d;
            end
        end

    // VectorRegWriteEn logic
        // vload instruction, write to VectorRF after 2 cycles
        // MAC instruction, write to VectorRF after 2 cycles
        reg VectorRegWriteEn_d;
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                VectorRegWriteEn_d <= 0;
            end 
            else if(is_vload || is_mac) begin
                VectorRegWriteEn_d <= 1'b1;
            end
            else begin
                VectorRegWriteEn_d <= 1'b0;
            end
        end
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                VectorRegWriteEn <= 0;
            end 
            else begin
                VectorRegWriteEn <= VectorRegWriteEn_d;
            end
        end

    // VectorMemRead logic
        // VLOAD instruction, read from VectorDCM after 1 cycle
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                VectorMemRead <= 0;
            end 
            else if(is_vload) begin
                VectorMemRead <= 1'b1;
            end
            else begin
                VectorMemRead <= 1'b0;
            end
        end

    // VectorMemWrite logic
        // VSTORE instruction, write to VectorDCM after 1 cycle
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                VectorMemWrite <= 0;
            end 
            else if(is_vstore) begin
                VectorMemWrite <= 1'b1;
            end
            else begin
                VectorMemWrite <= 1'b0;
            end
        end

endmodule
