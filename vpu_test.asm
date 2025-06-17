// line1
    MOV     R1,       0x0     // R1 = 0x0
    VLOAD  VR2,  R0,  0x8     // VR2 = Matrix_3[0][:]
    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2

    LOAD    R2,  R1,  0x0     // R2 = Matrix_1[0][0]
    VLOAD  VR2,  R0,  0x0     // VR2 = Matrix_2[0][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x1     // R2 = Matrix_1[0][1]
    VLOAD  VR2,  R0,  0x1     // VR2 = Matrix_2[1][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x2     // R2 = Matrix_1[0][2]
    VLOAD  VR2,  R0,  0x2     // VR2 = Matrix_2[2][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x3     // R2 = Matrix_1[0][3]
    VLOAD  VR2,  R0,  0x3     // VR2 = Matrix_2[3][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x4     // R2 = Matrix_1[0][4]
    VLOAD  VR2,  R0,  0x4     // VR2 = Matrix_2[4][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x5     // R2 = Matrix_1[0][5]
    VLOAD  VR2,  R0,  0x5     // VR2 = Matrix_2[5][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x6     // R2 = Matrix_1[0][6]
    VLOAD  VR2,  R0,  0x6     // VR2 = Matrix_2[6][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x7     // R2 = Matrix_1[0][7]
    VLOAD  VR2,  R0,  0x7     // VR2 = Matrix_2[7][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    MOV     R3,       0x10    // R3 = 0x10(after matrix3)
    VSTORE  R3,  VR2          // store VR2 to VectorDCM[16]
// line2
    MOV     R1,       0x8     // R1 = 0x8
    VLOAD  VR2,  R0,  0x9     // VR2 = Matrix_3[1][:]
    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2

    LOAD    R2,  R1,  0x0     // R2 = Matrix_1[1][0]
    VLOAD  VR2,  R0,  0x0     // VR2 = Matrix_2[0][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x1     // R2 = Matrix_1[1][1]
    VLOAD  VR2,  R0,  0x1     // VR2 = Matrix_2[1][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x2     // R2 = Matrix_1[1][2]
    VLOAD  VR2,  R0,  0x2     // VR2 = Matrix_2[2][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x3     // R2 = Matrix_1[1][3]
    VLOAD  VR2,  R0,  0x3     // VR2 = Matrix_2[3][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x4     // R2 = Matrix_1[1][4]
    VLOAD  VR2,  R0,  0x4     // VR2 = Matrix_2[4][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x5     // R2 = Matrix_1[1][5]
    VLOAD  VR2,  R0,  0x5     // VR2 = Matrix_2[5][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x6     // R2 = Matrix_1[1][6]
    VLOAD  VR2,  R0,  0x6     // VR2 = Matrix_2[6][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x7     // R2 = Matrix_1[1][7]
    VLOAD  VR2,  R0,  0x7     // VR2 = Matrix_2[7][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    MOV     R3,       0x11    // R3 = 0x11(after matrix3)
    VSTORE  R3,  VR2          // store VR2 to VectorDCM[17]
// line3
    MOV     R1,       0x10     // R1 = 0x10
    VLOAD  VR2,  R0,  0xa     // VR2 = Matrix_3[2][:]
    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2

    LOAD    R2,  R1,  0x0     // R2 = Matrix_1[2][0]
    VLOAD  VR2,  R0,  0x0     // VR2 = Matrix_2[0][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x1     // R2 = Matrix_1[2][1]
    VLOAD  VR2,  R0,  0x1     // VR2 = Matrix_2[1][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x2     // R2 = Matrix_1[2][2]
    VLOAD  VR2,  R0,  0x2     // VR2 = Matrix_2[2][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x3     // R2 = Matrix_1[2][3]
    VLOAD  VR2,  R0,  0x3     // VR2 = Matrix_2[3][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x4     // R2 = Matrix_1[2][4]
    VLOAD  VR2,  R0,  0x4     // VR2 = Matrix_2[4][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x5     // R2 = Matrix_1[2][5]
    VLOAD  VR2,  R0,  0x5     // VR2 = Matrix_2[5][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x6     // R2 = Matrix_1[2][6]
    VLOAD  VR2,  R0,  0x6     // VR2 = Matrix_2[6][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x7     // R2 = Matrix_1[2][7]
    VLOAD  VR2,  R0,  0x7     // VR2 = Matrix_2[7][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    MOV     R3,       0x12    // R3 = 0x12(after matrix3)
    VSTORE  R3,  VR2          // store VR2 to VectorDCM[18]
// line4
    MOV     R1,       0x18     // R1 = 0x18
    VLOAD  VR2,  R0,  0xb     // VR2 = Matrix_3[3][:]
    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2

    LOAD    R2,  R1,  0x0     // R2 = Matrix_1[3][0]
    VLOAD  VR2,  R0,  0x0     // VR2 = Matrix_2[0][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x1     // R2 = Matrix_1[3][1]
    VLOAD  VR2,  R0,  0x1     // VR2 = Matrix_2[1][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x2     // R2 = Matrix_1[3][2]
    VLOAD  VR2,  R0,  0x2     // VR2 = Matrix_2[2][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x3     // R2 = Matrix_1[3][3]
    VLOAD  VR2,  R0,  0x3     // VR2 = Matrix_2[3][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x4     // R2 = Matrix_1[3][4]
    VLOAD  VR2,  R0,  0x4     // VR2 = Matrix_2[4][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x5     // R2 = Matrix_1[3][5]
    VLOAD  VR2,  R0,  0x5     // VR2 = Matrix_2[5][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x6     // R2 = Matrix_1[3][6]
    VLOAD  VR2,  R0,  0x6     // VR2 = Matrix_2[6][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x7     // R2 = Matrix_1[3][7]
    VLOAD  VR2,  R0,  0x7     // VR2 = Matrix_2[7][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    MOV     R3,       0x13    // R3 = 0x13(after matrix3)
    VSTORE  R3,  VR2          // store VR2 to VectorDCM[19]
// line5
    MOV     R1,       0x20     // R1 = 0x20
    VLOAD  VR2,  R0,  0xc     // VR2 = Matrix_3[4][:]
    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2

    LOAD    R2,  R1,  0x0     // R2 = Matrix_1[4][0]
    VLOAD  VR2,  R0,  0x0     // VR2 = Matrix_2[0][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x1     // R2 = Matrix_1[4][1]
    VLOAD  VR2,  R0,  0x1     // VR2 = Matrix_2[1][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x2     // R2 = Matrix_1[4][2]
    VLOAD  VR2,  R0,  0x2     // VR2 = Matrix_2[2][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x3     // R2 = Matrix_1[4][3]
    VLOAD  VR2,  R0,  0x3     // VR2 = Matrix_2[3][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x4     // R2 = Matrix_1[4][4]
    VLOAD  VR2,  R0,  0x4     // VR2 = Matrix_2[4][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x5     // R2 = Matrix_1[4][5]
    VLOAD  VR2,  R0,  0x5     // VR2 = Matrix_2[5][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x6     // R2 = Matrix_1[4][6]
    VLOAD  VR2,  R0,  0x6     // VR2 = Matrix_2[6][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x7     // R2 = Matrix_1[4][7]
    VLOAD  VR2,  R0,  0x7     // VR2 = Matrix_2[7][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    MOV     R3,       0x14    // R3 = 0x14(after matrix3)
    VSTORE  R3,  VR2          // store VR2 to VectorDCM[20]
// line6
    MOV     R1,       0x28     // R1 = 0x28
    VLOAD  VR2,  R0,  0xd     // VR2 = Matrix_3[5][:]
    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2

    LOAD    R2,  R1,  0x0     // R2 = Matrix_1[5][0]
    VLOAD  VR2,  R0,  0x0     // VR2 = Matrix_2[0][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x1     // R2 = Matrix_1[5][1]
    VLOAD  VR2,  R0,  0x1     // VR2 = Matrix_2[1][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x2     // R2 = Matrix_1[5][2]
    VLOAD  VR2,  R0,  0x2     // VR2 = Matrix_2[2][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x3     // R2 = Matrix_1[5][3]
    VLOAD  VR2,  R0,  0x3     // VR2 = Matrix_2[3][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x4     // R2 = Matrix_1[5][4]
    VLOAD  VR2,  R0,  0x4     // VR2 = Matrix_2[4][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x5     // R2 = Matrix_1[5][5]
    VLOAD  VR2,  R0,  0x5     // VR2 = Matrix_2[5][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x6     // R2 = Matrix_1[5][6]
    VLOAD  VR2,  R0,  0x6     // VR2 = Matrix_2[6][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x7     // R2 = Matrix_1[5][7]
    VLOAD  VR2,  R0,  0x7     // VR2 = Matrix_2[7][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    MOV     R3,       0x15    // R3 = 0x15(after matrix3)
    VSTORE  R3,  VR2          // store VR2 to VectorDCM[21]
// line7
    MOV     R1,       0x30     // R1 = 0x30
    VLOAD  VR2,  R0,  0xe     // VR2 = Matrix_3[6][:]
    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2

    LOAD    R2,  R1,  0x0     // R2 = Matrix_1[6][0]
    VLOAD  VR2,  R0,  0x0     // VR2 = Matrix_2[0][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x1     // R2 = Matrix_1[6][1]
    VLOAD  VR2,  R0,  0x1     // VR2 = Matrix_2[1][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x2     // R2 = Matrix_1[6][2]
    VLOAD  VR2,  R0,  0x2     // VR2 = Matrix_2[2][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x3     // R2 = Matrix_1[6][3]
    VLOAD  VR2,  R0,  0x3     // VR2 = Matrix_2[3][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x4     // R2 = Matrix_1[6][4]
    VLOAD  VR2,  R0,  0x4     // VR2 = Matrix_2[4][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x5     // R2 = Matrix_1[6][5]
    VLOAD  VR2,  R0,  0x5     // VR2 = Matrix_2[5][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x6     // R2 = Matrix_1[6][6]
    VLOAD  VR2,  R0,  0x6     // VR2 = Matrix_2[6][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x7     // R2 = Matrix_1[6][7]
    VLOAD  VR2,  R0,  0x7     // VR2 = Matrix_2[7][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    MOV     R3,       0x16    // R3 = 0x16(after matrix3)
    VSTORE  R3,  VR2          // store VR2 to VectorDCM[22]
// line8
    MOV     R1,       0x38     // R1 = 0x38
    VLOAD  VR2,  R0,  0xf     // VR2 = Matrix_3[7][:]
    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2

    LOAD    R2,  R1,  0x0     // R2 = Matrix_1[7][0]
    VLOAD  VR2,  R0,  0x0     // VR2 = Matrix_2[0][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x1     // R2 = Matrix_1[7][1]
    VLOAD  VR2,  R0,  0x1     // VR2 = Matrix_2[1][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x2     // R2 = Matrix_1[7][2]
    VLOAD  VR2,  R0,  0x2     // VR2 = Matrix_2[2][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x3     // R2 = Matrix_1[7][3]
    VLOAD  VR2,  R0,  0x3     // VR2 = Matrix_2[3][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x4     // R2 = Matrix_1[7][4]
    VLOAD  VR2,  R0,  0x4     // VR2 = Matrix_2[4][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x5     // R2 = Matrix_1[7][5]
    VLOAD  VR2,  R0,  0x5     // VR2 = Matrix_2[5][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x6     // R2 = Matrix_1[7][6]
    VLOAD  VR2,  R0,  0x6     // VR2 = Matrix_2[6][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    LOAD    R2,  R1,  0x7     // R2 = Matrix_1[7][7]
    VLOAD  VR2,  R0,  0x7     // VR2 = Matrix_2[7][:]
    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3

    MOV     R3,       0x17    // R3 = 0x17(after matrix3)
    VSTORE  R3,  VR2          // store VR2 to VectorDCM[23]
