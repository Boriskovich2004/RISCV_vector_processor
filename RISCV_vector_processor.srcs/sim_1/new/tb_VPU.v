`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 20:33:07
// Design Name: 
// Module Name: tb_VPU
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


module tb_VPU();
    parameter ICM_ADDR_WIDTH = 10             ; // Address width for instruction cache
    parameter ICM_NUMBER = 1<<ICM_ADDR_WIDTH  ; // Number of instruction cache lines
    parameter INST_WIDTH = 32                ; // Instruction data width
    // Scalar
    parameter REG_ADDR_WIDTH = 5             ; // Address width for scalar registers
    parameter DCM_ADDR_WIDTH = 10            ; // Address width for scalar DCM
    parameter REG_NUMBER = 1<<REG_ADDR_WIDTH  ; // Number of scalar registers
    parameter DCM_NUMBER = 1<<DCM_ADDR_WIDTH  ; // Number of scalar data cache lines
    parameter DATA_WIDTH = 32                ; // Data width for scalar registers
    //Vector
    parameter VREG_ADDR_WIDTH = 5            ; // Address width for vector registers
    parameter VDCM_ADDR_WIDTH = 10           ; // Address width for vector DCM
    parameter VREG_NUMBER = 1<<VREG_ADDR_WIDTH; // Number of vector registers
    parameter VDCM_NUMBER = 1<<VDCM_ADDR_WIDTH; // Number of vector data cache lines
    parameter VREG_DATA_WIDTH = 32           ; // Data width for vector registers
    parameter VECTOR_LENGTH = 8              ; // Number of elements in a vector register
    
    reg clk;
    reg rst_n;

    // input
    reg                                          write_mode;
    reg  [ICM_ADDR_WIDTH                  - 1:0] icm_wr_addr;
    reg  [DCM_ADDR_WIDTH                  - 1:0] scalar_wr_addr;
    reg  [VDCM_ADDR_WIDTH                 - 1:0] vector_wr_addr;
    reg  [INST_WIDTH                      - 1:0] inst_data;
    reg  [DATA_WIDTH                      - 1:0] scalar_wr_data;
    reg  [VREG_DATA_WIDTH * VECTOR_LENGTH - 1:0] vector_wr_data;
    reg                                          start;
    reg                                          read_mode;
    reg  [DCM_ADDR_WIDTH                  - 1:0] scalar_rd_addr;
    reg  [VDCM_ADDR_WIDTH                 - 1:0] vector_rd_addr;
    // output
    wire [DATA_WIDTH                      - 1:0] ScalarReadData;
    wire [VREG_DATA_WIDTH * VECTOR_LENGTH - 1:0] VectorReadData;

    VPU #(
        .ICM_ADDR_WIDTH(ICM_ADDR_WIDTH),
        .ICM_NUMBER(ICM_NUMBER),
        .INST_WIDTH(INST_WIDTH),
        .REG_ADDR_WIDTH(REG_ADDR_WIDTH),
        .DCM_ADDR_WIDTH(DCM_ADDR_WIDTH),
        .REG_NUMBER(REG_NUMBER),
        .DCM_NUMBER(DCM_NUMBER),
        .DATA_WIDTH(DATA_WIDTH),
        .VREG_ADDR_WIDTH(VREG_ADDR_WIDTH),
        .VDCM_ADDR_WIDTH(VDCM_ADDR_WIDTH),
        .VREG_NUMBER(VREG_NUMBER),
        .VDCM_NUMBER(VDCM_NUMBER),
        .VREG_DATA_WIDTH(VREG_DATA_WIDTH),
        .VECTOR_LENGTH(VECTOR_LENGTH)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .write_mode(write_mode),
        .icm_wr_addr(icm_wr_addr),
        .scalar_wr_addr(scalar_wr_addr),
        .vector_wr_addr(vector_wr_addr),
        .inst_data(inst_data),
        .scalar_wr_data(scalar_wr_data),
        .vector_wr_data(vector_wr_data),
        .start(start),
        .read_mode(read_mode),
        .scalar_rd_addr(scalar_rd_addr),
        .vector_rd_addr(vector_rd_addr),
        .ScalarReadData(ScalarReadData),
        .VectorReadData(VectorReadData)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // initialization
        rst_n = 0;

        write_mode     = 'b0;
        icm_wr_addr    = 'b0;
        scalar_wr_addr = 'b0;
        vector_wr_addr = 'b0;
        inst_data      = 'b0;
        scalar_wr_data = 'b0;
        vector_wr_data = 'b0;
        start          = 'b0;
        read_mode      = 'b0;
        scalar_rd_addr = 'b0;
        vector_rd_addr = 'b0;

        #20;
        rst_n = 1;
        // input instructions, scalar data, vector data
        @(negedge clk);
        write_mode = 1;
        start = 0;
        read_mode = 0;
            // input scalar data
                icm_wr_addr = 'd0;
                vector_wr_addr = 'd0;
                inst_data = 'b0;
                vector_wr_data = 'b0;

                scalar_wr_addr = 'd0;
                scalar_wr_data = 32'h0000_0001;
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'h0000_0002;
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'h0000_0003;
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'h0000_0004;
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'h0000_0005;
                @(negedge clk);
            // input vector data
                icm_wr_addr = 'd0;
                scalar_wr_addr = scalar_wr_addr + 1;
                inst_data = 'b0;
                scalar_wr_data = 'b0;

                vector_wr_addr = 'd0;
                vector_wr_data = {32'h0000_0001, 32'h0000_0002, 32'h0000_0003, 32'h0000_0004,
                                  32'h0000_0005, 32'h0000_0006, 32'h0000_0007, 32'h0000_0008};
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'h0000_0009, 32'h0000_000a, 32'h0000_000b, 32'h0000_000c, 
                                  32'h0000_000d, 32'h0000_000e, 32'h0000_000f, 32'h0000_0010};
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'h0000_0011, 32'h0000_0012, 32'h0000_0013, 32'h0000_0014, 
                                  32'h0000_0015, 32'h0000_0016, 32'h0000_0017, 32'h0000_0018};
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'h0000_0019, 32'h0000_001a, 32'h0000_001b, 32'h0000_001c, 
                                  32'h0000_001d, 32'h0000_001e, 32'h0000_001f, 32'h0000_0020};
                @(negedge clk);
            // input instructions
                scalar_wr_addr = scalar_wr_addr;
                vector_wr_addr = vector_wr_addr + 1;
                scalar_wr_data = 'b0;
                vector_wr_data = 'b0;

                icm_wr_addr    = 'd0;
                inst_data = 32'b0000_0000_0000_0000_0000_00001_0110111; // MOV R1, 0x0                  R1 = 0
                @(negedge clk);
                icm_wr_addr    = icm_wr_addr + 1;
                inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = DCM[0] = 1
                @(negedge clk);
                icm_wr_addr    = icm_wr_addr + 1;
                inst_data = 32'b0000_0000_0000_00001_011_00010_0000011; // VLOAD VR2 R1 0x0             VR2 = VDCM[0] = [1, 2, 3, 4, 5, 6, 7, 8]
                @(negedge clk);
                icm_wr_addr    = icm_wr_addr + 1;
                inst_data = 32'b0100001_00010_00010_000_00100_0010011; // VMAC VR4 R2 VR2 1(reset)      VR4 = [1, 2, 3, 4, 5, 6, 7, 8]
                @(negedge clk);
                icm_wr_addr    = icm_wr_addr + 1;
                inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = DCM[1] = 2
                @(negedge clk);
                icm_wr_addr    = icm_wr_addr + 1;
                inst_data = 32'b0000_0000_0001_00001_011_00010_0000011; // VLOAD VR2 R1 0x1             VR2 = VDCM[1] = [9, a, b, c, d, e, f, 10]
                @(negedge clk);
                icm_wr_addr    = icm_wr_addr + 1;
                inst_data = 32'b0000001_00010_00010_000_00100_0010011; // VMAC VR4 R2 VR2 0(MAC)        VR4 = R2*VR2 + VR4 = [13, 16, 19, 22, 25, 28, 31, 34]
                @(negedge clk);
                icm_wr_addr    = icm_wr_addr + 1;
                inst_data = 32'b0000_0000_0000_0000_0011_00001_0110111; // MOV R1, 0x3  
                @(negedge clk);
                icm_wr_addr    = icm_wr_addr + 1;
                inst_data = 32'b0000000_00100_00001_011_00000_0100011; // VSTORE R1 VR4 0x0             
                @(negedge clk);

        // start execution
        write_mode = 0;
        start = 1;
        read_mode = 0;

        icm_wr_addr    = 'd0;
        scalar_wr_addr = 'd0;
        vector_wr_addr = 'd0;
        inst_data = 32'b0000_0000_0000_0000_0000_00000_0000000; // MOV R2, 0x3
        scalar_wr_data = 32'h0000_0000;
        vector_wr_data = {32'h0000_0000, 32'h0000_0000, 32'h0000_0000, 32'h0000_0000, 
                          32'h0000_0000, 32'h0000_0000, 32'h0000_0000, 32'h0000_0000};
        repeat(12) @(negedge clk);

        // read data
        @(negedge clk);
        write_mode = 0;
        start = 0;
        read_mode = 1;
        scalar_rd_addr = 'd0;
        vector_rd_addr = 'd0;
        @(negedge clk);
        scalar_rd_addr = 'd1;
        vector_rd_addr = 'd1;
        $display("Read SDCM Data: %h", ScalarReadData);
        $display("Read VDCM Data: %h", VectorReadData);
        @(negedge clk);
        scalar_rd_addr = 'd2;
        vector_rd_addr = 'd2;
        $display("Read SDCM Data: %h", ScalarReadData);
        $display("Read VDCM Data: %h", VectorReadData);

        #20;
        $finish;
    end

endmodule
