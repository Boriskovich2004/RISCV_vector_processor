# This script generates repeated VPU assembly code blocks for each row and writes them to a specified file.

def generate_block(row_idx):
    lines = []
    lines.append("// line{}".format(row_idx + 1))
    lines.append(
        "    MOV     R1,       {}     // R1 = {}".format(hex(row_idx*8), hex(row_idx*8)))
    lines.append(
        "    VLOAD  VR2,  R0,  {}     // VR2 = Matrix_3[{}][:]".format(hex(row_idx+8), row_idx))
    lines.append("    VMAC   VR3,  R2,  VR2, 1  // VR3 = VR2\n")
    for i in range(8):
        lines.append(
            "    LOAD    R2,  R1,  {}     // R2 = Matrix_1[{}][{}]".format(hex(i), row_idx, i))
        lines.append(
            "    VLOAD  VR2,  R0,  {}     // VR2 = Matrix_2[{}][:]".format(hex(i), i))
        lines.append("    VMAC   VR3,  R2,  VR2, 0  // VR3 = R2 * VR2 + VR3\n")
    lines.append(
        "    MOV     R3,       {}    // R3 = {}(after matrix3)".format(hex(16+row_idx), hex(16+row_idx)))
    lines.append(
        "    VSTORE  R3,  VR2          // store VR2 to VectorDCM[{}]\n".format(16+row_idx))
    return "\n".join(lines)


def main():
    output_file = "vpu_test.asm"  # You can change the output file name here
    with open(output_file, "w", encoding="utf-8") as f:
        for row in range(8):
            f.write(generate_block(row))


if __name__ == "__main__":
    main()
