# This script generates repeated icm instruction blocks for each row and writes them to a specified file.

def generate_block(row_idx):
    lines = []
    lines.append(f"// line{row_idx+1}(29 instructions)")
    if row_idx == 0:
        lines.append(f"                    icm_wr_addr    = 0;")
    else:
        lines.append(f"                    icm_wr_addr    = icm_wr_addr + 1;")
    lines.append(
        f"                    inst_data = 32'b0000_0000_0000_{(row_idx*8):08b}_00001_0110111; // MOV R1, {hex(row_idx*8)}                  R1 = {hex(row_idx*8)}")
    lines.append(f"                    @(negedge clk);")
    lines.append(f"                    icm_wr_addr    = icm_wr_addr + 1;")
    lines.append(
        f"                    inst_data = 32'b0000_{(8+row_idx):04b}_00000_011_00010_0000011; // VLOAD VR2 R0 {hex(8+row_idx)}             VR2 = Matrix3[{row_idx}][:]")
    lines.append(f"                    @(negedge clk);")
    lines.append(f"                    icm_wr_addr    = icm_wr_addr + 1;")
    lines.append(
        f"                    inst_data = 32'b0100001_00000_00010_000_00011_0010011;  // VMAC VR3 R0 VR2 1            VR3 = VR2")
    lines.append(f"                    @(negedge clk);\n")
    for i in range(8):
        lines.append(f"                    icm_wr_addr    = icm_wr_addr + 1;")
        lines.append(
            f"                    inst_data = 32'b0000_0000_{(i):04b}_00001_010_00010_0000011; // LOAD R2, R1, 0x{i:x}             R2 = Matrix_1[{row_idx}][{i}]")
        lines.append(f"                    @(negedge clk);")
        lines.append(f"                    icm_wr_addr    = icm_wr_addr + 1;")
        lines.append(
            f"                    inst_data = 32'b0000_0000_{(i):04b}_00000_011_00010_0000011; // VLOAD VR2 R0 0x{i:x}             VR2 = Matrix2[{i}][:]")
        lines.append(f"                    @(negedge clk);")
        lines.append(f"                    icm_wr_addr    = icm_wr_addr + 1;")
        lines.append(
            f"                    inst_data = 32'b0000001_00010_00010_000_00011_0010011;  // VMAC VR3 R2 VR2 0             VR3 = R2 * VR2 + VR3")
        lines.append(f"                    @(negedge clk);\n")
    lines.append(f"                    icm_wr_addr    = icm_wr_addr + 1;")
    lines.append(
        f"                    inst_data = 32'b0000_0000_0000_0001_{(row_idx):04b}_00011_0110111; // MOV  R3 {hex(16+row_idx)}                  R3 = {(16+row_idx)}")
    lines.append(f"                    @(negedge clk);")
    lines.append(f"                    icm_wr_addr    = icm_wr_addr + 1;")
    lines.append(
        f"                    inst_data = 32'b0000000_00010_00011_011_00000_0100011;  // VSTORE R3 VR2                 store VR2 to VectorDCM[{(16+row_idx)}]")
    lines.append(f"                    @(negedge clk);")
    return "\n".join(lines) + "\n"


def main():
    output_file = "icm_inst_block.txt"  # Change as needed
    with open(output_file, "w", encoding="utf-8") as f:
        for row in range(8):
            f.write(generate_block(row))


if __name__ == "__main__":
    main()
