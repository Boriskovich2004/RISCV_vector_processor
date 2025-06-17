`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/16 08:49:47
// Design Name: 
// Module Name: tb_ICM
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

module tb_ICM;

    // Parameters and port definitions
    localparam ADDR_WIDTH = 10;
    localparam INST_WIDTH = 32;
    localparam MEM_DEPTH  = 1 << ADDR_WIDTH;

    reg clk;
    reg write;
    reg [ADDR_WIDTH-1:0] addr;
    reg [INST_WIDTH-1:0] instruction_in;
    wire [INST_WIDTH-1:0] instr;

    // Reference model for verification
    reg [INST_WIDTH-1:0] ref_mem [0:MEM_DEPTH-1];

    // Instantiate ICM
    ICM #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .INST_WIDTH(INST_WIDTH)
    ) dut (
    .clk(clk),
    .write(write),
    .addr(addr),
    .instruction_in(instruction_in),
    .instr(instr)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    integer i;
    // Initialize reference model
    initial begin
    for (i = 0; i < MEM_DEPTH; i = i + 1)
        ref_mem[i] = 0;
    end

    integer err, rand_addr, rand_data;
    // Main test process
    initial begin
    err = 0;
    write = 0;
    addr = 0;
    instruction_in = 0;

    // Wait for reset (if any)
    #20;

    // 1. Write random data to all addresses
    for (i = 0; i < 16; i = i + 1) begin
        @(negedge clk);
        write = 1;
        addr = i;
        instruction_in = $random;
        ref_mem[i] = instruction_in;
    end

    // 2. Read all addresses and check data
    for (i = 0; i < 16; i = i + 1) begin
        @(negedge clk);
        write = 0;
        addr = i;
        @(negedge clk);
        if (instr !== ref_mem[i]) begin
        $display("ERROR: Addr %0d, expect %h, got %h", i, ref_mem[i], instr);
        err = err + 1;
        end
    end

    // 3. Boundary test: lowest and highest address
    @(negedge clk);
    write = 1;
    addr = 0;
    instruction_in = 32'hA5A5A5A5;
    ref_mem[0] = instruction_in;
    @(negedge clk);
    addr = MEM_DEPTH-1;
    instruction_in = 32'h5A5A5A5A;
    ref_mem[MEM_DEPTH-1] = instruction_in;   

    // Read boundary addresses
    @(negedge clk);
    write = 0;
    addr = 0;
    @(negedge clk);
    if (instr !== ref_mem[0]) begin
        $display("ERROR: Boundary Addr 0, expect %h, got %h", ref_mem[0], instr);
        err = err + 1;
    end
    @(negedge clk);
    addr = MEM_DEPTH-1;
    @(negedge clk);
    if (instr !== ref_mem[MEM_DEPTH-1]) begin
        $display("ERROR: Boundary Addr %0d, expect %h, got %h", MEM_DEPTH-1, ref_mem[MEM_DEPTH-1], instr);
        err = err + 1;
    end

    // 4. Write then immediate read (write-read priority)
    rand_addr = $urandom_range(0, 15);
    rand_data = $random;
    @(negedge clk);
    write = 1;
    addr = rand_addr;
    instruction_in = rand_data;
    ref_mem[rand_addr] = rand_data;
    @(negedge clk);
    write = 0;
    addr = rand_addr;
    @(negedge clk);
    if (instr !== ref_mem[rand_addr]) begin
        $display("ERROR: Write-then-read Addr %0d, expect %h, got %h", rand_addr, ref_mem[rand_addr], instr);
        err = err + 1;
    end

    // 5. Illegal address test (out of range, will wrap in hardware)
    @(negedge clk);
    write = 1;
    addr = {ADDR_WIDTH{1'b1}} + 1; // 1024, will wrap to 0
    instruction_in = 32'hDEADBEEF;
    @(negedge clk);
    write = 0;
    addr = {ADDR_WIDTH{1'b1}} + 1;
    @(negedge clk);

    // 6. Random address/data coverage
    for (i = 0; i < 16; i = i + 1) begin
        rand_addr = $urandom_range(0, 15);
        rand_data = $random;
        @(negedge clk);
        write = 1;
        addr = rand_addr;
        instruction_in = rand_data;
        ref_mem[rand_addr] = rand_data;
    end
    @(negedge clk);
    write = 0;

    // Random read and check
    for (i = 0; i < 16; i = i + 1) begin
        rand_addr = $urandom_range(0, 15);
        @(negedge clk);
        write = 0;
        addr = rand_addr;
        @(negedge clk);
        if (instr !== ref_mem[rand_addr]) begin
        $display("ERROR: Random read Addr %0d, expect %h, got %h", rand_addr, ref_mem[rand_addr], instr);
        err = err + 1;
        end
    end

    // 7. Write enable is 0, write should not occur
    @(negedge clk);
    write = 0;
    addr = 5;
    instruction_in = 32'hCAFEBABE;
    @(negedge clk);
    if (instr !== ref_mem[5]) begin
        $display("ERROR: Write disabled Addr 5, expect %h, got %h", ref_mem[5], instr);
        err = err + 1;
    end

    // Summary
    $display("ICM Testbench finished, error count = %0d", err);
    if (err == 0)
        $display("All tests passed!");
    else
        $display("Some tests failed!");

    #20;
    $finish;
    end

endmodule