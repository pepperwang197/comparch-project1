`include "memory.sv"
`include "registers.sv"
`include "alu.sv"

module top(
    input logic clk,
);

    logic reset;
    logic led;
    logic red;
    logic green;
    logic blue;

    logic [2:0] funct3 = 3'b010;
    logic dmem_wren = 1'b0;
    logic [31:0] dmem_address = 31'd0;
    logic [31:0] dmem_data_in = 31'd0;
    logic [31:0] dmem_data_out;
    logic [31:0] imem_address = 31'h1000;
    logic [31:0] instruction;

    memory #(
        .IMEM_INIT_FILE_PREFIX  ("rv32i_test")
    ) u1 (
        .clk            (clk), 
        .funct3         (funct3), 
        .dmem_wren      (dmem_wren), 
        .dmem_address   (dmem_address), 
        .dmem_data_in   (dmem_data_in), 
        .imem_address   (imem_address), 
        .imem_data_out  (instruction), 
        .dmem_data_out  (dmem_data_out), 
        .reset          (reset), 
        .led            (led), 
        .red            (red), 
        .green          (green), 
        .blue           (blue)
    );

    logic wren = 1'b0;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [31:0] rdv;
    logic [31:0] rs1v;
    logic [31:0] rs2v;

    registers registers (
        .clk (clk),
        .wren (wren),
        .rs1 (rs1),
        .rs2 (rs2),
        .rd (rd),
        .rdv (rdv),
        .rs1v (rs1v),
        .rs2v (rs2v)
    );

    logic [31:0] op1,
    logic [31:0] op2,
    logic [2:0] funct3,
    logic [6:0] funct7,
    logic [31:0] result

    alu alu (
        .op1 (op1),
        .op2 (op2),
        .funct3 (funct3),
        .funct7 (funct7),
        .result (result)
    );

    logic [31:0] pc;

    always_comb begin
        imem_address = pc;
        case (instruction[6:0])
            7'b0110011: // R type
                funct7 <= instruction[31:25]; // 7 bits
                rs2 <= instruction[24:20]; // 5 bits
                rs1 <= instruction[19:15]; // 5 bits
                funct3 <= instruction[14:12]; // 3 bits
                rd <= instruction[11:7]; // 5 bits

                op1 <= rs1v;
                op2 <= rs2v;

                wren <= 1'b1;
                rdv <= result;
            7'b0000011: // I type load
                // stuff here
            7'b0010011: // I type ALU
                // stuff here
            7'b0100011: // S type
                // stuff here
            7'b1100011: // B type
                // stuff here
    end
    
    always_ff @(posedge clk) begin
        pc <= pc + 32'd4;
    end
endmodule