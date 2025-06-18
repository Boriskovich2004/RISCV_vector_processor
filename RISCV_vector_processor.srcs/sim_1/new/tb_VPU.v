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
                // matrix1
                scalar_wr_addr = 'd0;
                scalar_wr_data = 32'd4294967227; // -69
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd95;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd73;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967241;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd17;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd32;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967280;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd24;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd100;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967203;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd56;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd41;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd47;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd83;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967227;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd77;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967213;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967270;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967218;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967282;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967269;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd75;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd1;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967242;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd62;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd88;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd13;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967278;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd39;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd0;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd97;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967284;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd85;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd58;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967216;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd44;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd53;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967197;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd66;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967259;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd7;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd99;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd25;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967235;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd18;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd55;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967204;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967226;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd49;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967262;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd81;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd60;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967249;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd28;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967211;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967294;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd100;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967237;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd36;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967219;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd72;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd11;                
                @(negedge clk);
                scalar_wr_addr = scalar_wr_addr + 1;
                scalar_wr_data = 32'd4294967233;
                @(negedge clk);
            // input vector data
                icm_wr_addr = 'd0;
                scalar_wr_addr = scalar_wr_addr + 1;
                inst_data = 'b0;
                scalar_wr_data = 'b0;
                // matrix2
                vector_wr_addr = 'd0;
                vector_wr_data = {32'd4294967208, 32'd14,         32'd67,         32'd4294967197, 32'd53,         32'd80,         32'd4294967255, 32'd22        };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd4294967289, 32'd91,         32'd4294967234, 32'd38,         32'd100,        32'd4294967240, 32'd19,         32'd4294967212};
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd4294967261, 32'd60,         32'd27,         32'd4294967206, 32'd45,         32'd8,          32'd4294967266, 32'd73        };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd59,         32'd4294967283, 32'd92,         32'd4294967221, 32'd31,         32'd4294967228, 32'd85,         32'd4294967272};
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd4294967200, 32'd70,         32'd2,          32'd99,         32'd4294967246, 32'd63,         32'd4294967279, 32'd44        };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd81,         32'd4294967268, 32'd54,         32'd4294967235, 32'd12,         32'd97,         32'd4294967217, 32'd6         };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd4294967238, 32'd35,         32'd100,        32'd4294967209, 32'd29,         32'd4294967264, 32'd76,         32'd4294967287};
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd40,         32'd4294967201, 32'd21,         32'd65,         32'd4294967223, 32'd58,         32'd4294967284, 32'd90        };
                @(negedge clk);
                // matrix3
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd81,         32'd4294967252, 32'd56,         32'd4294967206, 32'd13,         32'd67,         32'd4294967258, 32'd72        };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd4294967197, 32'd35,         32'd4294967223, 32'd40,         32'd86,         32'd4294967231, 32'd17,         32'd33        };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd27,         32'd4294967208, 32'd62,         32'd4294967255, 32'd19,         32'd77,         32'd4294967240, 32'd84        };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd4294967283, 32'd95,         32'd4294967274, 32'd59,         32'd4294967216, 32'd36,         32'd48,         32'd4294967225};
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd61,         32'd4294967272, 32'd79,         32'd4294967204, 32'd55,         32'd12,         32'd4294967258, 32'd70        };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd4294967249, 32'd81,         32'd4294967230, 32'd28,         32'd4294967261, 32'd99,         32'd4294967275, 32'd10        };
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd53,         32'd4294967236, 32'd44,         32'd4294967211, 32'd72,         32'd4294967278, 32'd25,         32'd4294967199};
                @(negedge clk);
                vector_wr_addr = vector_wr_addr + 1;
                vector_wr_data = {32'd4294967265, 32'd67,         32'd4294967247, 32'd90,         32'd4294967220, 32'd38,         32'd63,         32'd4294967267};
                @(negedge clk);
            // input instructions
                scalar_wr_addr = scalar_wr_addr;
                vector_wr_addr = vector_wr_addr + 1;
                scalar_wr_data = 'b0;
                vector_wr_data = 'b0;
                // line1(29 instructions)
                    icm_wr_addr    = 0;
                    inst_data = 32'b0000_0000_0000_00000000_00001_0110111; // MOV R1, 0x0                  R1 = 0x0
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_1000_00000_011_00010_0000011; // VLOAD VR2 R0 0x8             VR2 = Matrix3[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = Matrix_1[0][0]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00000_011_00010_0000011; // VLOAD VR2 R0 0x0             VR2 = Matrix2[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = Matrix_1[0][1]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00000_011_00010_0000011; // VLOAD VR2 R0 0x1             VR2 = Matrix2[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00001_010_00010_0000011; // LOAD R2, R1, 0x2             R2 = Matrix_1[0][2]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00000_011_00010_0000011; // VLOAD VR2 R0 0x2             VR2 = Matrix2[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00001_010_00010_0000011; // LOAD R2, R1, 0x3             R2 = Matrix_1[0][3]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00000_011_00010_0000011; // VLOAD VR2 R0 0x3             VR2 = Matrix2[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00001_010_00010_0000011; // LOAD R2, R1, 0x4             R2 = Matrix_1[0][4]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00000_011_00010_0000011; // VLOAD VR2 R0 0x4             VR2 = Matrix2[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00001_010_00010_0000011; // LOAD R2, R1, 0x5             R2 = Matrix_1[0][5]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00000_011_00010_0000011; // VLOAD VR2 R0 0x5             VR2 = Matrix2[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00001_010_00010_0000011; // LOAD R2, R1, 0x6             R2 = Matrix_1[0][6]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00000_011_00010_0000011; // VLOAD VR2 R0 0x6             VR2 = Matrix2[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00001_010_00010_0000011; // LOAD R2, R1, 0x7             R2 = Matrix_1[0][7]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00000_011_00010_0000011; // VLOAD VR2 R0 0x7             VR2 = Matrix2[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_0001_0000_00011_0110111; // MOV  R3 0x10                  R3 = 16
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[16]
                    @(negedge clk);
                // line2(29 instructions)
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001000_00001_0110111; // MOV R1, 0x8                  R1 = 0x8
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_1001_00000_011_00010_0000011; // VLOAD VR2 R0 0x9             VR2 = Matrix3[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = Matrix_1[1][0]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00000_011_00010_0000011; // VLOAD VR2 R0 0x0             VR2 = Matrix2[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = Matrix_1[1][1]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00000_011_00010_0000011; // VLOAD VR2 R0 0x1             VR2 = Matrix2[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00001_010_00010_0000011; // LOAD R2, R1, 0x2             R2 = Matrix_1[1][2]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00000_011_00010_0000011; // VLOAD VR2 R0 0x2             VR2 = Matrix2[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00001_010_00010_0000011; // LOAD R2, R1, 0x3             R2 = Matrix_1[1][3]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00000_011_00010_0000011; // VLOAD VR2 R0 0x3             VR2 = Matrix2[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00001_010_00010_0000011; // LOAD R2, R1, 0x4             R2 = Matrix_1[1][4]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00000_011_00010_0000011; // VLOAD VR2 R0 0x4             VR2 = Matrix2[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00001_010_00010_0000011; // LOAD R2, R1, 0x5             R2 = Matrix_1[1][5]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00000_011_00010_0000011; // VLOAD VR2 R0 0x5             VR2 = Matrix2[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00001_010_00010_0000011; // LOAD R2, R1, 0x6             R2 = Matrix_1[1][6]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00000_011_00010_0000011; // VLOAD VR2 R0 0x6             VR2 = Matrix2[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00001_010_00010_0000011; // LOAD R2, R1, 0x7             R2 = Matrix_1[1][7]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00000_011_00010_0000011; // VLOAD VR2 R0 0x7             VR2 = Matrix2[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_0001_0001_00011_0110111; // MOV  R3 0x11                  R3 = 17
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[17]
                    @(negedge clk);
                // line3(29 instructions)
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00010000_00001_0110111; // MOV R1, 0x10                  R1 = 0x10
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_1010_00000_011_00010_0000011; // VLOAD VR2 R0 0xa             VR2 = Matrix3[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = Matrix_1[2][0]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00000_011_00010_0000011; // VLOAD VR2 R0 0x0             VR2 = Matrix2[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = Matrix_1[2][1]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00000_011_00010_0000011; // VLOAD VR2 R0 0x1             VR2 = Matrix2[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00001_010_00010_0000011; // LOAD R2, R1, 0x2             R2 = Matrix_1[2][2]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00000_011_00010_0000011; // VLOAD VR2 R0 0x2             VR2 = Matrix2[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00001_010_00010_0000011; // LOAD R2, R1, 0x3             R2 = Matrix_1[2][3]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00000_011_00010_0000011; // VLOAD VR2 R0 0x3             VR2 = Matrix2[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00001_010_00010_0000011; // LOAD R2, R1, 0x4             R2 = Matrix_1[2][4]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00000_011_00010_0000011; // VLOAD VR2 R0 0x4             VR2 = Matrix2[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00001_010_00010_0000011; // LOAD R2, R1, 0x5             R2 = Matrix_1[2][5]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00000_011_00010_0000011; // VLOAD VR2 R0 0x5             VR2 = Matrix2[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00001_010_00010_0000011; // LOAD R2, R1, 0x6             R2 = Matrix_1[2][6]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00000_011_00010_0000011; // VLOAD VR2 R0 0x6             VR2 = Matrix2[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00001_010_00010_0000011; // LOAD R2, R1, 0x7             R2 = Matrix_1[2][7]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00000_011_00010_0000011; // VLOAD VR2 R0 0x7             VR2 = Matrix2[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_0001_0010_00011_0110111; // MOV  R3 0x12                  R3 = 18
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[18]
                    @(negedge clk);
                // line4(29 instructions)
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00011000_00001_0110111; // MOV R1, 0x18                  R1 = 0x18
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_1011_00000_011_00010_0000011; // VLOAD VR2 R0 0xb             VR2 = Matrix3[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = Matrix_1[3][0]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00000_011_00010_0000011; // VLOAD VR2 R0 0x0             VR2 = Matrix2[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = Matrix_1[3][1]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00000_011_00010_0000011; // VLOAD VR2 R0 0x1             VR2 = Matrix2[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00001_010_00010_0000011; // LOAD R2, R1, 0x2             R2 = Matrix_1[3][2]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00000_011_00010_0000011; // VLOAD VR2 R0 0x2             VR2 = Matrix2[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00001_010_00010_0000011; // LOAD R2, R1, 0x3             R2 = Matrix_1[3][3]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00000_011_00010_0000011; // VLOAD VR2 R0 0x3             VR2 = Matrix2[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00001_010_00010_0000011; // LOAD R2, R1, 0x4             R2 = Matrix_1[3][4]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00000_011_00010_0000011; // VLOAD VR2 R0 0x4             VR2 = Matrix2[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00001_010_00010_0000011; // LOAD R2, R1, 0x5             R2 = Matrix_1[3][5]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00000_011_00010_0000011; // VLOAD VR2 R0 0x5             VR2 = Matrix2[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00001_010_00010_0000011; // LOAD R2, R1, 0x6             R2 = Matrix_1[3][6]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00000_011_00010_0000011; // VLOAD VR2 R0 0x6             VR2 = Matrix2[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00001_010_00010_0000011; // LOAD R2, R1, 0x7             R2 = Matrix_1[3][7]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00000_011_00010_0000011; // VLOAD VR2 R0 0x7             VR2 = Matrix2[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_0001_0011_00011_0110111; // MOV  R3 0x13                  R3 = 19
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[19]
                    @(negedge clk);
                // line5(29 instructions)
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00100000_00001_0110111; // MOV R1, 0x20                  R1 = 0x20
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_1100_00000_011_00010_0000011; // VLOAD VR2 R0 0xc             VR2 = Matrix3[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = Matrix_1[4][0]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00000_011_00010_0000011; // VLOAD VR2 R0 0x0             VR2 = Matrix2[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = Matrix_1[4][1]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00000_011_00010_0000011; // VLOAD VR2 R0 0x1             VR2 = Matrix2[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00001_010_00010_0000011; // LOAD R2, R1, 0x2             R2 = Matrix_1[4][2]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00000_011_00010_0000011; // VLOAD VR2 R0 0x2             VR2 = Matrix2[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00001_010_00010_0000011; // LOAD R2, R1, 0x3             R2 = Matrix_1[4][3]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00000_011_00010_0000011; // VLOAD VR2 R0 0x3             VR2 = Matrix2[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00001_010_00010_0000011; // LOAD R2, R1, 0x4             R2 = Matrix_1[4][4]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00000_011_00010_0000011; // VLOAD VR2 R0 0x4             VR2 = Matrix2[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00001_010_00010_0000011; // LOAD R2, R1, 0x5             R2 = Matrix_1[4][5]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00000_011_00010_0000011; // VLOAD VR2 R0 0x5             VR2 = Matrix2[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00001_010_00010_0000011; // LOAD R2, R1, 0x6             R2 = Matrix_1[4][6]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00000_011_00010_0000011; // VLOAD VR2 R0 0x6             VR2 = Matrix2[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00001_010_00010_0000011; // LOAD R2, R1, 0x7             R2 = Matrix_1[4][7]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00000_011_00010_0000011; // VLOAD VR2 R0 0x7             VR2 = Matrix2[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_0001_0100_00011_0110111; // MOV  R3 0x14                  R3 = 20
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[20]
                    @(negedge clk);
                // line6(29 instructions)
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00101000_00001_0110111; // MOV R1, 0x28                  R1 = 0x28
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_1101_00000_011_00010_0000011; // VLOAD VR2 R0 0xd             VR2 = Matrix3[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = Matrix_1[5][0]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00000_011_00010_0000011; // VLOAD VR2 R0 0x0             VR2 = Matrix2[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = Matrix_1[5][1]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00000_011_00010_0000011; // VLOAD VR2 R0 0x1             VR2 = Matrix2[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00001_010_00010_0000011; // LOAD R2, R1, 0x2             R2 = Matrix_1[5][2]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00000_011_00010_0000011; // VLOAD VR2 R0 0x2             VR2 = Matrix2[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00001_010_00010_0000011; // LOAD R2, R1, 0x3             R2 = Matrix_1[5][3]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00000_011_00010_0000011; // VLOAD VR2 R0 0x3             VR2 = Matrix2[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00001_010_00010_0000011; // LOAD R2, R1, 0x4             R2 = Matrix_1[5][4]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00000_011_00010_0000011; // VLOAD VR2 R0 0x4             VR2 = Matrix2[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00001_010_00010_0000011; // LOAD R2, R1, 0x5             R2 = Matrix_1[5][5]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00000_011_00010_0000011; // VLOAD VR2 R0 0x5             VR2 = Matrix2[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00001_010_00010_0000011; // LOAD R2, R1, 0x6             R2 = Matrix_1[5][6]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00000_011_00010_0000011; // VLOAD VR2 R0 0x6             VR2 = Matrix2[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00001_010_00010_0000011; // LOAD R2, R1, 0x7             R2 = Matrix_1[5][7]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00000_011_00010_0000011; // VLOAD VR2 R0 0x7             VR2 = Matrix2[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_0001_0101_00011_0110111; // MOV  R3 0x15                  R3 = 21
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[21]
                    @(negedge clk);
                // line7(29 instructions)
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00110000_00001_0110111; // MOV R1, 0x30                  R1 = 0x30
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_1110_00000_011_00010_0000011; // VLOAD VR2 R0 0xe             VR2 = Matrix3[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = Matrix_1[6][0]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00000_011_00010_0000011; // VLOAD VR2 R0 0x0             VR2 = Matrix2[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = Matrix_1[6][1]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00000_011_00010_0000011; // VLOAD VR2 R0 0x1             VR2 = Matrix2[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00001_010_00010_0000011; // LOAD R2, R1, 0x2             R2 = Matrix_1[6][2]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00000_011_00010_0000011; // VLOAD VR2 R0 0x2             VR2 = Matrix2[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00001_010_00010_0000011; // LOAD R2, R1, 0x3             R2 = Matrix_1[6][3]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00000_011_00010_0000011; // VLOAD VR2 R0 0x3             VR2 = Matrix2[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00001_010_00010_0000011; // LOAD R2, R1, 0x4             R2 = Matrix_1[6][4]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00000_011_00010_0000011; // VLOAD VR2 R0 0x4             VR2 = Matrix2[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00001_010_00010_0000011; // LOAD R2, R1, 0x5             R2 = Matrix_1[6][5]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00000_011_00010_0000011; // VLOAD VR2 R0 0x5             VR2 = Matrix2[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00001_010_00010_0000011; // LOAD R2, R1, 0x6             R2 = Matrix_1[6][6]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00000_011_00010_0000011; // VLOAD VR2 R0 0x6             VR2 = Matrix2[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00001_010_00010_0000011; // LOAD R2, R1, 0x7             R2 = Matrix_1[6][7]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00000_011_00010_0000011; // VLOAD VR2 R0 0x7             VR2 = Matrix2[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_0001_0110_00011_0110111; // MOV  R3 0x16                  R3 = 22
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[22]
                    @(negedge clk);
                // line8(29 instructions)
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00111000_00001_0110111; // MOV R1, 0x38                  R1 = 0x38
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_1111_00000_011_00010_0000011; // VLOAD VR2 R0 0xf             VR2 = Matrix3[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00001_010_00010_0000011; // LOAD R2, R1, 0x0             R2 = Matrix_1[7][0]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_00000_011_00010_0000011; // VLOAD VR2 R0 0x0             VR2 = Matrix2[0][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00001_010_00010_0000011; // LOAD R2, R1, 0x1             R2 = Matrix_1[7][1]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0001_00000_011_00010_0000011; // VLOAD VR2 R0 0x1             VR2 = Matrix2[1][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00001_010_00010_0000011; // LOAD R2, R1, 0x2             R2 = Matrix_1[7][2]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0010_00000_011_00010_0000011; // VLOAD VR2 R0 0x2             VR2 = Matrix2[2][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00001_010_00010_0000011; // LOAD R2, R1, 0x3             R2 = Matrix_1[7][3]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0011_00000_011_00010_0000011; // VLOAD VR2 R0 0x3             VR2 = Matrix2[3][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00001_010_00010_0000011; // LOAD R2, R1, 0x4             R2 = Matrix_1[7][4]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0100_00000_011_00010_0000011; // VLOAD VR2 R0 0x4             VR2 = Matrix2[4][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00001_010_00010_0000011; // LOAD R2, R1, 0x5             R2 = Matrix_1[7][5]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0101_00000_011_00010_0000011; // VLOAD VR2 R0 0x5             VR2 = Matrix2[5][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00001_010_00010_0000011; // LOAD R2, R1, 0x6             R2 = Matrix_1[7][6]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0110_00000_011_00010_0000011; // VLOAD VR2 R0 0x6             VR2 = Matrix2[6][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00001_010_00010_0000011; // LOAD R2, R1, 0x7             R2 = Matrix_1[7][7]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0111_00000_011_00010_0000011; // VLOAD VR2 R0 0x7             VR2 = Matrix2[7][:]
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3
                    @(negedge clk);

                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000_0000_0000_0001_0111_00011_0110111; // MOV  R3 0x17                  R3 = 23
                    @(negedge clk);
                    icm_wr_addr    = icm_wr_addr + 1;
                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[23]
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
        repeat(240) @(negedge clk);

        // read data
        @(negedge clk);
        write_mode = 0;
        start = 0;
        read_mode = 1;
        scalar_rd_addr = 'd0;
        vector_rd_addr = 'd0;
        @(negedge clk);
        vector_rd_addr = 'h10;
        @(negedge clk);
        $display("Read VDCM Data: %h", VectorReadData);
        vector_rd_addr = 'h11;
        @(negedge clk);
        $display("Read VDCM Data: %h", VectorReadData);
        vector_rd_addr = 'h12;
        @(negedge clk);
        $display("Read VDCM Data: %h", VectorReadData);
        vector_rd_addr = 'h13;
        @(negedge clk);
        $display("Read VDCM Data: %h", VectorReadData);
        vector_rd_addr = 'h14;
        @(negedge clk);
        $display("Read VDCM Data: %h", VectorReadData);
        vector_rd_addr = 'h15;
        @(negedge clk);
        $display("Read VDCM Data: %h", VectorReadData);
        vector_rd_addr = 'h16;
        @(negedge clk);
        $display("Read VDCM Data: %h", VectorReadData);
        vector_rd_addr = 'h17;
        @(negedge clk);
        $display("Read VDCM Data: %h", VectorReadData);

        #20;
        $finish;
    end

endmodule
